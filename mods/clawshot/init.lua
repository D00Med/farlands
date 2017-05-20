local function release_player(player, attach_obj)
	attach_obj:remove()
end

local function check_for_mobs(pos, self)
	local objs = minetest.get_objects_inside_radius(pos, 2)
	for i = 1, #objs do
		local obj = objs[i]
		local luaent = obj:get_luaentity()
		if not obj:is_player() and
				luaent and
				luaent.name ~= self.object:get_luaentity().name and
				luaent.name ~= "__builtin:item" then
			obj:punch(self.object, 1.0, {
				full_punch_interval=2.0,
				damage_groups={fleshy=1},
			}, nil)
			self.object:setvelocity(vector.multiply(self.object:getvelocity(), -1))
		end
	end
end

minetest.register_entity("clawshot:dummy", {
	visual = "sprite",
	textures = {"blank.png"},
	physical = false,
	collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
})

local function register_clawshot(def)
	minetest.register_entity("clawshot:"..def.name.."_claw", {
		visual = "mesh",
		mesh = "claw.b3d",
		textures = {def.texture_claw},
		physical = false,
		collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
		on_step = function(self)
			local pos = self.object:getpos()
			check_for_mobs(pos, self)

			minetest.add_particle({
				pos = pos,
				velocity = {x=0, y=0, z=0},
				acceleration = {x=0, y=0, z=0},
				expirationtime = 1,
				size = 1,
				collisiondetection = false,
				collision_removal = false,
				vertical = false,
				texture = "clawshot_chain.png",
			})

			local node_name = minetest.get_node(pos).name
			if minetest.get_item_group(node_name, "hook") == 0 and
					minetest.get_item_group(node_name, "choppy") == 0 then
				return
			end
			local player_pos = self.launcher:getpos()
			local attach_obj = minetest.add_entity(player_pos, "clawshot:dummy")
			self.launcher:set_attach(attach_obj, "", {x=0, y=0, z=0}, {x=0, y=0.9, z=0})

			if minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z}).name == "air" or
					minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z}).name == "air" or
					minetest.get_node({x=pos.x, y=pos.y, z=pos.z+1}).name == "air" or
					minetest.get_node({x=pos.x, y=pos.y, z=pos.z-1}).name == "air" then
				local vel
				if not self.launcher:get_player_control().sneak then
					vel = vector.multiply(vector.direction(player_pos, pos), def.speed2)
				end
				attach_obj:setvelocity(vel)
				minetest.after(vector.distance(player_pos, pos)/def.speed2, function()
					release_player(self.launcher, attach_obj)
				end)
			end
			self.object:remove()
		end,
	})

	minetest.register_tool("clawshot:"..def.name, {
		description = def.description,
		inventory_image = def.texture,
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
			local dir = placer:get_look_dir()
			local obj = minetest.add_entity(vector.add(vector.add(placer:get_pos(), dir), {x=0,y=1.4,z=0}),
					"clawshot:"..def.name.."_claw")
			minetest.after(def.timeout*2, function()
				obj:remove()
			end)
			obj:set_velocity(vector.multiply(dir, def.speed))
			obj:set_yaw(placer:get_look_horizontal())
			--~ obj:set_bone_position("", {x=0,y=0,z=0}, dir)
			obj:set_acceleration(vector.multiply(dir, def.acceleration))
			local luaent = obj:get_luaentity()
			luaent.launcher = placer
			luaent.ready = true
			item:add_wear(300)
			return item
		end,
	})
end

register_clawshot({
	name = "clawshot",
	description = "Clawshot",
	texture = "clawshot.png",
	texture_claw = "clawshot_claw.png",
	speed = 10,
	speed2 = 8,
	acceleration = -6,
	timeout = 1.5,
})
register_clawshot({
	name = "clawshot_gold",
	description = "Gold Clawshot",
	texture = "clawshot_gold.png",
	texture_claw = "clawshot_claw_gold.png",
	speed = 12,
	speed2 = 10,
	acceleration = -6,
	timeout = 2,
})
