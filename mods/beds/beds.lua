
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

-- Aliases for PilzAdam's beds mod

minetest.register_alias("beds:bed_bottom_red", "beds:bed_bottom")
minetest.register_alias("beds:bed_top_red", "beds:bed_top")

-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "beds:bed_bottom",
	burntime = 12,
})
