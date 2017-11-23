
local flowers = {
	{"lavender", "flowers_plus:lavender_flower", "Lavender"},
	{"rose", "flowers:rose", "Rose"},
	{"tulip", "flowers:tulip", "Tulip"},
	{"geranium", "flowers:geranium", "Geranium"},
	{"viola", "flowers:viola", "Viola"},
	{"dandelion_yellow", "flowers:dandelion_yellow", "Yellow Dandelion"},
	{"dandelion_white", "flowers:dandelion_white", "White Dandelion"},
	{"flame_lily", "flowers_plus:flame_lily", "Flame Lily"},
	{"mushroom_brown", "flowers:mushroom_brown", "Brown Mushroom"},
	{"mushroom_red", "flowers:mushroom_red", "Red Mushroom"},
	{"grass", "default:grass_1", "Grass"},
	{"dry_grass", "default:dry_grass_1", "Dry Grass"},
	{"dry_shrub", "default:dry_shrub", "Dry Shrub"},
	{"papyrus", "default:papyrus", "Papyrus"},
	{"small_cactus", "mapgen:small_cactus", "Small Cactus"},
	{"small_cactus_1", "mapgen:small_cactus_1", "Small Cactus1"},
	{"oxeye_daisy", "flowers_plus:oxeye_daisy", "Oxeye Daisy"},
	{"dead_grass", "mapgen:dead_grass_5", "Dead Grass"},
	{"frozen_grass", "mapgen:snow_grass_5", "Frozen Grass"},
	{"jungle_grass", "mapgen:jungle_grass_5", "Jungle Grass"},
	{"sapling", "default:sapling", "Sapling"},
	{"acacia_sapling", "default:acacia_sapling", "Acacia Sapling"},
	{"aspen_sapling", "default:aspen_sapling", "Aspen Sapling"},
	{"junglesapling", "default:junglesapling", "Jungle Sapling"},
	{"pine_sapling", "default:pine_sapling", "Pine Sapling"},
	{"junglegrass", "default:junglegrass", "junglegrass"},
	{"frozen_rose", "flowers_plus:frozen_rose", "Frozen Rose"},
	{"pansy_purple", "flowers_plus:pansy_purple", "Purple Pansy"},
	{"pansy_blue", "flowers_plus:pansy_blue", "Blue Pansy"},
	{"petunia_blue", "flowers_plus:petunia_blue", "Blue Petunia"},
	{"petunia_pink", "flowers_plus:petunia_pink", "Pink Petunia"},
	{"petunia_white", "flowers_plus:petunia_white", "White Petunia"},
	{"lobelia", "flowers_plus:lobelia", "Lobelia"},
	{"foxglove", "flowers_plus:foxglove", "Foxglove", {"flowerpots_foxglove.png"}},
	{"foxglove_purple", "flowers_plus:foxglove_purple", "Purple Foxglove", {"flowerpots_foxglove_p.png"}},

}

local cubes = {
	{"cactus", "default:cactus", "Cactus"},
	{"leaves", "default:leaves", "Leaves"},
	{"aspen_leaves", "default:aspen_leaves", "Aspen Leaves"},
	{"pine_needles", "default:pine_needles", "Pine Needles"},
	{"jungleleaves", "default:jungleleaves", "Jungle Leaves"},
	{"acacia_leaves", "default:acacia_leaves", "Acacia Leaves"},
	{"bush_leaves", "default:bush_leaves", "Bush Leaves"},
	{"acacia_bush_leaves", "default:acacia_bush_leaves", "Acacia Bush Leaves"},
	{"willow_leaves", "mapgen:willow_leaves", "Willow Leaves"},
	{"baobab_leaves", "mapgen:baobab_leaves", "Baobab Leaves"},
	{"yellow_ipe_leaves", "mapgen:yellow_ipe_leaves", "Yellow Ipe Leaves"},
	{"palm_leaves", "mapgen:palm_leaves", "Palm Leaves"},
	{"bamboo_leaves", "mapgen:bamboo_leaves", "Bamboo Leaves"},

}

minetest.register_node("flowerpots:flower_pot", {
	description = "Flower Pot",
	drawtype = "mesh",
	mesh = "flowerpot.obj",
	tiles = {
		"flowerpot.png",
	},
	visual_scale = 0.5,
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
	groups = {cracky = 1, oddly_breakable_by_hand = 1, attached_node=1},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack)
		local item = clicker:get_wielded_item():get_name()
		for _, row in ipairs(flowers) do
			local flower = row[1]
			local flower_node = row[2]
			if item == flower_node then
				minetest.set_node(pos, {name="flowerpots:flower_pot_"..flower})
				if not minetest.setting_getbool("creative") then
				itemstack:take_item()
				end
			end
		end
		for _, row in ipairs(cubes) do
			local flower = row[1]
			local flower_node = row[2]
			if item == flower_node then
				minetest.set_node(pos, {name="flowerpots:flower_pot_"..flower})
				if not minetest.setting_getbool("creative") then
				itemstack:take_item()
				end
			end
		end
	end,
})

minetest.register_craft({
	output = 'flowerpots:flower_pot',
	recipe = {
		{'default:clay', 'default:dirt', 'default:clay'},
		{'', 'default:clay', ''},
	}
})

for _, row in ipairs(flowers) do
local flower = row[1]
local flower_node = row[2]
local desc = row[3]
local texture = minetest.registered_nodes[flower_node]["tiles"]
if row[4] ~= nil then texture = row[4] end
minetest.register_node("flowerpots:flower_pot_"..flower, {
	description = "Flower Pot With "..desc.."",
	drawtype = "mesh",
	mesh = "flowerpot.obj",
	tiles = {
		"[combine:32x32:0,0=flowerpot.png:0,0="..texture[1],
	},
	visual_scale = 0.5,
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
	groups = {cracky = 1, oddly_breakable_by_hand = 1, not_in_creative_inventory=1, attached_node=1},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function(pos, item, clicker)
		minetest.add_item({x=pos.x, y=pos.y+0.5, z=pos.z}, flower_node)
		minetest.set_node(pos, {name="flowerpots:flower_pot"})
	end,
	drop = {
	max_items = 2,items = {{items = {"flowerpots:flower_pot", flower_node},rarity = 1,},},
	},
})
end

for _, row in ipairs(cubes) do
local flower = row[1]
local flower_node = row[2]
local desc = row[3]
minetest.register_node("flowerpots:flower_pot_"..flower, {
	description = "Flower Pot With "..desc.."",
	drawtype = "mesh",
	mesh = "flowerpot_with_long_cube.obj",
	tiles = {
		"flowerpot_"..flower..".png",
	},
	visual_scale = 0.5,
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
	groups = {cracky = 1, oddly_breakable_by_hand = 1, not_in_creative_inventory=1, attached_node=1},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function(pos, item, clicker)
		minetest.add_item({x=pos.x, y=pos.y+0.5, z=pos.z}, flower_node)
		minetest.set_node(pos, {name="flowerpots:flower_pot"})
	end,
	drop = {
	max_items = 2,items = {{items = {"flowerpots:flower_pot", flower_node},rarity = 1,},},
	},
})
end