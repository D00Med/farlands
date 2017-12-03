
--[[

  Copyright (C) 2015 - Auke Kok <sofar@foo-projects.org>

  "frame" is free software; you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as
  published by the Free Software Foundation; either version 2.1 of
  the license, or (at your option) any later version.

--]]

frame = {}

-- handle node removal from frame
local function frame_on_punch(pos, node, puncher, pointed_thing)
	if puncher and not minetest.check_player_privs(puncher, "protection_bypass") then
		local name = puncher:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return false
		end
	end

	local def = minetest.registered_nodes[node.name]
	local item = ItemStack(def.frame_contents)

	-- preserve itemstack metadata and wear
	local meta = minetest.get_meta(pos)
	local wear = meta:get_int("wear")
	if wear then
		item:set_wear(wear)
	end
	local metadata = meta:get_string("metadata")
	if metadata ~= "" then
		item:set_metadata(metadata)
	end

	--minetest.handle_node_drops(pos, {item}, puncher)
	local inv = puncher:get_inventory()
	if inv:room_for_item("main", item) then
		inv:add_item("main", item)
		minetest.sound_play(def.sounds.dug, {pos = pos})
		minetest.swap_node(pos, {name = "frame:empty", param2 = node.param2})
	end
end

-- handle node insertion into frame
local function frame_on_rightclick(pos, node, clicker, itemstack, pointed_thing)
	if clicker and not minetest.check_player_privs(clicker, "protection_bypass") then
		local name = clicker:get_player_name()
		if minetest.is_protected(pos, name) then
			minetest.record_protection_violation(pos, name)
			return itemstack
		end
	end

	local nodename = itemstack:get_name()
	if not nodename then
		return itemstack
	end

	local wear = itemstack:get_wear()
	if wear then
		local meta = minetest.get_meta(pos)
		meta:set_int("wear", wear)
	end
	local metadata = itemstack:get_metadata()
	if metadata ~= "" then
		local meta = minetest.get_meta(pos)
		meta:set_string("metadata", metadata)
	end

	local name = "frame:" .. nodename:gsub(":", "_")
	local def = minetest.registered_nodes[name]
	if not def then
		def = minetest.registered_items[name]
		if not def then
			return itemstack
		end
	end
	minetest.sound_play(def.sounds.place, {pos = pos})
	minetest.swap_node(pos, {name = name, param2 = node.param2})
	if not minetest.setting_getbool("creative_mode") then
		itemstack:take_item()
	end
	return itemstack
end

function frame.register(name)
	assert(name, "no content passed")
	local tiles

	local def = minetest.registered_nodes[name]
	if not def then
		-- item?
		def = minetest.registered_items[name]
		if not def then
			-- nonexistant item.
			minetest.log("warning", "Frame registered for \"" .. name .. "\" but it isn't registered")
			return
		end
		assert(def.inventory_image, "no inventory image for " .. name)

		tiles = {
			{name = "frame_frame.png"},
			{name = def.inventory_image},
			{name = "doors_blank.png"},
			{name = "doors_blank.png"},
			{name = "doors_blank.png"},
		}
	else
		-- node
		if def.inventory_image ~= "" then
			-- custom inventory override image first.
			tiles = {
				{name = "frame_frame.png"},
				{name = def.inventory_image or "doors_blank.png"},
				{name = "doors_blank.png"},
				{name = "doors_blank.png"},
				{name = "doors_blank.png"},
			}
		elseif def.drawtype ~= "normal" then
			-- use tiles[1] only, but on frame
			tiles = {
				{name = "frame_frame.png"},
				{name = def.tiles[1] and def.tiles[1].name or def.tiles[1] or "doors_blank.png"},
				{name = "doors_blank.png"},
				{name = "doors_blank.png"},
				{name = "doors_blank.png"},
			}
		else -- type(def.tiles[1]) == "table" then
			-- multiple tiles
			tiles = {
				{name = "frame_frame.png"},
				{name = "doors_blank.png"},
				{name = def.tiles[1] and def.tiles[1].name or def.tiles[1]
					or "doors_blank.png"},
				{name = def.tiles[2] and def.tiles[2].name or def.tiles[2]
					or def.tiles[1] and def.tiles[1].name or def.tiles[1]
					or "doors_blank.png"},
				{name = def.tiles[6] and def.tiles[6].name or def.tiles[6]
				        or def.tiles[3] and def.tiles[3].name or def.tiles[3]
					or def.tiles[2] and def.tiles[2].name or def.tiles[2]
					or def.tiles[1] and def.tiles[1].name or def.tiles[1]
					or "doors_blank.png"},
			}
		end
	end
	assert(def, name .. " is not a known node or item")

	minetest.register_node("frame:" .. name:gsub(":", "_"), {
		description = "Item Frame with " .. def.description,
		drawtype = "mesh",
		mesh = "frame.obj",
		tiles = tiles,
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		selection_box = {
			type = "wallmounted",
			wall_side = {-1/2, -1/2, -1/2, -3/8, 1/2, 1/2},
		},
		sounds = default.node_sound_defaults(),
		groups = {attached_node = 1, oddly_breakable_by_hand = 1, snappy = 3, not_in_creative_inventory = 1},
		frame_contents = name,
		drop = "frame:empty", -- FIXME item should be in there but this would allow free repair
		on_punch = frame_on_punch,
	})
end

-- empty frame
minetest.register_node("frame:empty", {
	description = "Item Frame",
	drawtype = "mesh",
	mesh = "frame.obj",
	inventory_image = "frame_frame.png",
	wield_image = "frame_frame.png",
	tiles = {
		{name = "frame_frame.png"},
		{name = "doors_blank.png"},
		{name = "doors_blank.png"},
		{name = "doors_blank.png"},
		{name = "doors_blank.png"},
	},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/2, -3/8, 1/2, 1/2},
	},
	sounds = default.node_sound_defaults(),
	groups = {attached_node = 1, oddly_breakable_by_hand = 3, cracky = 1},
	on_rightclick = frame_on_rightclick,
})

-- craft
minetest.register_craft({
	output = "frame:empty",
	recipe = {
		{"default:stick", "default:stick", "default:stick"},
		{"default:stick", "default:paper", "default:stick"},
		{"default:stick", "default:stick", "default:stick"},
	}
})

for _, node in pairs({
	"beds:bed_bottom",
	"beds:fancy_bed_bottom",
	"boats:boat",
	"boats:boat",
	"bucket:bucket_empty",
	"bucket:bucket_lava",
	"bucket:bucket_river_water",
	"bucket:bucket_water",
	"carts:brakerail",
	"carts:cart",
	"carts:powerrail",
	"carts:rail",
	"default:acacia_bush_leaves",
	"default:acacia_bush_sapling",
	"default:acacia_bush_stem",
	"default:acacia_leaves",
	"default:acacia_sapling",
	"default:acacia_tree",
	"default:acacia_wood",
	"default:apple",
	"default:aspen_leaves",
	"default:aspen_sapling",
	"default:aspen_tree",
	"default:aspen_wood",
	"default:axe_bronze",
	"default:axe_diamond",
	"default:axe_mese",
	"default:axe_steel",
	"default:axe_stone",
	"default:axe_wood",
	"default:book",
	"default:bookshelf",
	"default:book_written",
	"default:brick",
	"default:bronzeblock",
	"default:bronze_ingot",
	"default:bush_leaves",
	"default:bush_sapling",
	"default:bush_stem",
	"default:cactus",
	"default:chest",
	"default:chest_locked",
	"default:clay",
	"default:clay_brick",
	"default:clay_lump",
	"default:cloud",
	"default:coalblock",
	"default:coal_lump",
	"default:cobble",
	"default:copperblock",
	"default:copper_ingot",
	"default:copper_lump",
	"default:coral_brown",
	"default:coral_orange",
	"default:coral_skeleton",
	"default:desert_cobble",
	"default:desert_sand",
	"default:desert_stone",
	"default:desert_stone_block",
	"default:desert_stonebrick",
	"default:diamond",
	"default:diamondblock",
	"default:dirt",
	"default:dirt_with_dry_grass",
	"default:dirt_with_grass",
	"default:dirt_with_grass_footsteps",
	"default:dirt_with_snow",
	"default:dry_grass_1",
	"default:dry_grass_2",
	"default:dry_grass_3",
	"default:dry_grass_4",
	"default:dry_grass_5",
	"default:dry_shrub",
	"default:flint",
	"default:furnace",
	"default:glass",
	"default:goldblock",
	"default:gold_ingot",
	"default:gold_lump",
	"default:grass_1",
	"default:grass_2",
	"default:grass_3",
	"default:grass_4",
	"default:grass_5",
	"default:gravel",
	"default:ice",
	"default:iron_lump",
	"default:junglegrass",
	"default:jungleleaves",
	"default:junglesapling",
	"default:jungletree",
	"default:junglewood",
	"default:key",
	"default:ladder_steel",
	"default:ladder_wood",
	"default:lava_flowing",
	"default:lava_source",
	"default:leaves",
	"default:mese",
	"default:mese_crystal",
	"default:mese_crystal_fragment",
	"default:meselamp",
	"default:mossycobble",
	"default:obsidian",
	"default:obsidian_block",
	"default:obsidianbrick",
	"default:obsidian_glass",
	"default:obsidian_shard",
	"default:paper",
	"default:papyrus",
	"default:pick_bronze",
	"default:pick_diamond",
	"default:pick_mese",
	"default:pick_steel",
	"default:pick_stone",
	"default:pick_wood",
	"default:pine_needles",
	"default:pine_sapling",
	"default:pine_tree",
	"default:pine_wood",
	"default:river_water_flowing",
	"default:river_water_source",
	"default:sand",
	"default:sandstone",
	"default:sandstone_block",
	"default:sandstonebrick",
	"default:sapling",
	"default:shovel_bronze",
	"default:shovel_diamond",
	"default:shovel_mese",
	"default:shovel_steel",
	"default:shovel_stone",
	"default:shovel_wood",
	"default:sign_wall_steel",
	"default:sign_wall_wood",
	"default:silver_sand",
	"default:skeleton_key",
	"default:snow",
	"default:snowblock",
	"default:steelblock",
	"default:steel_ingot",
	"default:stick",
	"default:stone",
	"default:stone_block",
	"default:stonebrick",
	"default:stone_with_coal",
	"default:stone_with_copper",
	"default:stone_with_diamond",
	"default:stone_with_gold",
	"default:stone_with_iron",
	"default:stone_with_mese",
	"default:sword_bronze",
	"default:sword_diamond",
	"default:sword_mese",
	"default:sword_steel",
	"default:sword_stone",
	"default:sword_wood",
	"default:torch",
	"default:tree",
	"default:water_flowing",
	"default:water_source",
	"default:wood",
	"doors:door_glass",
	"doors:door_obsidian_glass",
	"doors:door_steel",
	"doors:door_wood",
	"doors:trapdoor",
	"doors:trapdoor_steel",
	"dye:black",
	"dye:blue",
	"dye:brown",
	"dye:cyan",
	"dye:dark_green",
	"dye:dark_grey",
	"dye:green",
	"dye:grey",
	"dye:magenta",
	"dye:orange",
	"dye:pink",
	"dye:red",
	"dye:violet",
	"dye:white",
	"dye:yellow",
	"farming:bread",
	"farming:cotton",
	"farming:cotton_1",
	"farming:cotton_2",
	"farming:cotton_3",
	"farming:cotton_4",
	"farming:cotton_5",
	"farming:cotton_6",
	"farming:cotton_7",
	"farming:cotton_8",
	"farming:flour",
	"farming:hoe_bronze",
	"farming:hoe_diamond",
	"farming:hoe_mese",
	"farming:hoe_steel",
	"farming:hoe_stone",
	"farming:hoe_wood",
	"farming:seed_cotton",
	"farming:seed_wheat",
	"farming:straw",
	"farming:string",
	"farming:wheat",
	"farming:wheat_1",
	"farming:wheat_2",
	"farming:wheat_3",
	"farming:wheat_4",
	"farming:wheat_5",
	"farming:wheat_6",
	"farming:wheat_7",
	"farming:wheat_8",
	"fire:basic_flame",
	"fire:flint_and_steel",
	"fire:permanent_flame",
	"flowerpot:empty",
	"flowers:dandelion_white",
	"flowers:dandelion_yellow",
	"flowers:geranium",
	"flowers:mushroom_brown",
	"flowers:mushroom_red",
	"flowers:rose",
	"flowers:tulip",
	"flowers:viola",
	"flowers:waterlily",
	"nyancat:nyancat",
	"nyancat:nyancat_rainbow",
	"screwdriver:screwdriver",
	"tnt:gunpowder",
	"tnt:tnt",
	"vessels:drinking_glass",
	"vessels:glass_bottle",
	"vessels:glass_fragments",
	"vessels:shelf",
	"vessels:steel_bottle",
	"wool:black",
	"wool:blue",
	"wool:brown",
	"wool:cyan",
	"wool:dark_green",
	"wool:dark_grey",
	"wool:green",
	"wool:grey",
	"wool:magenta",
	"wool:orange",
	"wool:pink",
	"wool:red",
	"wool:violet",
	"wool:white",
	"wool:yellow",
	"xpanes:bar_flat",
	"xpanes:pane_flat",
	--Farlands nodes
	"decoblocks:sandstone_wall",
	"decoblocks:painted_sandstone_tile",
	"decoblocks:sandstone_pillar",
	"decoblocks:bamboo_block",
	"decoblocks:old_stone_tiles",
	"decoblocks:old_stone_tiles_with_dirt",
	"decoblocks:moss_old_stone_tiles",
	"decoblocks:moss_stonebrick",
	"decoblocks:chest",
	"decoblocks:dartblock",
	"decoblocks:crumblestone",
	"decoblocks:paper_lantern",
	"decoblocks:mammoth_wool",
	"decoblocks:bone_pillar",
	"decoblocks:framed_glass",
	"decoblocks:refined_granite",
	"decoblocks:refined_granite_brown",
	"decoblocks:stucco",
	"decoblocks:gold_brick",
	"decoblocks:snow_bricks",
	"decoblocks:rusty_steel_plating",
	"decoblocks:broken_glass",
	"decoblocks:red_glass",
	"decoblocks:blue_glass",
	"decoblocks:green_glass",
	"decoblocks:darkgreen_glass",
	"decoblocks:grey_glass",
	"decoblocks:white_glass",
	"decoblocks:black_glass",
	"decoblocks:orange_glass",
	"decoblocks:darkgrey_glass",
	"decoblocks:pink_glass",
	"decoblocks:purple_glass",
	"decoblocks:cyan_glass",
	"decoblocks:magenta_glass",
	"decoblocks:yellow_glass",
	"decoblocks:brown_glass",
}) do
	frame.register(node)
end

-- inception!
frame.register("frame:empty")

