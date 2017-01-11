--Stuff from vessels

-- -
-- Copyright (C) 2012 Vanessa Ezekowitz
-- Copyright (C) 2012 celeron55, Perttu Ahola <celeron55@gmail.com>

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

--changes so that bottles can't stack
minetest.override_item("vessels:glass_bottle", {
	stack_max = 3,
})

local vessels_shelf_formspec =
	"size[8,7;]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"list[context;vessels;0,0.3;8,2;]"..
	"list[current_player;main;0,2.85;8,1;]"..
	"list[current_player;main;0,4.08;8,3;8]"..
	"listring[context;vessels]"..
	"listring[current_player;main]"..
	default.get_hotbar_bg(0,2.85)

minetest.register_node("witchcraft:shelf", {
	description = "Potion shelf",
	tiles = {"default_wood.png", "default_wood.png", "default_wood.png^vessels_shelf.png^vessels_shelf_overlay.png"},
	is_ground_content = false,
	groups = {choppy=3,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", vessels_shelf_formspec)
		local inv = meta:get_inventory()
		inv:set_size("vessels", 8*2)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("vessels")
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local to_stack = inv:get_stack(listname, index)
		if listname == "vessels" then
			if minetest.get_item_group(stack:get_name(), "potion") ~= 0 or minetest.get_item_group(stack:get_name(), "potion2") ~= 0
					and to_stack:is_empty() then
				return 1
			else
				return 0
			end
		end
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		local to_stack = inv:get_stack(to_list, to_index)
		if to_list == "vessels" then
			if minetest.get_item_group(stack:get_name(), "potion") ~= 0 
					and to_stack:is_empty() then
				return 1
			else
				return 0
			end
		end
	end,

	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
			   " moves stuff in vessels shelf at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
			   " moves stuff to vessels shelf at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
			   " takes stuff from vessels shelf at "..minetest.pos_to_string(pos))
	end,
})

--my stuff

-- Copyright (C) 2016 DOOmed <heiselong@gmx.com>

-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation; either version 2.1 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.

-- You should have received a copy of the GNU Lesser General Public License along
-- with this program; if not, write to the Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

--ingredients

minetest.register_node("witchcraft:bottle_eyes", {
	description = "Jar of eyes",
	drawtype = "plantlike",
	tiles = {"witchcraft_jar_eyes.png"},
	inventory_image = "witchcraft_jar_eyes.png",
	wield_image = "witchcraft_jar_eyes.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	stack_max = 1,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("witchcraft:bottle_slime", {
	description = "Jar of Slime",
	drawtype = "plantlike",
	tiles = {"witchcraft_jar_slime.png"},
	inventory_image = "witchcraft_jar_slime.png",
	wield_image = "witchcraft_jar_slime.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	stack_max = 1,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craftitem("witchcraft:herb", {
	description = "herb",
	inventory_image = "witchcraft_herbs.png"
})

minetest.register_craftitem("witchcraft:tooth", {
	description = "tooth",
	inventory_image = "witchcraft_tooth.png"
})

minetest.register_craftitem("witchcraft:horn", {
	description = "horn",
	inventory_image = "witchcraft_horn.png"
})

minetest.register_craftitem("witchcraft:bone", {
	description = "bone",
	inventory_image = "witchcraft_bone.png"
})

--crafting

minetest.register_craft({
	output = 'witchcraft:shelf',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:potion', 'group:potion', 'group:potion'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

if minetest.get_modpath("moreplants") then
minetest.register_craft({
	output = 'witchcraft:bottle_eyes',
	recipe = {
		{'moreplants:eye'},
		{'moreplants:eye'},
		{'vessels:drinking_glass'},
	}
})


minetest.register_craft({
	output = "moreplants:eye 2",
	type = "shapeless",
	recipe = {"witchcraft:bottle_eyes"}
})

minetest.register_craft({
	output = "witchcraft:herb 4",
	type = "shapeless",
	recipe = {"moreplants:bush"}
})

minetest.register_craft({
	output = "witchcraft:herb 4",
	type = "shapeless",
	recipe = {"moreplants:weed"}
})

minetest.register_craft({
	output = "witchcraft:herb 4",
	type = "shapeless",
	recipe = {"moreplants:groundfung"}
})
else
minetest.register_craft({
	output = "witchcraft:herb 4",
	type = "shapeless",
	recipe = {"default:grass_5"}
})

minetest.register_craft({
	output = "witchcraft:herb 4",
	type = "shapeless",
	recipe = {"default:grass_4"}
})

minetest.register_craft({
	output = "witchcraft:herb 4",
	type = "shapeless",
	recipe = {"default:grass_3"}
})

minetest.register_craft({
	output = "witchcraft:herb 4",
	type = "shapeless",
	recipe = {"default:grass_2"}
})

minetest.register_craft({
	output = "witchcraft:herb 4",
	type = "shapeless",
	recipe = {"default:grass_1"}
})

minetest.register_craft({
	output = 'witchcraft:bottle_eyes',
	recipe = {
		{'default:bucket_water'},
		{'vessels:drinking_glass'},
	}
})
end

minetest.register_craft({
	output = 'witchcraft:pot',
	recipe = {
		{'default:copper_lump', '', 'default:copper_lump'},
		{'default:copper_lump', '', 'default:copper_lump'},
		{'', 'default:copper_lump', ''},
	}
})

minetest.register_craft({
	output = 'witchcraft:mortar',
	recipe = {
		{'default:stone', '', 'default:stone'},
		{'default:stone', '', 'default:stone'},
		{'', 'default:stone', ''},
	}
})

minetest.register_craft({
	output = 'witchcraft:pentagram',
	recipe = {
		{'default:torch', 'default:clay', 'default:torch'},
	}
})

minetest.register_craft({
	output = 'witchcraft:small_bottle',
	recipe = {
		{'vessels:glass_fragments', 'vessels:glass_fragments', 'vessels:glass_fragments'},
	}
})

minetest.register_craft({
	output = 'witchcraft:bottle_medicine 2',
	recipe = {
		{'witchcraft:small_bottle', 'witchcraft:potion_red', 'witchcraft:small_bottle'},
	},
	replacements = {
		{"witchcraft:potion_red", "vessels:glass_bottle"}
	}
})

minetest.register_craft({
	output = 'witchcraft:mud_bottle',
	recipe = {
		{'default:dirt'},
		{'witchcraft:small_bottle'},
	},
})

minetest.register_craft({
	output = 'witchcraft:bone_bottle',
	recipe = {
		{'bones:bones'},
		{'witchcraft:small_bottle'},
	},
})

minetest.register_craft({
	output = 'witchcraft:herb_bottle',
	recipe = {
		{'witchcraft:herb'},
		{'witchcraft:small_bottle'},
	},
})

minetest.register_craft({
	output = 'witchcraft:slime_bottle',
	recipe = {
		{'witchcraft:bottle_slime'},
		{'witchcraft:small_bottle'},
	},
	replacements = {
		{"witchcraft:bottle_slime", "vessels:drinking_glass"}
	}
})

minetest.register_craft({
	output = 'witchcraft:herb',
	recipe = {
		{'witchcraft:herb_bottle'},
	},
	replacements = {
		{"witchcraft:herb_bottle", "witchcraft:small_bottle"}
	}
})

minetest.register_craft({
	output = 'bones:bones',
	recipe = {
		{'witchcraft:bone_bottle'},
	},
	replacements = {
		{"witchcraft:bone_bottle", "witchcraft:small_bottle"}
	}
})

minetest.register_craft({
	output = 'default:dirt',
	recipe = {
		{'witchcraft:mud_bottle'},
	},
	replacements = {
		{"witchcraft:mud_bottle", "witchcraft:small_bottle"}
	}
})

minetest.register_craft({
	output = 'witchcraft:bottle_slime',
	recipe = {
		{'witchcraft:slime_bottle'},
	},
	replacements = {
		{"witchcraft:slime_bottle", "witchcraft:small_bottle"}
	}
})

minetest.register_craft({
	output = 'witchcraft:slime_bottle',
	recipe = {
		{'witchcraft:bottle_slime'},
		{'witchcraft:small_bottle'},
	},
})

minetest.register_craft({
	output = 'vessels:glass_fragments 3',
	recipe = {
		{'default:glass'},
	},
})

minetest.register_craft({
	output = 'witchcraft:bone 4',
	recipe = {
		{'bones:bones', 'bones:bones'},
	},
})

--teeth from sand, maybe fossilised?
minetest.register_craft({
	output = 'witchcraft:tooth 1',
	recipe = {
		{'default:sand'},
	},
})



--splash potions crafting

minetest.register_craft({
	output = 'witchcraft:splash_yellwgrn',
	recipe = {
		{'vessels:glass_fragments'},
		{'witchcraft:potion_yllwgrn'},
	}
})

minetest.register_craft({
	output = 'witchcraft:splash_orange',
	recipe = {
		{'vessels:glass_fragments'},
		{'witchcraft:potion_orange'},
	}
})


minetest.register_craft({
	output = 'witchcraft:splash_purple',
	recipe = {
		{'vessels:glass_fragments'},
		{'witchcraft:potion_purple'},
	}
})
minetest.register_craft({
	output = 'witchcraft:splash_magenta',
	recipe = {
		{'vessels:glass_fragments'},
		{'witchcraft:potion_magenta'},
	}
})
minetest.register_craft({
	output = 'witchcraft:splash_cyan',
	recipe = {
		{'vessels:glass_fragments'},
		{'witchcraft:potion_cyan'},
	}
})
minetest.register_craft({
	output = 'witchcraft:splash_red',
	recipe = {
		{'vessels:glass_fragments'},
		{'witchcraft:potion_red'},
	}
})
minetest.register_craft({
	output = 'witchcraft:splash_green',
	recipe = {
		{'vessels:glass_fragments'},
		{'witchcraft:potion_green'},
	}
})
minetest.register_craft({
	output = 'witchcraft:splash_grey',
	recipe = {
		{'vessels:glass_fragments'},
		{'witchcraft:potion_grey'},
	}
})
minetest.register_craft({
	output = 'witchcraft:splash_brown',
	recipe = {
		{'vessels:glass_fragments'},
		{'witchcraft:potion_brown'},
	}
})
minetest.register_craft({
	output = 'witchcraft:splash_redbrown',
	recipe = {
		{'vessels:glass_fragments'},
		{'witchcraft:potion_redbrown'},
	}
})


minetest.register_craft({
	output = 'witchcraft:splash_ggreen',
	recipe = {
		{'vessels:glass_fragments'},
		{'witchcraft:potion_ggreen'},
	}
})



--empty cooking pot

minetest.register_node("witchcraft:pot", {
	description = "magic cooking pot",
	tiles = {
		"witchcraft_pot_top.png",
		"witchcraft_pot_bottom.png",
		"witchcraft_pot_side.png",
		"witchcraft_pot_side.png",
		"witchcraft_pot_side.png",
		"witchcraft_pot_side.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, 0.4375}, -- NodeBox1
			{-0.375, -0.4375, -0.375, 0.375, -0.375, 0.375}, -- NodeBox2
			{-0.3125, -0.375, -0.3125, 0.3125, -0.3125, 0.3125}, -- NodeBox3
			{-0.375, -0.3125, -0.375, 0.375, -0.25, 0.375}, -- NodeBox4
			{-0.4375, -0.25, -0.4375, 0.4375, -0.1875, 0.4375}, -- NodeBox5
			{-0.5, -0.1875, -0.5, 0.5, -0.125, 0.5}, -- NodeBox7
			{-0.5, -0.125, -0.5, 0.5, 0.3125, -0.3125}, -- NodeBox8
			{-0.5, -0.125, 0.3125, 0.5, 0.3125, 0.5}, -- NodeBox9
			{0.3125, -0.1875, -0.5, 0.5, 0.3125, 0.5}, -- NodeBox10
			{-0.5, -0.125, -0.5, -0.3125, 0.3125, 0.5}, -- NodeBox11
			{-0.4375, 0.375, 0.3125, 0.4375, 0.5, 0.4375}, -- NodeBox12
			{-0.4375, 0.375, -0.4375, 0.4375, 0.5, -0.3125}, -- NodeBox13
			{-0.4375, 0.375, -0.4375, 0.4375, 0.5, -0.3125}, -- NodeBox14
			{0.3125, 0.375, -0.4375, 0.4375, 0.5, 0.4375}, -- NodeBox15
			{-0.4375, 0.375, -0.4375, -0.3125, 0.5, 0.4375}, -- NodeBox16
			{-0.375, 0.3125, -0.375, 0.375, 0.375, -0.3125}, -- NodeBox17
			{-0.375, 0.3125, 0.3125, 0.375, 0.375, 0.375}, -- NodeBox18
			{0.3125, 0.3125, -0.375, 0.375, 0.375, 0.375}, -- NodeBox19
			{-0.375, 0.3125, -0.375, -0.3125, 0.375, 0.375}, -- NodeBox20
		}
	},
	on_rightclick = function(pos, node, clicker, item, _)
		local wield_item = clicker:get_wielded_item():get_name()
		if wield_item == "bucket:bucket_water" or
				wield_item == "bucket:bucket_river_water" then
			minetest.set_node(pos, {name="witchcraft:pot_blue", param2=node.param2})
			item:replace("bucket:bucket_empty")
			elseif wield_item == "vessels:drinking_glass" then
			item:replace("witchcraft:bottle_slime")
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1}
})

--level 1 potions from cooking pot

local witchcraft = {}
--the old recipes
witchcraft.pot = {
	{"blue", "brown", "default:dirt", "blue2", "moreplants:bullrush", "red", "purple"},
	{"blue2", "yellow", "default:steelblock", "yellow", "default:copperblock", "green2", "aqua"},
	{"darkpurple", "cyan", "flowers:mushroom_red", "green", "moreplants:weed", "yellow", "redbrown"},
	{"purple", "blue2", "flowers:waterlily", "gpurple", "default:mese_crystal", "magenta", "darkpurple"},
	{"magenta", "purple", "witchcraft:bottle_eyes", "darkpurple", "moreplants:mushroom", "purple", "darkpurple"},
	{"red", "grey", "default:gravel", "yllwgrn", "default:flint", "blue", "purple"},
	{"redbrown", "magenta", "flowers:mushroom_brown", "magenta", "default:stone", "grey", "brown"},
	{"brown", "gred", "witchcraft:herb", "grey", "moreplants:bush", "red", "redbrown"},
	{"orange", "redbrown", "witchcraft:bottle_slime", "yellow", "default:steelblock", "green", "yllwgrn"},
	{"gold", "yllwgrn", "tnt:tnt", "", "", "green", "yllwgrn"},
	{"yellow", "yllwgrn", "tnt:tnt", "yllwgrn", "default:coal_lump", "darkpurple", "redbrown"},
	{"yllwgrn", "green", "default:gold_lump", "orange", "mobs:lava_orb", "grey", "magenta"},
	{"green2", "darkpurple", "default:glass", "red", "witchcraft:herb", "blue2", "aqua"},
	{"green", "green2", "default:apple", "ggreen", "default:mese_crystal", "orange", "yllwgrn"},
	{"aqua", "", "", "", "", "blue", "cyan"},
	{"cyan", "aqua", "default:diamond", "gcyan", "default:mese_crystal", "green", "yellow"},
	{"grey", "orange", "default:torch", "brown", "default:apple", "yllwgrn", "magenta"},
	{"ggreen", "", "", "", "", "", ""},
	{"gpurple", "", "", "", "", "", ""},
	{"gred", "red", "default:apple", "grey", "default:gravel", "", ""},
	{"gcyan", "", "", "", "", "", ""},
}
--new recipes

witchcraft.pot_new = {
	{"blue", "blue2", "flowers:waterlily", "brown", "default:dirt", "red", "purple"},
	{"blue2", "green", "default:papyrus", "", "", "gred", "magenta"},
	{"green", "green2", "default:sapling", "", "", "yellow", "yllwgrn"},
	{"green2", "yellow", "default:mese_crystal_fragment", "", "", "blue", "cyan"},
	{"yellow", "ggreen", "flowers:mushroom_brown", "", "", "green", "yllwgrn"},
	{"ggreen", "cyan", "witchcraft:slime_bottle", "", "", "gcyan", "aqua"},
	{"cyan", "gcyan", "witchcraft:bottle_medicine", "", "", "blue", "blue2"},
	{"gcyan", "orange", "default:torch", "", "", "ggreen", "aqua"},
	{"orange", "yllwgrn", "tnt:gunpowder", "", "", "red", "redbrown"},
	{"yllwgrn", "gold", "default:steel_ingot", "", "", "green", "green2"},
	{"gold", "aqua", "default:diamond", "", "", "", ""},
	{"aqua", "", "", "", "", "", ""},
	{"brown", "redbrown", "flowers:mushroom_red", "", "", "red", "redbrown"},
	{"redbrown", "gred", "default:apple", "", "", "", ""},
	{"gred", "red", "witchcraft:herbs", "", "", "blue2", "magenta"},
	{"red", "magenta", "witchcraft:tooth", "", "", "blue", "purple"},
	{"magenta", "gpurple", "witchcraft:bottle_slime", "", "", "cyan", "darkpurple"},
	{"gpurple", "purple", "witchcraft:bone_bottle", "", "", "yllwgrn", "green2"},
	{"purple", "darkpurple", "default:glass", "", "", "yellow", "green"},
	{"darkpurple", "silver", "default:steel_ingot", "", "", "", ""},
	{"silver", "grey", "witchcraft:bone", "", "", "", ""},
	{"grey", "aqua", "default:diamond", "", "", "", ""},
}


--potion pots

for _, row in ipairs(witchcraft.pot_new) do --change 'pot_new' to 'pot' for the old recipes
local color = row[1]
local newcolor = row[2]
local newcolor2 = row[4]
local ingredient = row[3]
local ingredient2 = row[5]
local combine = row[6]
local cresult = row[7]
minetest.register_node("witchcraft:pot_"..color, {
	tiles = {
		{ name = "witchcraft_pot_"..color..".png",
			animation = {type="vertical_frames", length=3.0} },
		"witchcraft_pot_bottom.png",
		"witchcraft_pot_side.png",
		"witchcraft_pot_side.png",
		"witchcraft_pot_side.png",
		"witchcraft_pot_side.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	drop = {
		items = {
			{items = {'witchcraft:pot'}, rarity = 1},
		}
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, 0.4375}, -- NodeBox1
			{-0.375, -0.4375, -0.375, 0.375, -0.375, 0.375}, -- NodeBox2
			{-0.3125, -0.375, -0.3125, 0.3125, -0.3125, 0.3125}, -- NodeBox3
			{-0.375, -0.3125, -0.375, 0.375, 0.5, 0.375}, -- NodeBox4
			{-0.4375, -0.25, -0.4375, 0.4375, 0.3125, 0.4375}, -- NodeBox5
			{-0.5, -0.1875, -0.5, 0.5, 0.3125, 0.5}, -- NodeBox6
			{-0.4375, 0.375, -0.4375, 0.4375, 0.5, 0.4375}, -- NodeBox7
		}
	},
	on_rightclick = function(pos, node, clicker, item, _)
		local wield_item = clicker:get_wielded_item():get_name()
		if wield_item == "vessels:glass_bottle" and clicker:get_wielded_item():get_count() == 3 then
			item:replace("witchcraft:potion_"..color)
			minetest.env:add_item({x=pos.x, y=pos.y+1.5, z=pos.z}, "witchcraft:potion_"..color)
			minetest.env:add_item({x=pos.x, y=pos.y+1.5, z=pos.z}, "witchcraft:potion_"..color)
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "vessels:glass_bottle" and clicker:get_wielded_item():get_count() ~= 3 then
			item:replace("witchcraft:potion_"..color)
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		else
		if wield_item == ingredient then
			minetest.set_node(pos, {name="witchcraft:pot_"..newcolor, param2=node.param2})
			item:take_item()
		elseif wield_item == ingredient2 then
			minetest.set_node(pos, {name="witchcraft:pot_"..newcolor2, param2=node.param2})
			item:take_item()
		elseif wield_item == "bucket:bucket_water" then
			minetest.set_node(pos, {name="witchcraft:pot_blue", param2=node.param2})
			item:replace("bucket:bucket_empty")
		elseif wield_item == "witchcraft:potion_"..combine then
			minetest.set_node(pos, {name="witchcraft:pot_"..cresult, param2=node.param2})
			item:replace("vessels:glass_bottle")
		end
	end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1}
})
end

--pot effects
minetest.register_abm({
	nodenames = {"witchcraft:pot_water", "witchcraft:pot_gold", "witchcraft:pot_redbrown", "witchcraft:pot_blue2", "witchcraft:pot_cyan", "witchcraft:pot_green", "witchcraft:pot_green2", "witchcraft:pot_aqua", "witchcraft:pot_yellow", "witchcraft:pot_yllwgrn", "witchcraft:pot_red", "witchcraft:pot_magenta", "witchcraft:pot_brown"},
	interval = 0.5,
	chance = 1,
	action = function(pos, node)
		minetest.add_particlespawner({
			amount = 2,
			time = 1,
			minpos = {x=pos.x-0.1, y=pos.y, z=pos.z-0.1},
			maxpos = {x=pos.x+0.1, y=pos.y, z=pos.z+0.1},
			minvel = {x=0, y=0.5, z=0},
			maxvel = {x=0, y=0.6, z=0},
			minacc = {x=0, y=0.2, z=0},
			maxacc = {x=0, y=0.3, z=0},
			minexptime = 1,
			maxexptime = 2,
			minsize = 2,
			maxsize = 3,
			collisiondetection = false,
			texture = "witchcraft_bubbles.png"
		})
	end
})

minetest.register_abm({
	nodenames = {"witchcraft:pot_ggreen", "witchcraft:pot_gred", "witchcraft:pot_gpurple", "witchcraft:pot_gcyan"},
	interval = 0.5,
	chance = 1,
	action = function(pos, node)
		minetest.add_particlespawner({
			amount = 2,
			time = 1,
			minpos = {x=pos.x-0.1, y=pos.y, z=pos.z-0.1},
			maxpos = {x=pos.x+0.1, y=pos.y, z=pos.z+0.1},
			minvel = {x=0, y=0.5, z=0},
			maxvel = {x=0, y=0.6, z=0},
			minacc = {x=0, y=0.2, z=0},
			maxacc = {x=0, y=0.3, z=0},
			minexptime = 1,
			maxexptime = 2,
			minsize = 1,
			maxsize = 2,
			collisiondetection = false,
			texture = "witchcraft_light_over.png"
		})
	end
})

minetest.register_abm({
	nodenames = {"witchcraft:pot_purple"},
	interval = 0.5,
	chance = 1,
	action = function(pos, node)
		minetest.add_particlespawner({
			amount = 2,
			time = 1,
			minpos = {x=pos.x-0.1, y=pos.y, z=pos.z-0.1},
			maxpos = {x=pos.x+0.1, y=pos.y, z=pos.z+0.1},
			minvel = {x=0, y=0.5, z=0},
			maxvel = {x=0, y=0.6, z=0},
			minacc = {x=0, y=0.2, z=0},
			maxacc = {x=0, y=0.3, z=0},
			minexptime = 1,
			maxexptime = 2,
			minsize = 5,
			maxsize = 8,
			collisiondetection = false,
			texture = "witchcraft_smoke.png"
		})
	end
})

minetest.register_abm({
	nodenames = {"witchcraft:pot_darkpurple"},
	interval = 0.5,
	chance = 1,
	action = function(pos, node)
		minetest.add_particlespawner({
			amount = 2,
			time = 1,
			minpos = {x=pos.x-0.1, y=pos.y, z=pos.z-0.1},
			maxpos = {x=pos.x+0.1, y=pos.y, z=pos.z+0.1},
			minvel = {x=0, y=0.5, z=0},
			maxvel = {x=0, y=0.6, z=0},
			minacc = {x=0, y=0.2, z=0},
			maxacc = {x=0, y=0.3, z=0},
			minexptime = 1,
			maxexptime = 2,
			minsize = 2,
			maxsize = 3,
			collisiondetection = false,
			texture = "witchcraft_symbol.png"
		})
	end
})

minetest.register_abm({
	nodenames = {"witchcraft:pot_orange"},
	interval = 0.5,
	chance = 1,
	action = function(pos, node)
		minetest.add_particlespawner({
			amount = 2,
			time = 1,
			minpos = {x=pos.x-0.1, y=pos.y, z=pos.z-0.1},
			maxpos = {x=pos.x+0.1, y=pos.y, z=pos.z+0.1},
			minvel = {x=0, y=0.5, z=0},
			maxvel = {x=0, y=0.6, z=0},
			minacc = {x=0, y=0.2, z=0},
			maxacc = {x=0, y=0.3, z=0},
			minexptime = 1,
			maxexptime = 2,
			minsize = 2,
			maxsize = 3,
			collisiondetection = false,
			texture = "witchcraft_flame.png"
		})
	end
})

--small bottle and contents

minetest.register_node("witchcraft:small_bottle", {
	description = "Small bottle",
	drawtype = "plantlike",
	tiles = {"witchcraft_small_bottle.png"},
	wield_image = "witchcraft_small_bottle.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_small_bottle.png",
})

minetest.register_node("witchcraft:bone_bottle", {
	description = "Small bottle of bone dust",
	drawtype = "plantlike",
	tiles = {"witchcraft_bone_bottle.png"},
	wield_image = "witchcraft_bone_bottle.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_bone_bottle.png",
})

minetest.register_node("witchcraft:slime_bottle", {
	description = "Small bottle of slime",
	drawtype = "plantlike",
	tiles = {"witchcraft_slime_bottle.png"},
	wield_image = "witchcraft_slime_bottle.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_slime_bottle.png",
})

minetest.register_node("witchcraft:herb_bottle", {
	description = "Small bottle of herbs",
	drawtype = "plantlike",
	tiles = {"witchcraft_herb_bottle.png"},
	wield_image = "witchcraft_herb_bottle.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_herb_bottle.png",
})

minetest.register_node("witchcraft:mud_bottle", {
	description = "Small bottle of mud",
	drawtype = "plantlike",
	tiles = {"witchcraft_mud_bottle.png"},
	wield_image = "witchcraft_mud_bottle.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_mud_bottle.png",
})

minetest.register_node("witchcraft:bottle_medicine", {
	description = "Small bottle of Medicine",
	drawtype = "plantlike",
	tiles = {"witchcraft_medicine_bottle.png"},
	wield_image = "witchcraft_medicine_bottle.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_medicine_bottle.png",
	on_use = function(itemstack, player)
	local health = player:get_hp();
	player:set_hp(health+10)
	itemstack:replace("witchcraft:small_bottle")
	return itemstack
	end,
})



--splash effects

minetest.register_entity("witchcraft:tnt_splash", {
	textures = {"witchcraft_splash_yellgrn.png"},
	velocity = 0.1,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "witchcraft:tnt_splash" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=3},
						}, nil)
					tnt.boom(pos, {damage_radius=5,radius=3,ignore_protection=false})
					self.object:remove()
					end
				end
			end
			for dx=0,1 do
						for dy=0,1 do
							for dz=0,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "witchcraft:tnt_splash" and n ~="default:obsidian" and n ~= "air" then	
									local pos = self.object:getpos()
									minetest.sound_play("default_break_glass.1", {
									pos = self.object:getpos(),
									gaint = 1.0,
									max_hear_distance = 20,
									})
									tnt.boom(pos, {damage_radius=5,radius=3,ignore_protection=false})
										self.object:remove()
									return
								end
							end
						end
					end
			hit_node = function(self, pos, node)
    local pos = self.object:getpos()
		for dx=-4,4 do
			for dy=-4,4 do
				for dz=-4,4 do
					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local n = minetest.env:get_node(pos).name
					if math.random(1, 50) <= 35 then
						tnt.boom(n, {damage_radius=5,radius=3,ignore_protection=false})
					end
					if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <=5 then
								if not ignore_protection and minetest.is_protected(npos, "") then
								return
								end
										minetest.env:set_node(t, {name="fire:basic_flame"})
					end
				end
			end
		end
		end
		
	end,
})



minetest.register_entity("witchcraft:fire_splash", {
	textures = {"witchcraft_splash_orange.png"},
	velocity = 0.1,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "witchcraft:fire_splash" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=1},
						}, nil)
					self.object:remove()
					end
				end
			end
			for dx=0,1 do
						for dy=0,1 do
							for dz=0,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "witchcraft:fire_splash" and n ~= "air" then
								if not ignore_protection and minetest.is_protected(npos, "") then
								return
								end
										minetest.env:set_node(t, {name="fire:basic_flame"})
									minetest.sound_play("default_break_glass.1", {
									pos = self.object:getpos(),
									max_hear_distance = 20,
									gain = 10.0,
									})
										self.object:remove()
								elseif n =="default:dirt_with_grass" or n =="default:dirt_with_dry_grass" then
									self.object:remove()
									return
								end
							end
						end
					end
			hit_node = function(self, pos, node)
    local pos = self.object:getpos()
		for dx=-4,4 do
			for dy=-4,4 do
				for dz=-4,4 do
					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local n = minetest.env:get_node(pos).name
					if math.random(1, 50) <= 1 then
						minetest.env:remove_node(p)
					end
					if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <=5 then
										minetest.env:set_node(t, {name="fire:basic_flame"})
					end
				end
			end
		end
		end
		
	end,
})

minetest.register_entity("witchcraft:death_splash", {
	textures = {"witchcraft_splash_grey.png"},
	velocity = 0.1,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "witchcraft:death_splash" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=50},
						}, nil)
					self.object:remove()
					end
				end
			end
			for dx=0,1 do
						for dy=0,1 do
							for dz=0,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "witchcraft:death_splash" and n ~= "air" then
									minetest.sound_play("default_break_glass.1", {
									pos = self.object:getpos(),
									max_hear_distance = 20,
									gain = 10.0,
									})
										self.object:remove()
								elseif n =="default:dirt_with_grass" or n =="default:dirt_with_dry_grass" then
									self.object:remove()
									return
								end
							end
						end
					end
   
		
	end,
})

minetest.register_entity("witchcraft:heal_splash", {
	textures = {"witchcraft_splash_red.png"},
	velocity = 0.1,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "witchcraft:heal_splash" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=-20},
						}, nil)
					self.object:remove()
					end
				end
			end
			for dx=0,1 do
						for dy=0,1 do
							for dz=0,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "witchcraft:heal_splash" and n ~= "air" then
									minetest.sound_play("default_break_glass.1", {
									pos = self.object:getpos(),
									max_hear_distance = 20,
									gain = 10.0,
									})
										self.object:remove()
								elseif n =="default:dirt_with_grass" or n =="default:dirt_with_dry_grass" then
									self.object:remove()
									return
								end
							end
						end
					end
   
		
	end,
})

minetest.register_entity("witchcraft:slow_splash", {
	textures = {"witchcraft_splash_redbrown.png"},
	velocity = 0.1,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "witchcraft:slow_splash" and obj:get_luaentity().name ~= "__builtin:item" then
						local vel = obj:getvelocity()
						obj:setvelocity({x=vel.x*0.5, y=vel.y*0.5, z=vel.z*0.5})
					self.object:remove()
					end
				end
			end
			for dx=0,1 do
						for dy=0,1 do
							for dz=0,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "witchcraft:slow_splash" and n ~= "air" then
									
										self.object:remove()
								elseif n =="default:dirt_with_grass" or n =="default:dirt_with_dry_grass" then
									minetest.sound_play("default_break_glass.1", {
									pos = self.object:getpos(),
									max_hear_distance = 20,
									gain = 10.0,
									})
									self.object:remove()
									return
								end
							end
						end
					end
   
		
	end,
})

minetest.register_entity("witchcraft:fast_splash", {
	textures = {"witchcraft_splash_magenta.png"},
	velocity = 0.1,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "witchcraft:fast_splash" and obj:get_luaentity().name ~= "__builtin:item" then
						local vel = obj:getvelocity()
						obj:setvelocity({x=vel.x*4, y=vel.y*1, z=vel.z*4})
					self.object:remove()
					end
				end
			end
			for dx=0,1 do
						for dy=0,1 do
							for dz=0,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "witchcraft:fast_splash" and n ~= "air" then
									
										self.object:remove()
								elseif n =="default:dirt_with_grass" or n =="default:dirt_with_dry_grass" then
									minetest.sound_play("default_break_glass.1", {
									pos = self.object:getpos(),
									max_hear_distance = 20,
									gain = 10.0,
									})
									self.object:remove()
									return
								end
							end
						end
					end
   
		
	end,
})

minetest.register_entity("witchcraft:antigrav_splash", {
	textures = {"witchcraft_splash_green.png"},
	velocity = 0.1,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "witchcraft:antigrav_splash" and obj:get_luaentity().name ~= "__builtin:item" then
						local vel = obj:getvelocity()
						obj:setvelocity({x=vel.x*1, y=vel.y*0.1, z=vel.z*1})
					self.object:remove()
					end
				end
			end
			for dx=0,1 do
						for dy=0,1 do
							for dz=0,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "witchcraft:antigrav_splash" and n ~= "air" then
									
										self.object:remove()
								elseif n =="default:dirt_with_grass" or n =="default:dirt_with_dry_grass" then
									minetest.sound_play("default_break_glass.1", {
									pos = self.object:getpos(),
									max_hear_distance = 20,
									gain = 10.0,
									})
									self.object:remove()
									return
								end
							end
						end
					end
   
		
	end,
})

minetest.register_entity("witchcraft:jump_splash", {
	textures = {"witchcraft_splash_cyan.png"},
	velocity = 0.1,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "witchcraft:jump_splash" and obj:get_luaentity().name ~= "__builtin:item" then
						local vel = obj:getvelocity()
						obj:setvelocity({x=vel.x*1, y=(vel.y+2)*3, z=vel.z*1})
					self.object:remove()
					end
				end
			end
			for dx=0,1 do
						for dy=0,1 do
							for dz=0,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "witchcraft:jump_splash" and n ~= "air" then
									
										self.object:remove()
								elseif n =="default:dirt_with_grass" or n =="default:dirt_with_dry_grass" then
									minetest.sound_play("default_break_glass.1", {
									pos = self.object:getpos(),
									max_hear_distance = 20,
									gain = 10.0,
									})
									self.object:remove()
									return
								end
							end
						end
					end
   
		
	end,
})

minetest.register_entity("witchcraft:murky_splash", {
	textures = {"witchcraft_splash_brown.png"},
	velocity = 0.1,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "witchcraft:murky_splash" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=20},
						}, nil)
					self.object:remove()
					end
				end
			end
			for dx=0,1 do
						for dy=0,1 do
							for dz=0,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "witchcraft:murky_splash" and n ~= "air" then
									minetest.sound_play("default_break_glass.1", {
									pos = self.object:getpos(),
									max_hear_distance = 20,
									gain = 10.0,
									})
										self.object:remove()
								elseif n =="default:dirt_with_grass" or n =="default:dirt_with_dry_grass" then
									self.object:remove()
									return
								end
							end
						end
					end
   
		
	end,
})

minetest.register_entity("witchcraft:shadow_splash", {
	textures = {"witchcraft_splash_ggreen.png"},
	velocity = 0.1,
	damage = 2,
	physical = true,
	collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(5, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
			minetest.add_particlespawner(
			50, --amount
			1, --time
			{x=pos.x-3, y=pos.y-3, z=pos.z-3}, --minpos
			{x=pos.x+3, y=pos.y+3, z=pos.z+3}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.1,y=0.2,z=-0.1}, --minacc
			{x=0.1,y=0.2,z=0.1}, --maxacc
			5, --minexptime
			10, --maxexptime
			10, --minsize
			20, --maxsize
			false, --collisiondetection
			"witchcraft_pot_bottom.png^[colorize:black:200" --texture
		)
	end,
})

minetest.register_entity("witchcraft:smoke_splash", {
	textures = {"witchcraft_splash_purple.png"},
	velocity = 0.1,
	damage = 2,
	physical = true,
	collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(10, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local velo = self.object:getvelocity()
		self.object:setvelocity({x=velo.x*0.9,y=velo.y,z=velo.z*0.9})
			minetest.add_particlespawner(
			10, --amount
			1, --time
			{x=pos.x-1, y=pos.y-1, z=pos.z-1}, --minpos
			{x=pos.x+1, y=pos.y+1, z=pos.z+1}, --maxpos
			{x=-1, y=-0, z=-1}, --minvel
			{x=1, y=0, z=1}, --maxvel
			{x=-0.5,y=2,z=-0.5}, --minacc
			{x=0.5,y=3,z=0.5}, --maxacc
			2, --minexptime
			4, --maxexptime
			10, --minsize
			20, --maxsize
			false, --collisiondetection
			"witchcraft_smoke.png" --texture
		)
		
	end,
})

--player effects

playereffects.register_effect_type("potion_speed_lv1", "High speed", nil, {"speed"}, 
	function(player)
		player:set_physics_override(2,nil,nil)
	end,
	
	function(effect, player)
		player:set_physics_override(1,nil,nil)
	end,
	false
)

playereffects.register_effect_type("potion_speed_lv2", "High speed", nil, {"speed"}, 
	function(player)
		player:set_physics_override(2.5,nil,nil)
	end,
	
	function(effect, player)
		player:set_physics_override(1,nil,nil)
	end,
	false
)

playereffects.register_effect_type("potion_jump_lvx", "High Jump", nil, {"jump"}, 
	function(player)
		player:set_physics_override(nil,1.5,0.8)
	end,
	
	function(effect, player)
		player:set_physics_override(nil,1,1)
	end,
	false
)

playereffects.register_effect_type("potion_antigrav_lvx", "Light weight", nil, {"gravity"}, 
	function(player)
		player:set_physics_override(nil,nil,0.1)
	end,
	
	function(effect, player)
		player:set_physics_override(nil,nil,1)
	end,
	false
)

playereffects.register_effect_type("potion_slow_lv1", "Low speed", nil, {"speed"}, 
	function(player)
		player:set_physics_override(0.5,nil,nil)
	end,
	
	function(effect, player)
		player:set_physics_override(1,nil,nil)
	end,
	false
)

playereffects.register_effect_type("potion_slow_lv2", "Low speed", nil, {"speed"}, 
	function(player)
		player:set_physics_override(0.4,nil,nil)
	end,
	
	function(effect, player)
		player:set_physics_override(1,nil,nil)
	end,
	false
)

playereffects.register_effect_type("potion_swim_lv1", "Fast Swim", nil, {"swim"}, 
	function(player)
		player:set_physics_override(3,nil,nil)
	end,
	
	function(effect, player)
		player:set_physics_override(1,nil,nil)
	end,
	false
)

playereffects.register_effect_type("potion_swim_lv2", "Dive", nil, {"swim"}, 
	function(player)
		player:set_physics_override(3,nil,4)
	end,
	
	function(effect, player)
		player:set_physics_override(1,nil,1)
	end,
	false
)

playereffects.register_effect_type("potion_silver", "Fire resist", nil, {"fire_resist"}, 
	function(player)
		local pos = player:getpos()
		local node = minetest.get_node(pos).name
		if node == "default:lava_source" or node == "default:lava_flowing" or node == "fire:basic_flame" then
		local hp1 = player:get_hp()
		minetest.after(0.8, function()
		local hp2 = player:get_hp()
		local change = hp1-hp2
		if change >= 0 then
		player:set_hp(hp2+change)
		end
		end)
		end
	end,
	nil,
	nil,
	nil,
	0.3
)


--splash potions

minetest.register_node("witchcraft:splash_orange", {
	description = "Dragon Splash Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_splash_orange.png"},
	wield_image = "witchcraft_splash_orange.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_splash_orange.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*6,y=dir.y*3.5,z=dir.z*6}
	local acc = {x=0,y=-9.8,z=0}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+2+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:fire_splash")
	obj:setvelocity(vec)
	obj:setacceleration(acc)
		item:take_item()
		return item
	end,
})

minetest.register_node("witchcraft:splash_purple", {
	description = "Smokey Splash Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_splash_purple.png"},
	wield_image = "witchcraft_splash_purple.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_splash_purple.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*9,y=dir.y*3.5,z=dir.z*9}
	local acc = {x=0,y=-9.8,z=0}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x,y=playerpos.y+2+dir.y,z=playerpos.z+dir.z}, "witchcraft:smoke_splash")
	obj:setvelocity(vec)
	obj:setacceleration(acc)
		item:take_item()
		return item
	end,
})

minetest.register_node("witchcraft:splash_red", {
	description = "Healthy Splash Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_splash_red.png"},
	wield_image = "witchcraft_splash_red.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_splash_red.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*9,y=dir.y*3.5,z=dir.z*9}
	local acc = {x=0,y=-9,z=0}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*2,y=playerpos.y+2+dir.y,z=playerpos.z+dir.z*2}, "witchcraft:heal_splash")
	obj:setvelocity(vec)
	obj:setacceleration(acc)
		item:take_item()
		return item
	end,
})

minetest.register_node("witchcraft:splash_green", {
	description = "Volatile Splash Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_splash_green.png"},
	wield_image = "witchcraft_splash_green.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_splash_green.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*9,y=dir.y*3.5,z=dir.z*9}
	local acc = {x=0,y=-9,z=0}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*2,y=playerpos.y+2+dir.y,z=playerpos.z+dir.z*2}, "witchcraft:jump_splash")
	obj:setvelocity(vec)
	obj:setacceleration(acc)
		item:take_item()
		return item
	end,
})

minetest.register_node("witchcraft:splash_cyan", {
	description = "Light Splash Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_splash_cyan.png"},
	wield_image = "witchcraft_splash_cyan.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_splash_cyan.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*9,y=dir.y*3.5,z=dir.z*9}
	local acc = {x=0,y=-9,z=0}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*2,y=playerpos.y+2+dir.y,z=playerpos.z+dir.z*2}, "witchcraft:antigrav_splash")
	obj:setvelocity(vec)
	obj:setacceleration(acc)
		item:take_item()
		return item
	end,
})

minetest.register_node("witchcraft:splash_redbrown", {
	description = "Thick Splash Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_splash_redbrown.png"},
	wield_image = "witchcraft_splash_redbrown.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_splash_redbrown.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*9,y=dir.y*3.5,z=dir.z*9}
	local acc = {x=0,y=-9,z=0}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*2,y=playerpos.y+2+dir.y,z=playerpos.z+dir.z*2}, "witchcraft:slow_splash")
	obj:setvelocity(vec)
	obj:setacceleration(acc)
		item:take_item()
		return item
	end,
})

minetest.register_node("witchcraft:splash_magenta", {
	description = "Fast Splash Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_splash_magenta.png"},
	wield_image = "witchcraft_splash_magenta.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_splash_magenta.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*13,y=dir.y*2.5,z=dir.z*13}
	local acc = {x=0,y=-9,z=0}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*2,y=playerpos.y+2+dir.y,z=playerpos.z+dir.z*2}, "witchcraft:fast_splash")
	obj:setvelocity(vec)
	obj:setacceleration(acc)
		item:take_item()
		return item
	end,
})

minetest.register_node("witchcraft:splash_brown", {
	description = "Murky Splash Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_splash_brown.png"},
	wield_image = "witchcraft_splash_brown.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_splash_brown.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*9,y=dir.y*3.5,z=dir.z*9}
	local acc = {x=0,y=-9,z=0}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*2,y=playerpos.y+2+dir.y,z=playerpos.z+dir.z*2}, "witchcraft:murky_splash")
	obj:setvelocity(vec)
	obj:setacceleration(acc)
		item:take_item()
		return item
	end,
})

minetest.register_node("witchcraft:splash_grey", {
	description = "Death Splash Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_splash_grey.png"},
	wield_image = "witchcraft_splash_grey.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_splash_grey.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*9,y=dir.y*3.5,z=dir.z*9}
	local acc = {x=0,y=-9,z=0}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*2,y=playerpos.y+2+dir.y,z=playerpos.z+dir.z*2}, "witchcraft:death_splash")
	obj:setvelocity(vec)
	obj:setacceleration(acc)
		item:take_item()
		return item
	end,
})



minetest.register_node("witchcraft:splash_ggreen", {
	description = "Darkness Splash Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_splash_ggreen.png"},
	wield_image = "witchcraft_splash_ggreen.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_splash_ggreen.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*6,y=dir.y*3.5,z=dir.z*6}
	local acc = {x=0,y=-9.8,z=0}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+2+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:shadow_splash")
	obj:setvelocity(vec)
	obj:setacceleration(acc)
		item:take_item()
		return item
	end,
})

minetest.register_node("witchcraft:splash_yellwgrn", {
	description = "Dodgy Splash Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_splash_yellgrn.png"},
	wield_image = "witchcraft_splash_yellgrn.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_splash_yellgrn.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*7,y=dir.y*3.5,z=dir.z*7}
	local acc = {x=0,y=-9.8,z=0}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+2+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:tnt_splash")
	obj:setvelocity(vec)
	obj:setacceleration(acc)
		item:take_item()
		return item
	end,
})

--potions (level 1 and 2)

minetest.register_node("witchcraft:potion_red", {
	description = "Tasty Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_red.png"},
	wield_image = "witchcraft_potion_red.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_red.png",
	on_use = function(itemstack, player)
	local health = player:get_hp();
	player:set_hp(health+20)
	itemstack:replace("vessels:glass_bottle")
	return itemstack
	end,
})

minetest.register_node("witchcraft:potion_red_2", {
	description = "Tasty Potion (lv2)",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_red.png^[colorize:black:50"},
	wield_image = "witchcraft_potion_red.png^[colorize:black:50",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_red.png^[colorize:black:50",
	on_use = function(itemstack, player)
	local health = player:get_hp();
	player:set_hp(health+50)
	itemstack:replace("vessels:glass_bottle")
	return itemstack
	end,
})

minetest.register_node("witchcraft:potion_darkpurple", {
	description = "Shady Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_darkpurple.png"},
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	stack_max = 1,
	wield_image = "witchcraft_potion_darkpurple.png",
	inventory_image = "witchcraft_potion_darkpurple.png",
	on_use = function(itemstack, user)
		--invisibility effect from invisibility potion by Tenplus1

		local pos = user:getpos()

		-- make player invisible
		invisible(user, true)

		-- play sound
		minetest.sound_play("pop", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5
		})

		-- display 10 second warning
		minetest.after(290, function()

			if user:getpos() then

				minetest.chat_send_player(user:get_player_name(),
					">>> You have 10 seconds before invisibility wears off!")
			end
		end)

		-- make player visible 5 minutes later
		minetest.after(300, function()

			if user:getpos() then

				-- show aready hidden player
				invisible(user, nil)

				-- play sound
				minetest.sound_play("pop", {
					pos = pos,
					gain = 1.0,
					max_hear_distance = 5
				})
			end
		end)

	--effect
	local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		
		-- take item
		if not minetest.setting_getbool("creative_mode") then

			itemstack:take_item()

			return {name = "vessels:glass_bottle"}
		end
	end,
})


minetest.register_node("witchcraft:potion_darkpurple_2", {
	description = "Shady Potion (lv2)",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_darkpurple.png^[colorize:black:50"},
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	paramtype = "light",
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	stack_max = 1,
	wield_image = "witchcraft_potion_darkpurple.png^[colorize:black:50",
	inventory_image = "witchcraft_potion_darkpurple.png^[colorize:black:50",
	on_use = function(itemstack, user)

		local pos = user:getpos()

		-- make player invisible
		invisible(user, true)

		-- play sound
		minetest.sound_play("pop", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5
		})

		-- display 10 second warning
		minetest.after(340, function()

			if user:getpos() then

				minetest.chat_send_player(user:get_player_name(),
					">>> You have 10 seconds before invisibility wears off!")
			end
		end)

		-- make player visible 5 minutes later
		minetest.after(350, function()

			if user:getpos() then

				-- show aready hidden player
				invisible(user, nil)

				-- play sound
				minetest.sound_play("pop", {
					pos = pos,
					gain = 1.0,
					max_hear_distance = 5
				})
			end
		end)

	--effect
	local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		
		-- take item
		if not minetest.setting_getbool("creative_mode") then

			itemstack:take_item()

			return {name = "vessels:glass_bottle"}
		end
	end,
})

minetest.register_node("witchcraft:potion_brown", {
	description = "Murky Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_brown.png"},
	wield_image = "witchcraft_potion_brown.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_brown.png",
	on_use = minetest.item_eat(-5, "vessels:glass_bottle"),
})

minetest.register_node("witchcraft:potion_brown_2", {
	description = "Murky Potion (lv2)",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_brown.png^[colorize:black:50"},
	wield_image = "witchcraft_potion_brown.png^[colorize:black:50",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_brown.png^[colorize:black:50",
	on_use = minetest.item_eat(-10, "vessels:glass_bottle"),
})


--cannot get the potion to be removed from inventory on use?
minetest.register_node("witchcraft:potion_yllwgrn", {
	description = "Dodgy Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_yellgrn.png"},
	wield_image = "witchcraft_potion_yellgrn.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_yellgrn.png",
	on_use = function(pos, placer, itemstack)
	local pos = placer:getpos();
	tnt.boom(pos, {damage_radius=5,radius=3,ignore_protection=false})
	return itemstack
	end,
})

minetest.register_node("witchcraft:potion_yllwgrn_2", {
	description = "Dodgy Potion (lv2)",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_yellgrn.png^[colorize:black:50"},
	wield_image = "witchcraft_potion_yellgrn.png^[colorize:black:50",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_yellgrn.png^[colorize:black:50",
	on_use = function(pos, placer, itemstack)
	local pos = placer:getpos();
	tnt.boom(pos, {damage_radius=10,radius=4,ignore_protection=false})
	return itemstack
	end,
})



minetest.register_entity("witchcraft:fire", {
	textures = {"witchcraft_flame.png"},
	velocity = 0.1,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "witchcraft:fire" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=3},
						}, nil)
					self.object:remove()
					end
				end
			end
			for dx=0,1 do
						for dy=0,1 do
							for dz=0,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "witchcraft:fire" and n ~= "air" and n ~="default:dirt_with_grass" and n ~="default:dirt_with_dry_grass" and n ~="default:stone"  then	
									minetest.env:set_node(t, {name="fire:basic_flame"})
								elseif n =="default:dirt_with_grass" or n =="default:dirt_with_dry_grass" then
									self.object:remove()
									return
								end
							end
						end
					end
			hit_node = function(self, pos, node)
     	local pos = self.object:getpos()
		for dx=-4,4 do
			for dy=-4,4 do
				for dz=-4,4 do
					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local n = minetest.env:get_node(pos).name
					if math.random(1, 50) <= 35 then
						minetest.env:remove_node(p)
					end
					if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <=5 then
										minetest.env:set_node(t, {name="fire:basic_flame"})
					end
				end
			end
		end
		end

		local apos = self.object:getpos()
		local part = minetest.add_particlespawner(
			10, --amount
			0.3, --time
			{x=apos.x-0.3, y=apos.y-0.3, z=apos.z-0.3}, --minpos
			{x=apos.x+0.3, y=apos.y+0.3, z=apos.z+0.3}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=0,y=-0.5,z=0}, --minacc
			{x=0.5,y=0.5,z=0.5}, --maxacc
			1, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_flame.png" --texture
		)
		
	end,
})


minetest.register_node("witchcraft:potion_orange", {
	description = "Dragon Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_orange.png"},
	wield_image = "witchcraft_potion_orange.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_orange.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*2,y=dir.y*2.5,z=dir.z*2}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:fire")
	obj:setvelocity(vec)
	local part = minetest.add_particlespawner(
			10, --amount
			0.3, --time
			{x=playerpos.x-0.3, y=playerpos.y+1.5, z=playerpos.z-0.3}, --minpos
			{x=playerpos.x+0.3, y=playerpos.y+1.5, z=playerpos.z+0.3}, --maxpos
			{x=dir.x*3,y=dir.y*3,z=dir.z*3}, --minvel
			{x=dir.x*3,y=dir.y*3,z=dir.z*3}, --maxvel
			{x=0,y=-0.5,z=0}, --minacc
			{x=0.5,y=0.5,z=0.5}, --maxacc
			1, --minexptime
			2, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_flame.png" --texture
		)
	
		item:replace("vessels:glass_bottle")
		return item
	end,
})

minetest.register_node("witchcraft:potion_orange_2", {
	description = "Dragon Potion (v2)",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_orange.png^[colorize:black:50"},
	wield_image = "witchcraft_potion_orange.png^[colorize:black:50",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_orange.png^[colorize:black:50",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*3,y=dir.y*3.5,z=dir.z*3}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:fire")
	obj:setvelocity(vec)
	local part = minetest.add_particlespawner(
			10, --amount
			0.3, --time
			{x=playerpos.x-0.3, y=playerpos.y+1.5, z=playerpos.z-0.3}, --minpos
			{x=playerpos.x+0.3, y=playerpos.y+1.5, z=playerpos.z+0.3}, --maxpos
			{x=dir.x*3,y=dir.y*3,z=dir.z*3}, --minvel
			{x=dir.x*3,y=dir.y*3,z=dir.z*3}, --maxvel
			{x=0,y=-0.5,z=0}, --minacc
			{x=0.5,y=0.5,z=0.5}, --maxacc
			1, --minexptime
			2, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_flame.png^[colorize:blue:200" --texture
		)
	
		item:replace("vessels:glass_bottle")
		return item
	end,
})

minetest.register_node("witchcraft:splash_orange", {
	description = "Dragon Splash Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_splash_orange.png"},
	wield_image = "witchcraft_splash_orange.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_splash_orange.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*6,y=dir.y*3.5,z=dir.z*6}
	local acc = {x=0,y=-9.8,z=0}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+2+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:fire_splash")
	obj:setvelocity(vec)
	obj:setacceleration(acc)
		item:take_item()
		return item
	end,
})

minetest.register_node("witchcraft:splash_yellwgrn", {
	description = "Dodgy Splash Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_splash_yellgrn.png"},
	wield_image = "witchcraft_splash_yellgrn.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_splash_yellgrn.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*7,y=dir.y*3.5,z=dir.z*7}
	local acc = {x=0,y=-9.8,z=0}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+2+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:tnt_splash")
	obj:setvelocity(vec)
	obj:setacceleration(acc)
		item:take_item()
		return item
	end,
})

minetest.register_node("witchcraft:potion_purple", {
	description = "Smokey Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_purple.png"},
	wield_image = "witchcraft_potion_purple.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_purple.png",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*2,y=dir.y*2.5,z=dir.z*2}
	local part = minetest.add_particlespawner(
			20, --amount
			0.5, --time
			{x=playerpos.x-1, y=playerpos.y, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y, z=playerpos.z+1}, --maxpos
			{x=0,y=0.5,z=0}, --minvel
			{x=0,y=0.6,z=0}, --maxvel
			{x=0,y=-0.5,z=0}, --minacc
			{x=0,y=0.5,z=0}, --maxacc
			1, --minexptime
			3, --maxexptime
			10, --minsize
			15, --maxsize
			false, --collisiondetection
			"witchcraft_smoke.png^[colorize:magenta:50" --texture
		)
	
		item:replace("vessels:glass_bottle")
		return item
	end,
})



if minetest.get_modpath("hud_hunger") ~= nil then
local register_food = hunger.register_food
minetest.register_node("witchcraft:potion_gpurple", {
	description = "Filling Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_gpurple.png"},
	wield_image = "witchcraft_potion_gpurple.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_gpurple.png",
	on_use = function(item, placer, pos)
		item:replace("vessels:glass_bottle")
		return item
	end,
})

minetest.register_node("witchcraft:potion_gred", {
	description = "Hunger Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_gred.png"},
	wield_image = "witchcraft_potion_gred.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_gred.png",
	on_use = function(item, placer, pos)
		item:replace("vessels:glass_bottle")
		return item
	end,
})

register_food("witchcraft:potion_gpurple", 10)
register_food("witchcraft:potion_gred", -4)
else

	minetest.register_node("witchcraft:potion_gpurple", {
	description = "Filling Potion (better with hunger mod)",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_purple.png"},
	wield_image = "witchcraft_potion_purple.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_purple.png",
	on_use = function(itemstack, player)
	local health = player:get_hp();
	player:set_hp(health+20)
	itemstack:replace("vessels:glass_bottle")
	return itemstack
	end,
	
	minetest.register_node("witchcraft:potion_gred", {
	description = "Hunger Potion (better with hunger mod)",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_gred.png"},
	wield_image = "witchcraft_potion_gred.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_gred.png",
	on_use = function(itemstack, player)
	local health = player:get_hp();
	player:set_hp(health+10)
	itemstack:replace("vessels:glass_bottle")
	return itemstack
	end,
})
})
end

minetest.register_node("witchcraft:potion_purple_2", {
	description = "Smokey Potion (lv2)",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_purple.png^[colorize:black:50"},
	wield_image = "witchcraft_potion_purple.png^[colorize:black:50",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_purple.png^[colorize:black:20",
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*2,y=dir.y*2.5,z=dir.z*2}
	local part = minetest.add_particlespawner(
			20, --amount
			0.5, --time
			{x=playerpos.x-1, y=playerpos.y, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y, z=playerpos.z+1}, --maxpos
			{x=0,y=0.2,z=0}, --minvel
			{x=0,y=0.2,z=0}, --maxvel
			{x=0,y=-0.1,z=0}, --minacc
			{x=0,y=0.1,z=0}, --maxacc
			5, --minexptime
			10, --maxexptime
			10, --minsize
			15, --maxsize
			false, --collisiondetection
			"witchcraft_smoke.png^[colorize:magenta:50" --texture
		)
	
		item:replace("vessels:glass_bottle")
		return item
	end,
})

minetest.register_node("witchcraft:potion_grey", {
	description = "Evil Potion",
	drawtype = "plantlike",
	stack_max = 1,
	tiles = {"witchcraft_potion_grey.png"},
	wield_image = "witchcraft_potion_grey.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_grey.png",
	on_use = minetest.item_eat(-100, "vessels:glass_bottle"),
})

minetest.register_node("witchcraft:potion_grey_2", {
	description = "Evil Potion (lv2)",
	drawtype = "plantlike",
	stack_max = 1,
	tiles = {"witchcraft_potion_grey.png^[colorize:black:50"},
	wield_image = "witchcraft_potion_grey.png^[colorize:black:50",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_grey.png^[colorize:black:50",
	on_use = minetest.item_eat(-200, "vessels:glass_bottle"),
})

minetest.register_node("witchcraft:potion_blue", {
	description = "Bottle of Water",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_blue.png"},
	wield_image = "witchcraft_potion_blue.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_blue.png",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		if pointed_thing.type == "node" and
				minetest.get_node(pointed_thing.above).name == "air" then
			if not minetest.is_protected(pointed_thing.above, player) then
				minetest.set_node(pointed_thing.above, {name="default:water_source"})
			else
				minetest.chat_send_player(player, "This area is protected.")
			end
		end
		item:replace("vessels:glass_bottle")
		return item
	end
})


minetest.register_node("witchcraft:potion_silver", {
	description = "Cold potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_silver.png"},
	wield_image = "witchcraft_potion_silver.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_silver.png",
	on_use = function(item, user, pointed_thing)
		 playereffects.apply_effect_type("potion_silver", 15, user)
		item:replace("vessels:glass_bottle")
		return item
	end
})

minetest.register_node("witchcraft:potion_silver_2", {
	description = "Cold potion lv2",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_silver.png^[colorize:black:50"},
	wield_image = "witchcraft_potion_silver.png^[colorize:black:50",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_silver.png^[colorize:black:50",
	on_use = function(item, user, pointed_thing)
		 playereffects.apply_effect_type("potion_silver", 60, user)
		item:replace("vessels:glass_bottle")
		return item
	end
})

if minetest.get_modpath("farming_redo") then
minetest.register_node("witchcraft:potion_green", {
	description = "Melon Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_green.png"},
	wield_image = "witchcraft_potion_green.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_green.png",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		if pointed_thing.type == "node" and
				minetest.get_node(pointed_thing.above).name == "air" then
			if not minetest.is_protected(pointed_thing.above, player) then
				minetest.set_node(pointed_thing.above, {name="farming:melon_8"})
			else
				minetest.chat_send_player(player, "This area is protected.")
			end
		end
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
		return item
	end
})
else
minetest.register_node("witchcraft:potion_green", {
	description = "Plant Potion (destructive!)",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_green.png"},
	wield_image = "witchcraft_potion_green.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_green.png",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		if pointed_thing.type == "node" and
				minetest.get_node(pointed_thing.above).name == "air" then
			if not minetest.is_protected(pointed_thing.above, player) then
				default.grow_new_jungle_tree(pointed_thing.above)
			else
				minetest.chat_send_player(player, "This area is protected.")
			end
		end
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
		return item
	end
})
end

minetest.register_node("witchcraft:potion_gold", {
	description = "Alchemy Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_gold.png"},
	wield_image = "witchcraft_potion_gold.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_gold.png",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		if pointed_thing.type == "node" and
				minetest.get_node(pointed_thing.above).name == "air" then
			if not minetest.is_protected(pointed_thing.above, player) then
				minetest.set_node(pointed_thing.above, {name="default:goldblock"})
			else
				minetest.chat_send_player(player, "This area is protected.")
			end
		end
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
		return item
	end
})

minetest.register_node("witchcraft:potion_gold_2", {
	description = "Alchemy Potion (lv2)",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_gold.png^[colorize:black:50"},
	wield_image = "witchcraft_potion_gold.png^[colorize:black:50",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_gold.png^[colorize:black:50",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		if pointed_thing.type == "node" and
				minetest.get_node(pointed_thing.above).name == "air" then
			if not minetest.is_protected(pointed_thing.above, player) then
				minetest.set_node(pointed_thing.above, {name="default:diamondblock"})
			else
				minetest.chat_send_player(player, "This area is protected.")
			end
		end
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
		return item
	end
})



if minetest.get_modpath("experience") then
minetest.register_node("witchcraft:potion_aqua", {
	description = "Complex Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_aqua.png"},
	wield_image = "witchcraft_potion_aqua.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_aqua.png",
	on_use = function(item, placer, pos)
	local pos = placer:getpos();
	minetest.add_particlespawner(
			6, --amount
			0.1, --time
			{x=pos.x-1, y=pos.y+0.5, z=pos.z-1}, --minpos
			{x=pos.x+1, y=pos.y+1, z=pos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=2,z=-0.5}, --minacc
			{x=0.5,y=2,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"orb.png" --texture
		)
	minetest.env:add_entity(pos, "experience:orb")
	minetest.env:add_entity(pos, "experience:orb")
	minetest.env:add_entity(pos, "experience:orb")
	minetest.env:add_entity(pos, "experience:orb")
	minetest.env:add_entity(pos, "experience:orb")
	
		item:replace("vessels:glass_bottle")
		return item
	end
})
else
minetest.register_node("witchcraft:potion_aqua", {
	description = "Complex Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_aqua.png"},
	wield_image = "witchcraft_potion_aqua.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_aqua.png",
	on_use = function(item, placer, pos)
	local pos = placer:getpos();
	minetest.add_particlespawner(
			6, --amount
			0.1, --time
			{x=pos.x-1, y=pos.y+0.5, z=pos.z-1}, --minpos
			{x=pos.x+1, y=pos.y+1, z=pos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=2,z=-0.5}, --minacc
			{x=0.5,y=2,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		minetest.add_item(pos, "default:steel_ingot")
		minetest.add_item(pos, "witchcraft:herb")
		minetest.add_item(pos, "default:mese_crystal")
		minetest.add_item(pos, "default:gold_lump")
		minetest.add_item(pos, "farming:bread")
		minetest.add_item(pos, "default:copper_ingot")
	
		item:replace("vessels:glass_bottle")
		return item
	end
})
end

minetest.register_node("witchcraft:potion_magenta", {
	description = "Fast Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_magenta.png"},
	wield_image = "witchcraft_potion_magenta.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_magenta.png",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		local breath_change = user:set_breath(5)
		    playereffects.apply_effect_type("potion_speed_lv1", 10, user)

		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
	return item
	end
})

minetest.register_node("witchcraft:potion_magenta_2", {
	description = "Fast Potion (lv2)",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_magenta.png^[colorize:black:50"},
	wield_image = "witchcraft_potion_magenta.png^[colorize:black:50",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_magenta.png^[colorize:black:50",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		local breath_change = user:set_breath(5)
		    playereffects.apply_effect_type("potion_speed_lv2", 10, user)

		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
	return item
	end
})

minetest.register_node("witchcraft:potion_cyan", {
	description = "Light Potion",
	drawtype = "plantlike",
	stack_max = 1,
	tiles = {"witchcraft_potion_cyan.png"},
	wield_image = "witchcraft_potion_cyan.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_cyan.png",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		local breath_change = user:set_breath(5)
		    playereffects.apply_effect_type("potion_antigrav_lvx", 10, user)
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
	return item
	end
})

minetest.register_node("witchcraft:potion_gcyan", {
	description = "Air Potion",
	drawtype = "plantlike",
	stack_max = 1,
	tiles = {"witchcraft_potion_gcyan.png"},
	wield_image = "witchcraft_potion_gcyan.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_gcyan.png",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		local breath_change = user:set_breath(12)
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
	return item
	end
})

minetest.register_node("witchcraft:potion_cyan_2", {
	description = "Light Potion (lv2)",
	drawtype = "plantlike",
	stack_max = 1,
	tiles = {"witchcraft_potion_cyan.png^[colorize:black:50"},
	wield_image = "witchcraft_potion_cyan.png^[colorize:black:50",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_cyan.png^[colorize:black:50",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		local breath_change = user:set_breath(5)
		    playereffects.apply_effect_type("potion_antigrav_lvx", 20, user)
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
	return item
	end
})

minetest.register_node("witchcraft:potion_green2", {
	description = "Volatile Potion",
	drawtype = "plantlike",
	stack_max = 1,
	tiles = {"witchcraft_potion_green2.png"},
	wield_image = "witchcraft_potion_green2.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_green2.png",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		local breath_change = user:set_breath(5)
		    playereffects.apply_effect_type("potion_jump_lvx", 6, user)
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
	return item
	end
})

minetest.register_node("witchcraft:potion_ggreen", {
	description = "Darkness Potion",
	drawtype = "plantlike",
	stack_max = 1,
	tiles = {"witchcraft_potion_ggreen.png"},
	wield_image = "witchcraft_potion_ggreen.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_ggreen.png",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			2000, --amount
			1, --time
			{x=playerpos.x-20, y=playerpos.y-3, z=playerpos.z-20}, --minpos
			{x=playerpos.x+20, y=playerpos.y+3, z=playerpos.z+20}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.1,y=0,z=-0.1}, --minacc
			{x=0.1,y=0,z=0.1}, --maxacc
			5, --minexptime
			10, --maxexptime
			10, --minsize
			20, --maxsize
			false, --collisiondetection
			"witchcraft_pot_bottom.png^[colorize:black:200" --texture
		)
	local mtime = minetest.get_timeofday()
	if mtime >= 0.25 and mtime <= 0.75 then
	user:override_day_night_ratio(-mtime+0.5)
	minetest.after(10, function()
	user:override_day_night_ratio(nil)
	end)
	end
		item:replace("vessels:glass_bottle")
	return item
	end
})

minetest.register_node("witchcraft:potion_green2_2", {
	description = "Volatile Potion (lv2)",
	drawtype = "plantlike",
	stack_max = 1,
	tiles = {"witchcraft_potion_green2.png^[colorize:black:50"},
	wield_image = "witchcraft_potion_green2.png^[colorize:black:50",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_green2.png^[colorize:black:50",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		local breath_change = user:set_breath(5)
		    playereffects.apply_effect_type("potion_jump_lvx", 10, user)
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
	return item
	end
})

minetest.register_node("witchcraft:potion_redbrown", {
	description = "Thick Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_redbrown.png"},
	wield_image = "witchcraft_potion_redbrown.png",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_redbrown.png",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		local breath_change = user:set_breath(5)
		    playereffects.apply_effect_type("potion_slow_lv1", 11, user)
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
	return item
	end
})

minetest.register_node("witchcraft:potion_redbrown_2", {
	description = "Thick Potion (lv2)",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_redbrown.png^[colorize:black:50"},
	wield_image = "witchcraft_potion_redbrown.png^[colorize:black:50",
	paramtype = "light",
	stack_max = 1,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_redbrown.png^[colorize:black:50",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		local breath_change = user:set_breath(5)
		    playereffects.apply_effect_type("potion_slow_lv2", 15, user)
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
	return item
	end
})

minetest.register_node("witchcraft:potion_blue2", {
	description = "Watery Potion",
	drawtype = "plantlike",
	stack_max = 1,
	tiles = {"witchcraft_potion_blue2.png"},
	wield_image = "witchcraft_potion_blue2.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_blue2.png",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		local breath = user:get_breath()
	if breath <= 10 then
		    playereffects.apply_effect_type("potion_swim_lv1", 15, user)
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
	return item
	end
	end
})

minetest.register_node("witchcraft:potion_blue2_2", {
	description = "Watery Potion (lv2)",
	drawtype = "plantlike",
	stack_max = 1,
	tiles = {"witchcraft_potion_blue2.png^[colorize:black:50"},
	wield_image = "witchcraft_potion_blue2.png^[colorize:black:50",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_blue2.png^[colorize:black:50",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		local breath = user:get_breath()
	if breath <= 10 then
		    playereffects.apply_effect_type("potion_swim_lv2", 15, user)
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
	return item
	end
	end
})

--light potion

function lightchange(person, duration)
	local mtime = minetest.get_timeofday()
	if mtime <= 0.25 or mtime >= 0.75 then
	person:override_day_night_ratio(mtime+0.5)
	minetest.after(duration, function()
	person:override_day_night_ratio(nil)
	end)
	end
end

minetest.register_node("witchcraft:potion_yellow", {
	description = "Shiny Potion",
	drawtype = "plantlike",
	stack_max = 1,
	tiles = {"witchcraft_potion_yellow.png"},
	wield_image = "witchcraft_potion_yellow.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_yellow.png",
	on_use = function(item, user, pointed_thing)
		local player = user:get_player_name()
		lightchange(user, 10)
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
	return item
	end
})

minetest.register_node("witchcraft:potion_yellow_2", {
	description = "Shiny Potion (lv2)",
	drawtype = "plantlike",
	stack_max = 1,
	tiles = {"witchcraft_potion_yellow.png^[colorize:black:50"},
	wield_image = "witchcraft_potion_yellow.png^[colorize:black:50",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion2=1},
	sounds = default.node_sound_glass_defaults(),
	inventory_image = "witchcraft_potion_yellow.png^[colorize:black:50",
	on_use = function(item, user, pointed_thing)
		lightchange(user, 20)
		local playerpos = user:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png" --texture
		)
		item:replace("vessels:glass_bottle")
	return item
	end
})


--invisibility potion by Tenplus1(DWTFYWT V2), see darkpurple potion for on_use effect


invisibility = {}

-- reset player invisibility if they go offline

minetest.register_on_leaveplayer(function(player)

	local name = player:get_player_name()

	if invisibility[name] then
		invisibility[name] = nil
	end
end)

invisible = function(player, toggle)

	if not player then return false end

	local name = player:get_player_name()

	invisibility[name] = toggle

	local prop

	if toggle == true then

		-- hide player and name tag
		prop = {
			visual_size = {x = 0, y = 0},
			collisionbox = {0, 0, 0, 0, 0, 0}
		}

		player:set_nametag_attributes({
			color = {a = 0, r = 255, g = 255, b = 255}
		})
	else
		-- show player and tag
		prop = {
			visual_size = {x = 1, y = 1},
			collisionbox = {-0.35, -1, -0.35, 0.35, 1, 0.35}
		}

		player:set_nametag_attributes({
			color = {a = 255, r = 255, g = 255, b = 255}
		})
	end

	player:set_properties(prop)

end

--decorative nodes

minetest.register_node("witchcraft:mortar", {
	description = "mortar and pestle",
	tiles = {
		"default_stone.png",
		"default_stone.png",
		"default_stone.png",
		"default_stone.png",
		"default_stone.png",
		"default_stone.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25}, -- NodeBox1
			{-0.1875, -0.4375, -0.1875, 0.1875, -0.375, 0.1875}, -- NodeBox2
			{-0.3125, -0.375, -0.3125, -0.1875, 0.125, 0.3125}, -- NodeBox3
			{0.1875, -0.375, -0.3125, 0.3125, 0.125, 0.3125}, -- NodeBox4
			{-0.3125, -0.375, -0.3125, 0.3125, 0.125, -0.1875}, -- NodeBox5
			{-0.3125, -0.375, 0.1875, 0.3125, 0.125, 0.3125}, -- NodeBox6
			{-0.1875, -0.375, -0.1875, 0.25, -0.0625, 0.1875}, -- NodeBox7
			{-0.3125, -0.5, -0.5, 0.3125, -0.375, -0.375}, -- NodeBox8
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1}
})

minetest.register_node("witchcraft:pentablock", {
	description = "Pentagram block",
	tiles = {
		"witchcraft_pentablock.png",
	},
	groups = {cracky=1, oddly_breakable_by_hand=1}
})

minetest.register_node("witchcraft:pentagram", {
	description = "pentagram",
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {"witchcraft_pentagram.png"},
	inventory_image = "witchcraft_pentagram.png",
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = false,	
	light_source = 50,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	on_rightclick = function(pos, node, _)
	if minetest.get_modpath("mobs") then
		minetest.after(0.5, function()
		minetest.set_node(pos, {name="witchcraft:portal", param2=node.param2})
		minetest.add_particlespawner(
			25, --amount
			1, --time
			{x=pos.x-1, y=pos.y, z=pos.z-1}, --minpos
			{x=pos.x+1, y=pos.y, z=pos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=1,z=-0.5}, --minacc
			{x=0.5,y=1,z=0.5}, --maxacc
			1, --minexptime
			1.5, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_effect.png^[colorize:green:400" --texture
		)
		end)
		end
	end,
	groups = {cracky=3,dig_immediate=3},
})

minetest.register_node("witchcraft:portal", {
	description = "portal",
	drawtype = "signlike",
	visual_scale = 3.0,
	tiles = {"witchcraft_portal.png"},
	inventory_image = "witchcraft_portal.png",
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = false,	
	light_source = 50,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
	on_construct = function(pos, node, _)
		minetest.after(1, function()
		if minetest.get_modpath("horror") then
		minetest.env:add_entity(pos, "horror:werewolf")
		elseif minetest.get_modpath("dmobs") then
		minetest.env:add_entity(pos, "dmobs:owl")
		elseif minetest.get_modpath("mobs_animal") then
		minetest.env:add_entity(pos, "mobs_animal:kitten")
		elseif minetest.get_modpath("mobs_monster") then
		minetest.env:add_entity(pos, "mobs_monster:oerkki")
		elseif minetest.get_modpath("pmobs") then
		minetest.env:add_entity(pos, "pmobs:wolf")
		end
		minetest.remove_node(pos)
		end)
	end,
	groups = {cracky=3,dig_immediate=3, not_in_creative_inventory=1},
})

minetest.register_node("witchcraft:candle", {
	description = "red candle",
	tiles = {
		"witchcraft_candle_top.png",
		"witchcraft_candle_top.png",
		"witchcraft_candle.png",
		"witchcraft_candle.png",
		"witchcraft_candle.png",
		"witchcraft_candle.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, -0.0625, 0.1875}, -- NodeBox1
			{-0.03125, -0.5, -0.03125, 0.03125, 0.0625, 0.03125}, -- NodeBox2
		}
	},
	groups = {fleshy=1, oddly_breakable_by_hand=1, dig_immediate=3},
})

--other stuff

dofile(minetest.get_modpath("witchcraft").."/scrolls.lua")
dofile(minetest.get_modpath("witchcraft").."/brewing_stand.lua")
