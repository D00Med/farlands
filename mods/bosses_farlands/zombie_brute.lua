local animation = {
	idle  = {{x = 1, y = 20}, 5},
	punch = {{x = 0, y =  0}, 0},
	box   = {{x = 0, y =  0}, 0},
	walk  = {{x = 0, y =  0}, 0},
	run   = {{x = 0, y =  0}, 0},
	throw = {{x = 0, y =  0}, 0},
}
local function set_anim(obj, anim)
	local a = animation[anim]
	obj:set_animation(a[1], a[2] or 0, a[3] or 0)
end

local gravity = tonumber(minetest.settings:get("movement_gravity"))

minetest.register_entity("bosses_farlands:cube_projectile", {
	hp_max = 1,
	physical = true,
	collide_with_objects = true,
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	visual = "cube",
	visual_size = {x = 1, y = 1},
	textures = {},

	--~ on_activate = function(self, staticdata, dtime_s)
		--~ if staticdata == "" then
			--~ self.object:remove()
			--~ return
		--~ end
		--~ self.textures = staticdata
		--~ self.object:set_properties({textures = self.textures})
		--~ self.object:set_acceleration({x = 0, y = -gravity, z = 0})
	--~ end,
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
		local pos = self.object:get_pos()
		self.object:set_acceleration({x = 0, y = -gravity, z = 0})
		set_anim(self.object, "idle")
		local stone = minetest.add_entity(pos, "bosses_farlands:cube_projectile")
		stone:set_attach(self.object, "rock", {x=0,y=0,z=0}, {x=0,y=0,z=0})
		stone:set_properties({visual_size = {x = 0.2, y = 0.2},})
	end,
	--~ on_step = function(self, dtime)
	--~ end,
	--~ on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	--~ end,
	--~ on_rightclick = function(self, clicker)
	--~ end,
	--~ get_staticdata = function(self)
	--~ end,
})

bosses_farlands.register_egg("bosses_farlands:zombie_brute_egg", "bosses_farlands:zombie_brute", {
	description = "Zombie Brute (boss)",
	inventory_image = "mobs_chicken_egg.png^(default_dirt.png^[mask:mobs_chicken_egg_overlay.png)",
})
