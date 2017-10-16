--[[
	Minetest Farming Redo Mod 1.22 (26th October 2015)
	by TenPlus1
	NEW growing routine by prestidigitator
	auto-refill by crabman77
]]

farming = {}
farming.mod = "redo"
farming.path = minetest.get_modpath("farming")
farming.hoe_on_use = default.hoe_on_use
farming.select = {
	type = "fixed",
	fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
}

farming.DEBUG = false
-- farming.DEBUG = {}  -- Uncomment to turn on profiling code/functions

local DEBUG_abm_runs   = 0
local DEBUG_abm_time   = 0
local DEBUG_timer_runs = 0
local DEBUG_timer_time = 0
if farming.DEBUG then
	function farming.DEBUG.reset_times()
		DEBUG_abm_runs = 0
		DEBUG_abm_time = 0
		DEBUG_timer_runs = 0
		DEBUG_timer_time = 0
	end

	function farming.DEBUG.report_times()
		local abm_n     = DEBUG_abm_runs
		local abm_dt    = DEBUG_abm_time
		local abm_avg   = (abm_n > 0 and abm_dt / abm_n) or 0
		local timer_n   = DEBUG_timer_runs
		local timer_dt  = DEBUG_timer_time
		local timer_avg = (timer_n > 0 and timer_dt / timer_n) or 0
		local dt = abm_dt + timer_dt
		print("ABM ran for "..abm_dt.."µs over "..abm_n.." runs: "..
		      abm_avg.."µs/run")
		print("Timer ran for "..timer_dt.."µs over "..timer_n.." runs: "..
		      timer_avg.."µs/run")
		print("Total farming time: "..dt.."µs")
	end
end

local statistics = dofile(farming.path.."/statistics.lua")
dofile(farming.path.."/soil.lua")
dofile(farming.path.."/hoes.lua")
dofile(farming.path.."/grass.lua")
dofile(farming.path.."/wheat.lua")
dofile(farming.path.."/cotton.lua")
dofile(farming.path.."/melon.lua")
dofile(farming.path.."/carrot.lua")
dofile(farming.path.."/potato.lua")
dofile(farming.path.."/corn.lua")
dofile(farming.path.."/raddish.lua")
dofile(farming.path.."/pumpkin.lua")
dofile(farming.path.."/sugar.lua")
dofile(farming.path.."/mapgen.lua")
dofile(farming.path.."/compatibility.lua") -- Farming Plus compatibility

-- Utility Functions

local time_speed = tonumber(minetest.setting_get("time_speed")) or 72
local SECS_PER_CYCLE = (time_speed > 0 and 24 * 60 * 60 / time_speed) or 0 --nil

local function clamp(x, min, max)
	return (x < min and min) or (x > max and max) or x
end

local function in_range(x, min, max)
	return min <= x and x <= max
end

--- Tests the amount of day or night time between two times.
 --
 -- @param t_game
 --    The current time, as reported by mintest.get_gametime().
 -- @param t_day
 --    The current time, as reported by mintest.get_timeofday().
 -- @param dt
 --    The amount of elapsed time.
 -- @param count_day
 --    If true, count elapsed day time.  Otherwise, count elapsed night time.
 -- @return
 --    The amount of day or night time that has elapsed.
 --
local function day_or_night_time(t_game, t_day, dt, count_day)
	local t1_day = t_day - dt / SECS_PER_CYCLE

	local t1_c, t2_c  -- t1_c < t2_c and t2_c always in [0, 1)
	if count_day then
		if t_day < 0.25 then
			t1_c = t1_day + 0.75  -- Relative to sunup, yesterday
			t2_c = t_day  + 0.75
		else
			t1_c = t1_day - 0.25  -- Relative to sunup, today
			t2_c = t_day  - 0.25
		end
	else
		if t_day < 0.75 then
			t1_c = t1_day + 0.25  -- Relative to sundown, yesterday
			t2_c = t_day  + 0.25
		else
			t1_c = t1_day - 0.75  -- Relative to sundown, today
			t2_c = t_day  - 0.75
		end
	end

	local dt_c = clamp(t2_c, 0, 0.5) - clamp(t1_c, 0, 0.5)  -- this cycle
	if t1_c < -0.5 then
		local nc = math.floor(-t1_c)
		t1_c = t1_c + nc
		dt_c = dt_c + 0.5 * nc + clamp(-t1_c - 0.5, 0, 0.5)
	end

	return dt_c * SECS_PER_CYCLE
end

--- Tests the amount of elapsed day time.
 --
 -- @param dt
 --    The amount of elapsed time.
 -- @return
 --    The amount of day time that has elapsed.
 --
local function day_time(dt)
	return day_or_night_time(minetest.get_gametime(), minetest.get_timeofday(), dt, true)
end

--- Tests the amount of elapsed night time.
 --
 -- @param dt
 --    The amount of elapsed time.
 -- @return
 --    The amount of night time that has elapsed.
 --
local function night_time(time_game, time_day, dt, count_day)
	return day_or_night_time(minetest.get_gametime(), minetest.get_timeofday(), dt, false)
end


-- Growth Logic

local STAGE_LENGTH_AVG = 320.0
local STAGE_LENGTH_DEV = STAGE_LENGTH_AVG / 6
local MIN_LIGHT = 13
local MAX_LIGHT = 1000

--- Determines plant name and stage from node.
 --
 -- Separates node name on the last underscore (_).
 --
 -- @param node
 --    Node or position table, or node name.
 -- @return
 --    List (plant_name, stage), or nothing (nil) if node isn't loaded
 --
local function plant_name_stage(node)
	local name
	if type(node) == 'table' then
		if node.name then
		   name = node.name
		elseif node.x and node.y and node.z then
			node = minetest.get_node_or_nil(node)
			name = node and node.name
		end
	else
		name = tostring(node)
	end
	if not name or name == "ignore" then return nil end

	local sep_pos = name:find("_[^_]+$")
	if sep_pos and sep_pos > 1 then
		local stage = tonumber(name:sub(sep_pos + 1))
		if stage and stage >= 0 then
			return name:sub(1, sep_pos - 1), stage
		end
	end

	return name, 0
end

--- Map from node name to
 -- { plant_name = ..., name = ..., stage = n, stages_left = { node_name, ... } }
local plant_stages = {}
farming.plant_stages = plant_stages

--- Registers the stages of growth of a (possible plant) node.
 --
 -- @param node
 --    Node or position table, or node name.
 -- @return
 --    The (possibly zero) number of stages of growth the plant will go through
 --    before being fully grown, or nil if not a plant.
 --
local register_plant_node
-- Recursive helper
local function reg_plant_stages(plant_name, stage, force_last)
	local node_name = plant_name and plant_name .. "_" .. stage
	local node_def = node_name and minetest.registered_nodes[node_name]
	if not node_def then return nil end

	local stages = plant_stages[node_name]
	if stages then return stages end

	if minetest.get_item_group(node_name, "growing") > 0 then
		local ns = reg_plant_stages(plant_name, stage + 1, true)

		local stages_left = (ns and { ns.name, unpack(ns.stages_left) }) or {}
		stages = {
			plant_name = plant_name,
			name = node_name,
			stage = stage,
			stages_left = stages_left
		}

		if #stages_left > 0 then
			local old_constr = node_def.on_construct
			local old_destr  = node_def.on_destruct
			minetest.override_item(node_name,
				{
					on_construct = function(pos)
						if old_constr then old_constr(pos) end
						farming.handle_growth(pos)
					end,

					on_destruct = function(pos)
						minetest.get_node_timer(pos):stop()
						if old_destr then old_destr(pos) end
					end,

					on_timer = function(pos, elapsed)
						return farming.plant_growth_timer(pos, elapsed, node_name)
					end,
				})
		end
	elseif force_last then
		stages = {
			plant_name = plant_name,
			name = node_name,
			stage = stage,
			stages_left = {}
		}
	else
		return nil
	end

	plant_stages[node_name] = stages
	return stages
end

register_plant_node = function(node)
	local plant_name, stage = plant_name_stage(node)
	if plant_name then
		local stages = reg_plant_stages(plant_name, stage, false)
		return stages and #stages.stages_left
	else
		return nil
	end
end

local function set_growing(pos, stages_left)
	if not stages_left then return end

	local timer = minetest.get_node_timer(pos)
	if stages_left > 0 then
		if not timer:is_started() then
			--local stage_length = statistics.normal(STAGE_LENGTH_AVG, STAGE_LENGTH_DEV)
			--stage_length = clamp(stage_length, 0.5 * STAGE_LENGTH_AVG, 3.0 * STAGE_LENGTH_AVG)
			--local grow_time = -0.5 * math.random() * STAGE_LENGTH_AVG
			--timer:set(stage_length, grow_time)
			timer:start(math.random(STAGE_LENGTH_AVG - (STAGE_LENGTH_AVG * 0.15),
						STAGE_LENGTH_AVG + (STAGE_LENGTH_AVG * 0.15)))
		end
	elseif timer:is_started() then
		timer:stop()
	end
end

--- Detects a plant type node at the given position, starting or stopping the plant growth timer as appopriate
 --
 -- @param pos
 --    The node's position.
 -- @param node
 --    The cached node table if available, or nil.
 --
function farming.handle_growth(pos, node)
	if not pos then return end
	local stages_left = register_plant_node(node or pos)
	if stages_left then set_growing(pos, stages_left) end
end

minetest.after(0,
	function()
		for _, node_def in pairs(minetest.registered_nodes) do
			register_plant_node(node_def)
		end
	end)

local abm_func = farming.handle_growth
if farming.DEBUG then
	local normal_abm_func = abm_func
	abm_func = function(...)
		local t0 = minetest.get_us_time()
		local r = { normal_abm_func(...) }
		local t1 = minetest.get_us_time()
		DEBUG_abm_runs = DEBUG_abm_runs + 1
		DEBUG_abm_time = DEBUG_abm_time + (t1 - t0)
		return unpack(r)
	end
end

-- Just in case a growing type or added node is missed (also catches existing
-- nodes added to map before timers were incorporated).
minetest.register_abm({
	nodenames = { "group:growing" },
	interval  = 300,
	chance    = 1,
	action = abm_func})

--- Plant timer function.
 --
 -- Grows plants under the right conditions.
 --
function farming.plant_growth_timer(pos, elapsed, node_name)
	local stages = plant_stages[node_name]
	if not stages then return false end

	local max_growth = #stages.stages_left
	if max_growth <= 0 then return false end

	local mature = minetest.registered_nodes[node_name].mature
	if mature and math.random(100) < 95 then
		return true
	end

	if stages.plant_name == "farming:cocoa" then
		if not minetest.find_node_near(pos, 1, { "default:jungletree", "moretrees:jungletree_leaves_green" }) then
			return true
		end
	else
		local under = minetest.get_node_or_nil({ x = pos.x, y = pos.y - 1, z = pos.z })
		if not under or under.name ~= "farming:soil_wet" then return true end
	end

	local growth

	local light_pos = { x = pos.x, y = pos.y, z = pos.z }
	local lambda = elapsed / STAGE_LENGTH_AVG
	if lambda < 0.1 then return true end
	if max_growth == 1 or lambda < 2.0 then
		local light = (minetest.get_node_light(light_pos) or 0) -- CHANGED
		--print ("light level:", light)
		if not in_range(light, MIN_LIGHT, MAX_LIGHT) then return true end
		growth = 1
	else
		local night_light  = (minetest.get_node_light(light_pos, 0) or 0) -- CHANGED
		local day_light    = (minetest.get_node_light(light_pos, 0.5) or 0) -- ChANGED
		local night_growth = in_range(night_light, MIN_LIGHT, MAX_LIGHT)
		local day_growth   = in_range(day_light,   MIN_LIGHT, MAX_LIGHT)

		if not night_growth then
			if not day_growth then return true end
			lambda = day_time(elapsed) / STAGE_LENGTH_AVG
		elseif not day_growth then
			lambda = night_time(elapsed) / STAGE_LENGTH_AVG
		end

		growth = statistics.poisson(lambda, max_growth)
		if growth < 1 then return true end
	end

	minetest.swap_node(pos, { name = stages.stages_left[growth] })

	return growth ~= max_growth
end

if farming.DEBUG then
	local timer_func = farming.plant_growth_timer;
	farming.plant_growth_timer = function(pos, elapsed, node_name)
		local t0 = minetest.get_us_time()

		local r = { timer_func(pos, elapsed, node_name) }

		local t1 = minetest.get_us_time()
		DEBUG_timer_runs = DEBUG_timer_runs + 1
		DEBUG_timer_time = DEBUG_timer_time + (t1 - t0)
		return unpack(r)
	end
end

-- refill placed plant by crabman (26/08/2015)
local can_refill_plant = {
	["farming:blueberry_1"] =  "farming:blueberries",
	["farming:carrot_1"] =  "farming:carrot",
	["farming:coffee_1"] =  "farming:coffee_beans",
	["farming:corn_1"] =  "farming:corn",
	["farming:cotton_1"] =  "farming:seed_cotton",
	["farming:cucumber_1"] =  "farming:cucumber",
	["farming:melon_1"] =  "farming:melon_slice",
	["farming:potato_1"] =  "farming:potato",
	["farming:pumpkin_1"] =  "farming:pumpkin_slice",
	["farming:raspberry_1"] =  "farming:raspberries",
	["farming:rhubarb_1"] =  "farming:rhubarb",
	["farming:tomato_1"] =  "farming:tomato",
	["farming:wheat_1"] =  "farming:seed_wheat"
}

function farming.refill_plant(player, plantname, index)
	local inv = player:get_inventory()
	local old_stack = inv:get_stack("main", index)
	if old_stack:get_name() ~= "" then return end
	for i,stack in ipairs(inv:get_list("main")) do
		if stack:get_name() == plantname and i ~= index then
			inv:set_stack("main", index, stack)
			stack:clear()
			inv:set_stack("main", i, stack)
			--minetest.log("action", "farming: refilled stack("..plantname..") of "  .. player:get_player_name()  )
			return
		end
	end
end -- END refill

-- Place Seeds on Soil

function farming.place_seed(itemstack, placer, pointed_thing, plantname)
	local pt = pointed_thing

	-- check if pointing at a node
	if not pt or pt.type ~= "node" then
		return
	end

	local under = minetest.get_node(pt.under)
	local above = minetest.get_node(pt.above)

	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y + 1 then
		return
	end

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name]
	or not minetest.registered_nodes[above.name] then
		return
	end

	-- can I replace above node, and am I pointing at soil
	if not minetest.registered_nodes[above.name].buildable_to
	or minetest.get_item_group(under.name, "soil") < 2
	-- avoid multiple seed placement bug
	or minetest.get_item_group(above.name, "plant") ~= 0 then
		return
	end

	-- if not protected then add node and remove 1 item from the itemstack
	if not minetest.is_protected(pt.above, placer:get_player_name()) then
		minetest.set_node(pt.above, {name = plantname, param2 = 1})
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
			-- check for refill
			if itemstack:get_count() == 0
			and can_refill_plant[plantname] then
				minetest.after(0.10,
					farming.refill_plant,
					placer,
					can_refill_plant[plantname],
					placer:get_wield_index()
				)
			end -- END refill
		end
		return itemstack
	end
end

-- Function to register plants (for compatibility)

farming.register_plant = function(name, def)
	local mname = name:split(":")[1]
	local pname = name:split(":")[2]

	-- Check def table
	if not def.description then
		def.description = "Seed"
	end
	if not def.inventory_image then
		def.inventory_image = "unknown_item.png"
	end
	if not def.steps then
		return nil
	end
	-- Register seed
	minetest.register_node(":" .. mname .. ":seed_" .. pname, {
		description = def.description,
		tiles = {def.inventory_image},
		inventory_image = def.inventory_image,
		wield_image = def.inventory_image,
		drawtype = "signlike",
		groups = {seed = 1, snappy = 3, attached_node = 1},
		paramtype = "light",
		paramtype2 = "wallmounted",
		walkable = false,
		sunlight_propagates = true,
		selection_box = farming.select,
		on_place = function(itemstack, placer, pointed_thing)
			return farming.place_seed(itemstack, placer, pointed_thing, mname .. ":"..pname.."_1")
		end
	})

	-- Register harvest
	minetest.register_craftitem(":" .. mname .. ":" .. pname, {
		description = pname:gsub("^%l", string.upper),
		inventory_image = mname .. "_" .. pname .. ".png",
	})

	-- Register growing steps
	for i = 1, def.steps do
		local drop = {
			items = {
				{items = {mname .. ":" .. pname}, rarity = 9 - i},
				{items = {mname .. ":" .. pname}, rarity= 18 - i * 2},
				{items = {mname .. ":seed_" .. pname}, rarity = 9 - i},
				{items = {mname .. ":seed_" .. pname}, rarity = 18 - i * 2},
			}
		}

		local g = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1, growing = 1}
		-- Last step doesn't need growing=1 so Abm never has to check these
		if i == def.steps then
			g = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1}
		end

		local node_name = mname .. ":" .. pname .. "_" .. i
		minetest.register_node(node_name, {
			drawtype = "plantlike",
			waving = 1,
			tiles = {mname .. "_" .. pname .. "_" .. i .. ".png"},
			paramtype = "light",
			walkable = false,
			buildable_to = true,
			drop = drop,
			selection_box = farming.select,
			groups = g,
			sounds = default.node_sound_leaves_defaults(),
		})
		register_plant_node(node_name)
	end

	-- Return info
	local r = {seed = mname .. ":seed_" .. pname, harvest = mname .. ":" .. pname}
	return r
end

--[[ Cotton (example, is already registered in cotton.lua)
farming.register_plant("farming:cotton", {
	description = "Cotton2 seed",
	inventory_image = "farming_cotton_seed.png",
	steps = 8,
})]]
