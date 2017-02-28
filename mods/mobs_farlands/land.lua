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
	collisionbox = {-0.5, 0, -0.5, 0.5, 1, 0.5},
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
	collisionbox = {-1.1, 0, -1.1, 1.1, 2.1, 1.1},
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

mobs:register_mob("mobs_m:elephant", {
	type = "animal",
	passive = false,
	reach = 3,
	damage = 5,
	attack_type = "dogfight",
	hp_min = 50,
	hp_max = 550,
	armor = 100,
	collisionbox = {-1.6, 0, -1.6, 1.6, 3.3, 1.6},
	visual = "mesh",
	mesh = "elephant.b3d",
	textures = {
		{"mobs_elephant.png"},
	},
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
		speed_normal = 16,
		speed_run = 19,
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
mobs:register_spawn("mobs_m:elephant", {"default:dirt_with_dry_grass",}, 5, 0, 7000, 0, 11000)

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