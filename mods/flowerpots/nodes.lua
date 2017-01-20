
local flowers = {
	{"lavender", "mapgen:lavender_flower"},
	{"rose", "flowers:rose"},
	{"tulip", "flowers:tulip"},
	{"geranium", "flowers:geranium"},
	{"viola", "flowers:viola"},
	{"dandelion_yellow", "flowers:dandelion_yellow"},
	{"dandelion_white", "flowers:dandelion_white"},
	{"flame_lily", "mapgen:flame_lily"},
}

minetest.register_node("flowerpots:flower_pot", {
	description = "Flower Pot",
	drawtype = "mesh",
	mesh = "flowerpot.obj",
	tiles = {
		"flowerpot.png",
	},
	visual_scale = 0.5,
	wield_image = "flowerpot_item.png",
	wield_scale = {x=1.0, y=1.0, z=1.0},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
	},
	inventory_image = "flowerpot_item.png",
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack)
		local item = clicker:get_wielded_item():get_name()
		for _, row in ipairs(flowers) do
			local flower = row[1]
			local flower_node = row[2]
			if item == flower_node then
				minetest.env:set_node(pos, {name="flowerpots:flower_pot_"..flower})
				itemstack:take_item()
			end
		end
	end,
})

for _, row in ipairs(flowers) do
local flower = row[1]
local flower_node = row[2]
minetest.register_node("flowerpots:flower_pot_"..flower, {
	description = "Flower Pot With "..flower.." Flower",
	drawtype = "mesh",
	mesh = "flowerpot_with_Xflower.obj",
	tiles = {
		"flowerpot_"..flower..".png",
	},
	visual_scale = 0.5,
	wield_image = "flowerpot_item.png",
	wield_scale = {x=1.0, y=1.0, z=1.0},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
	},
	inventory_image = "flowerpot_item.png",
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function(pos, item, clicker)
		minetest.env:add_item({x=pos.x, y=pos.y+0.5, z=pos.z}, flower_node)
		minetest.env:set_node(pos, {name="flowerpots:flower_pot"})
	end,
})
end