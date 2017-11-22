--functions from flowers mod:
--Originally by Ironzorg (MIT) and VanessaE (MIT)
--Various Minetest developers and contributors (MIT)

local function add_simple_flower(name, desc, box, f_groups)
	-- Common flowers' groups
	f_groups.snappy = 3
	f_groups.flower = 1
	f_groups.flora = 1
	f_groups.attached_node = 1

	minetest.register_node("flowers_plus:" .. name, {
		description = desc,
		drawtype = "plantlike",
		waving = 1,
		tiles = {"flowers_" .. name .. ".png"},
		inventory_image = "flowers_" .. name .. ".png",
		wield_image = "flowers_" .. name .. ".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		stack_max = 99,
		groups = f_groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = box
		}
	})
end

add_simple_flower("pansy_purple", "Purple Pansy", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_violet=1, flammable=1})
add_simple_flower("pansy_blue", "Blue Pansy", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_blue=1, flammable=1})
add_simple_flower("petunia_blue", "Blue Petunia", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_blue=1, flammable=1})
add_simple_flower("petunia_pink", "Pink Petunia", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_pink=1, flammable=1})
add_simple_flower("petunia_white", "White Petunia", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_white=1, flammable=1})
add_simple_flower("lobelia", "Lobelia", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_blue=1, flammable=1})
add_simple_flower("frozen_rose", "Frozen Rose", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_blue=1, flammable=0})
add_simple_flower("lantana", "Lantana", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_purple=1, flammable=1})
add_simple_flower("lavender_flower", "Lavender", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_purple=1, flammable=1})
add_simple_flower("purple_allium", "Purple Allium", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_purple=1, flammable=1})
add_simple_flower("flame_lily", "Flame Lily", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_orange=1, flammable=1})
add_simple_flower("oxeye_daisy", "Ox Eye Daisy", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_white=1, flammable=1})


minetest.register_node("flowers_plus:foxglove", {
	description = "Pink Foxglove",
	drawtype = "plantlike",
	tiles = {"flowers_foxglove_pink.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "flowers_foxglove_pink.png",
	visual_scale = 2,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25}
	},
	walkable = false,
})

minetest.register_node("flowers_plus:foxglove_purple", {
	description = "Pink Purple",
	drawtype = "plantlike",
	tiles = {"flowers_foxglove_purple.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "flowers_foxglove_purple.png",
	visual_scale = 2,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25}
	},
	walkable = false,
})

minetest.register_node("flowers_plus:red_ground_flower", {
	description = "Red Ground flower",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"flowers_red_ground_flower.png",
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

minetest.register_node("flowers_plus:pink_ground_flower", {
	description = "Pink Ground flower",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"flowers_pink_ground_flower.png",
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

minetest.register_node("flowers_plus:blue_ground_flower", {
	description = "Blue Ground Flower",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"flowers_blue_ground_flower.png",
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

function flowers_plus_decorations()
--original mapgen mod flowers
minetest.register_decoration({
	deco_type = "simple",
	place_on = "mapgen:dirt_with_junglegrass",
	sidelen = 16,
	fill_ratio = 0.02,
	biomes = {"rainforest",},
	decoration = "flowers_plus:flame_lily",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "mapgen:dirt_with_swampgrass",
	sidelen = 16,
	fill_ratio = 0.02,
	biomes = {"swamp",},
	decoration = "flowers_plus:lavender_flower",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "mapgen:dirt_with_leafygrass",
	sidelen = 16,
	fill_ratio = 0.02,
	biomes = {"coniferous_forest_tall",},
	decoration = "flowers_plus:purple_allium",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.04,
	biomes = {"deciduous_forest2",},
	decoration = "flowers_plus:lantana",
	height = 1,
})

--new flowers
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.03,
	biomes = {"deciduous_forest2",},
	decoration = "flowers_plus:foxglove",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.03,
	biomes = {"deciduous_forest",},
	decoration = "flowers_plus:foxglove_purple",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.03,
	biomes = {"taiga",},
	decoration = "flowers_plus:frozen_rose",
	height = 1,
})
end