
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

mobs:register_spawn("mobs_m:trilobite", {"default:water_source",}, 20, 10, 15000, 2, 11000)

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

minetest.register_craftitem("mobs_m:smallfish_raw", {
	description = "Small Raw Fish",
	inventory_image = "mobs_smallfish_item",
	on_use = minetest.item_eat(1)
})

minetest.register_craftitem("mobs_m:smallfish_cooked", {
	description = "Small Cooked Fish",
	inventory_image = "mobs_smallfish_cooked",
	on_use = minetest.item_eat(2)
})

minetest.register_craft({
	type = "cooking",
	output = "mobs_m:smallfish_raw",
	recipe = "mobs_m:smallfish_cooked",
	cooktime = 3,
})