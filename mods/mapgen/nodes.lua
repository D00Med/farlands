mapgen = {}

--functions
function mapgen.register_fern(name, desc, texnumber)
minetest.register_node("mapgen:"..name, {
	description = desc,
	drawtype = "mesh",
	mesh = "fern.b3d",
	tiles = {
		"mapgen_fern"..texnumber..".png",
	},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
	},
	paramtype2 = "degrotate",
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, oddly_breakable_by_hand = 1, flora = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults()
})
end

function mapgen.register_shrub(name, desc, texnumber)
minetest.register_node("mapgen:"..name, {
	description = desc,
	drawtype = "mesh",
	mesh = "shrub.obj",
	tiles = {
		"mapgen_shrub"..texnumber..".png",
	},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
	},
	on_construct = function(pos, node)
		local node = minetest.get_node(pos)
		node.param2 = math.random(0,179)
	end,
	paramtype2 = "degrotate",
	visual_scale = 0.5,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, oddly_breakable_by_hand = 1, flora = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults()
})
end

--function nodes

mapgen.register_fern("fern", "Ladyfern", "1")
mapgen.register_fern("fern2", "Broad Leaf Fern", "2")

mapgen.register_shrub("shrub", "Hog Peanut", "1")
mapgen.register_shrub("shrub2", "Deciduous Forest Shrub", "2")

--overrides

minetest.override_item("default:cactus", {
	drawtype = "mesh",
	mesh = "cactus.b3d",
	paramtype = "light",
	visual_scale = 0.5,
	selection_box = {
	type = "fixed",
	fixed = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
	},
	collision_box = {
	type = "fixed",
	fixed = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
	},
})

--nodes

minetest.register_node("mapgen:dungeon_spawner", {
	description = "Dungeon Spawner",
	tiles = {"mapgen_dungeon_spawner.png"},
	groups = {cracky=1,},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function(pos, node, clicker)
		local check_pos = pos
		check_pos.y = check_pos.y-1
		local node_below = minetest.get_node(check_pos)
		if node_below == "default:dirt_with_junglegrass" then
		elseif node_below == "default:desert_sand" then
		end
		minetest.chat_send_player(clicker:get_player_name(), "This node is unfinished")
	end,	
})

--plants (PLNT01)

minetest.register_node("mapgen:waterlily", {
	description = "Waterlily (no flower)",
	drawtype = "mesh",
	mesh = "waterlily.b3d",
	paramtype = "light",
	paramtype2 = "facedir",
	visual_scale = 0.5,
	tiles = {"mapgen_waterlily_noflower.png",},
	inventory_image = "mapgen_waterlily_item.png",
	wield_image = "mapgen_waterlily_item.png",
	liquids_pointable = true,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	floodable = true,
	groups = {snappy = 3, flower = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	node_placement_prediction = "",
	selection_box = {
		type = "fixed",
		fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, -15 / 32, 7 / 16}
	},

	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		local node = minetest.get_node(pointed_thing.under).name
		local def = minetest.registered_nodes[node]
		local player_name = placer:get_player_name()

		if def and def.liquidtype == "source" and
				minetest.get_item_group(node, "water") > 0 then
			if not minetest.is_protected(pos, player_name) then
				if math.random(1,2) == 1 then
				minetest.set_node(pos, {name = "mapgen:waterlily",
					param2 = math.random(0, 3)})
				else
				minetest.set_node(pos, {name = "flowers:waterlily",
					param2 = math.random(0, 3)})
				end
				if not minetest.setting_getbool("creative_mode") then
					itemstack:take_item()
				end
			else
				minetest.chat_send_player(player_name, "Node is protected")
				minetest.record_protection_violation(pos, player_name)
			end
		end

		return itemstack
	end
})

minetest.override_item("flowers:waterlily", {
	drawtype = "mesh",
	tiles = {"mapgen_waterlily.png"},
	mesh = "waterlily.b3d",
	paramtype = "light",
	visual_scale = 0.5,
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		local node = minetest.get_node(pointed_thing.under).name
		local def = minetest.registered_nodes[node]
		local player_name = placer:get_player_name()

		if def and def.liquidtype == "source" and
				minetest.get_item_group(node, "water") > 0 then
			if not minetest.is_protected(pos, player_name) then
				if math.random(1,2) == 1 then
				minetest.set_node(pos, {name = "mapgen:waterlily",
					param2 = math.random(0, 3)})
				else
				minetest.set_node(pos, {name = "flowers:waterlily",
					param2 = math.random(0, 3)})
				end
				if not minetest.setting_getbool("creative_mode") then
					itemstack:take_item()
				end
			else
				minetest.chat_send_player(player_name, "Node is protected")
				minetest.record_protection_violation(pos, player_name)
			end
		end

		return itemstack
	end
})

minetest.register_node("mapgen:red_ground_flower", {
	description = "Red Ground flower",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"mapgen_red_ground_flower.png",
	},
	node_box = {
		type = "fixed",
		fixed = {
		{-0.5,-0.5,-0.5,0.5,-0.49,0.5}
		}
	},
	buildable_to = true,
	groups = {snappy = 3, flammable = 1, dig_immediate = 1, flower = 1},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("mapgen:pink_ground_flower", {
	description = "Pink Ground flower",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"mapgen_pink_ground_flower.png",
	},
	node_box = {
		type = "fixed",
		fixed = {
		{-0.5,-0.5,-0.5,0.5,-0.49,0.5}
		}
	},
	buildable_to = true,
	groups = {snappy = 3, flammable = 1, dig_immediate = 1, flower = 1},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("mapgen:blue_ground_flower", {
	description = "Blue Ground Flower",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"mapgen_blue_ground_flower.png",
	},
	node_box = {
		type = "fixed",
		fixed = {
		{-0.5,-0.5,-0.5,0.5,-0.49,0.5}
		}
	},
	buildable_to = true,
	groups = {snappy = 3, flammable = 1, dig_immediate = 1, flower = 1},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("mapgen:dicksonia", {
	description = "Dicksonia",
	drawtype = "mesh",
	mesh = "dicksonia.b3d",
	tiles = {
		"mapgen_dicksonia.png",
	},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {choppy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("mapgen:statue", {
	description = "Statue",
	drawtype = "mesh",
	mesh = "statue.obj",
	tiles = {
		"mapgen_statue.png",
	},
	wield_scale = {x=0.5, y=0.5, z=0.5},
	paramtype = "light",
	paramtype2 = "facedir",
	selection_box = {
		type = "fixed",
		fixed = {-1, -0.5, -1, 1, 1.8, 0.5}
	},
	collision_box = {
		type = "fixed",
		fixed = {-1, -0.5, -1, 1, 1.8, 0.5}
	},
	groups = {cracky = 1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("mapgen:willow_leaves", {
	description = "Willow Leaves",
	drawtype = "allfaces_optional",
	tiles = {"mapgen_willow_leaves.png",},
	special_tiles = {"mapgen_willow_leaves_simple.png",},
	waving = 2,
	paramtype = "light",
	drop = {
		max_items = 1,
		items = {
			{items = {"default:willow_sapling",},
				rarity = 20,},
			{items = {"mapgen:willow_leaves",}},
		},
	},
	groups = {snappy = 3, flammable = 1, leaves = 1, leafdecay = 1},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("mapgen:willow_wood", {
	description = "Willow Wood Planks",
	tiles = {
		"mapgen_willow_wood.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1, wood=1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("mapgen:willow_tree", {
	description = "Willow Tree",
	tiles = {
		"mapgen_willow_tree_top.png",
		"mapgen_willow_tree_top.png",
		"mapgen_willow_tree.png",
	},
	groups = {choppy = 2, tree = 1, flammable = 1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_node("mapgen:baobab_leaves", {
	description = "Baobab Leaves",
	drawtype = "allfaces_optional",
	tiles = {"mapgen_baobab_leaves.png",},
	special_tiles = {"mapgen_baobab_leaves_simple.png",},
	waving = 2,
	paramtype = "light",
	drop = {
		max_items = 1,
		items = {
			{items = {"default:baobab_sapling",},
				rarity = 20,},
			{items = {"mapgen:baobab_leaves",}},
		},
	},
	groups = {snappy = 3, flammable = 1, leaves = 1, leafdecay = 1},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("mapgen:baobab_wood", {
	description = "Baobab wood Planks",
	tiles = {
		"mapgen_baobab_wood.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1, wood=1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("mapgen:baobab_tree", {
	description = "Baobab tree",
	tiles = {
		"mapgen_baobab_tree_top.png",
		"mapgen_baobab_tree_top.png",
		"mapgen_baobab_tree.png",
	},
	groups = {choppy = 2, tree = 1, flammable = 1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

-- fence code from minetest_game, see default mod's license.txt

default.register_fence("mapgen:fence_baobab", {
	description = "Baobab Fence",
	texture = "mapgen_baobab_fence.png",
	inventory_image = "default_fence_overlay.png^mapgen_baobab_fence.png^default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^mapgen_baobab_fence.png^default_fence_overlay.png^[makealpha:255,126,126",
	material = "mapgen:baobab_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("mapgen:yellow_ipe_leaves", {
	description = "Yellow Ipe Leaves",
	drawtype = "allfaces_optional",
	tiles = {"mapgen_yellow_ipe_leaves.png",},
	special_tiles = {"mapgen_yellow_ipe_leaves_simple.png",},
	waving = 2,
	paramtype = "light",
	drop = {
		max_items = 1,
		items = {
			{items = {"default:ipe_sapling",},
				rarity = 20,},
			{items = {"mapgen:yellow_ipe_leaves",}},
		},
	},
	groups = {snappy = 3, flammable = 1, leaves = 1, leafdecay = 1},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("mapgen:yellow_ipe_wood", {
	description = "Yellow Ipe Planks",
	tiles = {
		"mapgen_yellow_ipe_wood.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1, wood=1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("mapgen:yellow_ipe_tree", {
	description = "Yellow Ipe Tree",
	tiles = {
		"mapgen_yellow_ipe_tree_top.png",
		"mapgen_yellow_ipe_tree_top.png",
		"mapgen_yellow_ipe_tree.png",
	},
	groups = {choppy = 2, tree = 1, flammable = 1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

default.register_fence("mapgen:fence_yellow_ipe", {
	description = "Yellow Ipe Fence",
	texture = "mapgen_yellow_ipe_fence.png",
	inventory_image = "default_fence_overlay.png^mapgen_yellow_ipe_fence.png^default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^mapgen_yellow_ipe_fence.png^default_fence_overlay.png^[makealpha:255,126,126",
	material = "mapgen:yellow_ipe_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("mapgen:coarse_dirt", {
	description = "Coarse Dirt",
	tiles = {"mapgen_coarse_dirt.png"},
	groups = {crumbly = 3, dig_immediate=3},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_node("mapgen:dry_dirt", {
	description = "Dry Dirt",
	tiles = {"mapgen_dry_dirt.png"},
	groups = {crumbly = 3},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_node("mapgen:dirt_with_junglegrass", {
	description = "Dirt with Jungle Grass",
	tiles = {"mapgen_jungle_grass.png", "default_dirt.png", "default_dirt.png^mapgen_jungle_grass_side.png"},
	groups = {crumbly = 3,},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_node("mapgen:lantana", {
	description = "Lantana",
	drawtype = "plantlike",
	tiles = {
		"mapgen_lantana.png",
	},
	groups = {snappy=3, flammable=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	is_ground_content=true,
	buildable_to = true, 
	walkable = false,
	inventory_image = "mapgen_lantana.png",
	paramtype = "light",
	sunlight_propagates=true,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.1, 0.5}
	},
})

minetest.register_node("mapgen:creeper", {
	description = "Creeper",
	drawtype = "firelike",
	tiles = {
		"mapgen_creeper.png",
		"mapgen_trans.png",
		"mapgen_creeper.png",
		"mapgen_creeper.png",
		"mapgen_creeper.png",
		"mapgen_creeper.png"
	},
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	is_ground_content=true,
	buildable_to = true, 
	sunlight_propagates = true,
	walkable = false,
	inventory_image = "mapgen_creeper.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.1, 0.5}
	},
})

minetest.register_node("mapgen:cavefern1", {
	description = "Cave Fern",
	drawtype = "plantlike",
	tiles = {
		"mapgen_cavefern.png",
	},
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	is_ground_content=true,
	buildable_to = true, 
	walkable = false,
	inventory_image = "mapgen_cavefern.png",
	paramtype = "light",
	sunlight_propagates=true,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, 0.1, -0.5, 0.5, 0.5, 0.5}
	},
})

minetest.register_node("mapgen:cavefern2", {
	description = "Cave Fern",
	drawtype = "plantlike",
	tiles = {
		"mapgen_cavefern2.png",
	},
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	is_ground_content=true,
	buildable_to = true, 
	walkable = false,
	inventory_image = "mapgen_cavefern2.png",
	paramtype = "light",
	sunlight_propagates=true,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, 0.1, -0.5, 0.5, 0.5, 0.5}
	},
})

minetest.register_node("mapgen:palm_tree", {
	description = "Palm Tree",
	tiles = {
		"mapgen_palmtree_top.png",
		"mapgen_palmtree_top.png",
		"mapgen_palmtree_side.png",
	},
	groups = {choppy = 2, tree = 1, flammable = 1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_node("mapgen:palm_wood", {
	description = "Palm Wood Planks",
	tiles = {
		"mapgen_palm_wood.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1, wood=1},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence("mapgen:fence_palm_wood", {
	description = "palm fence",
	texture = "mapgen_palm_fence.png",
	inventory_image = "default_fence_overlay.png^mapgen_palm_fence.png^default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^mapgen_palm_fence.png^default_fence_overlay.png^[makealpha:255,126,126",
	material = "mapgen:baobab_wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()

})

minetest.register_node("mapgen:palm_leaves", {
	description = "Palm Leaves",
	drawtype = "allfaces_optional",
	tiles = {"mapgen_palmleaves.png",},
	special_tiles = {"mapgen_palmleaves_simple.png",},
	waving = 2,
	paramtype = "light",
	drop = {
		max_items = 1,
		items = {
			{items = {"default:palmtree_sapling",},
				rarity = 20,},
			{items = {"mapgen:palm_leaves",}},
		},
	},
	groups = {snappy = 3, flammable = 1, leaves = 1, leafdecay = 1},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("mapgen:pineapple_plant_growing", {
	description = "Pineapple Plant",
	drawtype = "plantlike",
	paramtype = "light",
	visual_scale = 2,
	walkable = false,
	tiles = {
		"mapgen_pineapple_plant_growing.png",
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.3, 0.2},
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1, flammable = 1, dig_immediate = 1, flora = 1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_abm({
	nodenames = {"mapgen:pineapple_plant_growing"},
	interval = 30,
	chance = 2,
	action = function(pos, node)
		minetest.env:set_node(pos, {name="mapgen:pineapple_plant"})
	end
})

minetest.register_node("mapgen:pineapple_plant", {
	description = "Pineapple Plant",
	drawtype = "plantlike",
	paramtype = "light",
	visual_scale = 2,
	walkable = false,
	tiles = {
		"mapgen_pineapple_plant.png",
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.3, 0.2},
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1, flammable = 1, dig_immediate = 1, flora = 1,},
	sounds = default.node_sound_leaves_defaults(),
	on_rightclick = function(pos, node)
		minetest.env:set_node(pos, {name="mapgen:pineapple_plant_growing"})
		minetest.env:add_item(pos, "mapgen:pineapple")
	end,
})

minetest.register_craftitem("mapgen:pineapple", {
	description = "Pineapple",
	inventory_image = "mapgen_pineapple.png",
	on_use = minetest.item_eat(4)
})

minetest.register_node("mapgen:moss", {
	description = "Moss",
	drawtype = "nodebox",
	tiles = {"mapgen_moss.png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
		}
	},
	buildable_to = true,
	groups = {snappy = 3, oddly_breakable_by_hand=1, dig_immediate=3},
	sounds = default.node_sound_leaves_defaults(),
})

--plantlike (PLNT02)

minetest.register_node("mapgen:tallgrass", {
	description = "Tall Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_longgrass.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_longgrass.png",
	visual_scale = 2,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:giantgrass", {
	description = "Giant Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_giantgrass.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_giantgrass.png",
	visual_scale = 4,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})


minetest.register_node("mapgen:bananaplant", {
	description = "Banana Plant",
	drawtype = "plantlike",
	tiles = {"mapgen_banana_plant.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_banana_plant.png",
	visual_scale = 2,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3}
	},
	walkable = false,
})

minetest.register_node("mapgen:jungletree", {
	description = "Small Jungle Tree",
	drawtype = "plantlike",
	tiles = {"mapgen_jungletree.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_jungletree.png",
	visual_scale = 2,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 1, 0.2}
	},
	walkable = false,
})

minetest.register_node("mapgen:bamboo_small", {
	description = "Small Bamboo",
	drawtype = "plantlike",
	tiles = {"mapgen_bamboo_small.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	inventory_image = "mapgen_bamboo_small.png",
	groups = {snappy=1, flammable=1, oddly_breakable_by_hand=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}
	},
	walkable = false,
})

minetest.register_node("mapgen:bamboo_small_top", {
	description = "Small Bamboo Top",
	drawtype = "plantlike",
	tiles = {"mapgen_bamboo_small_top.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	visual_scale = 2,
	inventory_image = "mapgen_bamboo_small_top.png",
	groups = {snappy=1, flammable=1, oddly_breakable_by_hand=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}
	},
	walkable = false,
})

minetest.register_node("mapgen:bamboo_grass", {
	description = "Bamboo Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_bamboo_grass.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	inventory_image = "mapgen_bamboo_grass.png",
	groups = {snappy=1, flammable=1, oddly_breakable_by_hand=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.3, 0.2}
	},
	walkable = false,
})

minetest.register_node("mapgen:bamboo", {
	description = "Bamboo",
	tiles = {
	"mapgen_bamboo_top.png",	
	"mapgen_bamboo_top.png",
	"mapgen_bamboo.png"
	},
	is_ground_content = false,
	sunlight_propagates = false,
	groups = {choppy=1, flammable=1, oddly_breakable_by_hand=1, tree=1},
	sounds = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875}, -- NodeBox1
			{-0.5, -0.5, 0, 0.5, 0.5, 0}, -- NodeBox2
			{0.00470524, -0.5, -0.5, 0.00470524, 0.5, 0.5}, -- NodeBox3
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
		}
	},
	walkable = true,
})

minetest.register_node("mapgen:bamboo_leaves", {
	description = "Bamboo Leaves",
	drawtype = "allfaces",
	tiles = {"mapgen_bamboo_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = false,
	groups = {snappy=3, flammable=1, leafdecay=4, leaves=1},
	sounds = default.node_sound_leaves_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {"default:bamboo_sapling",},
				rarity = 20,},
			{items = {"mapgen:bamboo_leaves",}},
		},
	},
})

minetest.register_node("mapgen:bush", {
	description = "Deciduous Forest Bush",
	drawtype = "firelike",
	tiles = {"mapgen_bush.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = false,
	groups = {snappy=3, flammable=1, oddly_breakable_by_hand=1, leaves=1},
	visual_scale = 1.2,
	sounds = default.node_sound_leaves_defaults(),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.4, -0.4, 0.4, 0.4, 0.4}
	},
})

minetest.register_node("mapgen:bamboo_with_leaves", {
	description = "Bamboo With Leaves",
	tiles = {
	"mapgen_bamboo_top.png",
	"mapgen_bamboo_top.png",
	"mapgen_bamboo_leaves.png^mapgen_bamboo.png"
	},
	is_ground_content = false,
	sunlight_propagates = false,
	groups = {choppy=1, flammable=1, oddly_breakable_by_hand=1, tree=1, leaves=1},
	sounds = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875}, -- NodeBox1
			{-0.5, -0.5, 0, 0.5, 0.5, 0}, -- NodeBox2
			{0.00470524, -0.5, -0.5, 0.00470524, 0.5, 0.5}, -- NodeBox3
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
		}
	},
	drop = "mapgen:bamboo"
})

minetest.register_node("mapgen:bamboo_wood", {
	description = "Bamboo Wood Planks",
	tiles = {"mapgen_bamboo_planks.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("mapgen:flame_lily", {
	description = "Flame Lily",
	drawtype = "plantlike",
	tiles = {"mapgen_flame_lily.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_flame_lily.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
	},
	walkable = false,
})

minetest.register_node("mapgen:jungle_grass_1", {
	description = "Jungle Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_jungle_grass_1.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:jungle_grass_5",
	inventory_image = "mapgen_jungle_grass_1.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:jungle_grass_2", {
	description = "Jungle Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_jungle_grass_2.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:jungle_grass_5",
	inventory_image = "mapgen_jungle_grass_2.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:jungle_grass_3", {
	description = "Jungle Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_jungle_grass_3.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:jungle_grass_5",
	inventory_image = "mapgen_jungle_grass_3.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:jungle_grass_4", {
	description = "Jungle Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_jungle_grass_4.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:jungle_grass_5",
	inventory_image = "mapgen_jungle_grass_4.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:jungle_grass_5", {
	description = "Jungle Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_jungle_grass_5.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:jungle_grass_5",
	inventory_image = "mapgen_jungle_grass_5.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
	on_construct = function(pos)
		local num = math.random(1,5)
		minetest.env:set_node(pos, {name="mapgen:jungle_grass_"..num})
	end,
})

minetest.register_node("mapgen:snow_grass_1", {
	description = "Frozen Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_snow_grass_1.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:snow_grass_5",
	inventory_image = "mapgen_snow_grass_1.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:snow_grass_2", {
	description = "Frozen Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_snow_grass_2.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:snow_grass_5",
	inventory_image = "mapgen_snow_grass_2.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:snow_grass_3", {
	description = "Frozen Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_snow_grass_3.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:snow_grass_5",
	inventory_image = "mapgen_snow_grass_3.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:snow_grass_4", {
	description = "Frozen Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_snow_grass_1.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:snow_grass_5",
	inventory_image = "mapgen_snow_grass_4.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:snow_grass_5", {
	description = "Frozen Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_snow_grass_5.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:snow_grass_5",
	inventory_image = "mapgen_snow_grass_5.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:swamp_grass_1", {
	description = "swamp Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_swamp_grass_1.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:swamp_grass_5",
	inventory_image = "mapgen_swamp_grass_1.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:swamp_grass_2", {
	description = "swamp Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_swamp_grass_2.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:swamp_grass_5",
	inventory_image = "mapgen_swamp_grass_2.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:swamp_grass_3", {
	description = "swamp Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_swamp_grass_3.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:swamp_grass_5",
	inventory_image = "mapgen_swamp_grass_3.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:swamp_grass_4", {
	description = "swamp Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_swamp_grass_4.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:swamp_grass_5",
	inventory_image = "mapgen_swamp_grass_4.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:swamp_grass_5", {
	description = "swamp Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_swamp_grass_5.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	drop = "mapgen:swamp_grass_5",
	inventory_image = "mapgen_swamp_grass_5.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
	on_construct = function(pos)
		local num = math.random(1,5)
		minetest.env:set_node(pos, {name="mapgen:swamp_grass_"..num})
	end,
})


minetest.register_node("mapgen:vine", {
	description = "Vine",
	drawtype = "nodebox",
	tiles = {
	"mapgen_trans.png",
	"mapgen_trans.png",
	"mapgen_trans.png",
	"mapgen_trans.png",
	"mapgen_vine.png",
	"mapgen_vine.png",
	},
	inventory_image = "mapgen_vine.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = false,
	walkable = false,
	climbable = true,
	drop = "mapgen:vine",
	node_box = {
		type = "fixed",
		fixed = {{-0.5, -0.5, 0.5, 0.5, 0.5, 0.48}}
	},
	groups = {cracky=3, oddly_breakable_by_hand=1},
})

minetest.register_node("mapgen:dirt_with_swampgrass", {
	description = "Dirt With Swamp Grass",
	tiles = {"mapgen_swamp_grass.png", "default_dirt.png", "default_dirt.png^mapgen_swamp_grass_side.png"},
	groups = {crumbly = 3,},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_node("mapgen:dirt_with_leafygrass", {
	description = "Dirt With Leaf Covered Grass",
	tiles = {"mapgen_leafy_grass.png", "default_dirt.png", "default_dirt.png^mapgen_leafy_grass_side.png"},
	groups = {crumbly = 3,},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_node("mapgen:aloe_vera", {
	description = "Aloe Vera",
	drawtype = "plantlike",
	tiles = {"mapgen_aloe_vera.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_aloe_vera.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:cattail", {
	description = "Cattail",
	drawtype = "plantlike",
	tiles = {"mapgen_cattail.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_cattail.png",
	visual_scale = 2,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3}
	},
	walkable = false,
})

minetest.register_node("mapgen:lavender_flower", {
	description = "Lavender Flower",
	drawtype = "plantlike",
	tiles = {"mapgen_lavender_flower.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_lavender_flower.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:oxeye_daisy", {
	description = "Oxeye Daisy",
	drawtype = "plantlike",
	tiles = {"mapgen_oxeye_daisy.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_oxeye_daisy.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:small_cactus", {
	description = "Small Cactus",
	drawtype = "plantlike",
	tiles = {"mapgen_small_cactus.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_small_cactus.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:small_cactus_1", {
	description = "Small Cactus",
	drawtype = "plantlike",
	tiles = {"mapgen_small_cactus_1.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_small_cactus_1.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:purple_allium", {
	description = "Purple Allium",
	drawtype = "plantlike",
	tiles = {"mapgen_purple_allium.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_purple_allium.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:wild_oat", {
	description = "Wild Oat",
	drawtype = "plantlike",
	tiles = {"mapgen_wild_oat.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_wild_oat.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:wild_oat_dry", {
	description = "Dry Wild Oat",
	drawtype = "plantlike",
	tiles = {"mapgen_wild_oat_dry.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_wild_oat_dry.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:dead_grass_1", {
	description = "Dead Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_dead_grass_2.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_dead_grass_1.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
	drop = "drop:dead_grass_5",
})

minetest.register_node("mapgen:dead_grass_2", {
	description = "Dead Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_dead_grass_3.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_dead_grass_2.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
	drop = "drop:dead_grass_5",
})

minetest.register_node("mapgen:dead_grass_3", {
	description = "Dead Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_dead_grass_4.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_dead_grass_3.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
	drop = "drop:dead_grass_5",
})

minetest.register_node("mapgen:dead_grass_4", {
	description = "Dead Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_dead_grass_5.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_dead_grass_4.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
	drop = "drop:dead_grass_5",
})

minetest.register_node("mapgen:dead_grass_5", {
	description = "Dead Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_dead_grass_5.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_dead_grass_4.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
	on_construct = function(pos)
		local num = math.random(1,5)
		minetest.env:set_node(pos, {name="mapgen:dead_grass_"..num})
	end
})

--underwater (WATR01)

minetest.register_node("mapgen:big_coral", {
	description = "Big Pink Coral",
	drawtype = "plantlike",
	visual_scale = 2,
	tiles = {"mapgen_big_coral.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_big_coral.png",
	groups = {snappy=3, flammable=1, attatched_node=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:red_coral", {
	description = "Pink Coral",
	drawtype = "plantlike",
	tiles = {"mapgen_pink_coral.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_pink_coral.png",
	groups = {snappy=3, flammable=1, attatched_node=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:orange_coral", {
	description = "Orange Coral",
	drawtype = "plantlike",
	tiles = {"mapgen_orange_coral.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_orange_coral.png",
	groups = {snappy=3, flammable=1, attatched_node=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:blue_coral", {
	description = "Blue Coral",
	drawtype = "plantlike",
	tiles = {"mapgen_blue_coral.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_blue_coral.png",
	groups = {snappy=3, flammable=1, attatched_node=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:anemone", {
	description = "Anemone",
	drawtype = "plantlike",
	tiles = {"mapgen_anemone.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_anemone.png",
	groups = {snappy=3, flammable=1, attatched_node=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})

minetest.register_node("mapgen:kelp1", {
	description = "Kelp",
	drawtype = "plantlike",
	tiles = {"mapgen_kelp.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_kelp.png",
	groups = {snappy=3, flammable=1, attatched_node=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}
	},
	walkable = false,
})

minetest.register_node("mapgen:kelp2", {
	description = "Kelp",
	drawtype = "plantlike",
	tiles = {"mapgen_kelp_2.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_kelp.png",
	groups = {snappy=3, flammable=1, attatched_node=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}
	},
	walkable = false,
})

minetest.register_node("mapgen:seagrass_1", {
	description = "Sea Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_seagrass_1.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_seagrass_1.png",
	groups = {snappy=3, flammable=1, attatched_node=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	drop = "mapgen:seagrass_1",
	walkable = false,
	on_construct = function(pos)
		local num = math.random(1,3)
		minetest.env:set_node(pos, {name="mapgen:seagrass_"..num})
	end,
})

minetest.register_node("mapgen:seagrass_2", {
	description = "Sea Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_seagrass_2.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_seagrass_2.png",
	groups = {snappy=3, flammable=1, attatched_node=1, sea=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	drop = "mapgen:seagrass_1",
	walkable = false,
})

minetest.register_node("mapgen:seagrass_3", {
	description = "Sea Grass",
	drawtype = "plantlike",
	tiles = {"mapgen_seagrass_3.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	waving = 1,
	inventory_image = "mapgen_seagrass_3.png",
	groups = {snappy=3, flammable=1, attatched_node=1, sea=1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	drop = "mapgen:seagrass_1",
	walkable = false,
})

--stone (STN02)

minetest.register_node("mapgen:stone_with_sea_grass", {
	description = "Stone With Sea Grass",
	tiles = {"mapgen_sea_grass.png", "default_stone.png",
	{name = "default_stone.png^mapgen_sea_grass_side.png",
	tileable_vertical = false}},
	groups = {crumbly = 3,},
	drop = 'mapgen:seagrass_1',
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:stone_with_ammonite", {
	description = "Stone with Ammonite",
	tiles = {"mapgen_marine_fossil.png"},
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:stone_with_bone", {
	description = "Stone with Bone",
	tiles = {"mapgen_land_fossil.png"},
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:granite", {
	description = "Granite",
	tiles = {"mapgen_granite.png"},
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("mapgen:granite_brown", {
	description = "Brown Granite",
	tiles = {"mapgen_granite_brown.png"},
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("mapgen:limestone", {
	description = "Limestone",
	tiles = {"mapgen_limestone.png"},
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:marble", {
	description = "Marble",
	tiles = {"mapgen_marble.png"},
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:savanna_cobblestone_stone", {
	description = "Savanna Cobblestone",
	tiles = {"mapgen_savanna_cobblestone_stone.png"},
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:savanna_coal", {
	description = "Savanna Stone With Coal",
	tiles = {"mapgen_savannah_coal.png"},
	groups = {cracky = 3, stone = 1, ore=1},
	drop = 'default:coal_lump',
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:savanna_iron", {
	description = "Savanna Stone With Iron",
	tiles = {"mapgen_savannah_iron.png"},
	groups = {cracky = 2, stone = 1, ore=1},
	drop = 'default:iron_lump',
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:savanna_stone", {
	description = "Savannah Stone",
	tiles = {"mapgen_savannah_stone.png"},
	groups = {cracky = 3, stone=1},
	drop = 'mapgen:savanna_cobblestone_stone',
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:icicle", {
	description = "Icicle",
	drawtype = "plantlike",
	tiles = {"mapgen_icicle.png"},
	inventory_image = "mapgen_icicle.png",
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	walkable = false,
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("mapgen:stalagtite", {
	description = "Stalagtite",
	drawtype = "plantlike",
	tiles = {"mapgen_stalagmite0.png"},
	inventory_image = "mapgen_stalagmite0.png",
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	walkable = false,
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:stalagtite1", {
	description = "Stalagtite",
	drawtype = "plantlike",
	tiles = {"mapgen_stalagmite1.png"},
	inventory_image = "mapgen_stalagmite1.png",
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	walkable = false,
	groups = {crumbly=1, oddly_breakable_by_hand=1},
})

minetest.register_node("mapgen:stalagtite2", {
	description = "Stalagtite",
	drawtype = "plantlike",
	tiles = {"mapgen_stalagmite2.png"},
	inventory_image = "mapgen_stalagmite2.png",
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	walkable = false,
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:stalagtite3", {
	description = "Stalagtite",
	drawtype = "plantlike",
	tiles = {"mapgen_stalagmite3.png"},
	inventory_image = "mapgen_stalagmite3.png",
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	walkable = false,
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:stalagmite0", {
	description = "Stalagmite",
	drawtype = "plantlike",
	tiles = {"mapgen_stalagmite0.png^[transformFY"},
	inventory_image = "mapgen_stalagmite0.png^[transformFY",
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	walkable = false,
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:stalagmite1", {
	description = "Stalagmite",
	drawtype = "plantlike",
	visual_scale = 2,
	tiles = {"mapgen_stalagmite3.png^[transformFY"},
	inventory_image = "mapgen_stalagmite3.png^[transformFY",
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	walkable = false,
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:stalagmite2", {
	description = "Stalagmite",
	drawtype = "plantlike",
	visual_scale = 1.5,
	tiles = {"mapgen_stalagmite2.png^[transformFY"},
	inventory_image = "mapgen_stalagmite2.png^[transformFY",
	is_ground_content = false,
	sunlight_propagates = true,
	paramtype = "light",
	selection_box = {
	type = "fixed",
	fixed = {{-0.3, -0.2, -0.3, 0.3, 0.5, 0.3}}
	},
	walkable = false,
	groups = {crumbly=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults()
})

--crystals

minetest.register_node("mapgen:crystal_block", {
	description = "Crystal stone",
	tiles = {{
		name = "mapgen_crystal_stone.png",
		animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.00},
	}},
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 7,
	groups = {cracky=2, dig_immediate=3, flammable=1},
	sounds = default.node_sound_glass_defaults()	
})

minetest.register_node("mapgen:crystal_small", {
	description = "Small Crystal",
	tiles = {{
		name = "mapgen_crystal_anim.png",
		animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.00},
	}},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 7,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.375, 0.125}, -- NodeBox3
			{-0.0625, -0.5, -0.0625, 0.0625, 0.4375, 0.0625}, -- NodeBox4
			{0, -0.5, 0.1875, 0.1875, 0.125, 0.375}, -- NodeBox5
			{0.0625, -0.5, 0.25, 0.125, 0.0625, 0.3125}, -- NodeBox6
			{-0.3125, -0.5, -0.375, -0.125, -0.0625, -0.1875}, -- NodeBox7
			{-0.25, -0.5, -0.3125, -0.1875, -0.125, -0.25}, -- NodeBox8
			{0.125, -0.5, -0.3125, 0.375, 0.125, -0.0625}, -- NodeBox9
			{0.1875, -0.5, -0.25, 0.3125, 0.1875, -0.125}, -- NodeBox10
			{-0.375, -0.5, 0.125, -0.1875, -0.1875, 0.3125}, -- NodeBox11
			{-0.3125, -0.5, 0.1875, -0.25, -0.25, 0.25}, -- NodeBox12
		}
	},
	groups = {cracky=2, dig_immediate=3, flammable=1},
	sounds = default.node_sound_glass_defaults()	
})

minetest.register_node("mapgen:crystal", {
	description = "Crystal",
	tiles = {{
		name = "mapgen_crystal_anim.png",
		animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.00},
	}},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 7,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0.875, 0.25}, -- NodeBox1
			{-0.1875, -0.5, -0.1875, 0.1875, 1.25, 0.1875}, -- NodeBox2
			{-0.625, -0.5, -0.1875, -0.3125, 0.5, 0.125}, -- NodeBox3
			{0.0625, -0.5, -0.625, 0.375, 0.3125, -0.3125}, -- NodeBox5
			{0.3125, -0.5, 0.3125, 0.5625, 0.5, 0.5625}, -- NodeBox7
			{-0.5625, -0.5, -0.125, -0.375, 0.4375, 0.0625}, -- NodeBox8
			{0.125, -0.5, -0.5625, 0.3125, 0.25, -0.375}, -- NodeBox9
			{0.375, -0.5, 0.375, 0.5, 0.4375, 0.5}, -- NodeBox10
		}
	},
	groups = {cracky=2, dig_immediate=3, flammable=1},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_abm({
	nodenames = {"mapgen:crystal_small"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		minetest.add_particle({
			pos = {x=pos.x, y=pos.y+0.1, z=pos.z},
			velocity = {x=0, y=0, z=0},
			acceleration = {x=0, y=0, z=0},
			expirationtime = 5,
			size = 15,
			collisiondetection = false,
			collisionremoval = false,
			vertical = true,
			texture = "mapgen_crystal_glow.png",
			animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.00},
			glow = 9
		})
	end
})

minetest.register_abm({
	nodenames = {"mapgen:crystal"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		minetest.add_particle({
			pos = {x=pos.x, y=pos.y+0.5, z=pos.z},
			velocity = {x=0, y=0, z=0},
			acceleration = {x=0, y=0, z=0},
			expirationtime = 5,
			size = 25,
			collisiondetection = false,
			collisionremoval = false,
			vertical = true,
			texture = "mapgen_crystal_glow.png",
			animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.00},
			glow = 9
		})
	end
})

minetest.register_craftitem("mapgen:crystal_shard", {
	description = "Crystal Shard",
	inventory_image = "mapgen_crystal_item.png"
})


--torch glow
minetest.register_abm({
	nodenames = {"default:torch", "default:torch_ceiling",},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		if minetest.get_timeofday() <= 0.6 and minetest.get_timeofday() >= 0.2 and pos.y >= -20 then
		return 
		end
		minetest.add_particle({
			pos = {x=pos.x, y=pos.y+0.1, z=pos.z},
			velocity = {x=0, y=0, z=0},
			acceleration = {x=0, y=0, z=0},
			expirationtime = 5,
			size = 15,
			collisiondetection = false,
			collisionremoval = false,
			vertical = true,
			texture = "mapgen_glow.png",
			animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 0.20},
			glow = 9
		})
	end
})

minetest.register_abm({
	nodenames = {"default:torch_wall"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		if minetest.get_timeofday() <= 0.6 and minetest.get_timeofday() >= 0.2 and pos.y >= -20  then
		return 
		end
		local dir = minetest.facedir_to_dir(node.param2)
		local particle_pos = {x=pos.x-0.22*dir.z*1.2, y=pos.y+0.1, z=pos.z-0.18*dir.x*1.2}
		if dir.x == 0 and dir.z == 0 then
		particle_pos = {x=pos.x, y=pos.y+0.1, z=pos.z+0.2}
		elseif dir.x == -1 and dir.z == 0 then
		particle_pos = {x=pos.x-0.15, y=pos.y+0.1, z=pos.z}
		elseif dir.x == 0 and dir.z == -1 then
		particle_pos = {x=pos.x+0.15, y=pos.y+0.1, z=pos.z}
		end
		minetest.add_particle({
			pos = particle_pos,
			velocity = {x=0, y=0, z=0},
			acceleration = {x=0, y=0, z=0},
			expirationtime = 5,
			size = 15,
			collisiondetection = false,
			collisionremoval = false,
			vertical = true,
			texture = "mapgen_glow.png",
			animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 0.20},
			glow = 9
		})
	end
})

--code taken from default

--License of source code
----------------------

--GNU Lesser General Public License, version 2.1
--Copyright (C) 2011-2016 celeron55, Perttu Ahola <celeron55@gmail.com>
--Copyright (C) 2011-2016 Various Minetest developers and contributors



minetest.register_node("mapgen:dirty_water_source", {
	description = "Dirty Water Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "mapgen_dirty_water_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	special_tiles = {
		{
			name = "mapgen_dirty_water_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
			backface_culling = false,
		},
	},
	alpha = 160,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "mapgen:dirty_water_flowing",
	liquid_alternative_source = ",mapgen:dirty_water_source",
	liquid_viscosity = 2,
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, puts_out_fire = 1, cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("mapgen:dirty_water_flowing", {
	description = "Flowing Dirty Water",
	drawtype = "flowingliquid",
	tiles = {"default_river_water.png^[colorize:green:100"},
	special_tiles = {
		{
			name = "mapgen_dirty_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "mapgen_dirty_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	alpha = 160,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "mapgen:dirty_water_flowing",
	liquid_alternative_source = "mapgen:dirty_water_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, puts_out_fire = 1,
		not_in_creative_inventory = 1, cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})


--new materials

minetest.register_craftitem("mapgen:tin_lump", {
	description = "Tin Lump",
	inventory_image = "mapgen_tin_lump.png",
})

minetest.register_craftitem("mapgen:tin_ingot", {
	description = "Tin Ingot",
	inventory_image = "mapgen_tin_ingot.png",
})

minetest.register_node("mapgen:tin", {
	description = "Tin Block",
	tiles = {
	"mapgen_tin.png",
	},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("mapgen:tin_ore", {
	description = "Stone with Tin",
	tiles = {
	"default_stone.png^mapgen_tin_ore.png",
	},
	groups = {cracky=2},
	drop = "mapgen:tin_lump",
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:big_mushroom_stem", {
	description = "Big Mushroom Stem",
	tiles = {
		"mapgen_big_mushroom_stem_top.png",
		"mapgen_big_mushroom_stem_top.png",
		"mapgen_big_mushroom_stem.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1, wood=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_node("mapgen:big_mushroom_red", {
	description = "Big Mushroom Red",
	tiles = {
		"mapgen_big_mushroom_red.png",
		"mapgen_big_mushroom_bottom.png",
		"mapgen_big_mushroom_red.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1, wood=1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("mapgen:big_mushroom_brown", {
	description = "Big Mushroom Brown",
	tiles = {
		"mapgen_big_mushroom_brown.png",
		"mapgen_big_mushroom_bottom.png",
		"mapgen_big_mushroom_brown.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1, wood=1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("mapgen:dirt_with_fungi_covered_grass", {
	description = "Fungi Covered Grass",
	tiles = {"mapgen_fungi_covered_grass.png", "default_dirt.png", "default_dirt.png^mapgen_fungi_covered_grass_side.png"},
	groups = {crumbly = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_node("mapgen:glowing_mushroom_white", {
	description = "White Glowing Mushroom",
	drawtype = "plantlike",
	tiles = {"mapgen_glowing_mushroom_white.png"},
	paramtype = "light",
	light_source = 9,
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "mapgen_glowing_mushroom_white.png",
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	walkable = false,
})