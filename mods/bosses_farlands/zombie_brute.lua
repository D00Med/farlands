local animation = {
	idle    = {{x =   1, y =  20},  5},
	walk_s  = {{x =  21, y =  30}, 10},
	walk    = {{x =  31, y =  70}, 10},
	walk_e  = {{x =  71, y =  80}, 10},
	jump    = {{x =  81, y = 120}, 10},
	punch   = {{x = 121, y = 160}, 20},
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
end

local function get_attacked(self, puncher, time_from_last_punch, tool_capabilities, dir)
	self.hp = self.hp - 10
	minetest.chat_send_all(self.hp)
	if self.hp <= 0 then
		die(self)
	end
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
		self.object:set_armor_groups({fleshy = 100, immortal = 1})
		apply_gravity(self.object)
		set_anim(self.object, "idle")
	end,
	--~ on_step = function(self, dtime)
	--~ end,
	on_punch = get_attacked,
	on_rightclick = function(self, clicker)
		set_anim(self.object, "grab", false)
		local stone
		minetest.after(5, function()
			local pos = self.object:get_pos()
			stone = minetest.add_entity(pos, "bosses_farlands:cube_projectile")
			stone:set_attach(self.object, "rock_l", {x=0,y=1,z=0}, {x=0,y=0,z=0})
			local node_pos = vector.round(vector.add(pos, minetest.yaw_to_dir(self.object:get_yaw())))
			stone:set_properties({
				visual_size = {x = 0.2, y = 0.2},
				textures = minetest.registered_nodes[minetest.get_node(node_pos).name].tiles,
			})
			minetest.remove_node(node_pos)
			set_anim(self.object, "throw", false)
		end)
		minetest.after(10, function()
			stone:set_detach()
			local stone_pos = stone:get_pos()
			stone_pos.y = stone_pos.y + 2
			stone:set_pos(stone_pos)
			stone:set_properties({visual_size = {x = 1, y = 1},})
			local yaw = self.object:get_yaw()
			stone:set_velocity(vector.multiply(minetest.yaw_to_dir(yaw), 10))
			apply_gravity(stone)
			stone:set_yaw(yaw)
			set_anim(self.object, "throw_e", false)
		end)
		minetest.after(15, function()
			set_anim(self.object, "idle", true)
		end)
	end,
	get_staticdata = function(self)
		return minetest.serialize({hp = self.hp})
	end,
})

bosses_farlands.register_egg("bosses_farlands:zombie_brute_egg", "bosses_farlands:zombie_brute", {
	description = "Zombie Brute (boss)",
	inventory_image = "mobs_chicken_egg.png^(default_dirt.png^[mask:mobs_chicken_egg_overlay.png)",
})
