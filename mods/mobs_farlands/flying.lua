
mobs:register_mob("mobs_m:smallbird", {
	type = "animal",
	passive = true,
	reach = 1,
	damage = 0,
	attack_type = "dogfight",
	hp_min = 10,
	hp_max = 25,
	armor = 130,
	collisionbox = {-0.2, 0, -0.2, 0.2, 0.4, 0.2},
	visual = "mesh",
	mesh = "smallbird.b3d",
	textures = {
		{"mobs_bird1.png"},
	},
	makes_footstep_sound = false,
	view_range = 10,
	walk_velocity = 3,
	run_velocity = 6,
	runaway = true,
	runaway_timer = 40,
	jump = false,
	jump_height = 0,
	stepheight = 1.5,
	fly = true,
	fly_in = "air",
	fall_damage = 0,
	fall_speed = -2,
	drops = {
		{name = "mobs:meat_raw",
		chance = 9, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 25,
		speed_run = 35,
		stand_start = 45,
		stand_end = 65,
		walk_start = 20,
		walk_end = 40,
		run_start = 20,
		run_end = 40,
		fly_start = 45,
		fly_end = 65,
	},
})

mobs:register_spawn("mobs_m:smallbird", {"default:leaves",}, 20, 10, 70000, 2, 11000)

mobs:register_egg("mobs_m:smallbird", "Small Bird", "wool_cyan.png", 1)

mobs:register_mob("mobs_m:pterodactyl", {
	type = "animal",
	passive = true,
	reach = 1,
	damage = 0,
	attack_type = "dogfight",
	hp_min = 20,
	hp_max = 35,
	armor = 100,
	collisionbox = {-0.5, -0.2, -0.5, 0.5, 0.2, 0.5},
	visual = "mesh",
	mesh = "pterodactyl.b3d",
	textures = {
		{"mobs_pterodactyl.png"},
	},
	makes_footstep_sound = false,
	view_range = 10,
	walk_velocity = 3,
	run_velocity = 6,
	runaway = true,
	runaway_timer = 40,
	jump = true,
	jump_height = 2,
	stepheight = 1.5,
	fly = true,
	fly_in = "air",
	fall_damage = 0,
	fall_speed = -2,
	drops = {
		{name = "mobs:meat_raw",
		chance = 9, min = 1, max = 2},
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 16,
		speed_run = 20,
		stand_start = 10,
		stand_end = 30,
		walk_start = 10,
		walk_end = 30,
		run_start = 10,
		run_end = 30,
		fly_start = 10,
		fly_end = 30,
	},
	--[[do_custom = function(self)
		local pos = self.object:get_pos()
		if math.random(1,200) == 1 and not self.changing then
			self.changing = true
			local obj = minetest.add_entity(pos, "mobs_m:pterodactyl_walking")
			local newmob = obj:get_luaentity()
			newmob.hp = self.object:get_hp()
			self.object:remove()
		end
	end,]]
})

mobs:register_mob("mobs_m:pterodactyl_walking", {
	type = "animal",
	passive = true,
	reach = 1,
	damage = 0,
	attack_type = "dogfight",
	hp_min = 20,
	hp_max = 35,
	armor = 100,
	collisionbox = {-0.5, 0, -0.5, 0.5, 1, 0.5},
	visual = "mesh",
	mesh = "pterodactyl.b3d",
	textures = {
		{"mobs_pterodactyl.png"},
	},
	makes_footstep_sound = true,
	view_range = 10,
	walk_velocity = 2,
	run_velocity = 3,
	runaway = true,
	runaway_timer = 40,
	jump = false,
	jump_height = 1,
	stepheight = 1.5,
	fall_damage = 0,
	drops = {
		{name = "mobs:meat_raw",
		chance = 9, min = 1, max = 2},
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 16,
		speed_run = 20,
		stand_start = 65,
		stand_end = 85,
		walk_start = 40,
		walk_end = 60,
		run_start = 40,
		run_end = 60,
	},
	do_custom = function(self)
		local pos = self.object:get_pos()
		if math.random(1,100) == 1 and not self.changing then
			self.changing = true
			local obj = minetest.add_entity(pos, "mobs_m:pterodactyl")
			local newmob = obj:get_luaentity()
			newmob.hp = self.object:get_hp()
			obj:setpos({x=pos.x, y=pos.y+1, z=pos.z})
			self.object:remove()
		end
	end,
})

mobs:register_egg("mobs_m:pterodactyl", "Pterodactyl", "default_dirt.png", 1)

mobs:register_mob("mobs_m:wasp", {
	type = "monster",
	reach = 1,
	damage = 1,
	attack_type = "dogfight",
	hp_min = 2,
	hp_max = 5,
	armor = 100,
	collisionbox = {-0.1, -0, -0.1, 0.1, 0.5, 0.1},
	fly = true,
	fall_speed = 0,
	stepheight = 1.5,
	visual = "mesh",
	mesh = "wasp.b3d",
	textures = {
		{"mobs_m_wasp.png"},
	},
	sounds = {
		random = "wasp",
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=0.6, y=0.6},
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 0,
	view_range = 14,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		walk_start = 6,
		walk_end = 16,
		stand_start = 6,
		stand_end = 16,
		run_start = 6,
		run_end = 16,
		punch_start = 6,
		punch_end = 16,
	},
})


mobs:register_egg("mobs_m:wasp", "Wasp", "default_obsidian.png", 1)
	mobs:register_spawn("mobs_m:wasp", {"default:dirt_with_grass"}, 20, 10, 32000, 2, 31000)
