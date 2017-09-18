--functions from flowers mod:
--Originally by Ironzorg (MIT) and VanessaE (MIT)
--Various Minetest developers and contributors (MIT)

local function add_simple_flower(name, desc, box, f_groups)
	-- Common flowers' groups
	f_groups.snappy = 3
	f_groups.flower = 1
	f_groups.flora = 1
	f_groups.attached_node = 1

	minetest.register_node("flowers_plus:" .. name, {
		description = desc,
		drawtype = "plantlike",
		waving = 1,
		tiles = {"flowers_" .. name .. ".png"},
		inventory_image = "flowers_" .. name .. ".png",
		wield_image = "flowers_" .. name .. ".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		stack_max = 99,
		groups = f_groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = box
		}
	})
end

add_simple_flower("pansy_purple", "Purple Pansy", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_violet=1, flammable=1})
add_simple_flower("pansy_blue", "Blue Pansy", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_blue=1, flammable=1})
add_simple_flower("petunia_blue", "Blue Petunia", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_blue=1, flammable=1})
add_simple_flower("petunia_pink", "Pink Petunia", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_pink=1, flammable=1})
add_simple_flower("petunia_white", "White Petunia", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_white=1, flammable=1})
add_simple_flower("lobelia", "Lobelia", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_blue=1, flammable=1})


minetest.register_node("flowers_plus:foxglove", {
	description = "Pink Foxglove",
	drawtype = "plantlike",
	tiles = {"flowers_foxglove_pink.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "flowers_foxglove_pink.png",
	visual_scale = 2,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25}
	},
	walkable = false,
})

minetest.register_node("flowers_plus:foxglove_purple", {
	description = "Pink Purple",
	drawtype = "plantlike",
	tiles = {"flowers_foxglove_purple.png"},
	paramtype = "light",
	is_ground_content = false,
	buildable_to = true, 
	sunlight_propagates = true,
	inventory_image = "flowers_foxglove_purple.png",
	visual_scale = 2,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	groups = {snappy=3, flammable=1, attatched_node=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25}
	},
	walkable = false,
})