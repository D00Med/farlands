
minetest.register_craft({
	output = 'decoblocks:vase',
	recipe = {
		{'default:clay_brick', '', 'default:clay_brick'},
		{'default:clay_brick', '', 'default:clay_brick'},
		{'', 'default:clay_brick', ''},
	}
})

minetest.register_craft({
	output = 'decoblocks:scarecrow',
	recipe = {
		{'', 'farming:pumpkin', ''},
		{'default:stick', 'farming:straw', 'default:stick'},
		{'', 'group:wood', ''},
	}
})

minetest.register_craft({
	output = 'decoblocks:paper_lantern',
	recipe = {
		{'group:wood', 'default:paper', 'group:wood'},
		{'default:paper', 'default:torch', 'default:paper'},
		{'group:wood', 'default:paper', 'group:wood'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "decoblocks:refined_granite",
	recipe = "mapgen:granite",
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "decoblocks:refined_granite_brown",
	recipe = "mapgen:granite_brown",
	cooktime = 5,
})

minetest.register_craft({
	output = 'decoblocks:gold_brick',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'default:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'decoblocks:snow_bricks 4',
	recipe = {
		{'default:snowblock', 'default:snowblock'},
		{'default:snowblock', 'default:snowblock'},
	}
})
