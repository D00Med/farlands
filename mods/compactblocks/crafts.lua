
minetest.register_craft({
	output = 'compactblocks:default_leaves',
	recipe = {
		{'default:leaves', 'default:leaves', 'default:leaves'},
		{'default:leaves', 'default:leaves', 'default:leaves'},
		{'default:leaves', 'default:leaves', 'default:leaves'},
	}
})

minetest.register_craft({
	output = "default:leaves 9",
	recipe = {
		{"compactblocks:default_leaves"},
	}
})

minetest.register_craft({
	output = 'compactblocks:meat_block',
	recipe = {
		{'mobs:meat_raw', 'mobs:meat_raw', 'mobs:meat_raw'},
		{'mobs:meat_raw', 'mobs:meat_raw', 'mobs:meat_raw'},
		{'mobs:meat_raw', 'mobs:meat_raw', 'mobs:meat_raw'},
	}
})

minetest.register_craft({
	output = 'mobs:meat_raw 9',
	recipe = {
		{'compactblocks:meat_block'},
	}
})

