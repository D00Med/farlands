
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