
--corn crop, textures by tobyplowy(aka toby109tt)

minetest.register_craftitem("farming:corn", {
	description = "Corn",
	inventory_image = "farming_corn.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:corn_1")
	end,
	on_use = minetest.item_eat(3),
})

minetest.register_node("farming:corn_1", {
	drawtype = "plantlike",
	tiles = {"farming_corn_1.png"},
	visual_scale = 2,
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:corn_2", {
	drawtype = "plantlike",
	tiles = {"farming_corn_2.png"},
	visual_scale = 2,
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:corn_3", {
	drawtype = "plantlike",
	tiles = {"farming_corn_3.png"},
	visual_scale = 2,
	paramtype = "light",
	waving = 1,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:corn_4", {
	drawtype = "plantlike",
	tiles = {"farming_corn_4.png"},
	visual_scale = 2,
	paramtype = "light",
	waving = 1,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = {
		items = {
			{items = {'farming:corn'}, rarity = 1},
			{items = {'farming:corn'}, rarity = 2},
			{items = {'farming:corn'}, rarity = 3},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
	mature = true,
})

minetest.register_node("farming:corn_5", {
	drawtype = "plantlike",
	tiles = {"farming_corn_5.png^[colorize:brown:50"},
	visual_scale = 2,
	paramtype = "light",
	waving = 1,
	drop = "",
	walkable = false,
	buildable_to = true,
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})
