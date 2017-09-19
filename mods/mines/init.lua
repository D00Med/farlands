local MINE_DEEP_MIN = tonumber(minetest.setting_get("mines_deep_min")) or -64
local MINE_DEEP_MAX = tonumber(minetest.setting_get("mines_deep_max")) or -380
local MINE_FACTOR = tonumber(minetest.setting_get("mines_spawnfactor")) or 1.5


minetest.register_node("mines:dummy", {
	description = "Air (you hacker you!)",
	inventory_image = "unknown_node.png",
	wield_image = "unknown_node.png",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	air_equivalent = true,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})


local ids = {
	air = minetest.get_content_id("air"),
	fence = minetest.get_content_id("default:fence_wood"),
	wood = minetest.get_content_id("default:wood"),
	dummy = minetest.get_content_id("mines:dummy")
}

local chest_stuff = {
	{name="fruit:apple", max = 3},
	{name="farming:bread", max = 3},
	{name="default:steel_ingot", max = 2},
	{name="default:gold_ingot", max = 2},
	{name="default:diamond", max = 1},
	{name="default:pick_steel", max = 1},
	{name="default:pick_bronze", max = 1}

}

local function rotate_torch(pos)
	minetest.after(8, function()
		local n = minetest.get_node(pos)
		if n ~= nil then
			if n.name == "mines:dummy" then
				minetest.set_node(pos, {name="decoblocks:lantern_wall",param2=2})
			end
		end
	end)
end

local function fill_chest(pos)
	minetest.after(5, function()
		local n = minetest.get_node(pos)
		if n ~= nil then
			if n.name == "mines:dummy" then
				minetest.set_node(pos, {name="default:chest"})
				local meta = minetest.get_meta(pos)
				--meta:set_string("formspec",default.chest_formspec)
				--meta:set_string("infotext", "Chest")
				local inv = meta:get_inventory()
				inv:set_size("main", 8*4)
				for i = 0, 2, 1 do
					local stuff = chest_stuff[math.random(1,#chest_stuff)]
					local stack = {name=stuff.name, count = math.random(1,stuff.max)}
					if not inv:contains_item("main", stack) then
						inv:set_stack("main", math.random(1,32), stack)
					end
				end
			end
		end
	end)
end

local function check_dir(dir, old_dir)
	if old_dir == 1 and dir == 3 then
		--n_switch = 2
		return true
	elseif old_dir == 3 and dir == 1 then
		--n_switch = 4
		return true
	elseif old_dir == 2 and dir == 4 then
		--n_switch = 1
		return true
	elseif old_dir == 4 and dir == 2 then
		--n_switch = 3
		return true
	end
	return false
end
local function make_mine(mpos, p2, p3, vm_data, vx_area,cnt)
	local pos = {x = mpos.x, y = mpos.y, z = mpos.z}
	for j = 0, 12, 1 do
	local switch = cnt+1
	n_switch = math.random(1, 4)
	while check_dir(n_switch, switch) == true do
		n_switch = math.random(1, 4)
	end
	switch = n_switch

	for i=0,20,1 do
		local pillar = ids.air
		local pillar_top = ids.air
		if i==0 or i == 5 or i == 10 or i == 15 or i == 20 then
			pillar = ids.fence
			pillar_top = ids.wood
		end
		local x1
		local x2
		local x3
		local x4
		local x5
		local z1
		local z2
		local z3
		local z4
		local z5
		if switch == 1 then
			x1 = pos.x+1
			x2 = pos.x
			x3 = pos.x-1
			x4 = pos.x
			x5 = pos.x+1

			z1 = pos.z+i
			z2 = pos.z+i
			z3 = pos.z+i
			z4 = pos.z+i-1
			z5 = pos.z+i
		elseif switch == 2 then
			x1 = pos.x+i
			x2 = pos.x+i
			x3 = pos.x+i
			x4 = pos.x+i-1
			x5 = pos.x+i

			z1 = pos.z+1
			z2 = pos.z
			z3 = pos.z-1
			z4 = pos.z
			z5 = pos.z+1
		elseif switch == 3 then
			x1 = pos.x+1
			x2 = pos.x
			x3 = pos.x-1
			x4 = pos.x
			x5 = pos.x+1

			z1 = pos.z-i
			z2 = pos.z-i
			z3 = pos.z-i
			z4 = pos.z-i-1
			z5 = pos.z-i
		else
			x1 = pos.x-i
			x2 = pos.x-i
			x3 = pos.x-i
			x4 = pos.x-i-1
			x5 = pos.x-i

			z1 = pos.z+1
			z2 = pos.z
			z3 = pos.z-1
			z4 = pos.z
			z5 = pos.z+1
		end
		vm_data[vx_area:indexp({x=x1, y=pos.y-1, z=z1})] = pillar
		vm_data[vx_area:indexp({x=x2, y=pos.y-1, z=z2})] = ids.air
		vm_data[vx_area:indexp({x=x3, y=pos.y-1, z=z3})] = pillar

		vm_data[vx_area:indexp({x=x1, y=pos.y, z=z1})] = pillar
		vm_data[vx_area:indexp({x=x2, y=pos.y, z=z2})] = ids.air
		vm_data[vx_area:indexp({x=x3, y=pos.y, z=z3})] = pillar

		vm_data[vx_area:indexp({x=x1, y=pos.y+1, z=z1})] = pillar_top
		vm_data[vx_area:indexp({x=x2, y=pos.y+1, z=z2})] = pillar_top
		vm_data[vx_area:indexp({x=x3, y=pos.y+1, z=z3})] = pillar_top

		if math.random(0,6) == 3 then 
			vm_data[vx_area:indexp({x=x4, y=pos.y-1, z=z4})] = ids.dummy
			rotate_torch({x=x4, y=pos.y-1, z=z4})
		end
		if math.random(0,60) == 13 then
			local p = {x=x5, y=pos.y-1, z=z5}
			if vm_data[vx_area:indexp(p)] ~= ids.fence then
				vm_data[vx_area:indexp(p)] = ids.dummy
				fill_chest(p)
			end
		end
	end
	if switch == 1 then			
		pos.z = pos.z+20
		--pos.x = pos.x+step
	elseif switch == 2 then
		pos.x = pos.x+20
		--pos.z = pos.z+step
	elseif switch == 3 then			
		pos.z = pos.z-20
		--pos.x = pos.x+step
	elseif switch == 4 then	
		pos.x = pos.x-20
		--pos.z = pos.z+step
	end
	end
	if cnt == 0 then
		minetest.log("action", "Created mine at ("..mpos.x..","..mpos.y..","..mpos.z..")")
		local out2 = make_mine(p2,p3,mpos,vm_data,vx_area,1)
		local out3 = make_mine(p3,p2,mpos,out2,vx_area,2)
		return out3
	else
		return vm_data
	end
end

local function find_cave(min,max,vm_data, vx_area)
	local out = nil
	for i in vx_area:iterp(min, max) do
		if vm_data[i] == ids.air then
			local p = vx_area:position(i)
			if p.y <= MINE_DEEP_MIN then out = p end
		end		
	end
	return out
end

local cnt = 0
minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y > MINE_DEEP_MIN or minp.y < MINE_DEEP_MAX then
		return
	end
	cnt = cnt+1
	if cnt < 8/MINE_FACTOR then return end
	cnt = 0

	--if math.random(0,100) > 85 then return end
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local data = vm:get_data()
	local va = VoxelArea:new{ MinEdge = emin, MaxEdge = emax }
	local mpos = find_cave(emin,emax,data,va)
	if mpos == nil then return end
	local mpos2 = {x=mpos.x+math.random(0,3),y=mpos.y-1,z=mpos.z}
	local mpos3 = {x=mpos.x,y=mpos.y-2,z=mpos.z+math.random(0,3)}
	data = make_mine(mpos,mpos2,mpos3, data, va, 0)
	vm:set_data(data)
	vm:calc_lighting(emin,emax)
	vm:update_liquids()
	vm:write_to_map()
end)
