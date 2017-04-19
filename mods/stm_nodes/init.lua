
minetest.register_node("stm_nodes:reactor", {
	description = "Reactor (for testing)",
	tiles = {
		"stm_nodes_reactor.png",
	},
	on_rightclick = function(pos, node)
		minetest.set_node(pos, {name="stm_nodes:reactor_active"})
	end,
	groups = {cracky=1, electric=1},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("stm_nodes:reactor_active", {
	tiles = {
		"stm_nodes_reactor_active.png",
	},
	on_rightclick = function(pos, node)
		minetest.set_node(pos, {name="stm_nodes:reactor"})
	end,
	paramtype = "light",
	light_source = 10,
	drop = "stm_nodes:reactor",
	groups = {cracky=1, electric=1},
	sounds = default.node_sound_metal_defaults(),
})

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
	groups = {cracky=1, ventilation=1,},
	on_place = minetest.rotate_node,
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:pipe_active", {
	tiles = {
		"stm_nodes_pipe_top.png",
		"stm_nodes_pipe_top.png",
		"stm_nodes_pipe.png",
	},
	paramtype2 = "facedir",
	drop = "stm_nodes:pipe",
	groups = {cracky=1, ventilation=1, pressure=1},
	on_place = minetest.rotate_node,
	sounds = default.node_sound_metal_defaults()
})

minetest.register_abm({
	nodenames = {"stm_nodes:pipe"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local steam_source = minetest.find_node_near(pos, 1, {"default:furnace_active2", "stm_nodes:pipe_active", "stm_nodes:reactor_active"})
			if steam_source then
				minetest.set_node(pos, {name="stm_nodes:pipe_active", param2=node.param2})
			end
		local boiler_output = minetest.find_node_near(pos, 1, {"stm_nodes:boiler_output"})
		if boiler_output and minetest.get_item_group(minetest.get_node({x=boiler_output.x, y=boiler_output.y-1, z=boiler_output.z}).name, "boiler") ~= 0 then
			local heat = minetest.find_node_near({x=boiler_output.x, y=boiler_output.y-2, z=boiler_output.z}, 1, {"stm_nodes:furnace_active", "default:furnace_active2"})
			if heat then
				minetest.set_node(pos, {name="stm_nodes:pipe_active", param2=node.param2})
			end
		end
	end
})

minetest.register_abm({
	nodenames = {"stm_nodes:pipe_active"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
				minetest.set_node(pos, {name="stm_nodes:pipe", param2=node.param2})
	end
})

minetest.register_abm({
	nodenames = {"stm_nodes:pipe"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local furnace = minetest.find_node_near(pos, 1, {"default:furnace_active2"})
			if furnace then
				minetest.set_node(pos, {name="stm_nodes:pipe_active", param2=node.param2})
			end
	end
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
		local steam_source = minetest.find_node_near(pos, 1, {"stm_nodes:pipe_active", "default:furnace_active2"})

		if steam_source == nil then
		return
		end

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
				if not obj:is_player() and obj:get_luaentity().name == "__builtin:item" then
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
						minetest.sound_play("default_place_node_metal", {pos = pos, gain = 0.3, max_hear_distance = 16})
						end)
					end
				end
			end
		end
		end
	end
})

minetest.register_node("stm_nodes:compressor_open", {
	description = "Compressor",
	tiles = {
		"stm_nodes_compressor_top.png",
		"stm_nodes_compressor_bottom.png",
		"stm_nodes_compressor_side.png",
		"stm_nodes_compressor_side.png",
		"stm_nodes_compressor_side.png",
		"stm_nodes_compressor_side.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, 0.4375}, -- NodeBox4
			{-0.5, 0.25, -0.5, 0.5, 0.5, -0.4375}, -- NodeBox5
			{-0.5, 0.25, 0.4375, 0.5, 0.5, 0.5}, -- NodeBox6
			{0.4375, 0.25, -0.5, 0.5, 0.5, 0.5}, -- NodeBox7
			{-0.5, 0.25, -0.5, -0.4375, 0.5, 0.5}, -- NodeBox8
			{-0.4375, 0.25, -0.4375, 0.4375, 0.4375, 0.4375}, -- NodeBox9
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, 0.4375}, -- NodeBox4
			{-0.5, 0.25, -0.5, 0.5, 0.5, -0.4375}, -- NodeBox5
			{-0.5, 0.25, 0.4375, 0.5, 0.5, 0.5}, -- NodeBox6
			{0.4375, 0.25, -0.5, 0.5, 0.5, 0.5}, -- NodeBox7
			{-0.5, 0.25, -0.5, -0.4375, 0.5, 0.5}, -- NodeBox8
			--{-0.4375, 0.25, -0.4375, 0.4375, 0.4375, 0.4375}, -- NodeBox9
		}
	},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults()
})

local compressor_function = function(pos)
	minetest.after(0.5, function()
		local steam_source = minetest.find_node_near(pos, 1, "stm_nodes:pipe_active")
		if steam_source ~= nil then
			minetest.set_node(pos, {name="stm_nodes:compressor_closed"})
			minetest.sound_play("default_place_node_metal", {pos = pos, gain = 0.3, max_hear_distance = 16})
		end
	end)
end

local closed_compressor_function = function(pos)
			local objects = minetest.get_objects_inside_radius(pos, 0.5)
			for _, obj in ipairs(objects) do
				if obj:get_luaentity().name == "__builtin:item" then
					local input_item = obj:get_luaentity().itemstring
					local itemname = ItemStack(input_item):get_name()
					local itemcount = ItemStack(input_item):get_count()
					if itemname == "default:papyrus" then
						obj:remove()
						minetest.after(1, function()
						minetest.add_item(pos, "default:paper "..itemcount)
						end)
					end
					if itemname == "default:gravel" then
						obj:remove()
						minetest.after(1, function()
						minetest.add_item(pos, "default:stone "..itemcount)
						end)
					end
					if itemname == "default:dirt" then
						obj:remove()
						minetest.after(1, function()
						minetest.add_item(pos, "mapgen:coarse_dirt "..itemcount)
						end)
					end
				end
			end
			minetest.after(1, function()
				minetest.set_node(pos, {name="stm_nodes:compressor_open"})
				minetest.sound_play("default_metal_footstep", {pos = pos, gain = 0.3, max_hear_distance = 16})
			end)
end

minetest.register_node("stm_nodes:compressor_closed", {
	tiles = {
		"stm_nodes_compressor_top.png",
		"stm_nodes_compressor_bottom.png",
		"stm_nodes_compressor_side.png",
		"stm_nodes_compressor_side.png",
		"stm_nodes_compressor_side.png",
		"stm_nodes_compressor_side.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, 0.4375}, -- NodeBox4
			{-0.5, 0.25, -0.5, 0.5, 0.5, -0.4375}, -- NodeBox5
			{-0.5, 0.25, 0.4375, 0.5, 0.5, 0.5}, -- NodeBox6
			{0.4375, 0.25, -0.5, 0.5, 0.5, 0.5}, -- NodeBox7
			{-0.5, 0.25, -0.5, -0.4375, 0.5, 0.5}, -- NodeBox8
			{-0.4375, -0.4375, -0.4375, 0.4375, 0.4375, 0.4375}, -- NodeBox9
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, 0.4375}, -- NodeBox4
			{-0.5, 0.25, -0.5, 0.5, 0.5, -0.4375}, -- NodeBox5
			{-0.5, 0.25, 0.4375, 0.5, 0.5, 0.5}, -- NodeBox6
			{0.4375, 0.25, -0.5, 0.5, 0.5, 0.5}, -- NodeBox7
			{-0.5, 0.25, -0.5, -0.4375, 0.5, 0.5}, -- NodeBox8
			--{-0.4375, 0.25, -0.4375, 0.4375, 0.4375, 0.4375}, -- NodeBox9
		}
	},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("stm_nodes:lever_open", {
	tiles = {
		"stm_nodes_lever_top.png",
		"stm_nodes_lever_top.png",
		"stm_nodes_lever_side.png",
		"stm_nodes_lever_side.png^[transformFX",
		"stm_nodes_lever_back.png",
		"stm_nodes_lever_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.125, -0.0625, 0.0625, 0, 0.5}, -- NodeBox1
			{-0.0625, -0.125, -0.0625, 0.0625, 0.4375, 0.0625}, -- NodeBox2
			{-0.125, 0.125, -0.125, 0.125, 0.375, -0.0625}, -- NodeBox3
			{-0.0625, -0.125, -0.125, 0.0625, 0.3125, -0.0625}, -- NodeBox4
		}
	},
	on_rightclick = function(pos, node)
		minetest.set_node(pos, {name="stm_nodes:lever_closed", param2=node.param2})
	end,
	groups = {cracky=1,},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_abm({
	nodenames = {"stm_nodes:lever_open"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local compressor = minetest.find_node_near(pos, 2, {"stm_nodes:compressor_open"})
			if compressor then
				compressor_function(compressor)
			end
		local compressor_closed = minetest.find_node_near(pos, 2, {"stm_nodes:compressor_closed"})
			if compressor_closed then
				closed_compressor_function(compressor_closed)
			end
	end
})

minetest.register_node("stm_nodes:lever_closed", {
	description = "Lever",
	tiles = {
		"stm_nodes_lever_top.png",
		"stm_nodes_lever_top.png",
		"stm_nodes_lever_side.png",
		"stm_nodes_lever_side.png^[transformFX",
		"stm_nodes_lever_back.png",
		"stm_nodes_lever_front2.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.125, -0.0625, 0.0625, 0, 0.5}, -- NodeBox1
			{-0.0625, -0.125, -0.0625, 0.0625, 0.4375, 0.0625}, -- NodeBox2
			{-0.125, 0.125, -0.125, 0.125, 0.375, -0.0625}, -- NodeBox3
			{-0.0625, 0.1875, -0.125, 0.375, 0.3125, -0.0625}, -- NodeBox4
		}
	},
	on_rightclick = function(pos, node)
		minetest.set_node(pos, {name="stm_nodes:lever_open", param2=node.param2})
	end,
	groups = {cracky=1,},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("stm_nodes:cable", {
	description = "Floor Cable",
	tiles = {
		"stm_nodes_cable.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	connects_to = {"group:cable", "group:electric"},
	node_box = {
		type = "connected",
		fixed = {
			{-0.0625, -0.5, -0.0625, 0.0625, -0.375, 0.0625}, -- NodeBox1
		},
		connect_front = {
			{-0.0625, -0.5, -0.5, 0.0625, -0.375, 0.0625}, -- NodeBox1
		},
		connect_back = {
			{-0.0625, -0.5, -0.0625, 0.0625, -0.375, 0.5}, -- NodeBox1
		},
		connect_left = {
			{-0.5, -0.5, -0.0625, 0.0625, -0.375, 0.0625}, -- NodeBox1
		},
		connect_right = {
			{-0.0625, -0.5, -0.0625, 0.5, -0.375, 0.0625}, -- NodeBox1
		},
		connect_top = {
			{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox1
		}
	},
	groups = {cracky=1, cable=1},
	sounds = default.node_sound_defaults()
})

minetest.register_node("stm_nodes:cable_active", {
	tiles = {
		"stm_nodes_cable.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	connects_to = {"group:cable", "group:electric"},
	node_box = {
		type = "connected",
		fixed = {
			{-0.0625, -0.5, -0.0625, 0.0625, -0.375, 0.0625}, -- NodeBox1
		},
		connect_front = {
			{-0.0625, -0.5, -0.5, 0.0625, -0.375, 0.0625}, -- NodeBox1
		},
		connect_back = {
			{-0.0625, -0.5, -0.0625, 0.0625, -0.375, 0.5}, -- NodeBox1
		},
		connect_left = {
			{-0.5, -0.5, -0.0625, 0.0625, -0.375, 0.0625}, -- NodeBox1
		},
		connect_right = {
			{-0.0625, -0.5, -0.0625, 0.5, -0.375, 0.0625}, -- NodeBox1
		},
		connect_top = {
			{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox1
		}
	},
	drop = "stm_nodes:cable",
	groups = {cracky=1, cable=1, electric=2},
	sounds = default.node_sound_defaults()
})

minetest.register_node("stm_nodes:cable_ceiling", {
	description = "Ceiling Cable",
	tiles = {
		"stm_nodes_cable.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	connects_to = {"group:cable", "group:electric"},
	node_box = {
		type = "connected",
		fixed = {
			{-0.0625, 0.375, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox1
		},
		connect_front = {
			{-0.0625, 0.375, -0.5, 0.0625, 0.5, 0.0625}, -- NodeBox1
		},
		connect_back = {
			{-0.0625, 0.375, -0.0625, 0.0625, 0.5, 0.5}, -- NodeBox1
		},
		connect_left = {
			{-0.5, 0.375, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox1
		},
		connect_right = {
			{-0.0625, 0.375, -0.0625, 0.5, 0.5, 0.0625}, -- NodeBox1
		},
		connect_bottom = {
			{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox1
		}
	},
	groups = {cracky=1, cable=1},
	sounds = default.node_sound_defaults()
})

minetest.register_node("stm_nodes:cable_ceiling_active", {
	tiles = {
		"stm_nodes_cable.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	connects_to = {"group:cable", "group:electric"},
	node_box = {
		type = "connected",
		fixed = {
			{-0.0625, 0.375, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox1
		},
		connect_front = {
			{-0.0625, 0.375, -0.5, 0.0625, 0.5, 0.0625}, -- NodeBox1
		},
		connect_back = {
			{-0.0625, 0.375, -0.0625, 0.0625, 0.5, 0.5}, -- NodeBox1
		},
		connect_left = {
			{-0.5, 0.375, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox1
		},
		connect_right = {
			{-0.0625, 0.375, -0.0625, 0.5, 0.5, 0.0625}, -- NodeBox1
		},
		connect_bottom = {
			{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox1
		}
	},
	drop = "stm_nodes:cable_ceiling",
	groups = {cracky=1, cable=1, electric=2},
	sounds = default.node_sound_defaults()
})


minetest.register_abm({
	nodenames = {"stm_nodes:cable"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local power = minetest.find_node_near(pos, 1, {"stm_nodes:reactor_active", "stm_nodes:cable_active", "stm_nodes:cable_ceiling_active", "stm_nodes:generator_active"})
			if power then
				minetest.set_node(pos, {name="stm_nodes:cable_active", param2=node.param2})
			end
	end
})

minetest.register_abm({
	nodenames = {"stm_nodes:cable_active"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		minetest.set_node(pos, {name="stm_nodes:cable", param2=node.param2})
	end
})

minetest.register_abm({
	nodenames = {"stm_nodes:cable_ceiling"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local power = minetest.find_node_near(pos, 1, {"stm_nodes:reactor_active", "stm_nodes:cable_active", "stm_nodes:cable_ceiling_active", "stm_nodes:generator_active"})
			if power then
				minetest.set_node(pos, {name="stm_nodes:cable_ceiling_active", param2=node.param2})
			end
	end
})

minetest.register_abm({
	nodenames = {"stm_nodes:cable_ceiling_active"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		minetest.set_node(pos, {name="stm_nodes:cable_ceiling", param2=node.param2})
	end
})

minetest.register_node("stm_nodes:big_vent", {
	description = "Fanned Vent",
	tiles = {
		"stm_nodes_block.png",
		"stm_nodes_block.png",
		"stm_nodes_block.png",
		"stm_nodes_block.png",
		"stm_nodes_block.png",
		"stm_nodes_vent.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.4375, 0, 0.5, 0.4375, 0.5}, -- NodeBox1
			{-0.4375, -0.5, 0, 0.4375, 0.5, 0.5}, -- NodeBox2
			{-0.5, -0.4375, -0.0625, -0.4375, 0.4375, 0}, -- NodeBox3
			{0.4375, -0.4375, -0.0625, 0.5, 0.4375, 0}, -- NodeBox5
			{-0.4375, 0.4375, -0.0625, 0.4375, 0.5, 0}, -- NodeBox6
			{-0.4375, -0.5, -0.0625, 0.4375, -0.4375, 0}, -- NodeBox7
		}
	},
	groups = {cracky=1, ventilation=1},
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:coal_feed", {
	description = "Coal Feeder",
	tiles = {
		"stm_nodes_block.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, -0.4375}, -- NodeBox16
			{-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5}, -- NodeBox17
			{-0.5, -0.5, -0.5, -0.4375, 0.5, 0.5}, -- NodeBox18
			{0.4375, -0.5, -0.5, 0.5, 0.5, 0.5}, -- NodeBox19
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, -- NodeBox20
		}
	},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults()
})

local check_for_coal = function(pos)
	local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)
	local objects = minetest.get_objects_inside_radius(pos, 0.5)
	local item_taken = false
	for _, obj in ipairs(objects) do
		if not obj:is_player() and obj:get_luaentity().name == "__builtin:item" and not item_taken then
			local itemstring = obj:get_luaentity().itemstring
			local item = ItemStack(itemstring):get_name()
			local count = ItemStack(itemstring):get_count()
			local new_count = count-1
			if ItemStack(itemstring):get_count() < 1 then
				obj:remove()
			end
			if item == "default:coal_lump" or item == "default:coalblock" then
				obj:get_luaentity().itemstring = item.." "..new_count
				item_taken = true
			end
		end
	end
	return item_taken
end

minetest.register_node("stm_nodes:machinery_base", {
	description = "Machinery Base Block",
	tiles = {
	"stm_nodes_block.png",
	},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:furnace_active", {
	tiles = {{
		name = "stm_nodes_furnace_core2.png",
		animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.5},
	}},
	paramtype = "light",
	light_source = 12,
	groups = {cracky=1},
	damage_per_second = 1,
	drop = "stm_nodes:furnace",
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:furnace", {
	description = "Industrial Furnace Core",
	tiles = {
	"stm_nodes_furnace_core.png",
	},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults()
})

minetest.register_abm({
	nodenames = {"stm_nodes:furnace"},
	interval = 3,
	chance = 1,
	action = function(pos, node)
		local ventilation = minetest.find_node_near(pos, 1, {"stm_nodes:chimney", "stm_nodes:chimney2", "stm_nodes:big_vent"})
		local fuel = minetest.find_node_near(pos, 1, {"stm_nodes:coal_feed"})
		if ventilation and fuel and check_for_coal(fuel) then
		minetest.set_node(pos, {name="stm_nodes:furnace_active", param2=node.param2})
		minetest.add_particlespawner({
			amount = 4,
			time = 2,
			minpos = {x=ventilation.x-0.1, y=ventilation.y+0.8, z=ventilation.z-0.1},
			maxpos = {x=ventilation.x+0.1, y=ventilation.y+1, z=ventilation.z+0.1},
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

minetest.register_abm({
	nodenames = {"stm_nodes:furnace_active"},
	interval = 15,
	chance = 1,
	action = function(pos, node)
		local ventilation = minetest.find_node_near(pos, 1, {"stm_nodes:chimney", "stm_nodes:chimney2", "stm_nodes:big_vent"})
		local base = minetest.find_node_near({x=pos.x, y=pos.y-1, z=pos.z}, 1, {"stm_nodes:machinery_base", "stm_nodes:stand", "stm_nodes:stand2", "default:steelblock", "default:bronzeblock"})
		local fuel = minetest.find_node_near(pos, 1, {"stm_nodes:coal_feed"})
		if ventilation then
		minetest.add_particlespawner({
			amount = 4,
			time = 2,
			minpos = {x=ventilation.x-0.1, y=ventilation.y+0.8, z=ventilation.z-0.1},
			maxpos = {x=ventilation.x+0.1, y=ventilation.y+1, z=ventilation.z+0.1},
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
		if not base or not ventilation then
			tnt.boom(pos, {damage_radius=3,radius=2,ignore_protection=false, disable_playerdamage=false})
		end
		if not ventilation or not fuel or not check_for_coal(fuel) then
			minetest.set_node(pos, {name="stm_nodes:furnace", param2=node.param2})
		end
	end
})

minetest.register_node("stm_nodes:large_boiler_base", {
	description = "Large Boiler",
	tiles = {
		"stm_nodes_lboiler_bottom.png",
		"stm_nodes_lboiler_bottom.png",
		"stm_nodes_lboiler.png^[transformFY",
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, -0.4375, 0.375}, -- NodeBox7
			{-0.375, -0.4375, -0.4375, 0.375, -0.375, 0.4375}, -- NodeBox8
			{-0.4375, -0.4375, -0.375, 0.4375, -0.375, 0.375}, -- NodeBox9
			{-0.5, -0.375, -0.4375, 0.5, 0.5, 0.4375}, -- NodeBox10
			{-0.4375, -0.375, -0.5, 0.4375, 0.5, 0.5}, -- NodeBox11
		}
	},
	groups = {boiler=1, cracky=1,},
	sounds = default.node_sound_metal_defaults(),
	on_construct = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		if minetest.get_node(above).name ~= "air" then
			minetest.add_item(pos, "stm_nodes:large_boiler_base")
			minetest.remove_node(pos)
		else
			minetest.set_node(above, {name="stm_nodes:large_boiler_top"})
		end
	end,
	on_destruct = function(pos, oldnode)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		if minetest.get_node(above).name == "stm_nodes:large_boiler_top" then
			minetest.remove_node(above)
		end
	end,
})

minetest.register_node("stm_nodes:large_boiler_top", {
	tiles = {
		"stm_nodes_lboiler_top.png",
		"stm_nodes_lboiler_top.png",
		"stm_nodes_lboiler.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, 0.4375, -0.375, 0.375, 0.5, 0.375}, -- NodeBox7
			{-0.375, 0.375, -0.4375, 0.375, 0.4375, 0.4375}, -- NodeBox8
			{-0.4375, 0.375, -0.375, 0.4375, 0.4375, 0.375}, -- NodeBox9
			{-0.5, -0.5, -0.4375, 0.5, 0.375, 0.4375}, -- NodeBox10
			{-0.4375, -0.5, -0.5, 0.4375, 0.375, 0.5}, -- NodeBox11
		}
	},
	drop = "stm_nodes:large_boiler_base",
	groups = {cracky=1, boiler=1},
	sounds = default.node_sound_metal_defaults(),
	on_destruct = function(pos, oldnode)
		local under = {x=pos.x, y=pos.y-1, z=pos.z}
		minetest.after(0.4, function()
		if minetest.get_node(under).name == "stm_nodes:large_boiler_base" then
			minetest.remove_node(under)
		end
		end)
	end,
})

minetest.register_node("stm_nodes:boiler_output", {
	description = "Boiler Output",
	tiles = {
		"stm_nodes_graveller_front.png",
		"stm_nodes_graveller_front.png",
		"stm_nodes_boiler_output.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.3125, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.125, -0.5, -0.125, 0.125, -0.3125, 0.125}, -- NodeBox2
		}
	},
	groups = {cracky=1, pressure=2},
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:plate", {
	description = "Metal Plate",
	tiles = {
		"stm_nodes_plate.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, -- NodeBox1
		}
	},
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("stm_nodes:motor", {
	description = "Motor",
	tiles = {
		"stm_nodes_motor_top.png",
		"stm_nodes_motor_top.png",
		"stm_nodes_motor_side.png",
		"stm_nodes_motor_side.png",
		"stm_nodes_motor_front.png",
		"stm_nodes_motor_front.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.5, 0.375, 0.375, 0.5}, -- NodeBox1
			{-0.4375, -0.4375, -0.5, 0.4375, 0.3125, 0.5}, -- NodeBox2
		}
	},
	groups = {cracky=1, electric=1},
	sounds = default.node_sound_defaults()
})

minetest.register_node("stm_nodes:generator_core", {
	description = "Generator core",
	tiles = {
		"stm_nodes_generator_top.png",
		"stm_nodes_generator_bottom.png",
		"stm_nodes_generator_side.png",
		"stm_nodes_generator_side.png",
		"stm_nodes_generator_front.png",
		"stm_nodes_generator_back.png"
	},
	groups = {cracky=1, electric=1},
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:generator_active", {
	tiles = {
		"stm_nodes_generator_top.png",
		"stm_nodes_generator_bottom.png",
		"stm_nodes_generator_side.png",
		"stm_nodes_generator_side.png",
		"stm_nodes_generator_front.png",
		"stm_nodes_generator_back.png"
	},
	groups = {cracky=1, electric=2},
	drop = "stm_nodes:generator_core",
	sounds = default.node_sound_metal_defaults()
})

minetest.register_abm({
	nodenames = {"stm_nodes:generator_core"},
	interval = 4,
	chance = 1,
	action = function(pos, node)
		local motor = minetest.find_node_near(pos, 1, {"stm_nodes:motor",})
		local steam_input = minetest.find_node_near(pos, 1, {"stm_nodes:pipe_active", "stm_nodes_boiler_output"})
		if motor and steam_input then
		minetest.set_node(pos, {name="stm_nodes:generator_active", param2=node.param2})
		minetest.add_particlespawner({
			amount = 4,
			time = 2,
			minpos = {x=motor.x-0.1, y=motor.y+0.8, z=motor.z-0.1},
			maxpos = {x=motor.x+0.1, y=motor.y+1, z=motor.z+0.1},
			minvel = {x=-0.2, y=1, z=-0.2},
			maxvel = {x=0.2, y=3, z=0.2},
			minacc = {x=0, y=0.1, z=0},
			maxacc = {x=0, y=0.2, z=0},
			minexptime = 1,
			maxexptime = 2,
			minsize = 2,
			maxsize = 5,
			collisiondetection = false,
			vertical = false,
			texture = "stm_nodes_steam.png",
		})
		end
	end
})

minetest.register_abm({
	nodenames = {"stm_nodes:generator_active"},
	interval = 4,
	chance = 1,
	action = function(pos, node)
		local motor = minetest.find_node_near(pos, 1, {"stm_nodes:motor",})
		local steam_input = minetest.find_node_near(pos, 1, {"stm_nodes:pipe_active", "stm_nodes_boiler_output"})
		minetest.add_particlespawner({
			amount = 4,
			time = 2,
			minpos = {x=motor.x-0.1, y=motor.y+0.8, z=motor.z-0.1},
			maxpos = {x=motor.x+0.1, y=motor.y+1, z=motor.z+0.1},
			minvel = {x=-0.2, y=1, z=-0.2},
			maxvel = {x=0.2, y=3, z=0.2},
			minacc = {x=0, y=0.1, z=0},
			maxacc = {x=0, y=0.2, z=0},
			minexptime = 1,
			maxexptime = 2,
			minsize = 2,
			maxsize = 5,
			collisiondetection = false,
			vertical = false,
			texture = "stm_nodes_steam.png",
		})
		if not motor or not steam_input then
			minetest.after(5, function()
				if pos ~= nil then
				local motor = minetest.find_node_near(pos, 1, {"stm_nodes:motor",})
				local steam_input = minetest.find_node_near(pos, 1, {"stm_nodes:pipe_active", "stm_nodes_boiler_output"})
				minetest.set_node(pos, {name="stm_nodes:generator_core", param2=node.param2})
				end
			end)
		end
	end
})

--electric, right-click activated

minetest.register_node("stm_nodes:bulb", {
	description = "Lightbulb",
	tiles = {
		"stm_nodes_bulb.png",
	},
	drawtype = "plantlike",
	paramtype = "light",
	--light_source = 5,
	use_texture_alpha = true,
	groups = {cracky=1, oddly_breakeable_by_hand=1, electric=1},
	selection_box = {
		type = "fixed",
		fixed = {
		{-0.2,-0.5,-0.2,0.2,0,0.2}
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
		{-0.2,-0.5,-0.2,0.2,0,0.2}
		}
	},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node)
		if minetest.find_node_near(pos, 1, {"stm_nodes:cable_active", "stm_nodes:cable_ceiling_active"}) ~= nil then
		minetest.set_node(pos, {name="stm_nodes:bulb_active", param2=node.param2})
		end
	end,
})

minetest.register_node("stm_nodes:bulb_active", {
	tiles = {
		"stm_nodes_bulb_active.png",
	},
	drawtype = "plantlike",
	paramtype = "light",
	light_source = 8,
	use_texture_alpha = true,
	groups = {cracky=1, oddly_breakeable_by_hand=1, electric=1},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node)
		minetest.set_node(pos, {name="stm_nodes:bulb"})
	end,
	selection_box = {
		type = "fixed",
		fixed = {
		{-0.2,-0.5,-0.2,0.2,0,0.2}
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
		{-0.2,-0.5,-0.2,0.2,0,0.2}
		}
	},
	drop = "stm_nodes:bulb",
})

minetest.register_node("stm_nodes:conveyor", {
	description = "Conveyor Belt",
	tiles = {
		"stm_nodes_conveyor.png",
		"stm_nodes_conveyor.png",
		"stm_nodes_conveyor_side.png",
		"stm_nodes_conveyor_side.png",
		"stm_nodes_conveyor.png",
		"stm_nodes_conveyor.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.5, 0.4375, -0.1875, 0.5}, -- NodeBox1
			{-0.5, -0.5, 0.1875, 0.5, -0.25, 0.4375}, -- NodeBox2
			{-0.5, -0.5, -0.4375, 0.5, -0.25, -0.1875}, -- NodeBox3
			{-0.5, -0.5, -0.125, 0.5, -0.25, 0.125}, -- NodeBox4
		}
	},
	groups = {cracky=1,}
})
