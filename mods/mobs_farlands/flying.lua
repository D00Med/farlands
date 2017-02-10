
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

mobs:register_spawn("mobs_m:smallbird", {"air",}, 20, 10, 50000, 2, 11000)

mobs:register_egg("mobs_m:smallbird", "Small Bird", "wool_cyan.png", 1)