minetest.register_node("backpack:backpack", {
	description = "Backpack",
	drawtype = "mesh",
	mesh = "backpack.obj",
	tiles = {
		"backpack.png",
	},
	visual_scale = 0.5,
	wield_image = "backpack_item.png",
	wield_scale = {x=1.0, y=1.0, z=1.0},
	paramtype = "light",
	paramtype2 = "facedir",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.2, 0.3}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.0, 0.3}
	},
	inventory_image = "backpack_item.png",
	groups = {choppy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults()
})