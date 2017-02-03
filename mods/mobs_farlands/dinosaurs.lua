

--spawns
--mobs:register_spawn("mobs_m:velociraptor", {"default:dirt_with_grass","default:dirt"}, 20, 10, 32000, 2, 31000)

--mobs

mobs:register_mob("mobs_m:velociraptor", {
	type = "monster",
	reach = 1.5,
	damage = 4,
	attack_type = "dogfight",
	hp_min = 42,
	hp_max = 52,
	armor = 100,
	collisionbox = {-0.4, 0, -0.4, 0.4, 0.5, 0.4},
	runaway = true,
	pathfinding = true,
	visual = "mesh",
	mesh = "velociraptor.b3d",
	textures = {
		{"mobs_velociraptor.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=1.5, y=1.5},
	makes_footstep_sound = true,
	walk_velocity = 2.5,
	run_velocity = 3,
	jump = true,
	drops = {
		{name = "mobs:meat_raw", chance = 3, min = 1, max = 2},
	},
	on_activate = function(self)
		if math.random(1,5) == 1 then
		self.type = "animal"
		end
	end,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fear_height = 8,
	follow = {"mobs:meat_raw"},
	view_range = 14,
	animation = {
		speed_normal = 12,
		speed_run = 18,
		walk_start = 45,
		walk_end = 65,
		stand_start = 16,
		stand_end = 42,
		run_start = 45,
		run_end = 65,
		punch_start = 1,
		punch_end = 16,
	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})


mobs:register_egg("mobs_m:velociraptor", "Velociraptor", "wool_orange.png", 1)