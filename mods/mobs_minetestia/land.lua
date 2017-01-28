--land dwelling mobs

minetest.register_node("mobs_m:mimic_chest", {
	description = "Mimic Chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=4},
	on_rightclick = function(pos, node, clicker)
		minetest.env:remove_node(pos)
		minetest.env:add_entity(pos, "mobs_m:mimic")
	end
})

mobs:register_mob("mobs_m:mimic", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	reach = 2,
	damage = 3,
	hp_min = 10,
	hp_max = 27,
	armor = 90,
	collisionbox = {-0.5, 0, -0.5, 0.5, 1, 0.5},
	visual = "mesh",
	mesh = "mimic.b3d",
	textures = {
		{"mobs_mimic.png"},
	},
	blood_texture = "mobs_rotten_blood.png",
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_dirtmonster",
	},
	view_range = 3.5,
	walk_velocity = 0.01,
	run_velocity = 2,
	jump = false,
	jump_height = 0,
	drops = {
		{name = "default:gold_lump",
		chance = 4, min = 1, max = 1},
	},
	do_custom = function(self)
		if self.state ~= "attack" then
			minetest.after(3, function()
			if self.state ~= "attack" and self.object ~= nil then
			local pos = self.object:getpos()
			if pos ~= nil then
			minetest.set_node(pos, {name="mobs_m:mimic_chest", param2=1})
			self.object:remove()
			end
			end
			end)
		end
	end,
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 3,
	animation = {
		speed_normal = 15,
		speed_run = 17,
		stand_start = 1,
		stand_end = 1,
		walk_start = 1,
		walk_end = 20,
		run_start = 1,
		run_end = 20,
		punch_start = 20,
		punch_end = 45,
	},
})

mobs:register_mob("mobs_m:mammoth", {
	type = "animal",
	passive = false,
	reach = 3,
	damage = 5,
	attack_type = "dogfight",
	hp_min = 50,
	hp_max = 60,
	armor = 100,
	collisionbox = {-1.8, 0, -1.8, 1.8, 3.5, 1.8},
	visual = "mesh",
	mesh = "mammoth.b3d",
	textures = {
		{"mobs_mammoth.png"},
	},
	blood_texture = "mobs_blood.png",
	makes_footstep_sound = true,
	walk_velocity = 0.5,
	run_velocity = 1,
	jump = false,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fall_speed = -20, -- extra heavy!
	fear_height = 2,
	replace_rate = 10,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "ethereal:bamboo"},
	replace_with = "air",
	follow = {"compactblocks:default_leaves"},
	view_range = 14,
	drops = {
		{name = "mobs:meat_raw", chance = 2, min = 5, max = 6},
	},
	animation = {
		speed_normal = 16,
		speed_run = 19,
		walk_start = 45,
		walk_end = 65,
		stand_start = 20,
		stand_end = 40,
		run_start = 45,
		run_end = 65,
		punch_start = 1,
		punch_end = 20,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})


mobs:register_egg("mobs_m:mammoth", "Mammoth", "default_dirt.png", 1)