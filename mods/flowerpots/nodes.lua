
minetest.register_node("flowerpots:flower_pot", {
	description = "Flower Pot",
	drawtype = "mesh",
	mesh = "flowerpot.obj",
	tiles = {
		"flowerpot.png",
	},
	visual_scale = 0.5,
	wield_image = "flowerpot_item.png",
	wield_scale = {x=1.0, y=1.0, z=1.0},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
	},
	inventory_image = "flowerpot_item.png",
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("flowerpots:flower_pot_lavender", {
	description = "Flower Pot With Lavender Flower",
	drawtype = "mesh",
	mesh = "flowerpot_with_Xflower.obj",
	tiles = {
		"flowerpot_lavender.png",
	},
	visual_scale = 0.5,
	wield_image = "flowerpot_item.png",
	wield_scale = {x=1.0, y=1.0, z=1.0},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
	},
	inventory_image = "flowerpot_item.png",
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})