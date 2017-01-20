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
	collisionbox = {-0.8, 0, -0.8, 0.8, 1.8, 0.8},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=11, z=3}, true, {x=0, y=2, z=0})
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		explode(self, 5)
		end
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive(self, dtime, {
			speed = 2, 
			decell = 0.95,
			fly = true,
			fly_mode = "hold",
			gravity = 0.1,
			moving_anim = {x=2, y=20},
			stand_anim = {x=1, y=1},
		})
		return false
		end
	return true
	end,
})

register_vehicle_spawner("vehicles:airballoon", "Airballoon", "vehicles_airballoon_inv.png")

minetest.register_entity("vehicles:boat", {
	visual = "mesh",
	mesh = "vehicles_boat.obj",
	textures = {"vehicles_boat.png"},
	velocity = 15,
	acceleration = -5,
	stepheight = 1,
	hp_max = 200,
	physical = true,
	collisionbox = {-0.5, 0, -0.6, 0.5, 0.3, 0.6},
	on_rightclick = function(self, clicker)
		if self.driver and clicker == self.driver then
		object_detach(self, clicker, {x=1, y=0, z=1})
		elseif not self.driver then
		object_attach(self, clicker, {x=0, y=1.5, z=0}, true, {x=0, y=1.7, z=0})
		end
	end,
	on_punch = function(self, puncher)
		if not self.driver then
		local name = self.object:get_luaentity().name
		local pos = self.object:getpos()
		minetest.env:add_item(pos, name.."_spawner")
		self.object:remove()
		end
		if self.object:get_hp() == 0 then
		if self.driver then
		object_detach(self, self.driver, {x=1, y=0, z=1})
		end
		self.object:remove()
		end
	end,
	on_step = function(self, dtime)
	if self.driver then
		object_drive(self, dtime, {
			speed = 3, 
			decell = 0.85,
			is_watercraft = true,
			gravity = 0,
		})
		return false
		else
		self.object:setvelocity({x=0, y=0, z=0})
		end
		return true
	end,
})

register_vehicle_spawner("vehicles:boat", "Boat", "vehicles_boat_item.png", true)

minetest.register_craft({
	output = 'vehicles:airballoon',
	recipe = {
		{'wool:white', 'wool:white', 'wool:white'},
		{'default:stick', 'default:copper_ingot', 'default:stick'},
		{'', 'group:wood', ''},
	}
})