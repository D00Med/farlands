minetest.register_node("decoblocks:old_stone_tiles", {
	description = "Old Stone Tiles",
	tiles = {"decoblocks_old_stone_tiles.png"},
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("decoblocks:old_stone_tiles_with_dirt", {
	description = "Old Stone Tiles With Dirt",
	tiles = {"decoblocks_old_stone_tiles_with_dirt.png"},
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_node("decoblocks:scarecrow", {
	description = "Scarecrow",
	drawtype = "mesh",
	mesh = "scarecrow.obj",
	tiles = {
		"decoblocks_scarecrow.png",
	},
	visual_scale = 0.5,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3}
	},
	inventory_image = "decoblocks_scarecrow_item.png",
	groups = {choppy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults()
})