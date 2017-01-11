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
	description = "Small Bottle (empty)",
	drawtype = "plantlike",
	tiles = {"vessels_glass_bottle.png"},
	inventory_image = "vessels_glass_bottle_inv.png",
	wield_image = "vessels_glass_bottle.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	stack_max = 1,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
	},
	groups = {vessel=1,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
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
			if minetest.get_item_group(stack:get_name(), "potion") ~= 0
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

minetest.register_craft({
	output = 'witchcraft:shelf',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:potion', 'group:potion', 'group:potion'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

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

minetest.register_craft({
	output = 'witchcraft:bottle_eyes',
	recipe = {
		{'moreplants:eye'},
		{'moreplants:eye'},
		{'vessels:drinking_glass'},
	}
})

minetest.register_craft({
	output = 'witchcraft:splash_orange',
	recipe = {
		{'group:stick'},
		{'witchcraft:potion_orange'},
	}
})

minetest.register_craft({
	output = 'witchcraft:splash_yellwgrn',
	recipe = {
		{'group:stick'},
		{'witchcraft:potion_yellgrn'},
	}
})

minetest.register_craft({
	output = "moreplants:eye 2",
	type = "shapeless",
	recipe = {"witchcraft:bottle_eyes"}
})

minetest.register_craftitem("witchcraft:herb", {
	description = "herb",
	inventory_image = "witchcraft_herbs.png"
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

-- GENERATED CODE
-- Node Box Editor, version 0.8.1 - Glass
-- Namespace: test

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
			{-0.375, -0.3125, -0.375, 0.375, 0.5, 0.375}, -- NodeBox4
			{-0.4375, -0.25, -0.4375, 0.4375, 0.3125, 0.4375}, -- NodeBox5
			{-0.5, -0.1875, -0.5, 0.5, 0.3125, 0.5}, -- NodeBox6
			{-0.4375, 0.375, -0.4375, 0.4375, 0.5, 0.4375}, -- NodeBox7
		}
	},
	on_rightclick = function(pos, node, clicker, item, _)
		local wield_item = clicker:get_wielded_item():get_name()
		if wield_item == "bucket:bucket_water" or
				wield_item == "bucket:bucket_river_water" then
			minetest.set_node(pos, {name="witchcraft:pot_water", param2=node.param2})
			item:replace("bucket:bucket_empty")
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_craft({
	output = 'witchcraft:pot',
	recipe = {
		{'default:copper_lump', '', 'default:copper_lump'},
		{'default:copper_lump', '', 'default:copper_lump'},
		{'', 'default:copper_lump', ''},
	}
})

minetest.register_node("witchcraft:pot_water", {
	tiles = {
		{ name = "witchcraft_pot_blue.png",
			animation = {type="vertical_frames", length=3.0} },
		"witchcraft_pot_bottom.png",
		"witchcraft_pot_side.png",
		"witchcraft_pot_side.png",
		"witchcraft_pot_side.png",
		"witchcraft_pot_side.png"
	},
	drop = {
		items = {
			{items = {'witchcraft:pot'}, rarity = 1},
		}
	},
	drawtype = "nodebox",
	paramtype = "light",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_blue")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		else
		if wield_item == "flowers:waterlily" or
				wield_item == "moreplants:bullrush" then
			minetest.set_node(pos, {name="witchcraft:pot_blue2", param2=node.param2})
			item:take_item()
		end
	end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_blue2", {
	tiles = {
		{ name = "witchcraft_pot_blue2.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_blue2")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "default:dirt" or
				wield_item == "default:sand" then
			minetest.set_node(pos, {name="witchcraft:pot_brown", param2=node.param2})
			item:take_item()
		elseif wield_item == "witchcraft:herb" then
			minetest.set_node(pos, {name="witchcraft:pot_red", param2=node.param2})
			item:take_item()
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_aqua", {
	tiles = {
		{ name = "witchcraft_pot_aqua.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_aqua")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "bucket:bucket_water" or
				wield_item == "bucket:bucket_river_water" then
			minetest.set_node(pos, {name="witchcraft:pot_water", param2=node.param2})
			item:replace("bucket:bucket_empty")
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_brown", {
	tiles = {
		{ name = "witchcraft_pot_brown.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_brown")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "witchcraft:bottle_eyes" then
			minetest.set_node(pos, {name="witchcraft:pot_redbrown", param2=node.param2})
			item:take_item()
		elseif wield_item == "vessels:drinking_glass" then
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
			item:replace("witchcraft:bottle_slime")
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_redbrown", {
	tiles = {
		{ name = "witchcraft_pot_brown.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_redbrown")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "bones:bones" then
			minetest.set_node(pos, {name="witchcraft:pot_grey", param2=node.param2})
			item:take_item()
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_grey", {
	tiles = {
		{ name = "witchcraft_pot_grey.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_grey")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "default:copperblock" or
				wield_item == "default:steelblock" then
			minetest.set_node(pos, {name="witchcraft:pot_yellow", param2=node.param2})
			item:take_item()
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_cyan", {
	tiles = {
		{ name = "witchcraft_pot_cyan.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_cyan")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "default:obsidian_shard" or
				wield_item == "default:mese_crystal_fragment" then
			minetest.set_node(pos, {name="witchcraft:pot_aqua", param2=node.param2})
			item:take_item()
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_darkpurple", {
	tiles = {
		{ name = "witchcraft_pot_darkpurple.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_darkpurple")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "witchcraft:bottle_slime" or
			wield_item == "moreplants:curlyfruit" then
			minetest.set_node(pos, {name="witchcraft:pot_cyan", param2=node.param2})
			item:take_item()
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_purple", {
	tiles = {
		{ name = "witchcraft_pot_purple.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_purple")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "default:diamond" or
				wield_item == "default:gold_lump" then
			minetest.set_node(pos, {name="witchcraft:pot_magenta", param2=node.param2})
			item:take_item()
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_green", {
	tiles = {
		{ name = "witchcraft_pot_green.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_green")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "flowers:mushroom_red" or
				wield_item == "moreplants:mushroom" then
			minetest.set_node(pos, {name="witchcraft:pot_purple", param2=node.param2})
			item:take_item()
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_green2", {
	tiles = {
		{ name = "witchcraft_pot_green2.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_green2")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "moreplants:umbrella" or
				wield_item == "default:grass_5" then
			minetest.set_node(pos, {name="witchcraft:pot_green", param2=node.param2})
			item:take_item()
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_magenta", {
	tiles = {
		{ name = "witchcraft_pot_magenta.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_magenta")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "default:glass" or
				wield_item == "vessels:glass_fragments" then
			minetest.set_node(pos, {name="witchcraft:pot_darkpurple", param2=node.param2})
			item:take_item()
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_orange", {
	tiles = {
		{ name = "witchcraft_pot_orange.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_orange")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "tnt:tnt" then
			minetest.set_node(pos, {name="witchcraft:pot_yllwgrn", param2=node.param2})
			item:take_item()
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_red", {
	tiles = {
		{ name = "witchcraft_pot_red.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_red")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "default:gravel" or
				wield_item == "default:flint" then
			minetest.set_node(pos, {name="witchcraft:pot_orange", param2=node.param2})
			item:take_item()
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_yellow", {
	tiles = {
		{ name = "witchcraft_pot_yellow.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_yellow")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "moreplants:eye" then
			minetest.set_node(pos, {name="witchcraft:pot_yllwgrn", param2=node.param2})
			item:take_item()
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_node("witchcraft:pot_yllwgrn", {
	tiles = {
		{ name = "witchcraft_pot_yllwgrn.png",
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
		if wield_item == "vessels:glass_bottle" then
			item:replace("witchcraft:potion_yellgrn")
			minetest.set_node(pos, {name="witchcraft:pot", param2=node.param2})
		elseif wield_item == "default:apple" then
			minetest.set_node(pos, {name="witchcraft:pot_green2", param2=node.param2})
			item:take_item()
		end
	end,
	groups = {cracky=1, falling_node=1, oddly_breakable_by_hand=1, potion=1}
})

minetest.register_abm({
	nodenames = {"witchcraft:pot_water", "witchcraft:pot_blue2", "witchcraft:pot_cyan", "witchcraft:pot_green", "witchcraft:pot_green2", "witchcraft:pot_aqua", "witchcraft:pot_yellow", "witchcraft:pot_yllwgrn", "witchcraft:pot_red", "witchcraft:pot_magenta", "witchcraft:pot_brown"},
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
	on_use = minetest.item_eat(100, "vessels:glass_bottle"),
})

minetest.register_tool("witchcraft:potion_darkpurple", {
	description = "Shady Potion",
	wield_image = "witchcraft_potion_darkpurple.png",
	inventory_image = "witchcraft_potion_darkpurple.png",
	on_use = function(item, user)
	default.player_set_skin(user, "witchcraft_skin.png")
	minetest.after(30, function()
	default.player_set_skin(user, "character.png")
	end)
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
	item:add_wear(30000)
	return item
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

--this one isn't removed but the player will die after using it so it hasn't been fixed
minetest.register_node("witchcraft:potion_yellgrn", {
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
	on_use = function(pos, placer)
	local pos = placer:getpos();
	tnt.boom(pos, {damage_radius=5,radius=3,ignore_protection=false})
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
									minetest.sound_play("default_break_glass.1.ogg", {
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
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
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
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
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
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
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

if minetest.get_modpath("farming") then
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
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
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
end

minetest.register_node("witchcraft:potion_yellow", {
	description = "Alchemy Potion",
	drawtype = "plantlike",
	tiles = {"witchcraft_potion_yellow.png"},
	wield_image = "witchcraft_potion_yellow.png",
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
	inventory_image = "witchcraft_potion_yellow.png",
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
	groups = {vessel=1,dig_immediate=3,attached_node=1, potion=1},
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
end

minetest.register_node("witchcraft:potion_magenta", {
	description = "Strong Potion",
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
		local effect = user:set_physics_override({

		speed = 2.0, -- multiplier to default value
		jump = 1, -- multiplier to default value
		gravity = 1, -- multiplier to default value
		sneak = true, -- whether player can sneak
		sneak_glitch = false, -- whether player can use the sneak glitch 

		})
		local reset = minetest.after(10, function()
			user:set_breath(11)
			local effect = user:set_physics_override({

		speed = 1.0, -- multiplier to default value
		jump = 1.0, -- multiplier to default value
		gravity = 1, -- multiplier to default value
		sneak = true, -- whether player can sneak
		sneak_glitch = false, -- whether player can use the sneak glitch 

		})
		end)

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
		local effect = user:set_physics_override({

		speed = 1.0, -- multiplier to default value
		jump = 1, -- multiplier to default value
		gravity = 0.1, -- multiplier to default value
		sneak = true, -- whether player can sneak
		sneak_glitch = false, -- whether player can use the sneak glitch 

		})
		local reset = minetest.after(10, function()
			user:set_breath(11)
			local effect = user:set_physics_override({

		speed = 1.0, -- multiplier to default value
		jump = 1.0, -- multiplier to default value
		gravity = 1, -- multiplier to default value
		sneak = true, -- whether player can sneak
		sneak_glitch = false, -- whether player can use the sneak glitch 

		})
		end)
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
		local effect = user:set_physics_override({

		speed = 1.0, -- multiplier to default value
		jump = 1.5, -- multiplier to default value
		gravity = 0.8, -- multiplier to default value
		sneak = true, -- whether player can sneak
		sneak_glitch = false, -- whether player can use the sneak glitch 

		})
		local reset = minetest.after(6, function()
			user:set_breath(11)
			local effect = user:set_physics_override({

		speed = 1.0, -- multiplier to default value
		jump = 1.0, -- multiplier to default value
		gravity = 1, -- multiplier to default value
		sneak = true, -- whether player can sneak
		sneak_glitch = false, -- whether player can use the sneak glitch 

		})
		end)
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
		local effect = user:set_physics_override({

		speed = 0.5, -- multiplier to default value
		jump = 1, -- multiplier to default value
		gravity = 1, -- multiplier to default value
		sneak = true, -- whether player can sneak
		sneak_glitch = false, -- whether player can use the sneak glitch 

		})
		local reset = minetest.after(10, function()
			user:set_breath(11)
			local effect = user:set_physics_override({

		speed = 1.0, -- multiplier to default value
		jump = 1.0, -- multiplier to default value
		gravity = 1, -- multiplier to default value
		sneak = true, -- whether player can sneak
		sneak_glitch = false, -- whether player can use the sneak glitch 

		})
		end)
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
		local spd = user:set_physics_override({

		speed = 3, -- multiplier to default value
		jump = 1.0, -- multiplier to default value
		gravity = 1.0, -- multiplier to default value
		sneak = true, -- whether player can sneak
		sneak_glitch = false, -- whether player can use the sneak glitch 

		})
	end
		local reset = minetest.after(20, function()
			user:set_physics_override({

		speed = 1.0, -- multiplier to default value
		jump = 1.0, -- multiplier to default value
		gravity = 1.0, -- multiplier to default value
		sneak = true, -- whether player can sneak
		sneak_glitch = false, -- whether player can use the sneak glitch 

		})
		end)
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

--scrolls

minetest.register_craftitem("witchcraft:scroll_day", {
	description = "Scroll of day",
	inventory_image = "witchcraft_scroll.png^witchcraft_sun_over.png",
	stack_max = 1,
	on_use = function(item)
	minetest.set_timeofday(0.5)
	item:take_item()
	return item
	end,
})

minetest.register_craftitem("witchcraft:scroll_night", {
	description = "Scroll of night",
	inventory_image = "witchcraft_scroll.png^witchcraft_moon_over.png",
	stack_max = 1,
	on_use = function(item)
	minetest.set_timeofday(0)
	item:take_item()
	return item
	end,
})

if minetest.get_modpath("pmobs")then
minetest.register_craftitem("witchcraft:scroll_wild", {
	description = "Scroll of Wild",
	inventory_image = "witchcraft_scroll.png^witchcraft_dark_over.png",
	stack_max = 1,
	on_use = function(item, placer)
	local pos = placer:getpos();
	minetest.env:add_entity(pos, "pmobs:dog")
	item:take_item()
	return item
	end,
})
end

minetest.register_craftitem("witchcraft:scroll_fireball", {
	description = "Scroll of fireball",
	inventory_image = "witchcraft_scroll.png^witchcraft_fire_over.png",
	stack_max = 1,
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*7,y=dir.y*7,z=dir.z*7}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:fireball")
	obj:setvelocity(vec)
	
		item:take_item()
		return item
	end,
})

if minetest.get_modpath("lightning") then
minetest.register_craftitem("witchcraft:scroll_lightning", {
	description = "Scroll of lightning",
	inventory_image = "witchcraft_scroll.png^witchcraft_thunder_over.png",
	stack_max = 1,
	on_use = function(item, placer, pos)
	local playerpos = placer:getpos();
	local dir = placer:get_look_dir();
	lightning.strike({x=playerpos.x+dir.x*2,y=playerpos.y+0+dir.y,z=playerpos.z+dir.z*2})
		item:take_item()
		return item
	end,
})
else
minetest.register_craftitem("witchcraft:scroll_lightning", {
	description = "Scroll of lightning",
	inventory_image = "witchcraft_scroll.png^witchcraft_thunder_over.png",
	stack_max = 1,
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*7,y=dir.y*7,z=dir.z*7}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:lightning")
	obj:setvelocity(vec)
	
		item:take_item()
		return item
	end,
})
end

minetest.register_craftitem("witchcraft:scroll_icicle", {
	description = "Scroll of icicle",
	inventory_image = "witchcraft_scroll.png^witchcraft_ice_over.png",
	stack_max = 1,
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*7,y=dir.y*7,z=dir.z*7}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:ice")
	local obj2 = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+1+dir.z}, "witchcraft:ice")
	local obj3 = minetest.env:add_entity({x=playerpos.x+1+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:ice")
	obj:setvelocity(vec)
	obj2:setvelocity(vec)
	obj3:setvelocity(vec)
	
		item:take_item()
		return item
	end,
})


minetest.register_craftitem("witchcraft:scroll_nature", {
	description = "Scroll of nature",
	inventory_image = "witchcraft_scroll.png^witchcraft_leaf_over.png",
	stack_max = 1,
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*6,y=dir.y*6,z=dir.z*6}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:tree")
	obj:setvelocity(vec)
	
		item:take_item()
		return item
	end,
})

minetest.register_craftitem("witchcraft:scroll", {
	description = "Blank Scroll",
	inventory_image = "witchcraft_scroll.png",
})

if minetest.get_modpath("pmobs")then
minetest.register_craft({
	output = 'witchcraft:scroll_wild',
	recipe = {
		{'mobs:meat_raw'},
		{'witchcraft:scroll'},
	}
})

end

minetest.register_craft({
	output = 'witchcraft:scroll',
	recipe = {
		{'default:paper', 'default:diamond', 'default:paper'},
		{'default:paper', 'default:paper', 'default:paper'},
	}
})

minetest.register_craft({
	output = 'witchcraft:scroll_icicle',
	recipe = {
		{'default:ice'},
		{'witchcraft:scroll'},
	}
})

minetest.register_craft({
	output = 'witchcraft:scroll_fireball',
	recipe = {
		{'default:obsidian_shard'},
		{'witchcraft:scroll'},
	}
})

minetest.register_craft({
	output = 'witchcraft:scroll_nature',
	recipe = {
		{'default:leaves'},
		{'witchcraft:scroll'},
	}
})

minetest.register_craft({
	output = 'witchcraft:scroll_day',
	recipe = {
		{'default:torch'},
		{'witchcraft:scroll'},
	}
})

minetest.register_craft({
	output = 'witchcraft:scroll_night',
	recipe = {
		{'default:coal_lump'},
		{'witchcraft:scroll'},
	}
})


minetest.register_craft({
	output = 'witchcraft:scroll_lightning',
	recipe = {
		{'default:steel_ingot'},
		{'witchcraft:scroll'},
	}
})


--scroll powers

minetest.register_entity("witchcraft:fireball", {
	textures = {"tnt_boom.png"},
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
					if obj:get_luaentity().name ~= "witchcraft:fireball" and obj:get_luaentity().name ~= "__builtin:item" then
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
								if n ~= "witchcraft:fireball" and n ~="default:dirt_with_grass" and n ~="default:dirt_with_dry_grass" and n ~="default:stone"  then	
									if minetest.registered_nodes[n].groups.flammable --[[or math.random(1, 100) <= 1]] then
										minetest.env:set_node(t, {name="fire:basic_flame"})
									self.object:remove()
									return
									end
								end
							end
						end
					end
			hit_node = function(self, pos, node)
--	local pos = self.object:getpos()
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
			6, --amount
			0.3, --time
			{x=apos.x-0.3, y=apos.y-0.3, z=apos.z-0.3}, --minpos
			{x=apos.x+0.3, y=apos.y+0.3, z=apos.z+0.3}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=0,y=-0.5,z=0}, --minacc
			{x=0.5,y=0.5,z=0.5}, --maxacc
			0.1, --minexptime
			0.3, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_flame.png" --texture
		)
		
	end,
})

minetest.register_entity("witchcraft:lightning", {
	textures = {"witchcraft_light_over.png"},
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
					if obj:get_luaentity().name ~= "witchcraft:lightning" and obj:get_luaentity().name ~= "__builtin:item" then
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
								if n ~= "witchcraft:lightning" and n ~="default:dirt_with_grass" and n ~="default:dirt_with_dry_grass" and n ~="default:stone"  then	
									if minetest.registered_nodes[n].groups.flammable --[[or math.random(1, 100) <= 1]] then
										minetest.env:set_node(t, {name="fire:basic_flame"})
									end
								elseif n == "default:wood" or n =="default:tree" or n =="default:dirt_with_grass" or n =="default:dirt_with_dry_grass" then
									self.object:remove()
									return
								end
							end
						end
					end

		local apos = self.object:getpos()
		local part = minetest.add_particlespawner(
			6, --amount
			0.3, --time
			{x=apos.x-0.3, y=apos.y-0.3, z=apos.z-0.3}, --minpos
			{x=apos.x+0.3, y=apos.y+0.3, z=apos.z+0.3}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=0,y=-0.5,z=0}, --minacc
			{x=0.5,y=0.5,z=0.5}, --maxacc
			1, --minexptime
			2, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_zap.png" --texture
		)
		
	end,
})

minetest.register_entity("witchcraft:tree", {
	textures = {"witchcraft_skin.png"},
	velocity = 1,
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
					if obj:get_luaentity().name ~= "witchcraft:tree" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:remove()
						local treepos = self.object:getpos()
						default.grow_new_jungle_tree(treepos)
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
								if n ~= "witchcraft:tree" and n ~="air" then	
						local treepos = self.object:getpos()
						default.grow_new_jungle_tree(treepos)
						self.object:remove()
								elseif n == "default:wood" or n =="default:tree" or n =="default:dirt_with_grass" or n =="default:dirt_with_dry_grass" then
									self.hit_node(self, pos, node)
									self.object:remove()
									return
								end
							end
						end
					end
			hit_node = function(self, pos, node)
						local treepos = self.object:getpos()
						default.grow_new_jungle_tree(treepos)
		end

		local apos = self.object:getpos()
		local part = minetest.add_particlespawner(
			6, --amount
			0.3, --time
			{x=apos.x-0.3, y=apos.y-0.3, z=apos.z-0.3}, --minpos
			{x=apos.x+0.3, y=apos.y+0.3, z=apos.z+0.3}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=0,y=-0.5,z=0}, --minacc
			{x=0.5,y=0.5,z=0.5}, --maxacc
			0.1, --minexptime
			0.3, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_leaf_over.png" --texture
		)
		
	end,
})

minetest.register_entity("witchcraft:ice", {
	visual="sprite",
	visual_size={x=1,y=1},
	physical=false,
	textures={"witchcraft_ice.png"},
	velocity = 1,
    rotate = 90,
	auto_rotate = true,
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
					if obj:get_luaentity().name ~= "witchcraft:ice" and obj:get_luaentity().name ~= "__builtin:item" then
					obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=1},
						}, nil)
					self.object:remove()
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
			0.1, --minexptime
			0.3, --maxexptime
			0.2, --minsize
			0.5, --maxsize
			false, --collisiondetection
			"witchcraft_light_over.png" --texture
		)
	end
	end
})