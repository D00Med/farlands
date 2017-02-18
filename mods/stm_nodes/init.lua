
minetest.register_node("stm_nodes:chimney", {
	description = "Tin Chimney",
	tiles = {
		"stm_nodes_chimney_top.png",
		"stm_nodes_chimney_front.png",
		"stm_nodes_chimney_side.png",
		"stm_nodes_chimney_side.png^[transformFX",
		"stm_nodes_chimney_front.png",
		"stm_nodes_chimney_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.1875, -0.125, 0.1875, 0.1875, 0.5}, -- NodeBox1
			{-0.1875, -0.1875, -0.125, 0.1875, 1, 0.1875}, -- NodeBox2
		}
	},
	groups = {cracky = 1, ventilation = 1},
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:chimney2", {
	description = "Copper Chimney",
	tiles = {
		"stm_nodes_chimney_top2.png",
		"stm_nodes_chimney_front2.png",
		"stm_nodes_chimney_side2.png",
		"stm_nodes_chimney_side2.png^[transformFX",
		"stm_nodes_chimney_front2.png",
		"stm_nodes_chimney_front2.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.1875, -0.125, 0.1875, 0.1875, 0.5}, -- NodeBox1
			{-0.1875, -0.1875, -0.125, 0.1875, 1, 0.1875}, -- NodeBox2
		}
	},
	groups = {cracky = 1, ventilation = 2},
	sounds = default.node_sound_metal_defaults()
})


minetest.register_abm({
	nodenames = {"stm_nodes:chimney", "stm_nodes:chimney2"},
	interval = 1.0,
	chance = 2,
	action = function(pos, node)
		if minetest.find_node_near(pos, 1, {"default:furnace_active2"}) then
		minetest.add_particlespawner({
			amount = 4,
			time = 1,
			minpos = {x=pos.x-0.1, y=pos.y+0.8, z=pos.z-0.1},
			maxpos = {x=pos.x+0.1, y=pos.y+1, z=pos.z+0.1},
			minvel = {x=-0.2, y=1, z=-0.2},
			maxvel = {x=0.2, y=3, z=0.2},
			minacc = {x=0, y=0.1, z=0},
			maxacc = {x=0, y=0.2, z=0},
			minexptime = 1,
			maxexptime = 2,
			minsize = 5,
			maxsize = 10,
			collisiondetection = false,
			vertical = false,
			texture = "stm_nodes_steam.png",
		})
		end
	end
})

minetest.register_node("stm_nodes:tank", {
	description = "Small Tin Boiler",
	tiles = {
		"stm_nodes_boiler_top.png",
		"stm_nodes_boiler.png",
		"stm_nodes_boiler.png",
		"stm_nodes_boiler.png",
		"stm_nodes_boiler.png",
		"stm_nodes_boiler_pipe.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, -0.1875, 0.1875}, -- NodeBox1
			{-0.3125, -0.375, -0.25, 0.3125, 0.4375, 0.25}, -- NodeBox2
			{-0.25, -0.375, -0.3125, 0.25, 0.4375, 0.3125}, -- NodeBox3
			{-0.25, -0.4375, -0.25, 0.25, 0.5, 0.25}, -- NodeBox4
			{-0.0625, -0.5, -0.4375, 0.0625, 0.125, -0.3125}, -- NodeBox5
			{-0.0625, 0, -0.4375, 0.0625, 0.125, 0.0625}, -- NodeBox6
		}
	},
	groups = {cracky = 1, boiler = 1},
	sounds = default:node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:tank2", {
	description = "Small Copper Boiler",
	tiles = {
		"stm_nodes_boiler_top2.png",
		"stm_nodes_boiler2.png",
		"stm_nodes_boiler2.png",
		"stm_nodes_boiler2.png",
		"stm_nodes_boiler2.png",
		"stm_nodes_boiler_pipe2.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, -0.1875, 0.1875}, -- NodeBox1
			{-0.3125, -0.375, -0.25, 0.3125, 0.4375, 0.25}, -- NodeBox2
			{-0.25, -0.375, -0.3125, 0.25, 0.4375, 0.3125}, -- NodeBox3
			{-0.25, -0.4375, -0.25, 0.25, 0.5, 0.25}, -- NodeBox4
			{-0.0625, -0.5, -0.4375, 0.0625, 0.125, -0.3125}, -- NodeBox5
			{-0.0625, 0, -0.4375, 0.0625, 0.125, 0.0625}, -- NodeBox6
		}
	},
	groups = {cracky = 1, boiler = 2},
	sounds = default:node_sound_metal_defaults()
})