

minetest.register_node("stm_nodes:hopper", {
	description = "Hopper",
	tiles = {
		"stm_nodes_hopper_top.png",
		"stm_nodes_hopper_bottom.png",
		"stm_nodes_hopper.png",
		"stm_nodes_hopper.png",
		"stm_nodes_hopper.png",
		"stm_nodes_hopper.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.1875, -0.3125, 0.3125, -0.125, 0.3125}, -- NodeBox14
			{-0.125, -0.5, -0.125, 0.125, -0.1875, 0.125}, -- NodeBox15
			{0.3125, -0.125, -0.375, 0.375, 0.5, 0.375}, -- NodeBox16
			{-0.375, -0.125, -0.375, -0.3125, 0.5, 0.375}, -- NodeBox17
			{-0.375, -0.125, -0.375, 0.375, 0.5, -0.3125}, -- NodeBox18
			{-0.375, -0.125, 0.3125, 0.375, 0.5, 0.375}, -- NodeBox19
			{-0.1875, -0.25, -0.1875, 0.1875, -0.1875, 0.1875}, -- NodeBox20
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{0.3125, -0.125, -0.375, 0.375, 0.5, 0.375}, -- NodeBox16
			{-0.375, -0.125, -0.375, -0.3125, 0.5, 0.375}, -- NodeBox17
			{-0.375, -0.125, -0.375, 0.375, 0.5, -0.3125}, -- NodeBox18
			{-0.375, -0.125, 0.3125, 0.375, 0.5, 0.375}, -- NodeBox19
		}
	},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack)
		minetest.add_item({x=pos.x, y=pos.y+0.5, z=pos.z}, itemstack)
		itemstack:clear()
	end
})


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
		"stm_nodes_boiler_pipe.png",
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
	sounds = default.node_sound_metal_defaults()
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
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:stand", {
	description = "Tin Machinery Stand",
	tiles = {
		"stm_nodes_tin2.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{0.1875, -0.5, 0.1875, 0.5, -0.375, 0.5}, -- NodeBox2
			{-0.5, -0.5, -0.5, -0.1875, -0.375, -0.1875}, -- NodeBox3
			{-0.5, -0.5, 0.1875, -0.1875, -0.375, 0.5}, -- NodeBox4
			{0.1875, -0.5, -0.5, 0.4375, -0.375, -0.1875}, -- NodeBox5
			{-0.4375, -0.4375, -0.4375, -0.1875, 0.4375, -0.1875}, -- NodeBox6
			{0.1875, -0.5, 0.1875, 0.4375, 0.4375, 0.4375}, -- NodeBox7
			{-0.4375, -0.5, 0.1875, -0.1875, 0.4375, 0.4375}, -- NodeBox8
			{0.1875, -0.5, -0.4375, 0.4375, 0.4375, -0.1875}, -- NodeBox9
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375}, -- NodeBox10
		}
	},
	groups = {cracky=1,},
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:stand2", {
	description = "Copper Machinery Stand",
	tiles = {
		"stm_nodes_copper2.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{0.1875, -0.5, 0.1875, 0.5, -0.375, 0.5}, -- NodeBox2
			{-0.5, -0.5, -0.5, -0.1875, -0.375, -0.1875}, -- NodeBox3
			{-0.5, -0.5, 0.1875, -0.1875, -0.375, 0.5}, -- NodeBox4
			{0.1875, -0.5, -0.5, 0.4375, -0.375, -0.1875}, -- NodeBox5
			{-0.4375, -0.4375, -0.4375, -0.1875, 0.4375, -0.1875}, -- NodeBox6
			{0.1875, -0.5, 0.1875, 0.4375, 0.4375, 0.4375}, -- NodeBox7
			{-0.4375, -0.5, 0.1875, -0.1875, 0.4375, 0.4375}, -- NodeBox8
			{0.1875, -0.5, -0.4375, 0.4375, 0.4375, -0.1875}, -- NodeBox9
			{-0.4375, 0.375, -0.4375, 0.4375, 0.4375, 0.4375}, -- NodeBox10
		}
	},
	groups = {cracky=1,},
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:pipe", {
	description = "Pipe",
	tiles = {
		"stm_nodes_pipe_top.png",
		"stm_nodes_pipe_top.png",
		"stm_nodes_pipe.png",
	},
	paramtype2 = "facedir",
	groups = {cracky=1, ventilation=1, pressure=1},
	on_place = minetest.rotate_node,
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:pipe_lid", {
	description = "Pipe Cover",
	tiles = {
		"stm_nodes_pipe_closed.png",
		"stm_nodes_pipe_closed.png",
		"stm_nodes_pipe.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, ventilation=1, pressure=1},
	on_place = minetest.rotate_node,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.4375, 0.375, -0.3125, 0.4375}, -- NodeBox1
			{-0.4375, -0.5, -0.375, 0.4375, -0.3125, 0.375}, -- NodeBox2
		}
	},
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:graveller", {
	description = "Stone Grinder",
	tiles = {
		"stm_nodes_graveller_top.png",
		"stm_nodes_graveller_top.png",
		"stm_nodes_graveller.png",
		"stm_nodes_graveller.png",
		"stm_nodes_graveller_front.png",
		"stm_nodes_graveller_front.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, machine = 1},
	on_punch = function(pos, node)
		minetest.set_node(pos, {name="stm_nodes:graveller_active", param2=node.param2})
	end,
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:graveller_active", {
	tiles = {
		"stm_nodes_graveller_top.png",
		"stm_nodes_graveller_top.png",
		"stm_nodes_graveller_active.png",
		"stm_nodes_graveller_active.png",
		"stm_nodes_graveller_back.png",
		"stm_nodes_graveller_back.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, machine = 1},
	drop = "stm_nodes:graveller",
	on_punch = function(pos, node)
		minetest.set_node(pos, {name="stm_nodes:graveller", param2=node.param2})
	end,
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:output_tray", {
	description = "Collection Tray",
	tiles = {
		"stm_nodes_tin.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, -- NodeBox21
			{-0.5, -0.5, 0.4375, 0.5, -0.125, 0.5}, -- NodeBox22
			{-0.5, -0.5, -0.5, 0.5, -0.125, -0.4375}, -- NodeBox23
			{0.4375, -0.5, -0.5, 0.5, -0.125, 0.5}, -- NodeBox24
			{-0.5, -0.5, -0.5, -0.4375, -0.125, 0.5}, -- NodeBox25
		}
	},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults()
})

minetest.register_abm({
	nodenames = {"stm_nodes:graveller_active"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local input_pos = {x=pos.x, y=pos.y+1, z=pos.z}
		local output_pos = minetest.find_node_near(pos, 1.5, {"stm_nodes:output_tray"})
		local n = {
			{x=pos.x+1, y=pos.y, z=pos.z},
			{x=pos.x-1, y=pos.y, z=pos.z},
			{x=pos.x, y=pos.y, z=pos.z+1},
			{x=pos.x, y=pos.y, z=pos.z-1},
			{x=pos.x, y=pos.y+1, z=pos.z},
		}
		local vent_pos = nil
		
		for _, position in ipairs(n) do
			local item = minetest.get_node(position).name
			if minetest.get_item_group(item, "ventilation") ~= 0 then
				vent_pos = position
			end
		end
		if vent_pos ~= nil then
		if minetest.get_node(input_pos).name == "stm_nodes:hopper" then
			local objects = minetest.get_objects_inside_radius(input_pos, 0.5)
			for _, obj in ipairs(objects) do
				if obj:get_luaentity().name == "__builtin:item" then
					local input_item = obj:get_luaentity().itemstring
					local itemname = ItemStack(input_item):get_name()
					local itemcount = ItemStack(input_item):get_count()
					if minetest.get_item_group(itemname, "cracky") ~= 0 then
						obj:remove()
						minetest.add_particlespawner({
							amount = 4,
							time = itemcount/2,
							minpos = {x=vent_pos.x-0.1, y=vent_pos.y+0.8, z=vent_pos.z-0.1},
							maxpos = {x=vent_pos.x+0.1, y=vent_pos.y+1, z=vent_pos.z+0.1},
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
						minetest.after(itemcount/2, function()
						minetest.add_item(output_pos, "default:gravel "..itemcount)
						end)
					end					
				end
			end
		end
		end
	end
})