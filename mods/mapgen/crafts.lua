
minetest.register_craft( {
	output = "mapgen:crystal_shard 4",
	recipe = {
		{ "mapgen:crystal",},
	}
})

minetest.register_craft( {
	output = "mapgen:crystal_shard 2",
	recipe = {
		{ "mapgen:crystal_small",},
	}
})

minetest.register_craft( {
	output = "decoblocks:bamboo_block 4",
	recipe = {
		{ "mapgen:bamboo", "mapgen:bamboo",},
		{ "mapgen:bamboo", "mapgen:bamboo",}
	}
})

minetest.register_craft({
	type = "cooking",
	output = "mapgen:tin_ingot",
	recipe = "mapgen:tin_lump",
})

minetest.register_craft({
	output = 'mapgen:tin',
	recipe = {
		{'mapgen:tin_ingot', 'mapgen:tin_ingot', 'mapgen:tin_ingot'},
		{'mapgen:tin_ingot', 'mapgen:tin_ingot', 'mapgen:tin_ingot'},
		{'mapgen:tin_ingot', 'mapgen:tin_ingot', 'mapgen:tin_ingot'},
	}
})

minetest.register_craft( {
	output = "mapgen:willow_wood 4",
	recipe = {
		{ "mapgen:willow_tree",},
	}
})

minetest.register_craft( {
	output = "mapgen:baobab_wood 4",
	recipe = {
		{ "mapgen:baobab_tree",},
	}
})

minetest.register_craft( {
	output = "mapgen:bamboo_wood 4",
	recipe = {
		{ "mapgen:bamboo",},
	}
})

minetest.register_craft( {
	output = "mapgen:bamboo_wood 4",
	recipe = {
		{ "mapgen:bamboo_with_leaves",},
	}
})

minetest.register_craft( {
	output = "mapgen:yellow_ipe_wood 4",
	recipe = {
		{ "mapgen:yellow_ipe_tree",},
	}
})

minetest.register_craft( {
	output = "mapgen:palm_wood 4",
	recipe = {
		{ "mapgen:palm_tree",},
	}
})

minetest.register_craft( {
	output = "fruit:coconut",
	recipe = {
		{ "fruit:palm_leaves_coconut",},
	}
})

minetest.register_craft( {
	output = "fruit:coconut_open 2",
	recipe = {
		{ "fruit:coconut",},
	}
})

minetest.register_craft( {
	output = "mapgen:bamboo_wood 4",
	recipe = {
		{ "mapgen:bamboo",},
	}
})