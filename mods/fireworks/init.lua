

minetest.register_entity("fireworks:dummy_entity", {
	visual = "sprite",
	textures = {"mapgen_trans.png"},
	collisionbox = {0, 0, 0, 0, 0, 0},
	visual_size = {x=0, y=0},
	physical = false,
	on_activate = function(self)
		minetest.after(2, function()
		self.object:remove()
		end)
	end,
	on_step = function(self)
		for i=1,2 do
		minetest.after(i/10, function()
			if self.object ~= nil then
			local pos = self.object:getpos()
			if pos == nil then
			return end
			minetest.add_particle({
				pos = {x=pos.x, y=pos.y, z=pos.z},
				velocity = {x=0, y=0, z=0},
				acceleration = {x=0, y=0, z=0},
				expirationtime = 1,
				size = 8,
				collisiondetection = false,
				collisionremoval = false,
				vertical = false,
				texture = self.texture,
				animation = {type = "vertical_frames", aspect_w = 8, aspect_h = 8, length = 1.00},
				glow = 13
			})
			end
		end)
		end
	end,
})

local function register_scatter_rocket(number, tex1, flare, shape)
minetest.register_entity("fireworks:firework_"..number.."_rocket", {
	visual = "mesh",
	mesh = "firework_rocket.b3d",
	textures = {"firework_rocket.png"},
	collisionbox = {-0.2, 0, -0.2, 0.2, 0.5, 0.2},
	visual_size = {x=4, y=4},
	physical = true,
	on_activate = function(self)
		minetest.after(3, function()
			local pos = self.object:get_pos()
			local velo = self.object:getvelocity()
			if pos == nil or velo == nil then
			return
			end
			minetest.sound_play("firework_pop", {pos = pos, gain = 1, max_hear_distance = 256})
			if flare then
			minetest.add_particle({
				pos = {x=pos.x, y=pos.y, z=pos.z},
				velocity = {x=0, y=0, z=0},
				acceleration = {x=0, y=0, z=0},
				expirationtime = 1,
				size = 70,
				collisiondetection = false,
				collisionremoval = false,
				vertical = false,
				texture = "firework_flare.png",
				animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 1.00},
				glow = 13
			})
			end
			for i=1,100 do
			if shape == "shower" then
			minetest.add_particle({
				pos = {x=pos.x, y=pos.y, z=pos.z},
				velocity = {x=math.random(-2,2), y=math.random(5,9), z=math.random(-2,2)},
				acceleration = {x=math.random(-2,2), y=-12, z=math.random(-2,2)},
				expirationtime = 2,
				size = 8,
				collisiondetection = false,
				collisionremoval = false,
				vertical = false,
				texture = tex1,
				animation = {type = "vertical_frames", aspect_w = 8, aspect_h = 8, length = 1.00},
				glow = 13
			})
			elseif shape == "scatter" then
			minetest.add_particle({
				pos = {x=pos.x, y=pos.y, z=pos.z},
				velocity = {x=math.random(-2,2), y=math.random(-3,3), z=math.random(-2,2)},
				acceleration = {x=math.random(-2,2), y=math.random(-2,2), z=math.random(-2,2)},
				expirationtime = 2,
				size = 10,
				collisiondetection = false,
				collisionremoval = false,
				vertical = false,
				texture = tex1,
				animation = {type = "vertical_frames", aspect_w = 8, aspect_h = 8, length = 1.00},
				glow = 13
			})
			elseif shape == "scatter" then
			minetest.add_particle({
				pos = {x=pos.x, y=pos.y, z=pos.z},
				velocity = {x=math.random(-2,2), y=math.random(-3,3), z=math.random(-2,2)},
				acceleration = {x=math.random(-2,2), y=math.random(-2,2), z=math.random(-2,2)},
				expirationtime = 2,
				size = 10,
				collisiondetection = false,
				collisionremoval = false,
				vertical = false,
				texture = tex1,
				animation = {type = "vertical_frames", aspect_w = 8, aspect_h = 8, length = 1.00},
				glow = 13
			})
			end
			end
			self.object:remove()
		end)
	end,
})
end

local function register_trail_rocket(number, tex1, flare, shape)
minetest.register_entity("fireworks:firework_"..number.."_rocket", {
	visual = "mesh",
	mesh = "firework_rocket.b3d",
	textures = {"firework_rocket.png"},
	collisionbox = {-0.2, 0, -0.2, 0.2, 0.5, 0.2},
	visual_size = {x=4, y=4},
	physical = true,
	on_activate = function(self)
		minetest.after(3, function()
			local pos = self.object:get_pos()
			local velo = self.object:getvelocity()
			if pos == nil or velo == nil then
			return
			end
			minetest.sound_play("firework_pop", {pos = pos, gain = 1, max_hear_distance = 256})
			if flare then
			minetest.add_particle({
				pos = {x=pos.x, y=pos.y, z=pos.z},
				velocity = {x=0, y=0, z=0},
				acceleration = {x=0, y=0, z=0},
				expirationtime = 1,
				size = 70,
				collisiondetection = false,
				collisionremoval = false,
				vertical = false,
				texture = "firework_flare.png",
				animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 1.00},
				glow = 13
			})
			end
			for i=1,100 do
			if shape == "roundel" then
			local spark = minetest.add_entity(pos, "fireworks:dummy_entity")
			local spark_thing = spark:get_luaentity()
			spark_thing.texture = tex1
			spark:setvelocity({x=math.random(-1,1)*3, y=math.random(-1,1)*3, z=math.random(-1,1)*3})
			spark:setacceleration({x=math.random(-1,1)*3, y=math.random(-4,-4), z=math.random(-1,1)*3})
			elseif shape == "scatter" then
			local spark = minetest.add_entity(pos, "fireworks:dummy_entity")
			local spark_thing = spark:get_luaentity()
			spark_thing.texture = tex1
			spark:setvelocity({x=math.random(-4,4), y=math.random(-4,4), z=math.random(-4,4)})
			spark:setacceleration({x=math.random(-4,4), y=math.random(-4,-4), z=math.random(-4,4)})
			minetest.add_particle({
				pos = {x=pos.x, y=pos.y, z=pos.z},
				velocity = {x=math.random(-2,2), y=math.random(5,9), z=math.random(-2,2)},
				acceleration = {x=math.random(-2,2), y=-12, z=math.random(-2,2)},
				expirationtime = 2,
				size = 8,
				collisiondetection = false,
				collisionremoval = false,
				vertical = false,
				texture = tex1,
				animation = {type = "vertical_frames", aspect_w = 8, aspect_h = 8, length = 1.00},
				glow = 13
			})
			end
			end
			self.object:remove()
		end)
	end,
})
end

local function register_pattern_rocket(number, tex1, flare)
minetest.register_entity("fireworks:firework_"..number.."_rocket", {
	visual = "mesh",
	mesh = "firework_rocket.b3d",
	textures = {"firework_rocket.png"},
	collisionbox = {-0.2, 0, -0.2, 0.2, 0.5, 0.2},
	visual_size = {x=3.5, y=3.5},
	physical = true,
	on_activate = function(self)
		minetest.after(3, function()
			local pos = self.object:get_pos()
			local velo = self.object:getvelocity()
			if pos == nil or velo == nil then
			return
			end
			minetest.sound_play("firework_pop", {pos = pos, gain = 1, max_hear_distance = 128})
			if flare then
			minetest.add_particle({
				pos = {x=pos.x, y=pos.y, z=pos.z},
				velocity = {x=0, y=0, z=0},
				acceleration = {x=0, y=0, z=0},
				expirationtime = 1,
				size = 120,
				collisiondetection = false,
				collisionremoval = false,
				vertical = false,
				texture = "firework_flare.png",
				animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 1.00},
				glow = 13
			})
			end
			minetest.add_particle({
				pos = {x=pos.x, y=pos.y, z=pos.z},
				velocity = {x=0, y=0, z=0},
				acceleration = {x=0, y=-0.2, z=0},
				expirationtime = 1,
				size = 120,
				collisiondetection = false,
				collisionremoval = false,
				vertical = false,
				texture = tex1,
				animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 1.00},
				glow = 13
			})
			self.object:remove()
		end)
	end,
})
end

register_scatter_rocket("1", "firework_spark_r.png", true, "shower")
register_scatter_rocket("2", "firework_spark_g.png", true, "scatter")
register_scatter_rocket("3", "firework_spark_b.png", true, "shower")
register_scatter_rocket("4", "firework_spark_p.png", true, "scatter")
register_pattern_rocket("5", "firework_face.png", true)

register_trail_rocket("6", "firework_spark_r.png", true, "roundel")
register_trail_rocket("7", "firework_spark_g.png", true, "scatter")
register_trail_rocket("8", "firework_spark_b.png", true, "roundel")
register_trail_rocket("9", "firework_spark_p.png", true, "scatter")


minetest.register_tool("fireworks:gun", {
	description = "Firework Gun",
	inventory_image = "firework_gun_2.png",
	wield_scale = {x = 1.5, y = 1.5, z = 1},
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=10, maxlevel=3},
		},
		damage_groups = {fleshy=0},
	},
	on_use = function(item, placer, pointed_thing)
	local inv = placer:get_inventory()
	local number = nil
	for i=1,10 do
		if number == nil then
		if inv:contains_item("main", "fireworks:firework_"..i) then
		local remov = inv:remove_item("main", "fireworks:firework_"..i)
		number = i
		end
	end
	end
	if number == nil then
	return item
	end
		local pos = placer:getpos()
		if pointed_thing ~= nil then
			local dir = placer:get_look_dir()
			local obj =  minetest.env:add_entity({x=pos.x+dir.x, y=pos.y+dir.y+0.5, z=pos.z+dir.z}, "fireworks:firework_"..number.."_rocket")
			minetest.sound_play("firework_whistle", {pos = pos, gain = 0.2, max_hear_distance = 15})
			obj:setvelocity({x=dir.x*15, y=dir.y*20, z=dir.z*15})
			obj:setacceleration({x=dir.x*2, y=-2, z=dir.z*2})
			local rocket = obj:get_luaentity()
			for i=1,23 do
			minetest.after(i/9, function()
			local pos = rocket.object:get_pos()
			local velo = rocket.object:getvelocity()
			if pos == nil or velo == nil then
			return item
			end
			minetest.add_particle({
				pos = {x=pos.x, y=pos.y, z=pos.z},
				velocity = {x=-velo.x*2, y=-velo.y*2, z=-velo.x*2},
				acceleration = {x=math.random(-0.5,0.5), y=-1, z=math.random(-0.5,0.5)},
				expirationtime = 3,
				size = 8,
				collisiondetection = true,
				collisionremoval = true,
				vertical = false,
				texture = "firework_rocket_spark.png",
				animation = {type = "vertical_frames", aspect_w = 15, aspect_h = 15, length = 1.00},
				glow = 13
			})
			end)
		end
	end
	end
})

function firework_launch(pos, name)
minetest.remove_node(pos)
local obj =  minetest.env:add_entity({x=pos.x, y=pos.y, z=pos.z}, name.."_rocket")
			minetest.sound_play("firework_whistle", {pos = pos, gain = 0.2, max_hear_distance = 15})
			obj:setvelocity({x=0, y=15, z=0})
			obj:setacceleration({x=0, y=2, z=0})
			local rocket = obj:get_luaentity()
			for i=1,23 do
			minetest.after(i/9, function()
			local pos = rocket.object:get_pos()
			local velo = rocket.object:getvelocity()
			if pos == nil or velo == nil then
			return
			end
			minetest.add_particle({
				pos = {x=pos.x, y=pos.y, z=pos.z},
				velocity = {x=-velo.x*2, y=-velo.y*2, z=-velo.x*2},
				acceleration = {x=math.random(-0.5,0.5), y=-1, z=math.random(-0.5,0.5)},
				expirationtime = 3,
				size = 8,
				collisiondetection = true,
				collisionremoval = true,
				vertical = false,
				texture = "firework_rocket_spark.png",
				animation = {type = "vertical_frames", aspect_w = 15, aspect_h = 15, length = 1.00},
				glow = 13
			})
			end)
		end
end

minetest.register_node("fireworks:firework_1", {
	description = "Red Firework",
	inventory_image = "firework_rocket_item.png",
	drawtype = "mesh",
	mesh = "firework_rocket2.b3d",
	tiles = {"firework_rocket.png"},
	paramtype = "light",
	collision_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	selection_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	groups = {snappy=1, oddly_breakable_by_hand=1, dig_immediate=3, firework=1},
	color = {r=255,g=100,b=100},
	on_rightclick = function(pos, node, clicker)
		if clicker:get_wielded_item():get_name() == "fire:flint_and_steel" then
		firework_launch(pos, "fireworks:firework_1")
		end
	end
})

minetest.register_node("fireworks:firework_2", {
	description = "Green Firework",
	inventory_image = "firework_rocket_item.png",
	drawtype = "mesh",
	mesh = "firework_rocket2.b3d",
	tiles = {"firework_rocket.png"},
	paramtype = "light",
	collision_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	selection_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	groups = {snappy=1, oddly_breakable_by_hand=1, dig_immediate=3, firework=1},
	color = {r=100,g=255,b=100},
	on_rightclick = function(pos, node, clicker)
		if clicker:get_wielded_item():get_name() == "fire:flint_and_steel" then
		firework_launch(pos, "fireworks:firework_2")
		end
	end
})

minetest.register_node("fireworks:firework_3", {
	description = "Blue Firework",
	inventory_image = "firework_rocket_item.png",
	drawtype = "mesh",
	mesh = "firework_rocket2.b3d",
	tiles = {"firework_rocket.png"},
	paramtype = "light",
	collision_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	selection_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	groups = {snappy=1, oddly_breakable_by_hand=1, dig_immediate=3, firework=1},
	color = {r=100,g=100,b=255},
	on_rightclick = function(pos, node, clicker)
		if clicker:get_wielded_item():get_name() == "fire:flint_and_steel" then
		firework_launch(pos, "fireworks:firework_3")
		end
	end
})

minetest.register_node("fireworks:firework_4", {
	description = "Purple Firework",
	inventory_image = "firework_rocket_item.png",
	drawtype = "mesh",
	mesh = "firework_rocket2.b3d",
	tiles = {"firework_rocket.png"},
	paramtype = "light",
	collision_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	selection_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	groups = {snappy=1, oddly_breakable_by_hand=1, dig_immediate=3, firework=1},
	color = {r=255,g=80,b=255},
	on_rightclick = function(pos, node, clicker)
		if clicker:get_wielded_item():get_name() == "fire:flint_and_steel" then
		firework_launch(pos, "fireworks:firework_4")
		end
	end
})

minetest.register_node("fireworks:firework_5", {
	description = "Smile Firework",
	inventory_image = "firework_rocket_item.png",
	drawtype = "mesh",
	mesh = "firework_rocket2.b3d",
	tiles = {"firework_rocket.png"},
	paramtype = "light",
	collision_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	selection_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	groups = {snappy=1, oddly_breakable_by_hand=1, dig_immediate=3, firework=1},
	color = {r=225,g=225,b=100},
	on_rightclick = function(pos, node, clicker)
		if clicker:get_wielded_item():get_name() == "fire:flint_and_steel" then
		firework_launch(pos, "fireworks:firework_5")
		end
	end
})

minetest.register_node("fireworks:firework_6", {
	description = "Red Trail Firework",
	inventory_image = "firework_rocket_item.png",
	drawtype = "mesh",
	mesh = "firework_rocket2.b3d",
	tiles = {"firework_rocket.png"},
	paramtype = "light",
	collision_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	selection_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	groups = {snappy=1, oddly_breakable_by_hand=1, dig_immediate=3, firework=1},
	color = {r=255,g=100,b=100},
	on_rightclick = function(pos, node, clicker)
		if clicker:get_wielded_item():get_name() == "fire:flint_and_steel" then
		firework_launch(pos, "fireworks:firework_6")
		end
	end
})

minetest.register_node("fireworks:firework_7", {
	description = "Green Trail Firework",
	inventory_image = "firework_rocket_item.png",
	drawtype = "mesh",
	mesh = "firework_rocket2.b3d",
	tiles = {"firework_rocket.png"},
	paramtype = "light",
	collision_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	selection_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	groups = {snappy=1, oddly_breakable_by_hand=1, dig_immediate=3, firework=1},
	color = {r=100,g=255,b=100},
	on_rightclick = function(pos, node, clicker)
		if clicker:get_wielded_item():get_name() == "fire:flint_and_steel" then
		firework_launch(pos, "fireworks:firework_7")
		end
	end
})

minetest.register_node("fireworks:firework_8", {
	description = "Blue Trail Firework",
	inventory_image = "firework_rocket_item.png",
	drawtype = "mesh",
	mesh = "firework_rocket2.b3d",
	tiles = {"firework_rocket.png"},
	paramtype = "light",
	collision_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	selection_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	groups = {snappy=1, oddly_breakable_by_hand=1, dig_immediate=3, firework=1},
	color = {r=100,g=100,b=255},
	on_rightclick = function(pos, node, clicker)
		if clicker:get_wielded_item():get_name() == "fire:flint_and_steel" then
		firework_launch(pos, "fireworks:firework_8")
		end
	end
})

minetest.register_node("fireworks:firework_9", {
	description = "Purple Trail Firework",
	inventory_image = "firework_rocket_item.png",
	drawtype = "mesh",
	mesh = "firework_rocket2.b3d",
	tiles = {"firework_rocket.png"},
	paramtype = "light",
	collision_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	selection_box = {
	type = "fixed",
	fixed = {{-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}},
	},
	groups = {snappy=1, oddly_breakable_by_hand=1, dig_immediate=3, firework=1},
	color = {r=255,g=80,b=255},
	on_rightclick = function(pos, node, clicker)
		if clicker:get_wielded_item():get_name() == "fire:flint_and_steel" then
		firework_launch(pos, "fireworks:firework_9")
		end
	end
})