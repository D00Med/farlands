local fighting_players = {}
local musics = {}
local hud_ids = {}

local animation = {
	idle    = {{x =   1, y =  20}, 10},
	walk_s  = {{x =  21, y =  30}, 30},
	walk    = {{x =  31, y =  70}, 30},
	walk_e  = {{x =  71, y =  80}, 30},
	jump    = {{x =  81, y = 120}, 40},
	punch   = {{x = 121, y = 160}, 30},
	grab    = {{x = 161, y = 180}, 10},
	throw   = {{x = 181, y = 210}, 20},
	throw_e = {{x = 211, y = 220}, 10},
	box     = {{x =   0, y =   0},  0},
	run     = {{x =   0, y =   0},  0},
	dash    = {{x = 220, y = 239}, 25},
}
local function set_anim(obj, anim, loop)
	loop = loop ~= false
	local a = animation[anim]
	obj:set_animation(a[1], a[2] or 0, a[3] or 0, loop)
end
local function anim_time(anim)
	return (animation[anim][1].y - animation[anim][1].x) / animation[anim][2]
end

local gravity = tonumber(minetest.settings:get("movement_gravity")) or 9.81
local function apply_gravity(obj)
	local acc = obj:get_acceleration()
	acc.y = acc.y - gravity
	obj:set_acceleration(acc)
end
local function take_gravity(obj)
	local acc = obj:get_acceleration()
	acc.y = acc.y + gravity
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
		if staticdata == "" then
			self.object:remove()
			return
		end
		self.node = minetest.deserialize(staticdata)
		local tiles = table.copy(minetest.registered_nodes[self.node.name].tiles or {"unknown_node.png"})
		local tiles_count = #tiles
		for i = 1, tiles_count do
			if type(tiles[i]) == "table" then
				tiles[i] = tiles[i].name
			end
		end
		if tiles_count < 6 then
			for i = tiles_count+1, 6 do
				tiles[i] = tiles[tiles_count]
			end
		end
		self.object:set_properties({textures = tiles})
	end,
	on_step = function(self, dtime)
		if not self.flying then
			return
		end
		local v = self.object:get_velocity()
		if v.x ~= 0 and v.y ~= 0 and v.z ~= 0 then
			return
		end
		local pos = vector.round(self.object:get_pos())
		tnt.boom(vector.round(pos),	{
			damage_radius = 3,
			radius = 1
		})
		minetest.set_node(pos, self.node)
		self.object:remove()
	end,
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

	-- Stop music and remove hud:
	for player_name, obj in pairs(fighting_players) do
		if obj == self.object then
			minetest.sound_stop(musics[player_name])
			musics[player_name] = nil
			fighting_players[player_name] = nil
			minetest.sound_play("bosses_farlands_win", {
				to_player = player_name,
				gain = 1.0,
			})
			local player = minetest.get_player_by_name(player_name)
			player:hud_remove(hud_ids[player_name][1])
			player:hud_remove(hud_ids[player_name][2])
			hud_ids[player_name] = nil
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
	self.wait_timer = 0
	self.wait_end = t
	self.after_wait = after
	self.wanted_vel = vector.new(0, 0, 0)
end

local function throw(self, pos, yaw)
	local node_pos = vector.round(vector.add(pos, minetest.yaw_to_dir(yaw)))
	local node_def = minetest.registered_nodes[minetest.get_node(node_pos).name]
	if node_def.drawtype ~= "normal" or minetest.get_node_timer(node_pos):is_started() then
		return false
	end
	local meta_table = minetest.get_meta(node_pos):to_table()
	if meta_table and ((meta_table.fields and #meta_table.fields > 0) or
			(meta_table.inventory and #meta_table.inventory > 0)) then
		return false
	end
	self.walked_time = 0
	set_anim(self.object, "grab", false)
	wait(self, anim_time("grab"), function()
		local rock = minetest.add_entity(node_pos, "bosses_farlands:cube_projectile",
				minetest.serialize(minetest.get_node(node_pos)))
		rock:set_attach(self.object, "rock_l", {x=0,y=0,z=0}, {x=0,y=0,z=0})
		rock:set_properties({visual_size = {x = 0.2, y = 0.2}})
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
			rock:get_luaentity().flying = true
			set_anim(self.object, "throw_e", false)
			wait(self, anim_time("throw_e"))
		end)
	end)
	return true
end

local function dash(self, dir)
	self.walked_time = 0
	self.dashed_time = 0
	self.wanted_vel = vector.new()
	set_anim(self.object, "dash", false)
	self.dash_startvel = vector.multiply(dir, 2)
	self.object:set_velocity(self.dash_startvel)
	self.status = "dash"
	take_gravity(self.object)
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
			self.hp = 800
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
		if self.status == "dash" then
			self.dashed_time = self.dashed_time + dtime
			if self.dashed_time >= 2 then
				self.object:set_velocity(vector.new())
				self.dashed_time = nil
				self.status = "idle"
				set_anim(self.object, "idle")
				self.dash_startvel = nil
				apply_gravity(self.object)
				return
			end
			local v = self.object:get_velocity()
			if not ((v.x == 0 and self.dash_startvel.x ~= 0) or
					(v.y == 0 and self.dash_startvel.y ~= 0) or
					(v.z == 0 and self.dash_startvel.z ~= 0)) then
				return
			end
			self.object:set_velocity(vector.new())
			local boom_pos = vector.normalize(self.dash_startvel)
			boom_pos = vector.add(boom_pos, self.object:get_pos())
			boom_pos = vector.round(boom_pos)
			tnt.boom(boom_pos, {damage_radius = 4, radius = 2})
			self.dash_startvel = nil
			self.status = "idle"
			set_anim(self.object, "idle")
			apply_gravity(self.object)
			self.dashed_time = nil
			return
		end
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
				self.target:set_hp(self.target:get_hp()-3)
			elseif self.status == "walk" then
				local dir = vector.direction(pos, target_pos)
				yaw = minetest.dir_to_yaw(dir)
				self.object:set_yaw(yaw)
				if self.walked_time >= 10 and vector.distance(pos, target_pos) <= 8 then
					if not throw(self, pos, yaw) then
						dash(self, dir)
						return
					end
				else
					if self.last_pos then
						local isway = vector.distance(pos, self.last_pos)
						local shouldway = vector.length(self.wanted_vel) * dtime
						if isway < shouldway - 0.2 then
							self.last_pos = nil
							set_anim(self.object, "jump", false)
							vel.y = vel.y + gravity
							wait(self, 1.2, function(self)
								self.wanted_vel = vector.new()
								self.status = "idle"
								set_anim(self.object, "idle")
							end)
						end
					end
					self.wanted_vel = dir
					self.walked_time = self.walked_time + dtime
					self.last_pos = pos
				end
			elseif self.status == "idle" then
				self.status = "walk"
				set_anim(self.object, "walk")
			elseif self.status == "wait" then
				self.wait_timer = self.wait_timer + dtime
				if self.wait_timer >= self.wait_end then
					self.status = "idle"
					if self.after_wait then
						self.after_wait(self)
					else
						set_anim(self.object, "idle")
					end
				end
			end
		end

		self.object:set_velocity(vector.add(vel, self.wanted_vel))
	end,

	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
		if not puncher:is_player() then
			return
		end
		--~ if puncher:get_player_control().aux1 then
			--~ die(self)
			--~ return
		--~ end
		local vel = self.object:get_velocity()
		local damage = tool_capabilities.damage_groups.fleshy or 0
		--~ print(dump(tool_capabilities))
		damage = damage * math.min(time_from_last_punch / tool_capabilities.full_punch_interval, 1)
		local knockback = math.floor(damage/3)
		damage = math.floor(damage)
		self.hp = self.hp - damage
		self.target = puncher
		local player_name = puncher:get_player_name()
		if not fighting_players[player_name] then
			musics[player_name] = minetest.sound_play("bosses_farlands_music", {
				to_player = player_name,
				gain = 1.0,
				loop = true,
			})
			hud_ids[player_name] = {
				puncher:hud_add({
					hud_elem_type = "image",
					position = {x=0.05, y=0.0},
					name = "farlands_bosses_zombie_brute_health_bg",
					scale = {x=4.4, y=3.7},
					text = "bosses_farlands_health_bg.png",
					direction = 0,
					alignment = {x=1, y=1},
					offset = {x=0, y=0},
				}),
				puncher:hud_add({
					hud_elem_type = "statbar",
					position = {x=0.05, y=0.0},
					name = "farlands_bosses_zombie_brute_health",
					text = "bosses_farlands_health.png",
					number = self.hp/5,
					direction = 0,
					offset = {x=10, y=5},
					size = {x=12, y=50},
				}),
			}
		else
			puncher:hud_change(hud_ids[player_name][2], "number", self.hp/5)
		end
		fighting_players[player_name] = self.object
		minetest.sound_play("default_punch", {
			gain = 3,
			object = self.object,
			max_hear_distance = 15,
		})
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
	inventory_image = "bosses_farlands_zspawner.png",
})

minetest.register_craft({
	output = "bosses_farlands:zombie_brute_egg",
	recipe = {
		{"",           "default:steel_ingot",    ""},
		{"default:steel_ingot", "mobs:zombie_flesh", "default:steel_ingot"},
		{"",           "default:steel_ingot",    ""}
	}
})