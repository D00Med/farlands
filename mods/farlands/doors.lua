
doors.register("door_jungle_wood", {
		tiles = {{ name = "doors_jungle_wood_door.png", backface_culling = true }},
		description = "Jungle Wood Door",
		inventory_image = "doors_jungle_wood_door_item.png",
		groups = {door=1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:junglewood", "default:junglewood"},
			{"default:junglewood", "default:junglewood"},
			{"default:junglewood", "default:junglewood"},
		}
})

doors.register("door_pine_wood", {
		tiles = {{ name = "doors_pine_wood_door.png", backface_culling = true }},
		description = "Pine Wood Door",
		inventory_image = "doors_pine_wood_door_item.png",
		groups = {door=1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:pine_wood", "default:pine_wood"},
			{"default:pine_wood", "default:pine_wood"},
			{"default:pine_wood", "default:pine_wood"},
		}
})


doors.register("door_acacia_wood", {
		tiles = {{ name = "doors_acacia_wood_door.png", backface_culling = true }},
		description = "Acacia Wood Door",
		inventory_image = "doors_acacia_wood_door_item.png",
		groups = {door=1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:acacia_wood", "default:acacia_wood"},
			{"default:acacia_wood", "default:acacia_wood"},
			{"default:acacia_wood", "default:acacia_wood"},
		}
})

doors.register("door_aspen_wood", {
		tiles = {{ name = "doors_aspen_wood_door.png", backface_culling = true }},
		description = "Aspen Wood Door",
		inventory_image = "doors_aspen_wood_door_item.png",
		groups = {door=1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:aspen_wood", "default:aspen_wood"},
			{"default:aspen_wood", "default:aspen_wood"},
			{"default:aspen_wood", "default:aspen_wood"},
		}
})

doors.register("door_willow_wood", {
		tiles = {{ name = "doors_willow_wood_door.png", backface_culling = true }},
		description = "Willow Wood Door",
		inventory_image = "doors_willow_wood_door_item.png",
		groups = {door=1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"mapgen:willow_wood", "mapgen:willow_wood"},
			{"mapgen:willow_wood", "mapgen:willow_wood"},
			{"mapgen:willow_wood", "mapgen:willow_wood"},
		}
})

doors.register("door_baobab_wood", {
		tiles = {{ name = "doors_baobab_wood_door.png", backface_culling = true }},
		description = "Baobab Wood Door",
		inventory_image = "doors_baobab_wood_door_item.png",
		groups = {door=1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"mapgen:baobab_wood", "mapgen:baobab_wood"},
			{"mapgen:baobab_wood", "mapgen:baobab_wood"},
			{"mapgen:baobab_wood", "mapgen:baobab_wood"},
		}
})

doors.register("door_yellow_ipewood", {
		tiles = {{ name = "doors_yellow_ipe_wood_door.png", backface_culling = true }},
		description = "Yellow Ipe Wood Door",
		inventory_image = "doors_yellow_ipe_wood_door_item.png",
		groups = {door=1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"mapgen:yellow_ipe_wood", "mapgen:yellow_ipe_wood"},
			{"mapgen:yellow_ipe_wood", "mapgen:yellow_ipe_wood"},
			{"mapgen:yellow_ipe_wood", "mapgen:yellow_ipe_wood"},
		}
})

doors.register("door_palm_wood", {
		tiles = {{ name = "doors_palm_wood_door.png", backface_culling = true }},
		description = "Palm Wood Door",
		inventory_image = "doors_palm_wood_door_item.png",
		groups = {door=1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"mapgen:palm_wood", "mapgen:palm_wood"},
			{"mapgen:palm_wood", "mapgen:palm_wood"},
			{"mapgen:palm_wood", "mapgen:palm_wood"},
		}
})

doors.register("door_copper", {
		tiles = {{ name = "doors_door_copper.png", backface_culling = true }},
		description = "Copper Door",
		inventory_image = "doors_item_copper.png",
		groups = {door=1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:copper_ingot", "default:copper_ingot"},
			{"default:copper_ingot", "default:copper_ingot"},
			{"default:copper_ingot", "default:copper_ingot"},
		}
})

doors.register("door_bamboo", {
		tiles = {{ name = "doors_door_bamboo.png", backface_culling = true }},
		description = "Bamboo Door",
		inventory_image = "doors_item_bamboo.png",
		groups = {door=1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"mapgen:bamboo", "mapgen:bamboo"},
			{"mapgen:bamboo", "mapgen:bamboo"},
			{"mapgen:bamboo", "mapgen:bamboo"},
		}
})


doors.register("door_ice", {
		tiles = {{name = "doors_door_ice.png", backface_culling = true}},
		description = "ice Door",
		inventory_image = "doors_item_ice.png",
		groups = {door=1, cracky=3, oddly_breakable_by_hand=3},
		sounds = default.node_sound_glass_defaults(),
		sound_open = "doors_glass_door_open",
		sound_close = "doors_glass_door_close",
		recipe = {
			{"default:ice", "default:ice"},
			{"default:ice", "default:ice"},
			{"default:ice", "default:ice"},
		}
})

doors.register_fencegate("doors:gate_bamboo", {
	description = "Bamboo Fence Gate",
	texture = "decoblocks_bamboo.png",
	material = "decoblocks:bamboo_block",
	groups = {door=1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3}
})
