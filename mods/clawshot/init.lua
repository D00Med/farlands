local function check_for_mobs(pos, self)
	local objs = minetest.get_objects_inside_radius(pos, 2)
	local own_name = self.object:get_luaentity().name
	for i = 1, #objs do
		local obj = objs[i]
		local luaent = obj:get_luaentity()
		if not obj:is_player() and
				luaent and
				luaent.name ~= own_name and
				luaent.name ~= "__builtin:item" then
			obj:punch(self.object, 1.0, {
				full_punch_interval=2.0,
				damage_groups={fleshy=1},
			}, nil)
			self.object:setvelocity(vector.multiply(self.object:getvelocity(), -1))
			self.timeout = self.timer
			break
		end
	end
end

minetest.register_entity("clawshot:dummy", {
	visual = "sprite",
	textures = {"blank.png"},
	physical = false,
	collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	on_activate = function(self, staticdata)
		if staticdata == "delete" then
			self.object:remove()
		end
	end,
	get_staticdata = function(self)
		return "delete"
	end,
})

local function register_clawshot(def)
	minetest.register_entity("clawshot:"..def.name.."_claw", {
		visual = "mesh",
		mesh = "claw.b3d",
		textures = {def.texture_claw},
		physical = false,
		collisionbox = {0, 0, 0, 0, 0, 0},
		on_activate = function(self, staticdata)
			if staticdata == "delete" then
				self.object:remove()
				return
			end
			self.timer = 0
			self.timeout = def.timeout
		end,
		get_staticdata = function(self)
			return "delete"
		end,
		on_step = function(self, dtime)
			self.timer = self.timer + dtime
			if self.timer >= self.timeout*2 then
				self.object:remove()
				return
			end
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
				local vel = vector.direction(player_pos, pos)
				local t = 1
				if self.launcher:get_player_control().sneak then
					vel.y = 0
					vel = vector.normalize(vel)
					t = 2
					pos.y = player_pos.y
				end
				vel = vector.multiply(vel, def.speed2)
				t = vector.distance(player_pos, pos)/vector.length(vel)*t
				attach_obj:set_velocity(vel)
				minetest.after(t, function()
					attach_obj:remove()
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
			obj:set_velocity(vector.multiply(dir, def.speed))
			obj:set_yaw(placer:get_look_horizontal())
			--~ obj:set_bone_position("", {x=0,y=0,z=0}, dir) --TODO
			obj:set_acceleration(vector.multiply(dir, def.acceleration))
			obj:get_luaentity().launcher = placer
			if not minetest.settings:get_bool("creative_mode") then
				item:add_wear(300)
			end
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
