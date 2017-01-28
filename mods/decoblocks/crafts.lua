
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