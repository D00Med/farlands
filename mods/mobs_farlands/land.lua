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
	collisionbox = {-0.5, -0.05, -0.5, 0.5, 1, 0.5},
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

minetest.register_node("mobs_m:mimic_chest2", {
	description = "Mimic Treasure Chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=4},
	on_rightclick = function(pos, node, clicker)
		minetest.env:remove_node(pos)
		minetest.env:add_entity(pos, "mobs_m:mimic2")
	end
})

mobs:register_mob("mobs_m:mimic2", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	reach = 2,
	damage = 3,
	hp_min = 10,
	hp_max = 27,
	armor = 90,
	collisionbox = {-0.5, -0.05, -0.5, 0.5, 1, 0.5},
	visual = "mesh",
	mesh = "mimic.b3d",
	textures = {
		{"mobs_mimic2.png"},
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
			minetest.set_node(pos, {name="mobs_m:mimic_chest2", param2=1})
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
	collisionbox = {-1.6, 0, -1.6, 1.6, 3.3, 1.6},
	visual = "mesh",
	mesh = "mammoth.b3d",
	textures = {
		{"mobs_mammoth.png"},
	},
	blood_texture = "mobs_blood.png",
	makes_footstep_sound = true,
	walk_velocity = 0.5,
	run_velocity = 1,
	jump = 0,
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
		speed_normal = 15,
		speed_run = 17,
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

mobs:register_mob("mobs_m:elephant", {
	type = "animal",
	passive = false,
	reach = 3,
	damage = 5,
	attack_type = "dogfight",
	hp_min = 50,
	hp_max = 550,
	armor = 100,
	visual = "mesh",
	mesh = "elephant.b3d",
	textures = {
		{"mobs_elephant.png"},
	},
	collisionbox = {-1.1, 0, -1.1, 1.1, 2.1, 1.1},
	blood_texture = "mobs_blood.png",
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 2,
	jump = 0,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fall_speed = -9, 
	fear_height = 2,
	replace_rate = 10,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "ethereal:bamboo"},
	replace_with = "air",
	follow = {"compactblocks:default_leaves"},
	view_range = 14,
	drops = {
		{name = "mobs:meat_raw", chance = 2, min = 3, max = 4},
	},
	animation = {
		speed_normal = 14,
		speed_run = 16,
		walk_start = 25,
		walk_end = 45,
		stand_start = 1,
		stand_end = 20,
		run_start = 25,
		run_end = 45,
		punch_start = 25,
		punch_end = 45,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})


mobs:register_egg("mobs_m:elephant", "Elephant", "default_stone.png", 1)
mobs:register_spawn("mobs_m:elephant", {"default:dirt_with_dry_grass",}, 20, 10, 7000, 0, 11000)

mobs:register_mob("mobs_m:horse", {
	type = "animal",
	passive = true,
	hp_min = 50,
	hp_max = 60,
	armor = 100,
	collisionbox = {-0.5, 0, -0.5, 0.5, 1.5, 0.5},
	visual = "mesh",
	mesh = "horse.b3d",
	textures = {
		{"mobs_horse.png"},
	},
	blood_texture = "mobs_blood.png",
	makes_footstep_sound = true,
	walk_velocity = 1.5,
	run_velocity = 3,
	jump = 1,
	stepheight = 1.2,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1, 
	fear_height = 2,
	replace_rate = 10,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "ethereal:bamboo"},
	replace_with = "air",
	follow = {"farming:wheat"},
	view_range = 14,
	drops = {
		{name = "mobs:meat_raw", chance = 2, min = 3, max = 4},
	},
	animation = {
		speed_normal = 16,
		speed_run = 22,
		walk_start = 25,
		walk_end = 45,
		stand_start = 80,
		stand_end = 120,
		run_start = 50,
		run_end = 70,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end
		
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver and clicker:get_wielded_item():get_name() == "mobs:saddle" then
		object_attach(self, clicker, {x=0, y=25, z=0}, true, {x=2, y=6, z=0})
		end
	
		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
	do_custom = function(self, dtime)
	if self.driver then
		self.state = "stand"
		object_drive(self, dtime, {
			speed = 6, 
			decell = 0.6,
			moving_anim = {x=50, y=70},
			stand_anim = {x=1, y=1},
			ignore_water = true
		})
		return false
		end
	return true
	end,
})


mobs:register_egg("mobs_m:horse", "Horse", "default_dirt.png", 1)
mobs:register_spawn("mobs_m:horse", {"default:dirt_with_grass",}, 20, 10, 7000, 0, 11000)

mobs:register_mob("mobs_m:quagga", {
	type = "animal",
	passive = true,
	hp_min = 50,
	hp_max = 60,
	armor = 100,
	collisionbox = {-0.5, 0, -0.5, 0.5, 1.5, 0.5},
	visual = "mesh",
	mesh = "horse.b3d",
	textures = {
		{"mobs_quagga.png"},
	},
	blood_texture = "mobs_blood.png",
	makes_footstep_sound = true,
	walk_velocity = 1.5,
	run_velocity = 3.2,
	jump = 1,
	stepheight = 1.2,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1, 
	fear_height = 2,
	replace_rate = 10,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5",},
	replace_with = "air",
	follow = {"farming:wheat"},
	view_range = 14,
	drops = {
		{name = "mobs:meat_raw", chance = 2, min = 3, max = 4},
	},
	animation = {
		speed_normal = 16,
		speed_run = 22,
		walk_start = 25,
		walk_end = 45,
		stand_start = 80,
		stand_end = 120,
		run_start = 50,
		run_end = 70,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end
		
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver and clicker:get_wielded_item():get_name() == "mobs:saddle" then
		object_attach(self, clicker, {x=0, y=25, z=0}, true, {x=2, y=6, z=0})
		end
	
		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
	do_custom = function(self, dtime)
	if self.driver then
		self.state = "stand"
		object_drive(self, dtime, {
			speed = 6.3, 
			decell = 0.65,
			moving_anim = {x=50, y=70},
			stand_anim = {x=1, y=1},
			ignore_water = true
		})
		return false
		end
	return true
	end,
})


mobs:register_egg("mobs_m:quagga", "Quagga", "wool_orange.png", 1)
--mobs:register_spawn("mobs_m:quagga", {"default:dirt_with_grass",}, 5, 0, 7000, 0, 11000)

mobs:register_mob("mobs_m:zebra", {
	type = "animal",
	passive = true,
	hp_min = 50,
	hp_max = 60,
	armor = 100,
	collisionbox = {-0.5, 0, -0.5, 0.5, 1.5, 0.5},
	visual = "mesh",
	mesh = "horse.b3d",
	textures = {
		{"mobs_zebra.png"},
	},
	blood_texture = "mobs_blood.png",
	makes_footstep_sound = true,
	walk_velocity = 1.5,
	run_velocity = 3.2,
	jump = 1,
	stepheight = 1.2,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1, 
	fear_height = 2,
	replace_rate = 10,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5",},
	replace_with = "air",
	follow = {"farming:wheat"},
	view_range = 14,
	drops = {
		{name = "mobs:meat_raw", chance = 2, min = 3, max = 4},
	},
	animation = {
		speed_normal = 16,
		speed_run = 22,
		walk_start = 25,
		walk_end = 45,
		stand_start = 80,
		stand_end = 120,
		run_start = 50,
		run_end = 70,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end
		
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver and clicker:get_wielded_item():get_name() == "mobs:saddle" then
		object_attach(self, clicker, {x=0, y=25, z=0}, true, {x=2, y=6, z=0})
		end
	
		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
	do_custom = function(self, dtime)
	if self.driver then
		self.state = "stand"
		object_drive(self, dtime, {
			speed = 6.3, 
			decell = 0.65,
			moving_anim = {x=50, y=70},
			stand_anim = {x=1, y=1},
			ignore_water = true
		})
		return false
		end
	return true
	end,
})


mobs:register_egg("mobs_m:zebra", "Zebra", "default_obsidian.png", 1)
mobs:register_spawn("mobs_m:zebra", {"default:dirt_with_dry_grass",}, 20, 10, 7000, 0, 11000)

mobs:register_mob("mobs_m:zombie", {
	type = "monster",
	passive = false,
	reach = 2,
	damage = 1,
	attack_type = "dogfight",
	hp_min = 30,
	hp_max = 40,
	armor = 120,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "character.b3d",
	textures = {
		{"mobs_zombie.png"},
	},
	blood_texture = "mobs_rotten_blood.png",
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 1.5,
	jump = 1,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 2,
	fall_damage = 1,
	view_range = 5,
	drops = {
		{name = "mobs:zombie_flesh_raw", chance = 2, min = 1, max = 2},
	},
	animation = {
		speed_normal = 27,
		speed_run = 27,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 200,
		punch_end = 219,
	},
})


mobs:register_egg("mobs_m:zombie", "Zombie", "default_dirt.png", 1)
mobs:register_spawn("mobs_m:zombie", {"default:dirt_with_grass",}, 5, 0, 7000, 0, 11000)

mobs:register_mob("mobs_m:zombie_brute", {
	type = "monster",
	passive = false,
	reach = 2.5,
	damage = 2,
	attack_type = "dogshoot",
   shoot_interval = 3,
	dogshoot_switch = 2,
	dogshoot_count = 0,
	dogshoot_count_max =1,
   arrow = "mobs_m:stone",
   shoot_offset = 1,
	hp_min = 60,
	hp_max = 80,
	armor = 100,
	collisionbox = {-0.7,0,-0.7, 0.7,2,0.7},
	visual = "mesh",
	mesh = "zombie_brute.b3d",
	textures = {
		{"mobs_zombie_brute.png"},
	},
	blood_texture = "mobs_rotten_blood.png",
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 1.5,
	jump = 1,
	water_damage = 1,
	lava_damage = 2,
	light_damage = 1,
	fall_damage = 0,
	view_range = 15,
	drops = {
		{name = "mobs:zombie_flesh_raw", chance = 2, min = 2, max = 5},
	},
	animation = {
		speed_normal = 27,
		speed_run = 35,
		stand_start = 1,
		stand_end = 20,
		walk_start = 45,
		walk_end = 65,
		run_start = 45,
		run_end = 65,
		punch_start = 20,
		punch_end = 40,
		shoot_start = 75,
		shoot_end = 95,
	},
})


mobs:register_egg("mobs_m:zombie_brute", "Zombie Brute (boss)", "default_dirt.png", 1)
--mobs:register_spawn("mobs_m:zombie_brute", {"default:dirt_with_grass",}, 5, 0, 7000, 0, 11000)

mobs:register_arrow("mobs_m:stone", {
   visual = "cube",
   visual_size = {x = 1, y = 1},
   textures = {
   "default_stone.png",
   "default_stone.png",
   "default_stone.png",
   "default_stone.png",
   "default_stone.png",
   "default_stone.png",
   },
   velocity = 8,
   tail = 0, -- enable tail

   hit_player = function(self, player)
	  player:punch(self.object, 1.0, {
	 full_punch_interval = 1.0,
	 damage_groups = {fleshy = 5},
	  }, nil)
   end,
   
   hit_mob = function(self, player)
	  player:punch(self.object, 1.0, {
	 full_punch_interval = 1.0,
	 damage_groups = {fleshy = 5},
	  }, nil)
   end,

   hit_node = function(self, pos, node)
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" then
			minetest.set_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="default:stone"})
		end
		self.object:remove()
   end,
   
   on_activate = function(self)
		self.object:set_properties({visual_size = {x=0, y=0},})
		local pos = self.object:getpos()
		local velo = self.object:get_velocity()
		self.object:set_pos({x=pos.x, y=pos.y+1.5, z=pos.z})
		minetest.after(0.5, function()
		self.object:set_properties({visual_size = {x=1, y=1},})
		--self.object:set_velocity({x=velo.x*8, y=0, z=velo.z*8})
		self.object:set_acceleration({x=velo.x*8, y=-9, z=velo.z*8})
		end)
   end
})

mobs:register_mob("mobs_m:witch", {
	type = "monster",
	passive = false,
	shoot_offset = 0.7,
	shoot_interval = 1,
	arrow = "mobs_m:lightning",
	attack_type = "shoot",
	hp_min = 30,
	hp_max = 40,
	armor = 100,
	collisionbox = {-0.35,0,-0.35, 0.35,1.8,0.35},
	visual = "mesh",
	mesh = "witch.b3d",
	textures = {
		{"mobs_witch.png"},
	},
	makes_footstep_sound = true,
	walk_velocity = 1.3,
	run_velocity = 1.5,
	jump = 1,
	water_damage = 5,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	view_range = 5,
	drops = {
		{name = "default:obsidian", chance = 2, min = 1, max = 2},
	},
	animation = {
		speed_normal = 16,
		speed_run = 20,
		stand_start = 1,
		stand_end = 30,
		walk_start = 60,
		walk_end = 80,
		run_start = 60,
		run_end = 80,
		shoot_start = 30,
		shoot_end = 50,
	},
})


mobs:register_egg("mobs_m:witch", "Witch", "wool_violet.png", 1)
mobs:register_spawn("mobs_m:witch", {"mapgen:dirt_with_swamp_grass",}, 5, 0, 7000, 0, 11000)

mobs:register_arrow("mobs_m:lightning", {
   visual = "sprite",
   visual_size = {x = 0.5, y = 0.5},
   textures = {"mobs_trans.png"},
   velocity = 4,
   tail = 0, -- enable tail

   hit_player = function(self, player)
	  player:punch(self.object, 1.0, {
	 full_punch_interval = 1.0,
	 damage_groups = {fleshy = 3},
	  }, nil)
   end,
   
   hit_mob = function(self, player)
	  player:punch(self.object, 1.0, {
	 full_punch_interval = 1.0,
	 damage_groups = {fleshy = 3},
	  }, nil)
   end,

   hit_node = function(self, pos, node)
	  self.object:remove()
   end,
   
   on_step = function(self)
		local velo = self.object:getvelocity()
		local pos = self.object:getpos()
		minetest.add_particle({
			pos = {x=pos.x, y=pos.y, z=pos.z},
			velocity = {x=0, y=0, z=0},
			acceleration = {x=0, y=0, z=0},
			expiration_time = 0.1,
			size = 5,
			collision_detection = true,
			collision_removal = true,
			vertical = true,
			texture = "mobs_lightning.png",
			animation = {type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0},
			glow = 12,
		})
   end,
})

mobs:register_mob("mobs_m:swamp_lurker", {
	type = "monster",
	passive = false,
	reach = 2,
	damage = 1,
	attack_type = "dogfight",
	hp_min = 30,
	hp_max = 40,
	armor = 120,
	visual_size = {x=0.7, y=0.7},
	collisionbox = {-0.35, 0,-0.35, 0.35,1.8,0.35},
	visual = "mesh",
	mesh = "swamplurker.b3d",
	textures = {
		{"mobs_swamplurker.png"},
	},
	blood_texture = "default_dirt.png",
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 1.5,
	jump = 1,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	view_range = 10,
	drops = {
		{name = "mobs:zombie_flesh_raw", chance = 2, min = 1, max = 2},
	},
	animation = {
		speed_normal = 14,
		speed_run = 18,
		stand_start = 1,
		stand_end = 25,
		walk_start = 55,
		walk_end = 75,
		run_start = 55,
		run_end = 75,
		punch_start = 20,
		punch_end = 50,
	},
})

mobs:register_egg("mobs_m:swamp_lurker", "Swamp Lurker", "default_dirt.png", 1)
mobs:register_spawn("mobs_m:swamp_lurker", {"default:dirt_with_swamp_grass",}, 5, 0, 7000, 0, 11000)

mobs:register_mob("mobs_m:beetle", {
	type = "monster",
	passive = false,
	reach = 1,
	damage = 1,
	attack_type = "dogfight",
	hp_min = 10,
	hp_max = 20,
	armor = 110,
	collisionbox = {-0.35,0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "beetle.b3d",
	textures = {
		{"mobs_beetle.png"},
	},
	blood_texture = "mobs_blood.png",
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 1.5,
	jump = 1,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	view_range = 15,
	drops = {
		{name = "default:dirt", chance = 2, min = 1, max = 1},
	},
	animation = {
		speed_normal = 27,
		speed_run = 27,
		stand_start = 1,
		stand_end = 20,
		walk_start = 25,
		walk_end = 45,
		run_start = 25,
		run_end = 45,
		punch_start = 1,
		punch_end = 20,
	},
})


mobs:register_egg("mobs_m:beetle", "Giant Beetle", "default_desert_sand.png", 1)
mobs:register_spawn("mobs_m:beetle", {"default:desert_sand",}, 5, 0, 7000, 0, 11000)

local all_colours = {
	{"black",      "Black",      "#000000b0"},
	{"blue",       "Blue",       "#015dbb70"},
	{"brown",      "Brown",      "#663300a0"},
	{"cyan",       "Cyan",       "#01ffd870"},
	{"dark_green", "Dark Green", "#005b0770"},
	{"dark_grey",  "Dark Grey",  "#303030b0"},
	{"green",      "Green",      "#61ff0170"},
	{"grey",       "Grey",       "#5b5b5bb0"},
	{"magenta",    "Magenta",    "#ff05bb70"},
	{"orange",     "Orange",     "#ff840170"},
	{"pink",       "Pink",       "#ff65b570"},
	{"red",        "Red",        "#ff0000a0"},
	{"violet",     "Violet",     "#2000c970"},
	{"white",      "White",      "#abababc0"},
	{"yellow",     "Yellow",     "#e3ff0070"},
}

-- Sheep by PilzAdam, taken from mobs_animal

for _, col in pairs(all_colours) do

	mobs:register_mob("mobs_m:sheep_"..col[1], {
		type = "animal",
		passive = true,
		hp_min = 8,
		hp_max = 10,
		armor = 200,
		collisionbox = {-0.4, 0, -0.4, 0.4, 1.3, 0.4},
		visual = "mesh",
		mesh = "mobs_sheep.b3d",
		textures = {
			{"mobs_sheep_base.png^mobs_sheep_"..col[1]..".png"},
		},
		gotten_texture = {"mobs_sheep_shaved.png"},
		gotten_mesh = "mobs_sheep_shaved.b3d",
		makes_footstep_sound = true,
		sounds = {
			random = "mobs_sheep",
		},
		walk_velocity = 1,
		run_velocity = 2,
		runaway = true,
		jump = true,
		drops = {
			{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
			--{name = "wool:"..col[1], chance = 1, min = 1, max = 1},
		},
		water_damage = 1,
		lava_damage = 5,
		light_damage = 0,
		animation = {
			speed_normal = 16,
			speed_run = 20,
			stand_start = 1,
			stand_end = 25,
			walk_start = 27,
			walk_end = 46,
			run_start = 27,
			run_end = 46,
		},
		follow = {"farming:wheat", "default:grass_5"},
		view_range = 8,
		replace_rate = 10,
		replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "farming:wheat_8"},
		replace_with = "air",
		replace_offset = -1,
		fear_height = 3,

		on_rightclick = function(self, clicker)

			--are we feeding?
			if mobs:feed_tame(self, clicker, 8, true, true) then

				--if full grow fuzz
				if self.gotten == false then

					self.object:set_properties({
						textures = {"mobs_sheep_base.png^mobs_sheep_"..col[1]..".png"},
						mesh = "mobs_sheep.b3d",
					})
				end

				return
			end

			local item = clicker:get_wielded_item()
			local itemname = item:get_name()

			--are we giving a haircut>
			if itemname == "mobs:shears" then

				if self.gotten ~= false
				or self.child ~= false
				or not minetest.get_modpath("wool") then
					return
				end

				self.gotten = true -- shaved

				local obj = minetest.add_item(
					self.object:getpos(),
					ItemStack( "wool:" .. col[1] .. " " .. math.random(1, 3) )
				)

				if obj then

					obj:setvelocity({
						x = math.random(-1, 1),
						y = 5,
						z = math.random(-1, 1)
					})
				end

				item:add_wear(650) -- 100 uses

				clicker:set_wielded_item(item)

				self.object:set_properties({
					textures = {"mobs_sheep_shaved.png"},
					mesh = "mobs_sheep.b3d",
				})

				return
			end

			local name = clicker:get_player_name()

			--are we coloring?
			if itemname:find("dye:") then

				if self.gotten == false
				and self.child == false
				and self.tamed == true
				and name == self.owner then

					local colr = string.split(itemname, ":")[2]

					for _,c in pairs(all_colours) do

						if c[1] == colr then

							local pos = self.object:getpos()

							self.object:remove()

							local mob = minetest.add_entity(pos, "mobs_m:sheep_" .. colr)
							local ent = mob:get_luaentity()

							ent.owner = name
							ent.tamed = true

							-- take item
							if not minetest.setting_getbool("creative_mode") then
								item:take_item()
								clicker:set_wielded_item(item)
							end

							break
						end
					end
				end

				return
			end

			--are we capturing?
			mobs:capture_mob(self, clicker, 0, 5, 60, false, nil)
		end
	})

	mobs:register_egg("mobs_m:sheep_"..col[1], col[2] .. " Sheep", "wool_"..col[1]..".png", 1)

	-- compatibility
	mobs:alias_mob("mobs_animal:sheep_" .. col[1], "mobs_m:sheep_" .. col[1])

end


mobs:register_spawn("mobs_m:sheep_white", {"default:dirt_with_grass",}, 20, 10, 7000, 0, 11000)

mobs:register_mob("mobs_m:badger", {
	type = "animal",
	passive = false,
	reach = 1.5,
	damage = 1,
	attack_type = "dogfight",
	hp_min = 12,
	hp_max = 22,
	armor = 120,
	collisionbox = {-0.5, 0, -0.5, 0.5, 0.7, 0.5},
	visual = "mesh",
	mesh = "badger.b3d",
	textures = {
		{"mobs_badger.png"},
	},
	blood_texture = "mobs_blood.png",
	--visual_size = {x=2, y=2},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 1.5,
	jump = 1,
	jump_height = 5,
	drops = {
		{name = "mobs:meat_raw", chance = 2, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fear_height = 4,
	follow = {"mobs:meat_raw"},
	view_range = 7,
	animation = {
		speed_normal = 22,
		speed_run = 26,
		walk_start = 25,
		walk_end = 45,
		stand_start = 75,
		stand_end = 95,
		run_start = 50,
		run_end = 70,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})


mobs:register_egg("mobs_m:badger", "Badger", "default_obsidian.png", 1)
mobs:register_spawn("mobs_m:badger", {"mapgen:dirt_with_leafy_grass",}, 20, 10, 7000, 0, 11000)





--chicken from mobs_animal (see mobs_redo)


mobs:register_mob("mobs_m:chicken", {
	type = "animal",
	passive = true,
	hp_min = 5,
	hp_max = 10,
	armor = 200,
	collisionbox = {-0.2, 0, -0.2, 0.2, 0.45, 0.2},
	visual = "mesh",
	mesh = "chicken.b3d",
	textures = {
		{"mobs_chicken.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_chicken",
	},
	walk_velocity = 1,
	run_velocity = 3,
	runaway = true,
	jump = true,
	drops = {
		{name = "mobs:chicken_raw", chance = 1, min = 2, max = 2},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fall_damage = 0,
	fall_speed = -8,
	fear_height = 5,
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 20,
		walk_start = 25,
		walk_end = 45,
	},
	follow = {"farming:seed_wheat", "farming:seed_cotton"},
	view_range = 5,

	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:protect(self, clicker)
		mobs:capture_mob(self, clicker, 30, 50, 80, false, nil)
	end,

	do_custom = function(self)

		if self.child
		or math.random(1, 5000) > 1 then
			return
		end

		local pos = self.object:getpos()

		minetest.add_item(pos, "mobs:egg")

		minetest.sound_play("default_place_node_hard", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
	end,
})

mobs:spawn({
	name = "mobs_m:chicken",
	nodes = {"default:dirt_with_grass", "ethereal:bamboo_dirt"},
	min_light = 10,
	chance = 15000,
	active_object_count = 2,
	min_height = 0,
	day_toggle = true,
})

mobs:register_egg("mobs_m:chicken", "Chicken", "mobs_chicken_inv.png", 0)

-- compatibility
mobs:alias_mob("mobs_animal:chicken", "mobs_m:chicken")

-- egg entity

mobs:register_arrow("mobs_m:egg_entity", {
	visual = "sprite",
	visual_size = {x=.5, y=.5},
	textures = {"mobs_chicken_egg.png"},
	velocity = 6,

	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 1},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 1},
		}, nil)
	end,

	hit_node = function(self, pos, node)

		local num = math.random(1, 10)

		if num == 1 then

			pos.y = pos.y + 1

			local nod = minetest.get_node_or_nil(pos)

			if not nod
			or not minetest.registered_nodes[nod.name]
			or minetest.registered_nodes[nod.name].walkable == true then
				return
			end

			local mob = minetest.add_entity(pos, "mobs_m:chicken")
			local ent2 = mob:get_luaentity()

			mob:set_properties({
				textures = ent2.texture[1],
				visual_size = {
					x = ent2.base_size.x / 2,
					y = ent2.base_size.y / 2
				},
				collisionbox = {
					ent2.base_colbox[1] / 2,
					ent2.base_colbox[2] / 2,
					ent2.base_colbox[3] / 2,
					ent2.base_colbox[4] / 2,
					ent2.base_colbox[5] / 2,
					ent2.base_colbox[6] / 2
				},
			})

			ent2.child = true
			ent2.tamed = true
			ent2.owner = self.playername
		end
	end
})

-- egg throwing item

local egg_GRAVITY = 9
local egg_VELOCITY = 19

-- shoot egg
local mobs_shoot_egg = function (item, player, pointed_thing)

	local playerpos = player:getpos()

	minetest.sound_play("default_place_node_hard", {
		pos = playerpos,
		gain = 1.0,
		max_hear_distance = 5,
	})

	local obj = minetest.add_entity({
		x = playerpos.x,
		y = playerpos.y +1.5,
		z = playerpos.z
	}, "mobs_m:egg_entity")

	local ent = obj:get_luaentity()
	local dir = player:get_look_dir()

	ent.velocity = egg_VELOCITY -- needed for api internal timing
	ent.switch = 1 -- needed so that egg doesn't despawn straight away

	obj:setvelocity({
		x = dir.x * egg_VELOCITY,
		y = dir.y * egg_VELOCITY,
		z = dir.z * egg_VELOCITY
	})

	obj:setacceleration({
		x = dir.x * -3,
		y = -egg_GRAVITY,
		z = dir.z * -3
	})

	-- pass player name to egg for chick ownership
	local ent2 = obj:get_luaentity()
	ent2.playername = player:get_player_name()

	item:take_item()

	return item
end

-- egg
minetest.register_node(":mobs:egg", {
	description = "Chicken Egg",
	tiles = {"mobs_chicken_egg.png"},
	inventory_image  = "mobs_chicken_egg.png",
	visual_scale = 0.7,
	drawtype = "plantlike",
	wield_image = "mobs_chicken_egg.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {snappy = 2, dig_immediate = 3},
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name = "mobs:egg", param2 = 1})
		end
	end,
	on_use = mobs_shoot_egg
})

-- fried egg
minetest.register_craftitem(":mobs:chicken_egg_fried", {
description = "Fried Egg",
	inventory_image = "mobs_chicken_egg_fried.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craft({
	type  =  "cooking",
	recipe  = "mobs:egg",
	output = "mobs:chicken_egg_fried",
})

-- raw chicken
minetest.register_craftitem(":mobs:chicken_raw", {
description = "Raw Chicken",
	inventory_image = "mobs_chicken_raw.png",
	on_use = minetest.item_eat(2),
})

-- cooked chicken
minetest.register_craftitem(":mobs:chicken_cooked", {
description = "Cooked Chicken",
	inventory_image = "mobs_chicken_cooked.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craft({
	type  =  "cooking",
	recipe  = "mobs:chicken_raw",
	output = "mobs:chicken_cooked",
})
