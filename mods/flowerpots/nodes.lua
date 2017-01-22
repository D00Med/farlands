
local flowers = {
	{"lavender", "mapgen:lavender_flower", "flowerpot_with_Xflower.obj"},
	{"rose", "flowers:rose", "flowerpot_with_Xflower.obj"},
	{"tulip", "flowers:tulip", "flowerpot_with_Xflower.obj"},
	{"geranium", "flowers:geranium", "flowerpot_with_Xflower.obj"},
	{"viola", "flowers:viola", "flowerpot_with_Xflower.obj"},
	{"dandelion_yellow", "flowers:dandelion_yellow", "flowerpot_with_Xflower.obj"},
	{"dandelion_white", "flowers:dandelion_white", "flowerpot_with_Xflower.obj"},
	{"flame_lily", "mapgen:flame_lily", "flowerpot_with_Xflower.obj"},
	{"mushroom_brown", "flowers:mushroom_brown", "flowerpot_with_Xflower.obj"},
	{"mushroom_red", "flowers:mushroom_red", "flowerpot_with_Xflower.obj"},
	{"cactus", "default:cactus", "flowerpot_with_long_cube.obj"},
	{"grass", "default:grass_1", "flowerpot_with_Xflower.obj"},
	{"dry_grass", "default:dry_grass_1", "flowerpot_with_Xflower.obj"},
	{"dry_shrub", "default:dry_shrub", "flowerpot_with_Xflower.obj"},
	{"papyrus", "default:papyrus", "flowerpot_with_Xflower.obj"},
	{"purple_allium", "mapgen:purple_allium", "flowerpot_with_Xflower.obj"},
	{"small_cactus", "mapgen:small_cactus", "flowerpot_with_Xflower.obj"},
	{"small_cactus_1", "mapgen:small_cactus_1", "flowerpot_with_Xflower.obj"},
	{"oxeye_daisy", "mapgen:oxeye_daisy", "flowerpot_with_Xflower.obj"},
	{"dead_grass", "mapgen:dead_grass_5", "flowerpot_with_Xflower.obj"},
	{"jungle_grass", "mapgen:jungle_grass_5", "flowerpot_with_Xflower.obj"},
	{"leaves", "default:leaves", "flowerpot_with_long_cube.obj"},
	{"aspen_leaves", "default:aspen_leaves", "flowerpot_with_long_cube.obj"},
	{"pine_needles", "default:pine_needles", "flowerpot_with_long_cube.obj"},
	{"jungleleaves", "default:jungleleaves", "flowerpot_with_long_cube.obj"},
	{"acacia_leaves", "default:acacia_leaves", "flowerpot_with_long_cube.obj"},
	{"willow_leaves", "mapgen:willow_leaves", "flowerpot_with_long_cube.obj"},
	{"baobab_leaves", "mapgen:baobab_leaves", "flowerpot_with_long_cube.obj"},
	{"yellow_ipe_leaves", "mapgen:yellow_ipe_leaves", "flowerpot_with_long_cube.obj"},
	{"palm_leaves", "mapgen:palm_leaves", "flowerpot_with_long_cube.obj"},
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
local model = row[3]
minetest.register_node("flowerpots:flower_pot_"..flower, {
	description = "Flower Pot With "..flower.." Flower",
	drawtype = "mesh",
	mesh = model,
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