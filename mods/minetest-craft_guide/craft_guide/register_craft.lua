--[[

Craft Guide for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-craft_guide
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-craft_guide/master/LICENSE

REGISTER CRAFTS

]]--


-- craft sign
minetest.register_craft({
	output = 'craft_guide:sign_wall',
	recipe = {
		{'group:stick', 'group:stick'},
		{'group:stick', 'group:stick'},
		{'group:stick', ''},
	}
})


-- craft pc
minetest.register_craft({
	output = 'craft_guide:lcd_pc',
	recipe = {
		{'craft_guide:sign_wall'},
		{'default:glass'},
		{'stairs:slab_stone'},
	}
})

-- craft sign
minetest.register_craft({
	type = 'shapeless',
	output = 'craft_guide:sign_wall_locked',
	recipe = {
		'craft_guide:sign_wall',
		'default:steel_ingot',
	}
})


-- craft pc
minetest.register_craft({
	type = 'shapeless',
	output = 'craft_guide:lcd_pc_locked',
	recipe = {
		'craft_guide:lcd_pc',
		'default:steel_ingot',
	}
})

minetest.register_craft({
	output = 'craft_guide:lcd_pc_locked',
	recipe = {
		{'craft_guide:sign_wall_locked'},
		{'default:glass'},
		{'stairs:slab_stone'},
	}
})

