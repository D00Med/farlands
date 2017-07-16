
minetest.register_globalstep(function()
	for _, player in ipairs(minetest.get_connected_players()) do
	if player:get_player_name() ~= "singleplayer" then return end
		local item = player:get_wielded_item():get_name()
		if item == "default:torch" or item == "decoblocks:lantern" then
			local pos = player:getpos()
			pos.y = pos.y+1.2
			if minetest.get_node(pos).name == "air" then
				minetest.set_node(pos, {name="tools:light"})
			end
			for i=1,2 do
			local remove_node = minetest.find_node_near(pos, 1, {"tools:light"}, false)
			if remove_node then
				minetest.remove_node(remove_node)
			end
			end
		end
	end
end)

minetest.register_node("tools:light", {
	drawtype = "airlike",
	groups = {not_in_creative_inventory=1},
	walkable = false,
	pointable = false,
	light_source = 10,
})

minetest.register_abm({
	nodenames = {"tools:light"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		minetest.remove_node(pos)
	end,
})

minetest.register_craftitem("tools:watering_can", {
	description = "Watering Can",
	inventory_image = "tools_watering_can.png",
	liquids_pointable = true,
	range = 4,
	on_use = function(item, placer, pointed_thing)
	if pointed_thing.under == nil then return end
	local dir = placer:get_look_dir()
	local pos1 = placer:getpos()
	local pos = pointed_thing.under
	for i=1,10 do
		minetest.add_particle({
			pos = {x=pos1.x+math.random(-5,5)/10, y=pos1.y+0.5, z=pos1.z+math.random(-5,5)/10},
			velocity = {x=pos.x-pos1.x, y=1, z=pos.z-pos1.z},
			acceleration = {x=0, y=-4, z=0},
			expirationtime = 1,
			size = 8,
			collisiondetection = false,
			collisionremoval = true,
			vertical = true,
			texture = "tools_water_spray.png",
		})
	end
	
	local node = minetest.get_node(pos)
	if node.name == "mapgen:dry_dirt" then
		minetest.set_node(pos, {name="default:dirt"})
	end
	
	pos.y = pos.y+1
	local mg_name = minetest.get_mapgen_setting("mg_name")
	local node = minetest.get_node(pos)
	if node.name == "default:sapling" then
		minetest.log("action", "A sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		if mg_name == "v6" then
			default.grow_tree(pos, random(1, 4) == 1)
		else
			default.grow_new_apple_tree(pos)
		end
	elseif node.name == "default:junglesapling" then
		minetest.log("action", "A jungle sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		if mg_name == "v6" then
			default.grow_jungle_tree(pos)
		else
			default.grow_new_jungle_tree(pos)
		end
	elseif node.name == "default:pine_sapling" then
		minetest.log("action", "A pine sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		local snow = minetest.find_node_near(pos, 1, {"group:snowy"})
		if mg_name == "v6" then
			default.grow_pine_tree(pos, snow)
		elseif snow then
			default.grow_new_snowy_pine_tree(pos)
		else
			default.grow_new_pine_tree(pos)
		end
	elseif node.name == "default:acacia_sapling" then
		minetest.log("action", "An acacia sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		default.grow_new_acacia_tree(pos)
	elseif node.name == "default:aspen_sapling" then
		minetest.log("action", "An aspen sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		default.grow_new_aspen_tree(pos)
	elseif node.name == "default:bush_sapling" then
		minetest.log("action", "A bush sapling grows into a bush at "..
			minetest.pos_to_string(pos))
		default.grow_bush(pos)
	elseif node.name == "default:acacia_bush_sapling" then
		minetest.log("action", "An acacia bush sapling grows into a bush at "..
			minetest.pos_to_string(pos))
		default.grow_acacia_bush(pos)
	elseif node.name == "default:palmtree_sapling" then
		minetest.log("action", "A palm tree sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		default.grow_new_palm_tree(pos)
	elseif node.name == "default:baobab_sapling" then
		minetest.log("action", "A baobab tree sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		default.grow_new_baobab_tree(pos)
	elseif node.name == "default:ipe_sapling" then
		minetest.log("action", "A yellow ipe tree sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		default.grow_new_ipe_tree(pos)
	elseif node.name == "default:big_pine_sapling" then
		minetest.log("action", "A big pine tree sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		default.grow_new_big_pine_tree(pos)
	elseif node.name == "default:willow_sapling" then
		minetest.log("action", "A willow tree sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		default.grow_new_willow_tree(pos)
	elseif node.name == "default:bamboo_sapling" then
		minetest.log("action", "A bamboo sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		default.grow_new_bamboo_tree(pos)
	end
	end,
})

minetest.register_craftitem("tools:superpick", {
	description = "Super Pickaxe",
	inventory_image = "default_tool_diamondpick.png^[colorize:red:100",
	liquids_pointable = true,
	on_use = function(item, placer, pointed_thing)
		if pointed_thing.under == nil then
		return end
		if minetest.get_node(pointed_thing.under) ~= nil then
			minetest.remove_node(pointed_thing.under)
		end
	end,
})

minetest.register_tool("tools:bigstone_sword", {
	description = "Big Stone Sword",
	inventory_image = "tools_bigstone_sword.png",
	wield_scale = {x=2, y=2, z=2},
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.4, [3]=0.40}, uses=25, maxlevel=1},
		},
		damage_groups = {fleshy=5, choppy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("tools:big_iron_battleaxe", {
	description = "Big Iron Battleaxe",
	inventory_image = "tools_big_iron_battleaxe.png",
	wield_scale = {x=2, y=2, z=2},
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.4, [3]=0.40}, uses=25, maxlevel=1},
		},
		damage_groups = {fleshy=5, choppy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("tools:sword_crystal", {
	description = "Crystal Sword",
	inventory_image = "tools_sword_crystal.png",
	wield_scale = {x=2, y=2, z=2},
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.4, [3]=0.40}, uses=25, maxlevel=1},
		},
		damage_groups = {fleshy=5, choppy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_craftitem("tools:gameboy", {
	description = "GameBoy",
	inventory_image = "tools_gameboy.png",
})





