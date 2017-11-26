farlands = {}

farlands.path = minetest.get_modpath("farlands")

-- unregister unwanted items, nodes an recipes
--~ minetest.clear_craft({output = 'default:sword_mese'})
--~ minetest.unregister_item("default:sword_mese")
--~ minetest.clear_craft({output = 'default:pick_mese'})
--~ minetest.unregister_item("default:pick_mese")
--~ minetest.clear_craft({output = 'default:shovel_mese'})
--~ minetest.unregister_item("default:shovel_mese")
--~ minetest.clear_craft({output = 'default:axe_mese'})
--~ minetest.unregister_item("default:axe_mese")
--~ minetest.clear_craft({output = 'farming:hoe_mese'})
--~ minetest.unregister_item("farming:hoe_mese")
--~ minetest.unregister_item("default:stone_with_mese")
--~ minetest.unregister_item("default:mese")
--~ minetest.unregister_item("default:meselamp")
--~ minetest.clear_craft({output = 'default:meselamp'})
--~ minetest.unregister_item("default:mese_post_light")
--~ minetest.clear_craft({output = 'default:mese_post_light'})
--~ minetest.unregister_item("default:mese_crystal")
--~ minetest.unregister_item("default:mese_crystal_fragment")
--~ minetest.clear_craft({output = 'default:mese'})
--~ minetest.clear_craft({output = 'default:mese_crystal'})
--~ minetest.clear_craft({output = 'default:mese_crystal_fragment'})

dofile(farlands.path.."/functions.lua")
dofile(farlands.path.."/nodes.lua")
dofile(farlands.path.."/doors.lua")
dofile(farlands.path.."/stairs.lua")

dungeon_loot.registered_loot = nil
dofile(farlands.path.."/dungeon_loot.lua")


-- override items
minetest.override_item("default:tree", {description = "Oak Tree"})
minetest.override_item("default:wood", {description = "Oakwood Planks"})
minetest.override_item("default:sapling", {description = "Oak Sapling"})
minetest.override_item("default:leaves", {description = "Oak Leaves"})
--~ minetest.override_item("default:sand_with_kelp", {waving = 1})


--torch glow
minetest.register_abm({
	nodenames = {"default:torch", "default:torch_ceiling",},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		if minetest.get_timeofday() <= 0.6 and minetest.get_timeofday() >= 0.2 and pos.y >= -20 then
		return
		end
		minetest.add_particle({
			pos = {x=pos.x, y=pos.y+0.1, z=pos.z},
			velocity = {x=0, y=0, z=0},
			acceleration = {x=0, y=0, z=0},
			expirationtime = 5,
			size = 15,
			collisiondetection = false,
			collisionremoval = false,
			vertical = true,
			texture = "mapgen_glow.png",
			animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 0.20},
			glow = 9
		})
	end
})

minetest.register_abm({
	nodenames = {"default:torch_wall"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		if minetest.get_timeofday() <= 0.6 and minetest.get_timeofday() >= 0.2 and pos.y >= -20  then
		return
		end
		local dir = minetest.facedir_to_dir(node.param2)
		local particle_pos = {x=pos.x-0.22*dir.z*1.2, y=pos.y+0.1, z=pos.z-0.18*dir.x*1.2}
		if dir.x == 0 and dir.z == 0 then
		particle_pos = {x=pos.x, y=pos.y+0.1, z=pos.z+0.2}
		elseif dir.x == -1 and dir.z == 0 then
		particle_pos = {x=pos.x-0.15, y=pos.y+0.1, z=pos.z}
		elseif dir.x == 0 and dir.z == -1 then
		particle_pos = {x=pos.x+0.15, y=pos.y+0.1, z=pos.z}
		end
		minetest.add_particle({
			pos = particle_pos,
			velocity = {x=0, y=0, z=0},
			acceleration = {x=0, y=0, z=0},
			expirationtime = 5,
			size = 15,
			collisiondetection = false,
			collisionremoval = false,
			vertical = true,
			texture = "mapgen_glow.png",
			animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 0.20},
			glow = 9
		})
	end
})

local meshleaves = minetest.settings:get_bool("enable_mesh_leaves")

if meshleaves then
	minetest.override_item("default:bush_leaves", {
		drawtype = "mesh",
		tiles = {"nodeboxtrees_bush_leaves.png"},
		wield_scale = {x = 0.5, y = 0.5, z = 0.5},
		mesh = "leaf.obj",
		paramtype = "light",
		waving = 2,
	})

	minetest.override_item("default:acacia_bush_leaves", {
		drawtype = "mesh",
		tiles = {"nodeboxtrees_acacia_leaves_simple.png"},
		wield_scale = {x = 0.5, y = 0.5, z = 0.5},
		mesh = "leaf.obj",
		paramtype = "light",
		waving = 2,
	})

	minetest.override_item("default:leaves", {
		drawtype = "mesh",
		tiles = {"nodeboxtrees_leaves.png"},
		wield_scale = {x = 0.5, y = 0.5, z = 0.5},
		mesh = "leaf.obj",
		paramtype = "light",
		waving = 2,
	})

	minetest.override_item("default:acacia_leaves", {
		drawtype = "mesh",
		tiles = {"nodeboxtrees_acacia_leaves.png"},
		wield_scale = {x = 0.5, y = 0.5, z = 0.5},
		mesh = "leaf.obj",
		paramtype = "light",
		waving = 2,
	})


	minetest.override_item("default:jungleleaves", {
		drawtype = "mesh",
		tiles = {"nodeboxtrees_jungleleaves.png"},
		wield_scale = {x = 0.5, y = 0.5, z = 0.5},
		mesh = "leaf.obj",
		paramtype = "light",
		waving = 2,
	})

	minetest.override_item("default:pine_needles", {
		drawtype = "mesh",
		tiles = {"nodeboxtrees_pine_needles.png"},
		wield_scale = {x = 0.5, y = 0.5, z = 0.5},
		mesh = "leaf.obj",
		paramtype = "light",
		waving = 2,
	})

	minetest.override_item("default:aspen_leaves", {
		drawtype = "mesh",
		tiles = {"nodeboxtrees_aspen_leaves.png"},
		wield_scale = {x = 0.5, y = 0.5, z = 0.5},
		mesh = "leaf.obj",
		paramtype = "light",
		waving = 2,
	})
end
