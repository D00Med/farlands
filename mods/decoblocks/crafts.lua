
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