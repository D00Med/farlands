
minetest.register_node("mapgen:coarse_dirt", {
	description = "coarse dirt",
	tiles = {"mapgen_coarse_dirt.png"},
	groups = {crumbly = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_node("mapgen:dirt_with_junglegrass", {
	description = "Dirt With Jungle Grass",
	tiles = {"mapgen_jungle_grass.png", "default_dirt.png", "default_dirt.png^mapgen_jungle_grass_side.png"},
	groups = {crumbly = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_node("mapgen:granite", {
	description = "Granite",
	tiles = {"mapgen_granite.png"},
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:granite_brown", {
	description = "Brown Granite",
	tiles = {"mapgen_granite_brown.png"},
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:limestone", {
	description = "Limestone",
	tiles = {"mapgen_limestone.png"},
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:palm_tree", {
	description = "Palm Tree",
	tiles = {
		"mapgen_palmtree_top.png",
		"mapgen_palmtree_top.png",
		"mapgen_palmtree_side.png",
	},
	groups = {choppy = 2, tree = 1, flammable = 1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("mapgen:palm_wood", {
	description = "Palm Wood Planks",
	tiles = {
		"mapgen_palmtree_wood.png",
	},
	groups = {choppy = 1, flammable = 1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("mapgen:palm_leaves", {
	description = "Palm Leaves",
	drawtype = "allfaces",
	paramtype = "light",
	tiles = {
		"mapgen_palmleaves.png",
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1, flammable = 1, dig_immediate = 1, leaves = 1, leafdecay = 3},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("mapgen:palm_leaves_coconut", {
	description = "Palm Leaves (coconut)",
	drawtype = "allfaces",
	paramtype = "light",
	tiles = {
		"mapgen_palmleaves_coconut.png",
	},
	groups = {snappy = 1, oddly_breakable_by_hand = 1, flammable = 1, dig_immediate = 1, leaves = 1, leafdecay = 3},
	sounds = default.node_sound_leaves_defaults(),
	on_rightclick = function(pos, node)
		minetest.env:set_node(pos, {name="mapgen:palm_leaves"})
		minetest.env:add_item(pos, "mapgen:coconut")
	end,
})

minetest.register_craftitem("mapgen:coconut", {
	description = "Coconut",
	inventory_image = "mapgen_coconut.png",
	on_use = function(itemstack, placer, pointed_thing)
		if pointed_thing.under == nil then
		return
		end
		local item = minetest.get_node(pointed_thing.under).name
		if minetest.get_item_group(item, "cracky") ~= 0 then
		itemstack:take_item()
		minetest.env:add_item(pointed_thing.above, "mapgen:coconut_open")
		end
		return itemstack
	end,
})

minetest.register_craftitem("mapgen:coconut_open", {
	description = "Cracked Coconut",
	inventory_image = "mapgen_coconut_opened.png",
	on_use = minetest.item_eat(2)
})

minetest.register_node("mapgen:moss", {
	description = "Moss",
	drawtype = "nodebox",
	tiles = {"mapgen_moss.png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
		}
	},
	buildable_to = true,
	groups = {snappy = 1, oddly_breakable_by_hand=1, dig_immediate=3},
	sounds = default.node_sound_defaults()
})