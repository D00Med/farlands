
mobs:register_mob("mobs_m:smallfish", {
	type = "animal",
	passive = true,
	reach = 1,
	damage = 0,
	attack_type = "dogfight",
	hp_min = 10,
	hp_max = 25,
	armor = 100,
	collisionbox = {-0.2, -0.2, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "fish.b3d",
	textures = {
		{"mobs_smallfish.png"},
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
	fly_in = "default:water_source",
	fall_damage = 0,
	fall_speed = 0,
	drops = {
		{name = "mobs_m:smallfish_raw",
		chance = 9, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 1,
		stand_end = 20,
		walk_start = 1,
		walk_end = 20,
		run_start = 1,
		run_end = 20,
	},
})

mobs:register_spawn("mobs_m:smallfish", {"default:water_source",}, 20, 10, 15000, 2, 11000)

mobs:register_egg("mobs_m:smallfish", "Small Fish", "default_water.png", 1)

mobs:register_mob("mobs_m:ammonite_s", {
	type = "animal",
	passive = true,
	reach = 1,
	damage = 0,
	attack_type = "dogfight",
	hp_min = 15,
	hp_max = 35,
	armor = 100,
	collisionbox = {-0.5, -0.2, -0.5, 0.5, 0.5, 0.5},
	visual = "mesh",
	mesh = "ammonite.b3d",
	textures = {
		{"mobs_ammonite.png"},
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
	fly_in = "default:water_source",
	fall_damage = 0,
	fall_speed = 0,
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 2,
		stand_end = 23,
		walk_start = 2,
		walk_end = 23,
		run_start = 2,
		run_end = 23,
	},
})

mobs:register_egg("mobs_m:ammonite_s", "Small Ammonite", "default_sand.png", 1)

mobs:register_mob("mobs_m:ammonite_b", {
	type = "animal",
	passive = true,
	reach = 1,
	damage = 0,
	attack_type = "dogfight",
	hp_min = 15,
	hp_max = 35,
	armor = 100,
	collisionbox = {-1, -0.2, -1, 1, 1, 1.2},
	visual = "mesh",
	mesh = "ammonite.b3d",
	textures = {
		{"mobs_ammonite_big.png"},
	},
	visual_size = {x=2.5, y=2.5},
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
	fly_in = "default:water_source",
	fall_damage = 0,
	fall_speed = 0,
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 2,
		stand_end = 23,
		walk_start = 2,
		walk_end = 23,
		run_start = 2,
		run_end = 23,
	},
})

mobs:register_egg("mobs_m:ammonite_b", "Large Ammonite", "default_sand.png", 1)

mobs:register_mob("mobs_m:trilobite", {
	type = "animal",
	passive = true,
	reach = 1,
	damage = 0,
	attack_type = "dogfight",
	hp_min = 10,
	hp_max = 25,
	armor = 100,
	collisionbox = {-0.2, 0, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "trilobite.b3d",
	textures = {
		{"mobs_trilobite.png"},
	},
	makes_footstep_sound = false,
	view_range = 5,
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	runaway_timer = 40,
	jump = 0,
	floats = 0,
	jump_height = 0,
	stepheight = 1.3,
	fall_damage = 0,
	fall_speed = -5,
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 40,
		stand_end = 60,
		walk_start = 1,
		walk_end = 30,
		run_start = 1,
		run_end = 30,
	},
})

--mobs:register_spawn("mobs_m:trilobite", {"default:water_source",}, 20, 10, 15000, 2, 11000)

mobs:register_egg("mobs_m:trilobite", "Trilobite", "default_water.png", 1)

mobs:register_mob("mobs_m:riverfish", {
	type = "animal",
	passive = true,
	reach = 1,
	damage = 0.5,
	attack_type = "dogfight",
	hp_min = 10,
	hp_max = 25,
	armor = 90,
	collisionbox = {-0.2, -0.2, -0.2, 0.2, 0.2, 0.2},
	visual_size = {x=1.6, y=1.6},
	visual = "mesh",
	mesh = "fish.b3d",
	textures = {
		{"mobs_riverfish.png"},
	},
	makes_footstep_sound = false,
	view_range = 10,
	walk_velocity = 3,
	run_velocity = 6,
	runaway = false,
	runaway_timer = 40,
	jump = false,
	jump_height = 0,
	stepheight = 1.5,
	fly = true,
	fly_in = "default:river_water_source",
	fall_damage = 0,
	fall_speed = 0,
	drops = {
		{name = "mobs_m:smallfish_raw",
		chance = 9, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 1,
		stand_end = 20,
		walk_start = 1,
		walk_end = 20,
		run_start = 1,
		run_end = 20,
	},
})

mobs:register_spawn("mobs_m:riverfish", {"default:river_water_source",}, 20, 10, 15000, 2, 11000)

mobs:register_egg("mobs_m:riverfish", "River Fish", "default_dirt.png", 1)

mobs:register_mob("mobs_m:pirana", {
	type = "monster",
	passive = false,
	group_attack = true,
	reach = 1,
	damage = 0.5,
	attack_type = "dogfight",
	hp_min = 10,
	hp_max = 25,
	armor = 90,
	collisionbox = {-0.2, 0, -0.2, 0.2, 0.4, 0.2},
	visual_size = {x=1.6, y=1.6},
	visual = "mesh",
	mesh = "pirana.b3d",
	textures = {
		{"mobs_pirana.png"},
	},
	makes_footstep_sound = false,
	view_range = 10,
	walk_velocity = 3,
	run_velocity = 6,
	runaway = false,
	runaway_timer = 40,
	jump = false,
	jump_height = 0,
	stepheight = 0,
	fly = true,
	fly_in = "default:river_water_source",
	fall_damage = 0,
	fall_speed = 0,
	drops = {
		{name = "mobs_m:smallfish_raw",
		chance = 9, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 2,
		stand_end = 30,
		walk_start = 2,
		walk_end = 30,
		run_start = 2,
		run_end = 30,
	},
})

mobs:register_spawn("mobs_m:pirana", {"default:river_water_source",}, 20, 10, 15000, 2, 11000)

mobs:register_egg("mobs_m:pirana", "Pirana", "default_dirt.png", 1)

mobs:register_mob("mobs_m:dearcmhara", {
	type = "monster",
	passive = false,
	reach = 1.5,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 30,
	hp_max = 40,
	armor = 100,
	collisionbox = {-0.7, -0.1, -0.7, 0.7, 1.3, 0.7},
	visual = "mesh",
	mesh = "dearcmhara.b3d",
	textures = {
		{"mobs_dearcmhara.png"},
	},
	makes_footstep_sound = false,
	view_range = 10,
	walk_velocity = 3,
	run_velocity = 6,
	runaway = true,
	runaway_timer = 40,
	jump = 0,
	jump_height = 0,
	stepheight = 1.5,
	fly = true,
	fly_in = "default:water_source",
	fall_damage = 0,
	fall_speed = 0,
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 20,
		stand_start = 6,
		stand_end = 24,
		walk_start = 6,
		walk_end = 24,
		run_start = 31,
		run_end = 49,
	},
})

mobs:register_egg("mobs_m:dearcmhara", "Dearcmhara", "wool_cyan.png", 1)

mobs:register_mob("mobs_m:whale", {
	type = "animal",
	passive = false,
	reach = 1,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 52,
	hp_max = 82,
	armor = 230,
	collisionbox = {-4, -2, -4, 4, 2, 4},
	visual = "mesh",
	mesh = "whale.b3d",
	textures = {
		{"mobs_m_whale.png"},
	},
	blood_texture = "mobs_blood.png",
	rotate = 180,
	visual_size = {x=1.5, y=1.5},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 2,
	jump = false,	
	stepheight = 1.5,
	fall_damage = 0,
	fall_speed = -6,
	fly = true,
	fly_in = "default:water_source",
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	follow = {"fishing:fish_cooked"},
	view_range = 14,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	sounds = {
      random = "whale_1",
      death = "whale_1",
      distance = 128,
	},
	animation = {
		speed_normal = 0.1,
		speed_run = 0.5,
		walk_start = 2,
		walk_end = 28,
		stand_start = 30,
		stand_end = 50,
		run_start = 2,
		run_end = 28,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})


mobs:register_egg("mobs_m:whale", "Whale", "default_water.png", 1)
	mobs:register_spawn("mobs_m:whale", {"default:water_source"}, 20, 10, 15000, -20, 1000)

minetest.register_craftitem("mobs_m:smallfish_raw", {
	description = "Small Raw Fish",
	inventory_image = "mobs_smallfish_item.png",
	on_use = minetest.item_eat(1)
})

minetest.register_craftitem("mobs_m:smallfish_cooked", {
	description = "Small Cooked Fish",
	inventory_image = "mobs_smallfish_cooked.png",
	on_use = minetest.item_eat(2)
})

minetest.register_craft({
	type = "cooking",
	output = "mobs_m:smallfish_raw",
	recipe = "mobs_m:smallfish_cooked",
	cooktime = 3,
})