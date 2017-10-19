
--melon crop, textures by D00Med

minetest.register_craftitem("farming:melon", {
	description = "Melon Slice",
	inventory_image = "farming_melon.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:melon_1")
	end,
	on_use = minetest.item_eat(2),
})

minetest.register_node("farming:melon_1", {
	drawtype = "plantlike",
	tiles = {"farming_melon_1.png"},
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

minetest.register_node("farming:melon_2", {
	drawtype = "plantlike",
	tiles = {"farming_melon_2.png"},
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

minetest.register_node("farming:melon_3", {
	tiles = {
	"farming_melon_3_top.png",
	"farming_melon_3_top.png",
	"farming_melon_3.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, -0.125, 0.1875}, -- NodeBox1
			{-0.5, -0.5, 0.03, 0.5, 0.5, 0.03}, -- NodeBox2
			{0.03, -0.5, -0.5, 0.03, 0.5, 0.5}, -- NodeBox4
		}
	},
	waving = 1,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, -0.125, 0.1875}, -- NodeBox1
		}
	},
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:melon_4", {
	tiles = {
	"farming_melon_4_top.png",
	"farming_melon_4_top.png",
	"farming_melon_4.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.3125, 0.3125, 0.125, 0.3125}, -- NodeBox1
			{-0.5, -0.5, 0.03, 0.5, 0.5, 0.03}, -- NodeBox2
			{0.03, -0.5, -0.5, 0.03, 0.5, 0.5}, -- NodeBox4
		}
	},
	waving = 1,
	sunlight_propagates = true,
	walkable = true,
	buildable_to = true,
	drop = {
		items = {
			{items = {'farming:melon'}, rarity = 1},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.3125, 0.3125, 0.125, 0.3125}, -- NodeBox1
		}
	},
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:melon_5", {
	tiles = {
	"farming_melon_5_top.png",
	"farming_melon_5_top.png",
	"farming_melon_5.png",
	},
	waving = 1,
	drop = {
		items = {
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
		}
	},
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
	on_rightclick = function(pos, node, clicker)
		minetest.set_node(pos, {name="farming:cut_melon_1", param2=node.param2})
		clicker:set_hp(clicker:get_hp()+1)
	end,
})

minetest.register_node("farming:melon_block", {
	description = "Melon",
	tiles = {
	"farming_melon_5_top.png",
	"farming_melon_5_top.png",
	"farming_melon_5.png",
	},
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
	on_rightclick = function(pos, node, clicker)
		minetest.set_node(pos, {name="farming:cut_melon_1", param2=node.param2})
		clicker:set_hp(clicker:get_hp()+1)
	end,
})

minetest.register_craft({
	output = "farming:melon 9",
	recipe = {
		{"farming:melon_block"},
	}
})

minetest.register_craft({
	output = "farming:melon_block",
	recipe = {
		{"farming:melon", "farming:melon", "farming:melon"},
		{"farming:melon", "farming:melon", "farming:melon"},
		{"farming:melon", "farming:melon",  "farming:melon"}
	}
})

minetest.register_node("farming:melon_6", {
	tiles = {
	"farming_melon_6_top.png",
	"farming_melon_6_top.png",
	"farming_melon_6.png",
	},
	waving = 1,
	drop = "",
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:cut_melon_1", {
	tiles = {
		"farming_melon_5_top.png",
		"farming_melon_5_top.png",
		"farming_melon_5.png",
		"farming_melon_cut_4.png^[transformFX",
		"farming_melon_5.png",
		"farming_melon_cut_1.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.5, 0.5, 0.5, 0}, -- NodeBox1
			{-0.5, -0.5, 0, 0.5, 0.5, 0.5}, -- NodeBox2
		}
	},
	drop = {
		items = {
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
		}
	},
	groups = {snappy=3, flammable=2, plant=1, attached_node=1, not_in_creative_inventory=1},
	on_rightclick = function(pos, node, clicker)
		minetest.set_node(pos, {name="farming:cut_melon_2", param2=node.param2})
		clicker:set_hp(clicker:get_hp()+1)
	end,
})

minetest.register_node("farming:cut_melon_2", {
	tiles = {
		"farming_melon_5_top.png",
		"farming_melon_5_top.png",
		"farming_melon_5.png",
		"farming_melon_cut_4.png^[transformFX",
		"farming_melon_5.png",
		"farming_melon_cut_2.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{0.125, -0.5, -0.5, 0.5, 0.5, 0}, -- NodeBox1
			{-0.5, -0.5, 0, 0.5, 0.5, 0.5}, -- NodeBox2
		}
	},
	drop = {
		items = {
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
		}
	},
	groups = {snappy=3, flammable=2, plant=1, attached_node=1, not_in_creative_inventory=1},
	on_rightclick = function(pos, node, clicker)
		minetest.set_node(pos, {name="farming:cut_melon_3", param2=node.param2})
		clicker:set_hp(clicker:get_hp()+1)
	end,
})

minetest.register_node("farming:cut_melon_3", {
	tiles = {
		"farming_melon_5_top.png",
		"farming_melon_5_top.png",
		"farming_melon_5.png",
		"farming_melon_cut_4.png^[transformFX",
		"farming_melon_5.png",
		"farming_melon_cut_3.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0, 0.5, 0.5, 0.5}, -- NodeBox2
		}
	},
	drop = {
		items = {
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
		}
	},
	groups = {snappy=3, flammable=2, plant=1, attached_node=1, not_in_creative_inventory=1},
	on_rightclick = function(pos, node, clicker)
		minetest.set_node(pos, {name="farming:cut_melon_4", param2=node.param2})
		clicker:set_hp(clicker:get_hp()+1)
	end,
})

minetest.register_node("farming:cut_melon_4", {
	tiles = {
		"farming_melon_5_top.png",
		"farming_melon_5_top.png",
		"farming_melon_5.png",
		"farming_melon_cut_3.png",
		"farming_melon_5.png",
		"farming_melon_cut_3.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, 0, 0.5, 0.5, 0.5}, -- NodeBox2
		}
	},
	drop = {
		items = {
			{items = {'farming:melon'}, rarity = 1},
			{items = {'farming:melon'}, rarity = 1},
		}
	},
	groups = {snappy=3, flammable=2, plant=1, attached_node=1, not_in_creative_inventory=1},
	on_rightclick = function(pos, node, clicker)
		minetest.set_node(pos, {name="farming:cut_melon_5", param2=node.param2})
		clicker:set_hp(clicker:get_hp()+1)
	end,
})

minetest.register_node("farming:cut_melon_5", {
	tiles = {
		"farming_melon_5_top.png",
		"farming_melon_5_top.png",
		"farming_melon_5.png",
		"farming_melon_cut_3.png",
		"farming_melon_5.png",
		"farming_melon_cut_3.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{0.125, -0.5, 0, 0.5, 0.5, 0.5}, -- NodeBox2
		}
	},
	drop = {
		items = {
			{items = {'farming:melon'}, rarity = 1},
		}
	},
	groups = {snappy=3, flammable=2, plant=1, attached_node=1, not_in_creative_inventory=1},
	on_rightclick = function(pos, node, clicker)
		minetest.remove_node(pos)
		clicker:set_hp(clicker:get_hp()+1)
	end,
})
