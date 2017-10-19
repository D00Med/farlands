
--raddish crop, textures by tobyplowy(aka toby109tt)

minetest.register_craftitem("farming:raddish", {
	description = "Raddish",
	inventory_image = "farming_raddish.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:raddish_1")
	end,
	on_use = minetest.item_eat(1),
})

minetest.register_node("farming:raddish_1", {
	drawtype = "plantlike",
	tiles = {"farming_raddish_1.png"},
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

minetest.register_node("farming:raddish_2", {
	drawtype = "plantlike",
	tiles = {"farming_raddish_2.png"},
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

minetest.register_node("farming:raddish_3", {
	drawtype = "plantlike",
	tiles = {"farming_raddish_3.png"},
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

minetest.register_node("farming:raddish_4", {
	drawtype = "plantlike",
	tiles = {"farming_raddish_4.png"},
	paramtype = "light",
	waving = 1,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = {
		items = {
			{items = {'farming:raddish'}, rarity = 1},
			{items = {'farming:raddish'}, rarity = 2},
			{items = {'farming:raddish'}, rarity = 3},
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

minetest.register_node("farming:raddish_5", {
	drawtype = "plantlike",
	tiles = {"farming_raddish_5.png^[colorize:brown:50"},
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
