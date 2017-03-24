
local S = mobs.intllib

-- Npc by TenPlus1

mobs.npc_drops = {
	"default:pick_steel", "mobs:meat", "default:sword_steel",
	"default:shovel_steel", "farming:bread", "bucket:bucket_water"
}

minetest.register_entity("mobs_npc:dummy", {
	visual = "sprite",
	textures = {"xpanes_trans.png"},
	physical = false,
	collisionbox = {0, 0, 0, 0.1, 0.1, 0.1},
	})

mobs:register_mob("mobs_npc:npc", {
	type = "npc",
	passive = false,
	damage = 3,
	attack_type = "dogfight",
	attacks_monsters = true,
	pathfinding = true,
	hp_min = 10,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.35,0,-0.35, 0.35,1.8,0.35},
	visual = "mesh",
	mesh = "villager.b3d",
	drawtype = "front",
	textures = {
		{"mobs_villager.png"},
		{"mobs_villager2.png"},
	},
	child_texture = {
		{"mobs_npc_baby.png"}, -- derpy baby by AmirDerAssassine
	},
	makes_footstep_sound = true,
	sounds = {},
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	drops = {
		{name = "default:wood", chance = 1, min = 1, max = 3},
		{name = "default:apple", chance = 2, min = 1, max = 2},
		{name = "default:axe_stone", chance = 5, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	follow = {"farming:bread", "mobs:meat", "default:diamond", "villages:colony_deed"},
	view_range = 15,
	owner = "",
	order = "follow",
	fear_height = 3,
	animation = {
		speed_normal = 18,
		speed_run = 27,
		stand_start = 1,
		stand_end = 20,
		walk_start = 25,
		walk_end = 45,
		run_start = 70,
		run_end = 90,
		punch_start = 45,
		punch_end = 65,
	},
	do_custom = function(self)
		local pos = self.object:getpos()
		pos.y = pos.y + 0.5
			
		local beds = minetest.find_node_near(pos, 5, {"beds:bed_bottom", "beds:bed", "beds:bed_yellow_bottom", "beds:bed_brown_bottom", "beds:bed_magenta_bottom", "beds:bed_blue_bottom", "beds:bed_orange_bottom", "beds:bed_cyan_bottom", "beds:bed_pink_bottom", "beds:bed_black_bottom", "beds:bed_white_bottom", "beds:bed_darkgrey_bottom", "beds:bed_grey_bottom", "beds:bed_green_bottom", "beds:bed_purple_bottom", "beds:bed_darkgreen_bottom"})
		local light_sources = minetest.find_node_near(pos, 5, {"default:torch", "default:torch_wall", "default:torch_floor", "default:torch_ceiling", "mese_lamp"})
		local doors = minetest.find_node_near(pos, 5, {"doors:door_wood_a", "doors:door_glass_a", "doors:door_obsidian_glass_a"})
		local is_owned = minetest.find_node_near(pos, 5, {"villages:colony_deed", "villages:hobo_deed",})
		local node_below = minetest.get_node({x=pos.x, y=pos.y-1.5, z=pos.z}).name
		local good_floor = minetest.get_item_group(node_below, "crumbly")
		if beds ~= nil and light_sources ~= nil and doors ~= nil and is_owned == nil and self.home == nil and good_floor == 0 then	
			self.home = pos
			local free_space = minetest.find_node_near(light_sources, 1, {"air"})
			local pos1 = free_space
			if minetest.get_node({x=pos1.x-1, y=pos1.y, z=pos1.z}).name ~= "air" then
			minetest.set_node({x=pos1.x, y=pos1.y, z=pos1.z}, {name="villages:colony_deed", param2=3})
			minetest.chat_send_all("param3")
			elseif minetest.get_node({x=pos1.x+1, y=pos1.y, z=pos1.z}).name ~= "air" then
			minetest.set_node({x=pos1.x, y=pos1.y, z=pos1.z}, {name="villages:colony_deed", param2=2})
			minetest.chat_send_all("param2")
			elseif minetest.get_node({x=pos1.x, y=pos1.y, z=pos1.z-1}).name ~= "air" then
			minetest.set_node({x=pos1.x, y=pos1.y, z=pos1.z}, {name="villages:colony_deed", param2=5})
			minetest.chat_send_all("param5")
			elseif minetest.get_node({x=pos1.x, y=pos1.y, z=pos1.z+1}).name ~= "air" then
			minetest.set_node({x=pos1.x, y=pos1.y, z=pos1.z}, {name="villages:colony_deed", param2=4})
			end
			minetest.chat_send_all("NPC home set!")
		end
		
		local game_time = minetest.get_timeofday()*24000
		
		if game_time <= 6000 and game_time >= 18000 and self.pos ~= nil and self.home_object == nil then
			self.home_object = minetest.add_entity(self.home, "mobs_npc:dummy")
			local home_object = self.home_object
			self.following = home_object.object
		else
			
		end
		
	end,
	on_rightclick = function(self, clicker)

		local item = clicker:get_wielded_item()
		local name = clicker:get_player_name()
		
		-- feed to heal npc
		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end


		-- right clicking with gold lump drops random item from mobs.npc_drops
		if item:get_name() == "default:gold_lump" then

			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end

			local pos = self.object:getpos()

			pos.y = pos.y + 0.5

			minetest.add_item(pos, {
				name = mobs.npc_drops[math.random(1, #mobs.npc_drops)]
			})

			minetest.chat_send_player(name, S("NPC dropped you an item for gold!"))

			return
		end


		-- capture npc with net or lasso
		mobs:capture_mob(self, clicker, 0, 5, 80, false, nil)

		-- protect npc with mobs:protector
		mobs:protect(self, clicker)

		-- by right-clicking owner can switch npc between follow and stand
		if self.owner and self.owner == name then

			if self.order == "follow" then
				self.order = "stand"

				minetest.chat_send_player(name, S("NPC stands still."))
			else
				self.order = "follow"

				minetest.chat_send_player(name, S("NPC will follow you."))
			end
		end

	end,
})

mobs:spawn({
	name = "mobs_npc:npc",
	nodes = {"default:brick"},
	neighbors = {"default:grass_3"},
	min_light = 10,
	chance = 10000,
	active_object_count = 1,
	min_height = 0,
	day_toggle = true,
})

mobs:register_egg("mobs_npc:npc", S("Npc"), "default_brick.png", 1)

-- compatibility
mobs:alias_mob("mobs:npc", "mobs_npc:npc")
