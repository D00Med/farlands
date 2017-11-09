--Nodes

minetest.register_node("villages:colony_deed", {
	description = "Villager Colony Deed",
	tiles = {"villages_deed.png"},
	inventory_image = "villages_deed.png",
	wield_image = "villages_deed.png",
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	selection_box = {type="wallmounted",},
	groups = {crumbly=1, dig_immediate=3, oddly_breakable_by_hand=1},
	--on_construct = function(pos, node, placer)
		--local meta = minetest.get_meta(pos)
	--end,
	walkable = false,
})

minetest.register_node("villages:hobo_deed", {
	description = "Hobo Colony Deed",
	tiles = {"villages_hobo_deed.png"},
	inventory_image = "villages_hobo_deed.png",
	wield_image = "villages_hobo_deed.png",
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	selection_box = {type="wallmounted",},
	groups = {crumbly=1, dig_immediate=3, oddly_breakable_by_hand=1,},
	--on_construct = function(pos, node, placer)
		--local meta = minetest.get_meta(pos)
		--meta:set_string("position", "not in building")
		--meta:set_string("population", "0")
	--end,
	walkable = false,
})
--[[
minetest.register_abm({
	nodenames = {"villages:colony_deed"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		local meta = minetest:get_meta(pos)
			minetest.chat_send_all("a deed just checked for a house")
		if meta:get_string("position") == "inside building" then
			if meta:get_string("population") == "0" and math.random(1,2) == 1 then
				minetest.add_entity(pos, "mobs_npc:npc")
				meta:set_string("population", "1")
				minetest.chat_send_all("npc spawned")
			end
		end
		local beds = minetest.find_node_near(pos, 5, {"beds:bed_bottom", "beds:bed", "beds:bed_yellow_bottom", "beds:bed_brown_bottom", "beds:bed_magenta_bottom", "beds:bed_blue_bottom", "beds:bed_orange_bottom", "beds:bed_cyan_bottom", "beds:bed_pink_bottom", "beds:bed_black_bottom", "beds:bed_white_bottom", "beds:bed_darkgrey_bottom", "beds:bed_grey_bottom", "beds:bed_green_bottom", "beds:bed_purple_bottom", "beds:bed_darkgreen_bottom"})
		local light_sources = minetest.find_node_near(pos, 5, {"default:torch", "default:torch_wall", "default:torch_floor", "default:torch_ceiling", "mese_lamp"})
		local doors = minetest.find_node_near(pos, 5, {"doors:door_wood_a", "doors:door_glass_a", "doors:door_obsidian_glass_a"})
		if beds ~= nil and light_sources ~= nil and doors ~= nil then
			meta:set_string("position", "inside building")
			minetest.chat_send_all("a building was found")
		else
			meta:set_string("position", "not in building")
			minetest.chat_send_all("no building was found")
		end
	end
})
]]

--village generation

local function get_positions(pos)
	local positions = {
		{{x=pos.x+11, y=pos.y, z=pos.z+11}},
		{{x=pos.x+11, y=pos.y, z=pos.z+32}},
		{{x=pos.x+11, y=pos.y, z=pos.z+53}},
		{{x=pos.x+11, y=pos.y, z=pos.z+74}},
		{{x=pos.x-10, y=pos.y, z=pos.z+11}},
		{{x=pos.x-10, y=pos.y, z=pos.z+32}},
		{{x=pos.x-10, y=pos.y, z=pos.z+53}},
		{{x=pos.x-10, y=pos.y, z=pos.z+74}},
		{{x=pos.x-32, y=pos.y, z=pos.z+11}},
		{{x=pos.x-32, y=pos.y, z=pos.z+32}},
		{{x=pos.x-32, y=pos.y, z=pos.z+53}},
		{{x=pos.x-32, y=pos.y, z=pos.z+74}},
	}
	return positions
end

local function clear_area(pos)
	local pos = pos
	local pos1 = {x=pos.x-38, y=pos.y+80, z=pos.z-10}
	local pos2 = {x=pos.x+16, y=pos.y-15, z=pos.z+80}
	local nodes = minetest.find_nodes_in_area(pos1, pos2, {"group:tree", "group:leaves", "default:pine_needles", "default:pine_tree"})
	for n = 1, #nodes do
		local pos3 = {x=nodes[n].x, y=nodes[n].y, z=nodes[n].z}
		minetest.remove_node(pos3)
		--minetest.chat_send_all("Node removed")
	end
	return true
end

local function find_ground(pos)
	local node = minetest.get_node(pos).name
	for i=-20,30 do
		local pos2 = pos
		pos2.y = pos.y+i
		local node = minetest.get_node(pos2).name
		local node2 = minetest.get_node({x=pos2.x, y=pos2.y+2, z=pos2.z}).name
		if minetest.get_item_group(node, "cracky") > 0 or minetest.get_item_group(node, "crumbly") > 0 then
			if minetest.get_item_group(node2, "cracky") <= 0 and minetest.get_item_group(node2, "crumbly") <= 0 then
			pos.y = pos2.y
			--minetest.chat_send_all(minetest.pos_to_string(pos, 0))
			return pos
			end
		end
	end
end

local village_rarity = 5

minetest.register_on_generated(function(minp, maxp)
	if maxp.y > 8000 or maxp.y < -20 then
		return
	end
	if math.random(1, village_rarity) == 1 then
	local surface = minetest.find_nodes_in_area_under_air(minp, maxp,
		{"default:dirt_with_grass", "mapgen:dirt_with_leafygrass", "mapgen:dirt_with_junglegrass", "mapgen:dirt_with_swampgrass", "default:dirt_with_dry_grass", "default:dirt_with_snow"})
	for n = 1, #surface do
		if math.random(1, village_rarity*1000) == 1 then
			local pos = {x=surface[n].x, y=surface[n].y, z=surface[n].z}
			local positions = get_positions(pos)
			minetest.set_node(pos, {name="mobs_npc:beacon"})
			for _, position in ipairs(positions) do
			local number = math.random(1,7)
			local test_pos = position[1]
			local place_pos = find_ground(test_pos)
			if place_pos == nil then 
			return end
				local node = minetest.get_node(place_pos).name
				minetest.place_schematic(place_pos, minetest.get_modpath("villages").."/schematics/structure_"..number..".mts", random, {["default:dirt_with_grass"] = node, ["farming:corn_5"] = "farming:corn_4"}, true)
			end
		end
		end
	end
end)

minetest.register_craftitem("villages:builder_tool", {
	description = "Village Building Tool",
	inventory_image = "villages_spanner.png",
	groups = {not_in_creative_inventory=1},
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.under == nil then
		return end
		if minetest.get_node(pointed_thing.under) ~= nil then
			local place_pos = pointed_thing.under
			local node = minetest.get_node(pointed_thing.under).name
			minetest.place_schematic(place_pos, minetest.get_modpath("villages").."/schematics/structure_4.mts", random, {["default:dirt_with_grass"] = node, ["farming:corn_5"] = "farming:corn_4"}, true)
		end
	end,
})

minetest.register_craftitem("villages:book", {
	description = "Village Building Book",
	inventory_image = "villages_book.png",
	groups = {book=1},
	on_use = function(itemstack, user, pointed_thing)
		local formspec = "size[10,8]"..
		"background[-0.6,-0.65;11.5,10.4;villages_book_gui.png^villages_book_room.png]"..
		"image_button[9,7;1,1;villages_book_button.png;btn;;false;false;villages_book_button2.png]";
		minetest.show_formspec(user:get_player_name(), "villages:book_f", formspec);
	end,
})

minetest.register_on_player_receive_fields(function(player, form, field)
	if form == "villages:book_f" then
		local formspec = "size[10,8]"..
		"background[-0.6,-0.65;11.5,10.4;villages_book_gui.png^villages_book_beacon.png]"..
		"image_button[0.1,7;1,1;villages_book_buttonfx.png;btn2;;false;false;villages_book_button2fx.png";
		minetest.show_formspec(player:get_player_name(), "villages:book_f2", formspec);
	end
end)

minetest.register_on_player_receive_fields(function(player, form, field)
	if form == "villages:book_f2" then
		local formspec = "size[10,8]"..
		"background[-0.6,-0.65;11.5,10.4;villages_book_gui.png^villages_book_room.png]"..
		"image_button[9,7;1,1;villages_book_button.png;btn;;false;false;villages_book_button2.png]";
		minetest.show_formspec(player:get_player_name(), "villages:book_f", formspec);
	end
end)
