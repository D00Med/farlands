vehicles = {}

dofile(minetest.get_modpath("vehicles").."/api.lua")


minetest.register_entity("vehicles:airballoon", {
	visual = "mesh",
	mesh = "airballoon.b3d",
	textures = {"vehicles_airballoon.png"},
	velocity = 15,
	acceleration = -5,
	hp_max = 200,
	animation_speed = 5,
	physical = true,
	collisionbox = {-0.8, -0.2, -0.8, 0.8, 1.8, 0.8},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		vehicles.object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		vehicles.object_attach(self, clicker, {x=0, y=10, z=1}, true, {x=0, y=2, z=5})
		end
	end,
	on_punch = vehicles.on_punch,
	on_step = function(self, dtime)
		return vehicles.on_step(self, dtime, {
			speed = 2, 
			decell = 0.95,
			moving_anim = {x=2, y=20},
			stand_anim = {x=1, y=1},
			fly = true,
			fly_mode = "hold",
			gravity = 0.2,
			animation_speed = 45,
		})
	end,
})

vehicles.register_spawner("vehicles:airballoon", "Airballoon", "vehicles_airballoon_inv.png")

minetest.register_entity("vehicles:boat", {
	visual = "mesh",
	mesh = "vehicles_boat.obj",
	textures = {"vehicles_boat.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1,
	hp_max = 200,
	physical = true,
	collisionbox = {-0.6, 0, -0.7, 0.6, 0.3, 0.7},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		vehicles.object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		vehicles.object_attach(self, clicker, {x=0, y=5, z=4}, false, {x=0, y=12, z=4})
		end
	end,
	on_punch = vehicles.on_punch,
	on_step = function(self, dtime)
		return vehicles.on_step(self, dtime, {
			speed = 4, 
			decell = 0.95,
			is_watercraft = true,
			gravity = 0,
			brakes = true,
			braking_effect = "vehicles_splash.png",
			handling = {initial=3.3, braking=3.5}
		})
	end,
})
