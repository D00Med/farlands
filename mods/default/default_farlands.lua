
function default.grow_new_baobab_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/baobab.mts"
	minetest.place_schematic({x = pos.x - 8, y = pos.y - 1, z = pos.z - 8},
		path, "random", nil, false)
	minetest.set_node(pos, {name="mapgen:baobab_tree"})
end

function default.grow_new_bamboo_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/bamboo1.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "random", nil, false)
	minetest.set_node(pos, {name="mapgen:bamboo"})
end

function default.grow_new_ipe_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/ipe.mts"
	minetest.place_schematic({x = pos.x - 7, y = pos.y - 1, z = pos.z - 6},
		path, "random", nil, false)
	minetest.set_node(pos, {name="mapgen:yellow_ipe_tree"})
end

function default.grow_new_palm_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/palmtree.mts"
	minetest.place_schematic({x = pos.x - 3, y = pos.y - 1, z = pos.z - 3},
		path, "random", nil, false)
	minetest.set_node(pos, {name="mapgen:palm_tree"})
end

function default.grow_new_big_pine_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/pine.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 3},
		path, "random", nil, false)
	minetest.set_node(pos, {name="default:pine_tree"})
end

function default.grow_new_willow_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/willow.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "random", nil, false)
	minetest.set_node(pos, {name="mapgen:willow_tree"})
end

minetest.register_node("default:bamboo_sapling", {
	description = "Bamboo Sapling",
	drawtype = "plantlike",
	tiles = {"mapgen_bamboo_sapling.png"},
	inventory_image = "mapgen_bamboo_sapling.png",
	wield_image = "mapgen_bamboo_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = default.grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(2400,4800))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"default:bamboo_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 15, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("default:baobab_sapling", {
	description = "Baobab Sapling",
	drawtype = "plantlike",
	tiles = {"mapgen_baobab_sapling.png"},
	inventory_image = "mapgen_baobab_sapling.png",
	wield_image = "mapgen_baobab_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = default.grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(2400,4800))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"default:baobab_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 15, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("default:ipe_sapling", {
	description = "Yellow Ipe Sapling",
	drawtype = "plantlike",
	tiles = {"mapgen_yellow_ipe_sapling.png"},
	inventory_image = "mapgen_yellow_ipe_sapling.png",
	wield_image = "mapgen_yellow_ipe_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = default.grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(2400,4800))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"default:ipe_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 15, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("default:palmtree_sapling", {
	description = "Palm Tree Sapling",
	drawtype = "plantlike",
	tiles = {"mapgen_palmtree_sapling.png"},
	inventory_image = "mapgen_palmtree_sapling.png",
	wield_image = "mapgen_palmtree_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = default.grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(2400,4800))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"default:palmtree_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 15, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("default:willow_sapling", {
	description = "Willow Tree Sapling",
	drawtype = "plantlike",
	tiles = {"mapgen_willow_sapling.png"},
	inventory_image = "mapgen_willow_sapling.png",
	wield_image = "mapgen_willow_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = default.grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(2400,4800))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"default:willow_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 15, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("default:big_pine_sapling", {
	description = "Big Pine Sapling",
	drawtype = "plantlike",
	tiles = {"mapgen_big_pine_sapling.png"},
	inventory_image = "mapgen_big_pine_sapling.png",
	wield_image = "mapgen_big_pine_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = default.grow_sapling,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(2400,4800))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"default:big_pine_sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 15, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

default.register_chest("bamboo_chest", {
	description = "Bamboo Chest",
	tiles = {
		"default_bamboo_chest_top.png",
		"default_bamboo_chest_top.png",
		"default_bamboo_chest_side.png",
		"default_bamboo_chest_side.png",
		"default_bamboo_chest_front.png",
		"default_chest_inside.png"
	},
	sounds = default.node_sound_wood_defaults(),
	sound_open = "default_chest_open",
	sound_close = "default_chest_close",
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
})

default.register_chest("ice_chest", {
	description = "Ice Chest",
	tiles = {
		"default_ice_chest_top.png",
		"default_ice_chest_top.png",
		"default_ice_chest_side.png",
		"default_ice_chest_side.png",
		"default_ice_chest_front.png",
		"default_chest_inside.png"
	},
	sounds = default.node_sound_glass_defaults(),
	sound_open = "default_chest_open",
	sound_close = "default_chest_close",
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
})

minetest.register_craft({
	output = 'default:bamboo_chest',
	recipe = {
		{'mapgen:bamboo', 'mapgen:bamboo', 'mapgen:bamboo'},
		{'mapgen:bamboo', '', 'mapgen:bamboo'},
		{'mapgen:bamboo', 'mapgen:bamboo', 'mapgen:bamboo'},
	}
})

minetest.register_craft({
	output = 'default:ice_chest',
	recipe = {
		{'default:ice', 'default:ice', 'default:ice'},
		{'default:ice', '', 'default:ice'},
		{'default:ice', 'default:ice', 'default:ice'},
	}
})