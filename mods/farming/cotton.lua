-- Cotton Seed

--minetest.register_craftitem("farming:seed_cotton", {
--	description = "Cotton Seed",
--	inventory_image = "farming_cotton_seed.png",
--	on_place = function(itemstack, placer, pointed_thing)
--		return farming.place_seed(itemstack, placer, pointed_thing, "farming:cotton_1")
--	end,
--})

minetest.register_node("farming:seed_cotton", {
	description = "Cotton Seed",
	tiles = {"farming_cotton_seed.png"},
	inventory_image = "farming_cotton_seed.png",
	wield_image = "farming_cotton_seed.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:cotton_1")
	end,
})

-- Cotton

minetest.register_craftitem("farming:cotton", {
	description = "Cotton",
	inventory_image = "farming_cotton.png",
})

minetest.register_alias("farming:string", "farming:cotton")

-- String to Wool

minetest.register_craft({
	output = "wool:white",
	recipe = {
		{"farming:string", "farming:string"},
		{"farming:string", "farming:string"},
	}
})

-- Define Cotton growth stages

minetest.register_node("farming:cotton_1", {
	drawtype = "plantlike",
	tiles = {"farming_cotton_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop =  "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:cotton_2", {
	drawtype = "plantlike",
	tiles = {"farming_cotton_2.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop =  "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:cotton_3", {
	drawtype = "plantlike",
	tiles = {"farming_cotton_3.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop =  "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:cotton_4", {
	drawtype = "plantlike",
	tiles = {"farming_cotton_4.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop =  "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:cotton_5", {
	drawtype = "plantlike",
	tiles = {"farming_cotton_5.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop =  {
		items = {
			{items = {"farming:seed_cotton"}, rarity = 1},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:cotton_6", {
	drawtype = "plantlike",
	tiles = {"farming_cotton_6.png"},
	paramtype = "light",
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop =  {
		items = {
			{items = {"farming:cotton"}, rarity = 1},
			{items = {"farming:cotton"}, rarity = 2},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:cotton_7", {
	drawtype = "plantlike",
	tiles = {"farming_cotton_7.png"},
	paramtype = "light",
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop =  {
		items = {
			{items = {"farming:cotton"}, rarity = 1},
			{items = {"farming:cotton"}, rarity = 2},
			{items = {"farming:seed_cotton"}, rarity = 1},
			{items = {"farming:seed_cotton"}, rarity = 2},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

-- Last stage of growth does not have growing group so abm never checks these

minetest.register_node("farming:cotton_8", {
	drawtype = "plantlike",
	tiles = {"farming_cotton_8.png"},
	paramtype = "light",
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop =  {
		items = {
			{items = {"farming:string"}, rarity = 1},
			{items = {"farming:string"}, rarity = 2},
			{items = {"farming:string"}, rarity = 3},
			{items = {"farming:seed_cotton"}, rarity = 1},
			{items = {"farming:seed_cotton"}, rarity = 2},
			{items = {"farming:seed_cotton"}, rarity = 3},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})