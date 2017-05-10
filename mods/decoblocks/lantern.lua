
--[[

lantern mod - formerly mod "Torch Mod"
======================

(c) Copyright BlockMen (2013-2015)
(C) Copyright sofar <sofar@foo-projects.org> (2016)
(C) Copyright tobyplowy (aka toby109tt) (2017)

this mod adds lanterns

License:
~~~~~~~~
(c) Copyright BlockMen (2013-2015)

Textures and Meshes/Models:
CC-BY 3.0 tobyplowy (aka toby109tt)

Code:
Licensed under the GNU LGPL version 2.1 or higher.
You can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License
as published by the Free Software Foundation;

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

See LICENSE.txt and http://www.gnu.org/licenses/lgpl-2.1.txt

--]]

minetest.register_node("decoblocks:lantern", {
	description = "Lantern",
	drawtype = "mesh",
	mesh = "lantern_floor.obj",
	inventory_image = "decoblocks_lantern_item.png",
	wield_image = "decoblocks_lantern_item.png",
	tiles = {{
		    name = "decoblocks_lantern.png",
		    animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 3.3}
	}},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	liquids_pointable = false,
	light_source = 13,
	groups = {choppy=2, dig_immediate=3, flammable=1, attached_node=1, torch=1},
	drop = "decoblocks:lantern",
	selection_box = {
		type = "wallmounted",
		wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
	},
	sounds = default.node_sound_wood_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local def = minetest.registered_nodes[node.name]
		if def and def.on_rightclick and
			((not placer) or (placer and not placer:get_player_control().sneak)) then
			return def.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end

		local above = pointed_thing.above
		local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
		local fakestack = itemstack
		if wdir == 0 then
			fakestack:set_name("decoblocks:lantern_ceiling")
		elseif wdir == 1 then
			fakestack:set_name("decoblocks:lantern")
		else
			fakestack:set_name("decoblocks:lantern_wall")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("decoblocks:lantern")

		return itemstack
	end
})

minetest.register_abm({
	nodenames = {"decoblocks:lantern"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		minetest.add_particle({
			pos = {x=pos.x, y=pos.y, z=pos.z},
			velocity = {x=0, y=0, z=0},
			acceleration = {x=0, y=0, z=0},
			expirationtime = 5,
			size = 25,
			collisiondetection = false,
			collisionremoval = false,
			vertical = true,
			texture = "decoblocks_glow.png",
			animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 2.00},
			glow = 9
		})
	end
})

minetest.register_node("decoblocks:lantern_wall", {
	drawtype = "mesh",
	mesh = "lantern_wall.obj",
	tiles = {{
		    name = "decoblocks_lantern.png",
		    animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 3.3}
	}},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 13,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "decoblocks:lantern",
	selection_box = {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/8, -1/8, 1/8, 1/8},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("decoblocks:lantern_ceiling", {
	drawtype = "mesh",
	mesh = "lantern_ceiling.obj",
	tiles = {{
		    name = "decoblocks_lantern.png",
		    animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 3.3}
	}},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 13,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "decoblocks:lantern",
	selection_box = {
		type = "wallmounted",
		wall_top = {-1/8, -1/16, -5/16, 1/8, 1/2, 1/8},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_lbm({
	name = "decoblocks:3dlantern",
	nodenames = {"decoblocks:lantern", "lantern:floor", "lantern:wall"},
	action = function(pos, node)
		if node.param2 == 0 then
			minetest.set_node(pos, {name = "decoblocks:lantern_ceiling",
				param2 = node.param2})
		elseif node.param2 == 1 then
			minetest.set_node(pos, {name = "decoblocks:lantern",
				param2 = node.param2})
		else
			minetest.set_node(pos, {name = "decoblocks:lantern_wall",
				param2 = node.param2})
		end
	end
})

