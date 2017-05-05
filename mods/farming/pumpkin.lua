
--pumpkin crop, textures by D00Med

minetest.register_craftitem("farming:pumpkin", {
	description = "Pumpkin Slice",
	inventory_image = "farming_pumpkin.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:pumpkin_1")
	end,
	on_use = minetest.item_eat(2),
})

minetest.register_node("farming:pumpkin_1", {
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

minetest.register_node("farming:pumpkin_2", {
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

minetest.register_node("farming:pumpkin_3", {
	tiles = {
	"farming_pumpkin_3_top.png",
	"farming_pumpkin_3_top.png",
	"farming_pumpkin_3.png",
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

minetest.register_node("farming:pumpkin_4", {
	tiles = {
	"farming_pumpkin_4_top.png",
	"farming_pumpkin_4_top.png",
	"farming_pumpkin_4.png",
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
			{items = {'farming:pumpkin'}, rarity = 1},
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

minetest.register_node("farming:pumpkin_5", {
	tiles = {
	"farming_pumpkin_5_top.png",
	"farming_pumpkin_5_top.png",
	"farming_pumpkin_5.png",
	},
	waving = 1,
	drop = {
		items = {
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
		}
	},
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
	on_rightclick = function(pos, node, clicker)
		minetest.set_node(pos, {name="farming:cut_pumpkin_1", param2=node.param2})
		clicker:set_hp(clicker:get_hp()+1)
	end,
})

minetest.register_node("farming:pumpkin_block", {
	description = "Pumpkin",
	tiles = {
	"farming_pumpkin_5_top.png",
	"farming_pumpkin_5_top.png",
	"farming_pumpkin_5.png",
	},
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
	on_rightclick = function(pos, node, clicker)
		minetest.set_node(pos, {name="farming:cut_pumpkin_1", param2=node.param2})
		clicker:set_hp(clicker:get_hp()+1)
	end,
})

minetest.register_craft({
	output = "default:pumpkin_5 1",
	recipe = {
		{"farming:pumpkin", "farming:pumpkin", "farming:pumpkin"},
		{"farming:pumpkin", "farming:pumpkin", "farming:pumpkin"},
		{"farming:pumpkin", "farming:pumpkin",  "farming:pumpkin"}
	}
})

minetest.register_node("farming:pumpkin_6", {
	tiles = {
	"farming_pumpkin_6_top.png",
	"farming_pumpkin_6_top.png",
	"farming_pumpkin_6.png",
	},
	waving = 1,
	drop = "",
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:cut_pumpkin_1", {
	tiles = {
		"farming_pumpkin_5_top.png",
		"farming_pumpkin_5_top.png",
		"farming_pumpkin_5.png",
		"farming_pumpkin_cut_4.png^[transformFX",
		"farming_pumpkin_5.png",
		"farming_pumpkin_cut_1.png"
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
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
		}
	},
	groups = {snappy=3, flammable=2, plant=1, attached_node=1, not_in_creative_inventory=1},
	on_rightclick = function(pos, node, clicker)
		minetest.set_node(pos, {name="farming:cut_pumpkin_2", param2=node.param2})
		clicker:set_hp(clicker:get_hp()+1)
	end,
})

minetest.register_node("farming:cut_pumpkin_2", {
	tiles = {
		"farming_pumpkin_5_top.png",
		"farming_pumpkin_5_top.png",
		"farming_pumpkin_5.png",
		"farming_pumpkin_cut_4.png^[transformFX",
		"farming_pumpkin_5.png",
		"farming_pumpkin_cut_2.png"
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
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
		}
	},
	groups = {snappy=3, flammable=2, plant=1, attached_node=1, not_in_creative_inventory=1},
	on_rightclick = function(pos, node, clicker)
		minetest.set_node(pos, {name="farming:cut_pumpkin_3", param2=node.param2})
		clicker:set_hp(clicker:get_hp()+1)
	end,
})

minetest.register_node("farming:cut_pumpkin_3", {
	tiles = {
		"farming_pumpkin_5_top.png",
		"farming_pumpkin_5_top.png",
		"farming_pumpkin_5.png",
		"farming_pumpkin_cut_4.png^[transformFX",
		"farming_pumpkin_5.png",
		"farming_pumpkin_cut_3.png"
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
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
		}
	},
	groups = {snappy=3, flammable=2, plant=1, attached_node=1, not_in_creative_inventory=1},
	on_rightclick = function(pos, node, clicker)
		minetest.set_node(pos, {name="farming:cut_pumpkin_4", param2=node.param2})
		clicker:set_hp(clicker:get_hp()+1)
	end,
})

minetest.register_node("farming:cut_pumpkin_4", {
	tiles = {
		"farming_pumpkin_5_top.png",
		"farming_pumpkin_5_top.png",
		"farming_pumpkin_5.png",
		"farming_pumpkin_cut_3.png",
		"farming_pumpkin_5.png",
		"farming_pumpkin_cut_3.png"
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
			{items = {'farming:pumpkin'}, rarity = 1},
			{items = {'farming:pumpkin'}, rarity = 1},
		}
	},
	groups = {snappy=3, flammable=2, plant=1, attached_node=1, not_in_creative_inventory=1},
	on_rightclick = function(pos, node, clicker)
		minetest.set_node(pos, {name="farming:cut_pumpkin_5", param2=node.param2})
		clicker:set_hp(clicker:get_hp()+1)
	end,
})

minetest.register_node("farming:cut_pumpkin_5", {
	tiles = {
		"farming_pumpkin_5_top.png",
		"farming_pumpkin_5_top.png",
		"farming_pumpkin_5.png",
		"farming_pumpkin_cut_3.png",
		"farming_pumpkin_5.png",
		"farming_pumpkin_cut_3.png"
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
			{items = {'farming:pumpkin'}, rarity = 1},
		}
	},
	groups = {snappy=3, flammable=2, plant=1, attached_node=1, not_in_creative_inventory=1},
	on_rightclick = function(pos, node, clicker)
		minetest.remove_node(pos)
		clicker:set_hp(clicker:get_hp()+1)
	end,
})