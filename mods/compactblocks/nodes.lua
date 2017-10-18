minetest.register_node("compactblocks:default_leaves", {
	description = "Compact Oak Leaves",
	tiles = {"compactblocks_default_leaves_top.png", "compactblocks_default_leaves_top.png", "compactblocks_default_leaves.png"},
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("compactblocks:meat_block", {
	description = "Meat Block",
	tiles = {
	"compactblocks_meat_block.png",
	},
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})



