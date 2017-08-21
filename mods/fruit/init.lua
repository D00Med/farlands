
minetest.register_node("fruit:leaves_with_mango", {
	description = "Leaves with Mango",
	drawtype = "allfaces",
	tiles = {
		"default_jungleleaves.png^fruit_mango_leaves.png",
	},
	paramtype = "light",
	groups = {snappy=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	drop = "default:jungleleaves",
	on_destruct = function(pos)
		minetest.add_item(pos, "fruit:mango")
	end,
	sounds = default.node_sound_leaves_defaults()
})

minetest.override_item("default:apple", {
	description = "Leaves with Apple",
	drawtype = "allfaces",
	tiles = {
		"default_leaves.png^fruit_apple_leaves.png",
	},
	paramtype = "light",
	groups = {snappy=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	drop = "default:leaves",
	on_destruct = function(pos)
		minetest.add_item(pos, "fruit:apple")
	end,
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("fruit:apple", {
	description = "Apple",
	drawtype = "plantlike",
	tiles = {
		"default_apple.png",
	},
	paramtype = "light",
	groups = {snappy=1, oddly_breakable_by_hand=1},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults()
})


minetest.register_node("fruit:cactus_fruit", {
	description = "Cactus Fruit",
	drawtype = "plantlike",
	tiles = {
		"fruit_cactus.png",
	},
	paramtype = "light",
	groups = {fleshy=1, oddly_breakable_by_hand=1,},
	inventory_image = "fruit_cactus_inv.png",
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.3, -0.4, -0.3, 0.3, -0.5, 0.3}, 
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.3, -0.4, -0.3, 0.3, -0.5, 0.3}, 
		}
	},
	on_use = minetest.item_eat(2)
})

minetest.register_node("fruit:leaves_with_berry", {
	description = "Leaves with Berry",
	drawtype = "allfaces",
	tiles = {
		"default_leaves_simple.png^fruit_berry_leaves.png",
	},
	paramtype = "light",
	groups = {snappy=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	drop = "default:bush_leaves",
	on_destruct = function(pos)
		minetest.add_item(pos, "fruit:berry")
	end,
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("fruit:leaves_with_pear", {
	description = "Leaves with Pear",
	drawtype = "allfaces",
	tiles = {
		"default_leaves.png^fruit_pear_leaves.png",
	},
	paramtype = "light",
	groups = {snappy=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	drop = "default:leaves",
	on_destruct = function(pos)
		minetest.add_item(pos, "fruit:pear")
	end,
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("fruit:leaves_with_plum", {
	description = "Leaves with Plum",
	drawtype = "allfaces",
	tiles = {
		"default_leaves.png^fruit_plum_leaves.png",
	},
	paramtype = "light",
	groups = {snappy=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	drop = "default:leaves",
	on_destruct = function(pos)
		minetest.add_item(pos, "fruit:plum")
	end,
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("fruit:leaves_with_peach", {
	description = "Leaves with Peach",
	drawtype = "allfaces",
	tiles = {
		"default_leaves.png^fruit_peach_leaves.png",
	},
	paramtype = "light",
	groups = {snappy=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	drop = "default:leaves",
	on_destruct = function(pos)
		minetest.add_item(pos, "fruit:peach")
	end,
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("fruit:leaves_with_orange", {
	description = "Leaves with Orange",
	drawtype = "allfaces",
	tiles = {
		"default_acacia_leaves.png^fruit_orange_leaves.png",
	},
	paramtype = "light",
	groups = {snappy=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	drop = "default:acacia_leaves",
	on_destruct = function(pos)
		minetest.add_item(pos, "fruit:orange")
	end,
	sounds = default.node_sound_leaves_defaults()
})


minetest.register_craftitem("fruit:pear", {
	description = "Pear",
	inventory_image = "fruit_pear.png",
	on_use = minetest.item_eat(2)
})

minetest.register_craftitem("fruit:plum", {
	description = "Plum",
	inventory_image = "fruit_plum.png",
	on_use = minetest.item_eat(1)
})

minetest.register_craftitem("fruit:peach", {
	description = "Peach",
	inventory_image = "fruit_peach.png",
	on_use = minetest.item_eat(2)
})

minetest.register_craftitem("fruit:orange", {
	description = "Orange",
	inventory_image = "fruit_orange.png",
	on_use = minetest.item_eat(2)
})

minetest.register_craftitem("fruit:berry", {
	description = "Berry",
	inventory_image = "fruit_berry.png",
	on_use = minetest.item_eat(1)
})

minetest.register_craftitem("fruit:mango", {
	description = "Mango",
	inventory_image = "fruit_mango.png",
	on_use = minetest.item_eat(2)
})

fruit = {}

function fruit.register_ores()
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "fruit:leaves_with_orange",
		wherein        = "default:acacia_leaves",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 6,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})
	
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "fruit:leaves_with_berry",
		wherein        = "default:bush_leaves",
		clust_scarcity = 10 * 10 * 10,
		clust_num_ores = 6,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})
	
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "fruit:leaves_with_mango",
		wherein        = "default:jungleleaves",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 6,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "fruit:leaves_with_peach",
		wherein        = "default:leaves",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 6,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})
	
	
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:apple",
		wherein        = "default:leaves",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 6,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "fruit:leaves_with_pear",
		wherein        = "default:leaves",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 6,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "fruit:leaves_with_plum",
		wherein        = "default:leaves",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 6,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})
end


minetest.register_abm({
	nodenames = {"default:cactus",},
	interval = 30,
	chance = 50,
	action = function(pos, node)
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" then
			minetest.set_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="fruit:cactus_fruit"})
		end
	end,
})