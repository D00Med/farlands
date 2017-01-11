
-- read/write
function hunger.read(player)
	local inv = player:get_inventory()
	if not inv then
		return nil
	end
	local hgp = inv:get_stack("hunger", 1):get_count()
	if hgp == 0 then
		hgp = 21
		inv:set_stack("hunger", 1, ItemStack({name = ":", count = hgp}))
	else
		hgp = hgp
	end
	if tonumber(hgp) > HUNGER_MAX + 1 then
		hgp = HUNGER_MAX + 1
	end
	return hgp - 1
end

function hunger.save(player)
	local inv = player:get_inventory()
	local name = player:get_player_name()
	local value = hunger.players[name].lvl
	if not inv or not value then
		return nil
	end
	if value > HUNGER_MAX then
		value = HUNGER_MAX
	end
	if value < 0 then
		value = 0
	end
	inv:set_stack("hunger", 1, ItemStack({name = ":", count = value + 1}))
	return true
end

function hunger.update_hunger(player, new_lvl)
	local name = player:get_player_name() or nil
	if not name then
		return false
	end
	if minetest.setting_getbool("enable_damage") == false then
		hunger.players[name] = 20
		return
	end
	local lvl = hunger.players[name].lvl
	if new_lvl then
		 lvl = new_lvl
	end
	if lvl > HUNGER_MAX then
		lvl = HUNGER_MAX
	end
	hunger.players[name].lvl = lvl
	if lvl > 20 then
		lvl = 20
	end
	hud.change_item(player, "hunger", {number = lvl})
	hunger.save(player)
end
local update_hunger = hunger.update_hunger

-- player-action based hunger changes
function hunger.handle_node_actions(pos, oldnode, player, ext)
	if not player or not player:is_player() then
		return
	end
	local name = player:get_player_name()
	if not name or not hunger.players[name] then
		return
	end

	local exhaus = hunger.players[name].exhaus
	if not exhaus then
		hunger.players[name].exhaus = 0
		--return
	end

	local new = HUNGER_EXHAUST_PLACE

	-- placenode event
	if not ext then
		new = HUNGER_EXHAUST_DIG
	end

	-- assume its send by action_timer(globalstep)
	if not pos and not oldnode then
		new = HUNGER_EXHAUST_MOVE
	end

	exhaus = exhaus + new

	if exhaus > HUNGER_EXHAUST_LVL then
		exhaus = 0
		local h = tonumber(hunger.players[name].lvl)
		if h > 0 then
			update_hunger(player, h - 1)
		end
	end

	hunger.players[name].exhaus = exhaus
end

-- sprint settings
local enable_sprint = minetest.setting_getbool("sprint") ~= false
local enable_sprint_particles = minetest.setting_getbool("sprint_particles") ~= false

-- 3d armor support
local armor_mod = minetest.get_modpath("3d_armor")

-- Sets the sprint state of a player (false = stopped, true = sprinting)
function set_sprinting(name, sprinting)

	if not hunger.players[name] then
		return false
	end

	local player = minetest.get_player_by_name(name)

	-- is 3d_armor active, then set to armor defaults
	local def = {}
	if armor_mod and armor and armor.def[name] then
		def = armor.def[name]
	end

	def.speed = def.speed or 1
	def.jump = def.jump or 1
	def.gravity = def.gravity or 1

	if sprinting == true then

		player:set_physics_override({
			speed = def.speed + SPRINT_SPEED,
			jump = def.jump + SPRINT_JUMP,
			gravity = def.gravity
		})

--print ("Speed:", def.speed + SPRINT_SPEED, "Jump:", def.jump + SPRINT_JUMP, "Gravity:", def.gravity)

	else

		player:set_physics_override({
			speed = def.speed,
			jump = def.jump,
			gravity = def.gravity
		})

--print ("Speed:", def.speed, "Jump:", def.jump, "Gravity:", def.gravity)

	end

	return true
end

-- Time based hunger functions
local hunger_timer = 0
local health_timer = 0
local action_timer = 0

local function hunger_globaltimer(dtime)
	hunger_timer = hunger_timer + dtime
	health_timer = health_timer + dtime
	action_timer = action_timer + dtime

	if action_timer > HUNGER_MOVE_TICK then
		for _,player in ipairs(minetest.get_connected_players()) do
			local controls = player:get_player_control()
			-- Determine if the player is walking
			if controls.up or controls.down or controls.left or controls.right then
				hunger.handle_node_actions(nil, nil, player)
			end

			if enable_sprint then

				local name = player:get_player_name()

				-- check if player should be sprinting (hunger must be over 6 points)
				if player
				and controls.aux1
				and controls.up
				and not minetest.check_player_privs(name, {fast = true})
				and hunger.players[name].lvl > 6 then

					set_sprinting(name, true)

					-- create particles behind player when sprinting
					if enable_sprint_particles then

						local pos = player:getpos()
						local node = minetest.get_node({
							x = pos.x,
							y = pos.y - 1,
							z = pos.z
						})

						if node.name ~= "air" then

						minetest.add_particlespawner({
							time = 0.01,
							amount = 5,
							minpos = {x = pos.x - 0.25, y = pos.y + 0.1, z = pos.z - 0.25},
							maxpos = {x = pos.x + 0.25, y = pos.y + 0.1, z = pos.z + 0.25},
							minvel = {x = -0.5, y = 1, z = -0.5},
							maxvel = {x = 0.5, y = 2, z = 0.5},
							minacc = {x = 0, y = -5, z = 0},
							maxacc = {x = 0, y = -12, z = 0},
							minexptime = 0.25,
							maxexptime = 0.5,
							minsize = 0.5,
							maxsize = 1.0,
							vertical = false,
							collisiondetection = false,
							texture = "default_dirt.png",
						})

						end
					end

					-- Lower the player's hunger
					update_hunger(player,
						hunger.players[name].lvl - (SPRINT_DRAIN * HUNGER_MOVE_TICK))
				else
					set_sprinting(name, false)
				end
			end

		end
		action_timer = 0
	end

	-- lower saturation by 1 point after <HUNGER_TICK> second(s)
	if hunger_timer > HUNGER_TICK then
		for _,player in ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			local tab = hunger.players[name]
			if tab then
				local hunger = tab.lvl
				if hunger > 0 then
					update_hunger(player, hunger - 1)
				end
			end
		end
		hunger_timer = 0
	end

	-- heal or damage player, depending on saturation
	if health_timer > HUNGER_HEALTH_TICK then
		for _,player in ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			local tab = hunger.players[name]
			if tab then
				local air = player:get_breath() or 0
				local hp = player:get_hp()

				-- heal player by 1 hp if not dead and saturation is > 15 (of 30) player is not drowning
				if tonumber(tab.lvl) > HUNGER_HEAL_LVL and hp > 0 and air > 0 then
					player:set_hp(hp + HUNGER_HEAL)
				end

				-- or damage player by 1 hp if saturation is < 2 (of 30)
				if tonumber(tab.lvl) < HUNGER_STARVE_LVL then
					player:set_hp(hp - HUNGER_STARVE)
				end
			end
		end

		health_timer = 0
	end
end


if minetest.setting_getbool("enable_damage") then
	minetest.register_globalstep(hunger_globaltimer)
end


-- food functions
local food = hunger.food

function hunger.register_food(name, hunger_change, replace_with_item, poisen, heal, sound)
	food[name] = {}
	food[name].saturation = hunger_change -- hunger points added
	food[name].replace = replace_with_item -- what item is given back after eating
	food[name].poisen = poisen -- time its poisening
	food[name].healing = heal -- amount of HP
	food[name].sound = sound -- special sound that is played when eating
end

-- Poison player
local function poisenp(tick, time, time_left, player)
	time_left = time_left + tick
	if time_left < time then
		minetest.after(tick, poisenp, tick, time, time_left, player)
	else
		hud.change_item(player, "hunger", {text = "hud_hunger_fg.png"})
	end
	local hp = player:get_hp() -1 or 0
	if hp > 0 then
		player:set_hp(hp)
	end
end

-- wrapper for minetest.item_eat (this way we make sure other mods can't break this one)
local org_eat = core.do_item_eat
core.do_item_eat = function(hp_change, replace_with_item, itemstack, user, pointed_thing)
	local old_itemstack = itemstack
	itemstack = hunger.eat(hp_change, replace_with_item, itemstack, user, pointed_thing)
	for _, callback in pairs(core.registered_on_item_eats) do
		local result = callback(hp_change, replace_with_item, itemstack, user, pointed_thing, old_itemstack)
		if result then
			return result
		end
	end
	return itemstack
end

function hunger.eat(hp_change, replace_with_item, itemstack, user, pointed_thing)
	local item = itemstack:get_name()
	local def = food[item]
	if not def then
		def = {}
		if type(hp_change) ~= "number" then
			hp_change = 1
			core.log("error", "Wrong on_use() definition for item '" .. item .. "'")
		end
		def.saturation = hp_change * 1.3
		def.replace = replace_with_item
	end
	local func = hunger.item_eat(def.saturation, def.replace, def.poisen, def.healing, def.sound)
	return func(itemstack, user, pointed_thing)
end

function hunger.item_eat(hunger_change, replace_with_item, poisen, heal, sound)
	return function(itemstack, user, pointed_thing)

		if itemstack:take_item() == nil and user == nil then
			return itemstack
		end

		local name = user:get_player_name()
		if not hunger.players[name] then
			return itemstack
		end
		local sat = tonumber(hunger.players[name].lvl or 0)
		local hp = user:get_hp()
		-- Saturation
		if sat < HUNGER_MAX and hunger_change then
			sat = sat + hunger_change
			hunger.update_hunger(user, sat)
		end
		-- Healing
		if hp < 20 and heal then
			hp = hp + heal
			if hp > 20 then
				hp = 20
			end
			user:set_hp(hp)
		end
		-- Poison
		if poisen then
			hud.change_item(user, "hunger", {text = "hunger_statbar_poisen.png"})
			poisenp(1.0, poisen, 0, user)
		end

		-- eating sound
		sound = sound or "hunger_eat"
		minetest.sound_play(sound, {to_player = name, gain = 0.7})

		if replace_with_item then
			if itemstack:is_empty() then
				itemstack:add_item(replace_with_item)
			else
				local inv = user:get_inventory()
				if inv:room_for_item("main", {name = replace_with_item}) then
					inv:add_item("main", replace_with_item)
				else
					local pos = user:getpos()
					pos.y = math.floor(pos.y + 0.5)
					core.add_item(pos, replace_with_item)
				end
			end
		end

		return itemstack
	end
end
