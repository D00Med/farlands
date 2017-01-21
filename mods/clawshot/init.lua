

local function register_clawshot(name, desc, texture, texture2, speed, accel, timeout, time2)
	
	minetest.register_entity("clawshot:dummy", {
	visual = "sprite",
	textures = {"clawshot_trans.png"},
	physical = false,
	collisionbox = {0, 0, 0, 0.1, 0.1, 0.1},
	})
	
	minetest.register_entity("clawshot:"..name.."_chain", {
	visual = "mesh",
	mesh = "claw.b3d",
	textures = {texture2},
	velocity = 15,
	acceleration = -5,
	damage = 2,
	physical = false,
	collisionbox = {0, 0, 0, 0.1, 0.1, 0.1},
	on_step = function(self)		
		local remove_ent = minetest.after(timeout*2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius(pos, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= self.object:get_luaentity().name and obj:get_luaentity().name ~= "__builtin:item" and not obj:is_player() then
						obj:punch(self.object, 1.0, {
							full_punch_interval=2.0,
							damage_groups={fleshy=1},
						}, nil)
						local velo = self.object:getvelocity()
						self.object:setvelocity({x=-velo.x, y=-velo.y, z=-velo.z})
					end
				end
				
				end
		
		if minetest.get_item_group(minetest.get_node(pos).name, "hook") ~= 0 or minetest.get_item_group(minetest.get_node(pos).name, "choppy") ~= 0 then 
			local player = self.launcher
			local player_pos = player:getpos()
			local attach_obj = minetest.env:add_entity(player_pos, "clawshot:dummy")
			local obj = attach_obj:get_luaentity()
			local obj_pos = attach_obj:getpos()
			local vec = {x=pos.x-obj_pos.x, y=pos.y-obj_pos.y, z=pos.z-obj_pos.z}
			player:set_attach(obj.object, "", {x=0, y=0, z=0}, {x=0, y=0.9, z=0})
		
			if minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z}).name == "air" then
				attach_obj:setvelocity(vec)
				minetest.after(time2, function()
				attach_obj:remove()
				--self.launcher:setpos({x=pos.x+1, y=pos.y, z=pos.z})
				self.object:remove()
				end)
			elseif minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z}).name == "air" then
				attach_obj:setvelocity(vec)
				minetest.after(time2, function()
				attach_obj:remove()
				--self.launcher:setpos({x=pos.x-1, y=pos.y, z=pos.z})
				self.object:remove()
				attach_obj:remove()
				end)
			elseif minetest.get_node({x=pos.x, y=pos.y, z=pos.z+1}).name == "air" then
				attach_obj:setvelocity(vec)
				minetest.after(time2, function()
				attach_obj:remove()
				--self.launcher:setpos({x=pos.x, y=pos.y, z=pos.z+1})
				self.object:remove()
				attach_obj:remove()
				end)
			elseif minetest.get_node({x=pos.x, y=pos.y, z=pos.z-1}).name == "air" then
				attach_obj:setvelocity(vec)
				minetest.after(time2, function()
				attach_obj:remove()
				--self.launcher:setpos({x=pos.x, y=pos.y, z=pos.z-1})
				self.object:remove()
				attach_obj:remove()
				end)
			end
			self.object:remove()
		end
		
		local part = minetest.add_particlespawner(
			5, --amount
			0.2, --time
			{x=pos.x, y=pos.y, z=pos.z}, --minpos
			{x=pos.x, y=pos.y, z=pos.z}, --maxpos
			{x=0, y=0, z=0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=0,y=0,z=0}, --minacc
			{x=0,y=0,z=0}, --maxacc
			1, --minexptime
			1, --maxexptime
			1, --minsize
			1, --maxsize
			false, --collisiondetection
			"clawshot_chain.png" --texture
		)
	end,
	})
	
	minetest.register_entity("clawshot:"..name.."_chain2", {
	visual = "mesh",
	mesh = "claw.b3d",
	textures = {texture2},
	velocity = 15,
	acceleration = -5,
	damage = 2,
	physical = false,
	collisionbox = {0, 0, 0, 0.1, 0.1, 0.1},
	on_step = function(self)		
		local remove_ent = minetest.after(timeout*2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius(pos, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= self.object:get_luaentity().name and obj:get_luaentity().name ~= "__builtin:item" and not obj:is_player() then
						obj:punch(self.object, 1.0, {
							full_punch_interval=2.0,
							damage_groups={fleshy=1},
						}, nil)
						local velo = self.object:getvelocity()
						self.object:setvelocity({x=-velo.x, y=-velo.y, z=-velo.z})
					end
				end
				
				end
		
		if minetest.get_item_group(minetest.get_node(pos).name, "hook") ~= 0 or minetest.get_item_group(minetest.get_node(pos).name, "choppy") ~= 0 then 
			local player = self.launcher
			local player_pos = player:getpos()
			local attach_obj = minetest.env:add_entity(player_pos, "clawshot:dummy")
			local obj = attach_obj:get_luaentity()
			local obj_pos = attach_obj:getpos()
			local dir = player:get_look_dir()
			local vec = {x=pos.x+dir.x*2.5-obj_pos.x, y=0, z=pos.z+dir.z*2.5-obj_pos.z}
			player:set_attach(obj.object, "", {x=0, y=0, z=0}, {x=0, y=0.9, z=0})
		
			if minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z}).name == "air" then
				attach_obj:setvelocity(vec)
				minetest.after(time2, function()
				attach_obj:remove()
				--self.launcher:setpos({x=pos.x+1, y=pos.y, z=pos.z})
				self.object:remove()
				end)
			elseif minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z}).name == "air" then
				attach_obj:setvelocity(vec)
				minetest.after(time2, function()
				attach_obj:remove()
				--self.launcher:setpos({x=pos.x-1, y=pos.y, z=pos.z})
				self.object:remove()
				attach_obj:remove()
				end)
			elseif minetest.get_node({x=pos.x, y=pos.y, z=pos.z+1}).name == "air" then
				attach_obj:setvelocity(vec)
				minetest.after(time2, function()
				attach_obj:remove()
				--self.launcher:setpos({x=pos.x, y=pos.y, z=pos.z+1})
				self.object:remove()
				attach_obj:remove()
				end)
			elseif minetest.get_node({x=pos.x, y=pos.y, z=pos.z-1}).name == "air" then
				attach_obj:setvelocity(vec)
				minetest.after(time2, function()
				attach_obj:remove()
				--self.launcher:setpos({x=pos.x, y=pos.y, z=pos.z-1})
				self.object:remove()
				attach_obj:remove()
				end)
			end
			self.object:remove()
		end
		
		local part = minetest.add_particlespawner(
			5, --amount
			0.2, --time
			{x=pos.x, y=pos.y, z=pos.z}, --minpos
			{x=pos.x, y=pos.y, z=pos.z}, --maxpos
			{x=0, y=0, z=0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=0,y=0,z=0}, --minacc
			{x=0,y=0,z=0}, --maxacc
			1, --minexptime
			1, --maxexptime
			1, --minsize
			1, --maxsize
			false, --collisiondetection
			"clawshot_chain.png" --texture
		)
	end,
	})
	
	
	minetest.register_tool("clawshot:"..name, {
	description = desc,
	inventory_image = texture,
	wield_scale = {x = 1.5, y = 1.5, z = 1},
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=1},
	},
	on_use = function(item, placer, pointed_thing)
			local dir = placer:get_look_dir();
			local playerpos = placer:getpos();
			local ctrl = placer:get_player_control()
			local obj = {}
			if not ctrl.sneak then
			obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+1.4+dir.y,z=playerpos.z+0+dir.z}, "clawshot:"..name.."_chain")
			else
			obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+1.4+dir.y,z=playerpos.z+0+dir.z}, "clawshot:"..name.."_chain2")
			end
			local vec = {x=dir.x*speed,y=dir.y*speed,z=dir.z*speed}
			local yaw = placer:get_look_yaw()
			obj:setvelocity(vec)
			obj:setyaw(yaw-math.pi/2)
			local acc = {x=dir.x*accel,y=dir.y*accel,z=dir.z*accel}
			obj:setacceleration(acc)
			local object = obj:get_luaentity()
			object.launcher = placer
			object.ready = true
			item:add_wear(300)
			return item
	end,
	
})
end

register_clawshot("clawshot", "Clawshot", "clawshot.png", "clawshot_claw.png", 10, -6, 1, 1)
register_clawshot("clawshot_gold", "Gold Clawshot", "clawshot_gold.png", "clawshot_claw_gold.png", 12, -6, 2, 1)
