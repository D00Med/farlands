minetest.register_node("decoblocks:old_stone_tiles", {
	description = "Old Stone Tiles",
	tiles = {"decoblocks_old_stone_tiles.png"},
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("decoblocks:old_stone_tiles_with_dirt", {
	description = "Old Stone Tiles With Dirt",
	tiles = {"decoblocks_old_stone_tiles_with_dirt.png"},
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("decoblocks:moss_stonebrick", {
	description = "Mossy Stone Brick",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"decoblocks_moss_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("decoblocks:scarecrow", {
	description = "Scarecrow",
	drawtype = "mesh",
	mesh = "scarecrow.obj",
	paramtype2 = "facedir",
	tiles = {
		"decoblocks_scarecrow.png",
	},
	visual_scale = 0.5,
	wield_image = "decoblocks_scarecrow_item.png",
	wield_scale = {x=1.0, y=1.0, z=1.0},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3}
	},
	inventory_image = "decoblocks_scarecrow_item.png",
	groups = {choppy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults()
})


minetest.register_node("decoblocks:hanging_flower", {
	description = "Hanging Flower",
	drawtype = "mesh",
	mesh = "hangingflower.obj",
	tiles = {
		"hanging_flower.png",
	},
	visual_scale = 0.5,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 1, 0.3}
	},
	inventory_image = "hanging_flower_item.png",
	groups = {choppy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults()
})


minetest.register_node("decoblocks:human_skull", {
	description = "Human Skull",
	drawtype = "mesh",
	mesh = "human_skull.obj",
	tiles = {
		"human_skull.png",
	},
	visual_scale = 0.5,
	wield_image = "decoblocks_skull_item.png",
	wield_scale = {x=1.0, y=1.0, z=1.0},
	paramtype = "light",
	paramtype2 = "facedir",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.0, 0.3}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.0, 0.3}
	},
	inventory_image = "decoblocks_skull_item.png",
	groups = {choppy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults()
})


minetest.register_node("decoblocks:vase", {
	description = "Vase",
	drawtype = "mesh",
	mesh = "vase.obj",
	tiles = {
		"vase.png",
	},
	visual_scale = 0.5,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {cracky = 2, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_node("decoblocks:Ancient_vase", {
	description = "Ancient Vase",
	drawtype = "mesh",
	mesh = "vase.obj",
	tiles = {
		"Ancient_vase.png",
	},
	visual_scale = 0.5,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("decoblocks:dartblock", {
	description = "Dart Trap",
	tiles = {
		"decoblocks_dartblock_top.png",
		"decoblocks_dartblock_top.png",
		"decoblocks_dartblock_sides.png",
		"decoblocks_dartblock_sides.png",
		"decoblocks_dartblock_sides.png",
		"decoblocks_dartblock_front.png",
	},
	groups = {cracky = 1,},
	paramtype2 = "facedir",
	drop = "decoblocks:dart_item2 5"
})

minetest.register_entity("decoblocks:dart", {
	visual = "cube",
	textures = {
	"decoblocks_dart.png",
	"decoblocks_dart.png",
	"decoblocks_dart.png",
	"decoblocks_dart.png",
	"decoblocks_dart.png",
	"decoblocks_dart.png",
	},
	visual_size={x=0.1,y=0.1},
	collisionbox = {0, 0, 0, 0, 0, 0},
	physical = false,
	automatic_rotate = true,
	automatic_face_movement_dir = 0,
	on_activate = function(self)
		minetest.after(3, function()
			self.object:remove()
		end)
	end,
	on_step = function(self, dtime)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y-0.5,z=pos.z}, 0.5)	
			for k, obj in pairs(objs) do
				if obj:is_player() then
					obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=3},
						}, nil)
						self.object:remove()
				end
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "decoblocks:dart" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=3},
						}, nil)
						self.object:remove()
					end
				end
			end
	end
})

minetest.register_entity("decoblocks:dart2", {
	visual = "cube",
	textures = {
	"decoblocks_dart2.png",
	"decoblocks_dart2.png",
	"decoblocks_dart2.png",
	"decoblocks_dart2.png",
	"decoblocks_dart2.png",
	"decoblocks_dart2.png",
	},
	visual_size={x=0.1,y=0.1},
	collisionbox = {0, 0, 0, 0, 0, 0},
	physical = false,
	automatic_rotate = true,
	automatic_face_movement_dir = 0,
	on_activate = function(self)
		minetest.after(3, function()
			self.object:remove()
		end)
	end,
	on_step = function(self, dtime)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y-0.5,z=pos.z}, 0.5)	
			for k, obj in pairs(objs) do
				if obj:is_player() then
					obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=3},
						}, nil)
					minetest.after(1, function()
					if obj:is_player() ~= nil then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=3},
						}, nil)
					end
					end)
					minetest.after(2, function()
					if obj:is_player() ~= nil then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=3},
						}, nil)
					end
					end)
					minetest.after(3, function()
					if obj:is_player() ~= nil then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=3},
						}, nil)
					end
					end)
						self.object:remove()
				end
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "decoblocks:dart" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=3},
						}, nil)
						minetest.after(1, function()
						if obj:get_luaentity() ~= nil then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=3},
						}, nil)
						end
						end)
						minetest.after(2, function()
						if obj:get_luaentity() ~= nil then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=3},
						}, nil)
						end
						end)
						minetest.after(3, function()
						if obj:get_luaentity() ~= nil then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=3},
						}, nil)
						end
						end)
						self.object:remove()
					end
				end
			end
	end
})

minetest.register_abm({
	nodenames = {"decoblocks:dartblock"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local x = 0
		local z = 0
		if node.param2 == 0 then
			z = -1
		elseif node.param2 == 2 then
			z = 1
		elseif node.param2 == 1 then
			x = -1
		elseif node.param2 == 3 then
			x = 1
		end
		--minetest.chat_send_all(node.param2)
		local numbers = {
		{1},
		{2},
		{3},
		{4},
		}
		for _, number in ipairs(numbers) do
		local num = number[1]
		local objs = minetest.get_objects_inside_radius({x=pos.x+x*num, y=pos.y, z=pos.z+z*num}, 1)
		for _, obj in ipairs(objs) do
			if obj:is_player() then
				local ent = minetest.env:add_entity(pos, "decoblocks:dart")
				ent:setvelocity({x=7*x, y=0, z=7*z})
			end
		end
		end
	end
})

minetest.register_node("decoblocks:spikes", {
	description = "Spikes",
	drawtype = "firelike",
	tiles = {
		"decoblocks_spikes.png"
	},
	wield_image = "decoblocks_spikes.png",
	inventory_image = "decoblocks_spikes.png",
	groups = {cracky=3},
	paramtype = "light",
	walkable = false,
	damage_per_second = 3,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3, 0.5}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}
	}
})

minetest.register_node("decoblocks:crumblestone", {
	description = "Crumbly Stone",
	tiles = {"default_stone.png"},
	groups = {crumbly = 1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_abm({
	nodenames = {"decoblocks:crumblestone"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local objs = minetest.get_objects_inside_radius({x=pos.x, y=pos.y+0.5, z=pos.z}, 0.5)
		for _, obj in ipairs(objs) do
			if obj:is_player() then
			minetest.add_particlespawner({
			amount = 13,
			time = 1,
			minpos = {x=pos.x-0.2, y=pos.y, z=pos.z-0.2},
			maxpos = {x=pos.x+0.2, y=pos.y+1, z=pos.z+0.2},
			minvel = {x=-0.1, y=-1, z=-0.1},
			maxvel = {x=0.1, y=-2, z=0.1},
			minacc = {x=0, y=-0.5, z=0},
			maxacc = {x=0, y=-1, z=0},
			minexptime = 1,
			maxexptime = 2,
			minsize = 1,
			maxsize = 2,
			collisiondetection = true,
			texture = "default_stone.png"
			})
				minetest.set_node(pos, {name = "air"})
				
			end
		end
	end
})

minetest.register_tool("decoblocks:blowpipe", {
	description = "Dart Blow Pipe",
	inventory_image = "decoblocks_blowdart.png",
	on_use = function(itemstack, placer)
		local dir = placer:get_look_dir()
		local pos = placer:getpos()
		local pname = placer:get_player_name();
		inv = minetest.get_inventory({type="player", name=pname})
		if inv:contains_item("main", "decoblocks:dart_item2") then
		local ent = minetest.env:add_entity({x=pos.x+1*dir.x, y=pos.y+1.5, z=pos.z+1*dir.z}, "decoblocks:dart2")
		ent:setvelocity({x=15*dir.x, y=15*dir.y, z=15*dir.z})
		local remov = inv:remove_item("main", "decoblocks:dart_item2")
		elseif inv:contains_item("main", "decoblocks:dart_item") then
		local ent = minetest.env:add_entity({x=pos.x+1*dir.x, y=pos.y+1.5, z=pos.z+1*dir.z}, "decoblocks:dart")
		ent:setvelocity({x=15*dir.x, y=15*dir.y, z=15*dir.z})
		local remov = inv:remove_item("main", "decoblocks:dart_item")
		end
	end,
})

minetest.register_craftitem("decoblocks:dart_item", {
	description = "Dart",
	inventory_image = "decoblocks_dart_item.png",
})

minetest.register_craftitem("decoblocks:dart_item2", {
	description = "Dart",
	inventory_image = "decoblocks_dart_item2.png",
})

minetest.register_node("decoblocks:old_skeleton", {
	description = "Old Human Skeleton",
	drawtype = "mesh",
	mesh = "old_skeleton.obj",
	tiles = {
		"old_skeleton.png",
	},
	visual_scale = 0.5,
	wield_image = "decoblocks_skull_item.png",
	wield_scale = {x=1.0, y=1.0, z=1.0},
	paramtype = "light",
	paramtype2 = "facedir",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.0, 0.3}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.0, 0.3}
	},
	inventory_image = "decoblocks_skull_item.png",
	groups = {choppy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults()
})


minetest.register_node("decoblocks:candle", {
	description = "Candle",
	drawtype = "mesh",
	mesh = "candle.obj",
	tiles = {
		"decoblocks_candle.png",
	},
	visual_scale = 0.5,
	wield_image = "decoblocks_candle_item.png",
	wield_scale = {x=1.0, y=1.0, z=1.0},
	paramtype = "light",
	paramtype2 = "facedir",
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.0, 0.3}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.0, 0.3}
	},
	inventory_image = "decoblocks_candle_item.png",
	groups = {choppy = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("decoblocks:paper_lantern", {
	description = "Paper Lantern",
	tiles = {"decoblocks_paper_lantern_top.png", "decoblocks_paper_lantern_top.png", "decoblocks_paper_lantern.png"},
	paramtype = "light",
	light_source = 13,
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

})