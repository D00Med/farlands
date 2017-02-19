--[[

Craft Guide for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-craft_guide
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-craft_guide/master/LICENSE

REGISTER NODES

]]--


-- craft sign
minetest.register_node("craft_guide:sign_wall", {
	description = "Craft Sign",
	drawtype = "signlike",
	tiles = {"craft_guide_sign.png"},
	inventory_image = "craft_guide_sign.png",
	paramtype = 'light',
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	groups = {choppy=2,dig_immediate=2,book=1},
	--sounds = default.node_sound_defaults(),
	selection_box = {
		type = "wallmounted",
	},
	on_construct = craft_guide.on_construct,
	on_receive_fields = craft_guide.on_receive_fields,
	allow_metadata_inventory_move = craft_guide.allow_metadata_inventory_move,
	allow_metadata_inventory_put = craft_guide.allow_metadata_inventory_put,
	allow_metadata_inventory_take = craft_guide.allow_metadata_inventory_take,
})

-- craft pc
minetest.register_node("craft_guide:lcd_pc", {
	description = "Craft PC",
	drawtype = "nodebox",
	tiles = {
		"craft_guide_pc_grey.png",
		"craft_guide_pc_grey.png",
		"craft_guide_pc_grey.png",
		"craft_guide_pc_grey.png",
		"craft_guide_pc_black.png",
		"craft_guide_pc_screen.png",
	},
	paramtype = 'light',
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {type="regular"},
	groups = {choppy=2,dig_immediate=2},
	-- thanks cactuz_pl for the nodebox code!  =)
	node_box = {
        type = "fixed",
        fixed = {
            {-1.0000000e-1,-0.45259861,2.5136044e-2, 0.10000000,-2.5986075e-3,-2.4863956e-2},
            {-0.40006064,-0.25615262,-0.13023723, -0.37006064,0.26767738,-0.16023723},
            {0.37054221,-0.25615274,-0.13023723, 0.40054221,0.26767750,-0.16023723},
            {-0.40000000,-0.30600000,-0.13023723, 0.40000000,-0.25600000,-0.16023723},
            {-0.40000000,0.26433021,-0.12945597, 0.40000000,0.29433021,-0.15945597},
            {-0.35000000,-0.25514168,-2.9045502e-2, 0.35000000,0.24485832,-7.9045502e-2},
            {-0.40000000,-0.30617002,-8.0237234e-2, 0.40000000,0.29382998,-0.13023723},
            {-0.25000000,-0.50000000,0.25000000, 0.25000000,-0.45000000,-0.25000000}
        },
    },
	--sounds = default.node_sound_defaults(),
	on_construct = craft_guide.on_construct,
	on_receive_fields = craft_guide.on_receive_fields,
	allow_metadata_inventory_move = craft_guide.allow_metadata_inventory_move,
	allow_metadata_inventory_put = craft_guide.allow_metadata_inventory_put,
	allow_metadata_inventory_take = craft_guide.allow_metadata_inventory_take,
})

-- craft sign
minetest.register_node("craft_guide:sign_wall_locked", {
	description = "Craft Sign (locked)",
	drawtype = "signlike",
	tiles = {"craft_guide_sign.png"},
	inventory_image = "craft_guide_sign.png",
	paramtype = 'light',
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	groups = {choppy=2,dig_immediate=2,book=1},
	--sounds = default.node_sound_defaults(),
	selection_box = {
		type = "wallmounted",
	},
	on_construct = craft_guide.on_construct,
	on_receive_fields = craft_guide.on_receive_fields,
	allow_metadata_inventory_move = craft_guide.allow_metadata_inventory_move,
	allow_metadata_inventory_put = craft_guide.allow_metadata_inventory_put,
	allow_metadata_inventory_take = craft_guide.allow_metadata_inventory_take,
})

-- craft pc
minetest.register_node("craft_guide:lcd_pc_locked", {
	description = "Craft PC (locked)",
	drawtype = "nodebox",
	tiles = {
		"craft_guide_pc_grey.png",
		"craft_guide_pc_grey.png",
		"craft_guide_pc_grey.png",
		"craft_guide_pc_grey.png",
		"craft_guide_pc_black.png",
		"craft_guide_pc_screen.png",
	},
	paramtype = 'light',
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {type="regular"},
	groups = {choppy=2,dig_immediate=2},
	-- thanks cactuz_pl for the nodebox code!  =)
	node_box = {
        type = "fixed",
        fixed = {
            {-1.0000000e-1,-0.45259861,2.5136044e-2, 0.10000000,-2.5986075e-3,-2.4863956e-2},
            {-0.40006064,-0.25615262,-0.13023723, -0.37006064,0.26767738,-0.16023723},
            {0.37054221,-0.25615274,-0.13023723, 0.40054221,0.26767750,-0.16023723},
            {-0.40000000,-0.30600000,-0.13023723, 0.40000000,-0.25600000,-0.16023723},
            {-0.40000000,0.26433021,-0.12945597, 0.40000000,0.29433021,-0.15945597},
            {-0.35000000,-0.25514168,-2.9045502e-2, 0.35000000,0.24485832,-7.9045502e-2},
            {-0.40000000,-0.30617002,-8.0237234e-2, 0.40000000,0.29382998,-0.13023723},
            {-0.25000000,-0.50000000,0.25000000, 0.25000000,-0.45000000,-0.25000000}
        },
    },
	--sounds = default.node_sound_defaults(),
	on_construct = craft_guide.on_construct,
	on_receive_fields = craft_guide.on_receive_fields,
	allow_metadata_inventory_move = craft_guide.allow_metadata_inventory_move,
	allow_metadata_inventory_put = craft_guide.allow_metadata_inventory_put,
	allow_metadata_inventory_take = craft_guide.allow_metadata_inventory_take,
})
