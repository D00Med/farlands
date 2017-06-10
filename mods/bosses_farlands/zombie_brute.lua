local fighting_players = {}
local musics = {}

local animation = {
	idle    = {{x =   1, y =  20}, 10},
	walk_s  = {{x =  21, y =  30}, 30},
	walk    = {{x =  31, y =  70}, 30},
	walk_e  = {{x =  71, y =  80}, 30},
	jump    = {{x =  81, y = 120}, 20},
	punch   = {{x = 121, y = 160}, 30},
	grab    = {{x = 161, y = 180}, 10},
	throw   = {{x = 181, y = 210}, 20},
	throw_e = {{x = 211, y = 220}, 10},
	box     = {{x =   0, y =   0},  0},
	run     = {{x =   0, y =   0},  0},
}
local function set_anim(obj, anim, loop)
	if loop == nil then
		loop = true
	end
	local a = animation[anim]
	obj:set_animation(a[1], a[2] or 0, a[3] or 0, loop)
end
local function anim_time(anim)
	return (animation[anim][1].y - animation[anim][1].x) / animation[anim][2]
end

local gravity = tonumber(minetest.settings:get("movement_gravity"))
local function apply_gravity(obj)
	local acc = obj:get_acceleration()
	acc.y = acc.y - gravity
	obj:set_acceleration(acc)
end

minetest.register_entity("bosses_farlands:cube_projectile", {
	hp_max = 1,
	physical = true,
	collide_with_objects = true,
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	visual = "cube",
	visual_size = {x = 1, y = 1},
	textures = {}, -- +Y, -Y, +X, -X, +Z, -Z

	on_activate = function(self, staticdata, dtime_s)
		--~ if staticdata == "" then
			--~ self.object:remove()
			--~ return
		--~ end
		--~ self.textures = staticdata
		--~ self.object:set_properties({textures = self.textures})
		apply_gravity(self.object)
	end,
	--~ on_step = function(self, dtime)
	--~ end,
	--~ on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	--~ end,
	--~ on_rightclick = function(self, clicker)
	--~ end,
	--~ get_staticdata = function(self)
		--~ return self.textures
	--~ end,
})

local function die(self)
	local pos = self.object:get_pos()
	self.object:remove()
	--~ pos.y = pos.y + 1
	--~ for i = -9, 9 do
		--~ if i == 0 then
			--~ i = i + 1
		--~ end
		--~ for k = 1, 18/math.abs(i) do
			--~ local v = minetest.yaw_to_dir(k/math.abs(18/i)*360)
			--~ v.y = i/18 * vector.length(v)
			--~ v = vector.normalize(v)
			--~ minetest.add_particle({
				--~ pos = pos,
				--~ velocity = v,
				--~ acceleration = {x=0, y=0, z=0},
				--~ expirationtime = 1,
				--~ size = 1,
				--~ collisiondetection = true,
				--~ collision_removal = true,
				--~ texture = "mobs_rotten_blood.png",
			--~ })
		--~ end
	--~ end

	-- Stop music:
	for player_name, obj in pairs(fighting_players) do
		if obj == self.object then
			minetest.sound_stop(musics[player_name])
			musics[player_name] = nil
			fighting_players[player_name] = nil
			minetest.sound_play("bosses_farlands_win", {
				to_player = player_name,
				gain = 1.0,
			})
		end
	end
end

-- Should look for collidable nodes.
local function is_node_bellow(pos, r)
	pos = vector.new(pos)
	pos.y = pos.y - 1
	for x = -r, r do
		for z = -r, r do
			local p = vector.new(pos)
			p = vector.add(pos, {x=x,y=0,z=z})
			local node = minetest.get_node(vector.round(p))
			if node.name ~= "air" then
				return true
			end
		end
	end
	return false
end

local function wait(self, t, after)
	self.status = "wait"
	self.wanted_vel = vector.new(0, 0, 0)
	if after then
		minetest.after(t, after)
	else
		minetest.after(t, function()
			set_anim(self.object, "idle")
			minetest.after(0.1, function()
				self.status = "idle"
			end)
		end)
	end
end

local function throw(self, pos, yaw)
	self.walked_time = 0
	set_anim(self.object, "grab", false)
	wait(self, anim_time("grab"), function()
		local rock = minetest.add_entity(pos, "bosses_farlands:cube_projectile")
		rock:set_attach(self.object, "rock_l", {x=0,y=0,z=0}, {x=0,y=0,z=0})
		local node_pos = vector.round(vector.add(pos, minetest.yaw_to_dir(yaw)))
		rock:set_properties({
			visual_size = {x = 0.2, y = 0.2},
			textures = minetest.registered_nodes[minetest.get_node(node_pos).name].tiles,
		})
		minetest.remove_node(node_pos)
		if self.target then
			yaw = minetest.dir_to_yaw(vector.direction(pos, self.target:get_pos()))
			self.object:set_yaw(yaw)
		end
		set_anim(self.object, "throw", false)
		wait(self, anim_time("throw"), function()
			if self.target then
				yaw = minetest.dir_to_yaw(vector.direction(pos, self.target:get_pos()))
				self.object:set_yaw(yaw)
			end
			rock:set_detach()
			local rock_pos = rock:get_pos()
			rock_pos.y = rock_pos.y + 2
			rock:set_pos(rock_pos)
			rock:set_properties({visual_size = {x = 1, y = 1}})
			rock:set_velocity(vector.multiply(minetest.yaw_to_dir(yaw), 10))
			rock:set_yaw(yaw)
			apply_gravity(rock)
			set_anim(self.object, "throw_e", false)
			wait(self, anim_time("throw_e"))
		end)
	end)
end

minetest.register_entity("bosses_farlands:zombie_brute", {
	hp_max = 1,
	physical = true,
	collide_with_objects = true,
	weight = 5,
	collisionbox = {-0.7,0,-0.7, 0.7,2,0.7},
	visual = "mesh",
	visual_size = {x = 5, y = 5},
	mesh = "bosses_zombie_brute.b3d",
	textures = {"bosses_zombie_brute.png"},
	makes_footstep_sound = false,
	stepheight = 0,
	backface_culling = true,
	nametag = "Zombie Brute",
	nametag_color = "#FF0000",

	on_activate = function(self, staticdata, dtime_s)
		if staticdata == "" then
			self.hp = 80
		else
			local s = minetest.deserialize(staticdata)
			self.hp = s.hp
		end
		self.wanted_vel = vector.new(0, 0, 0)
		self.status = "idle"
		self.walked_time = 0
		self.object:set_armor_groups({fleshy = 100, immortal = 1})
		apply_gravity(self.object)
		set_anim(self.object, "idle")
	end,

	on_step = function(self, dtime)
		local pos = self.object:get_pos()
		local yaw = self.object:get_yaw()
		local vel = vector.subtract(self.object:get_velocity(), self.wanted_vel)
		local v = vector.length(vel) -- Speed.

		-- Friction:
		if v ~= 0 then
			local pn = 1
			if v < 0 then
				v = -v
				pn = -1
			end
			-- Air fricion:
			v = v - dtime * 0.5 * v^2
			-- Ground friction:
			if vel.y == 0 and is_node_bellow(pos, 1) then
				v = v - dtime
				v = math.floor(v*5)/5
			else
				v = math.floor(v*100)/100
			end
			v = math.max(v, 0) * pn
		end
		vel = vector.multiply(vector.normalize(vel), v)

		-- Go for target:
		if self.target then
			local target_pos = self.target:get_pos()
			if (self.status == "idle" or self.status == "walk") and
					vector.distance(pos, target_pos) <= 1.5 then
				set_anim(self.object, "punch", false)
				wait(self, anim_time("punch"))
				self.walked_time = 0
				yaw = minetest.dir_to_yaw(vector.direction(pos, target_pos))
				self.object:set_yaw(yaw)
			elseif self.status == "walk" then
				local dir = vector.direction(pos, target_pos)
				self.object:set_yaw(minetest.dir_to_yaw(dir))
				yaw = minetest.dir_to_yaw(vector.direction(pos, target_pos))
				self.object:set_yaw(yaw)
				if self.walked_time >= 10 and vector.distance(pos, target_pos) <= 8 then
					throw(self, pos, yaw)
				else
					self.wanted_vel = dir
					self.walked_time = self.walked_time + dtime
				end
			elseif self.status == "idle" then
				self.status = "walk"
				set_anim(self.object, "walk")
			--~ elseif self.status == "wait" and self.wait_time_end <= os.time() then
				--~ if not self.after_wait then
					--~ self.status = "idle"
					--~ set_anim(self.object, "idle")
				--~ else
					--~ self.after_wait()
				--~ end
			end
		end

		self.object:set_velocity(vector.add(vel, self.wanted_vel))
	end,

	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
		if not puncher:is_player() then
			return
		end
		local vel = self.object:get_velocity()
		local knockback = 3
		local damage = 10
		self.target = puncher
		local player_name = puncher:get_player_name()
		if not fighting_players[player_name] then
			musics[player_name] = minetest.sound_play("bosses_farlands_music", {
				to_player = player_name,
				gain = 1.0,
				loop = true,
			})
		end
		fighting_players[player_name] = self.object
		minetest.sound_play("default_punch", {
			gain = 3,
			object = self.object,
			max_hear_distance = 15,
		})
		self.hp = self.hp - damage
		if dir then
			dir.y = dir.y + 1
			dir = vector.normalize(dir)
			vel = vector.add(vel, vector.multiply(dir, knockback))
		end
		minetest.chat_send_all(self.hp)
		if self.hp <= 0 then
			die(self)
		end
		self.object:set_velocity(vel)
	end,

	get_staticdata = function(self)
		return minetest.serialize({hp = self.hp})
	end,
})

bosses_farlands.register_egg("bosses_farlands:zombie_brute_egg", "bosses_farlands:zombie_brute", {
	description = "Zombie Brute (boss)",
	inventory_image = "mobs_chicken_egg.png^(default_dirt.png^[mask:mobs_chicken_egg_overlay.png)",
})
