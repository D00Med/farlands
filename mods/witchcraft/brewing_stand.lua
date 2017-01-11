--brewing stand and level 2 potions

-- GENERATED CODE
-- Node Box Editor, version 0.8.1 - Glass

minetest.register_node("witchcraft:brewing_stand", {
	tiles = {
		"witchcraft_brewing_stand_top.png",
		"witchcraft_brewing_stand_top.png",
		"witchcraft_brewing_stand_side.png",
		"witchcraft_brewing_stand_side.png",
		"witchcraft_brewing_stand_side.png",
		"witchcraft_brewing_stand_side.png"
	},
	drawtype = "nodebox",
	use_texture_alpha = true,
	paramtype = "light",
	drop = {
		items = {
			{items = {'witchcraft:brewing_stand_unready'}, rarity = 1},
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25}, -- NodeBox1
			{-0.0625, -0.5, -0.0625, 0.0625, 0, 0.0625}, -- NodeBox2
			{-0.5, 0, -0.125, 0.5, 0.0625, 0.125}, -- NodeBox3
			{-0.4375, -0.1875, -0.0625, -0.3125, 0.375, 0.0625}, -- NodeBox4
			{0.3125, -0.1875, -0.0625, 0.4375, 0.375, 0.0625}, -- NodeBox5
			{-0.125, 0.0625, -0.125, 0.125, 0.125, 0.125}, -- NodeBox6
			{-0.1875, 0.125, -0.125, 0.1875, 0.375, 0.125}, -- NodeBox7
			{-0.125, 0.125, -0.1875, 0.125, 0.375, 0.1875}, -- NodeBox8
			{-0.0625, 0.375, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox9
		}
	},
	on_rightclick = function(pos, node, clicker, item, _)
		local wield_item = clicker:get_wielded_item():get_name()
		local new_item = wield_item.."_2"
		if minetest.get_item_group(wield_item, "potion") ~= 0 then
			minetest.set_node(pos, {name="witchcraft:brewing_stand_active", param2=node.param2})
			item:take_item()
			minetest.after(30, function()
			minetest.set_node(pos, {name="witchcraft:brewing_stand_unready", param2=node.param2})
			minetest.add_item(pos, new_item)
			end)
		end
	end,
})

minetest.register_node("witchcraft:brewing_stand_active", {
	tiles = {
		"witchcraft_brewing_stand_top.png",
		"witchcraft_brewing_stand_top.png",
		"witchcraft_brewing_stand_side.png",
		"witchcraft_brewing_stand_side.png",
		"witchcraft_brewing_stand_side.png",
		"witchcraft_brewing_stand_side.png"
	},
	drawtype = "nodebox",
	use_texture_alpha = true,
	paramtype = "light",
	light_source = 1, 
	drop = {
		items = {
			{items = {'witchcraft:brewing_stand_unready'}, rarity = 1},
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25}, -- NodeBox1
			{-0.0625, -0.5, -0.0625, 0.0625, 0, 0.0625}, -- NodeBox2
			{-0.5, 0, -0.125, 0.5, 0.0625, 0.125}, -- NodeBox3
			{-0.4375, -0.1875, -0.0625, -0.3125, 0.375, 0.0625}, -- NodeBox4
			{0.3125, -0.1875, -0.0625, 0.4375, 0.375, 0.0625}, -- NodeBox5
			{-0.125, 0.0625, -0.125, 0.125, 0.125, 0.125}, -- NodeBox6
			{-0.1875, 0.125, -0.125, 0.1875, 0.375, 0.125}, -- NodeBox7
			{-0.125, 0.125, -0.1875, 0.125, 0.375, 0.1875}, -- NodeBox8
			{-0.0625, 0.375, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox9
		}
	}
})

minetest.register_node("witchcraft:brewing_stand_unready", {
	description = "brewing stand",
	tiles = {
		"witchcraft_brewing_stand_top.png^[colorize:black:100",
		"witchcraft_brewing_stand_top.png^[colorize:black:100",
		"witchcraft_brewing_stand_side.png^[colorize:black:100",
		"witchcraft_brewing_stand_side.png^[colorize:black:100",
		"witchcraft_brewing_stand_side.png^[colorize:black:100",
		"witchcraft_brewing_stand_side.png^[colorize:black:100"
	},
	inventory_image = "witchcraft_brewing_stand_inv.png",
	drawtype = "nodebox",
	use_texture_alpha = true,
	paramtype = "light",
	light_source = 1, 
	drop = {
		items = {
			{items = {'witchcraft:brewing_stand_unready'}, rarity = 1},
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25}, -- NodeBox1
			{-0.0625, -0.5, -0.0625, 0.0625, 0, 0.0625}, -- NodeBox2
			{-0.5, 0, -0.125, 0.5, 0.0625, 0.125}, -- NodeBox3
			{-0.4375, -0.1875, -0.0625, -0.3125, 0.375, 0.0625}, -- NodeBox4
			{0.3125, -0.1875, -0.0625, 0.4375, 0.375, 0.0625}, -- NodeBox5
			{-0.125, 0.0625, -0.125, 0.125, 0.125, 0.125}, -- NodeBox6
			{-0.1875, 0.125, -0.125, 0.1875, 0.375, 0.125}, -- NodeBox7
			{-0.125, 0.125, -0.1875, 0.125, 0.375, 0.1875}, -- NodeBox8
			{-0.0625, 0.375, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox9
		}
	},
	on_rightclick = function(pos, node, clicker, item, _)
		local wield_item = clicker:get_wielded_item():get_name()
		if wield_item == "default:mese_crystal_fragment" then
			minetest.set_node(pos, {name="witchcraft:brewing_stand", param2=node.param2})
			item:take_item()
		end
	end,
})

--end of GENERATED CODE

minetest.register_abm({
	nodenames = {"witchcraft:brewing_stand_active"},
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
			minsize = 0.5,
			maxsize = 1,
			collisiondetection = false,
			texture = "witchcraft_smoke.png"
		})
	end
})

minetest.register_craft({
	output = 'witchcraft:brewing_stand_unready',
	recipe = {
		{'', '', ''},
		{'group:stick', 'default:diamond', 'group:stick'},
		{'', 'default:obsidian_shard', ''},
	}
})