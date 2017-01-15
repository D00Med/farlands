
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:sand",},
	sidelen = 16,
	noise_params = {
		offset = 0.002,
		scale = 0.001,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	y_min = 1,
	y_max = 31000,
	schematic = minetest.get_modpath("mapgen").."/schematics/palmtree.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"mapgen:dirt_with_junglegrass", "default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.002,
		scale = 0.001,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"rainforest"},
	y_min = 1,
	y_max = 31000,
	schematic = minetest.get_modpath("mapgen").."/schematics/palmtree.mts",
	flags = "place_center_x, place_center_z",
})

