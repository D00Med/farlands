
beds.register_bed("beds:bed", {
	description = "Red Bed",
	inventory_image = "beds_bed.png",
	wield_image = "beds_bed.png",
	tiles = {
		"beds_bed_red.png"
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:red", "wool:red", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

beds.register_bed("beds:bed_blue", {
	description = "Blue Bed",
	inventory_image = "beds_blue.png",
	wield_image = "beds_blue.png",
	tiles = {
		"beds_bed_blue.png"
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:blue", "wool:blue", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

beds.register_bed("beds:bed_green", {
	description = "Green Bed",
	inventory_image = "beds_green.png",
	wield_image = "beds_green.png",
	tiles = {
		"beds_bed_green.png"
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:green", "wool:green", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

beds.register_bed("beds:bed_yellow", {
	description = "Yellow Bed",
	inventory_image = "beds_yellow.png",
	wield_image = "beds_yellow.png",
	tiles = {
		"beds_bed_yellow.png"
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:yellow", "wool:yellow", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

beds.register_bed("beds:bed_purple", {
	description = "Purple Bed",
	inventory_image = "beds_purple.png",
	wield_image = "beds_purple.png",
	tiles = {
		"beds_bed_purple.png"
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:purple", "wool:purple", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

beds.register_bed("beds:bed_orange", {
	description = "Orange Bed",
	inventory_image = "beds_orange.png",
	wield_image = "beds_orange.png",
	tiles = {
		"beds_bed_orange.png"
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:orange", "wool:orange", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

beds.register_bed("beds:bed_darkgreen", {
	description = "Dark Green Bed",
	inventory_image = "beds_darkgreen.png",
	wield_image = "beds_darkgreen.png",
	tiles = {
		"beds_bed_darkgreen.png"
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:darkgreen", "wool:darkgreen", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Aliases for PilzAdam's beds mod

minetest.register_alias("beds:bed_bottom_red", "beds:bed_bottom")
minetest.register_alias("beds:bed_top_red", "beds:bed_top")

-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "beds:bed_bottom",
	burntime = 12,
})
