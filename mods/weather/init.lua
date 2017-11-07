if minetest.setting_get("enable_weather") then
local weathers = {
	{"snow", "rain", "storm", "dust", "insects", "none"},
}

local nodes = {
	{{"default:snow", "default:snowblock"}, nil, nil, {"default:desert_sand"}, {"group:flower",}, nil}
}

weather = {}

minetest.register_node("weather:ice", {
	description = "ice sheet",
	tiles = {
		"weather_ice.png",
	},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, -- NodeBox1
		}
	},
	drop = "",
	groups = {cracky=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
})

local apply_weather = function(player, pos, weather_type)
	if weather_type == nil then return end
	--weather effects
	if weather_type == "snow" then
		if minetest.get_timeofday()*24000 >= 6000 and minetest.get_timeofday()*24000 <= 19000 then
		player:set_sky({r=208, g=223, b=238}, "plain", nil, true)
		end
		for i=1,24 do
		minetest.add_particle({
			pos = {x=pos.x+math.random(-10,10), y=pos.y+math.random(12,17), z=pos.z+math.random(-10,10)},
			velocity = {x=math.random(-5,5)/10, y=math.random(-6,-4), z=math.random(-5,5)/10},
			acceleration = {x=math.random(-1,1)/10, y=math.random(-10,-5)/10, z=math.random(-1,1)/10},
			expirationtime = 3,
			size = math.random(3,5),
			collisiondetection = true,
			collision_removal = true,
			vertical = false,
			texture = "weather_snow_"..math.random(1,2)..".png",
			glow = 0
		})
		local water = minetest.find_node_near({x=pos.x+math.random(-7,7), y=pos.y+math.random(-4,4), z=pos.z+math.random(-7,7)}, 10, {"default:water_source", "default:river_water_source"}, true)
		if not water then return end
		water.y =  water.y+1
		if minetest.get_node(water).name == "air" then
			minetest.set_node(water, {name="weather:ice"})
		end
		end
	elseif weather_type == "rain" then
		if minetest.get_timeofday()*24000 >= 6000 and minetest.get_timeofday()*24000 <= 19000 then
		player:set_sky({r=177, g=177, b=177}, "plain", nil, true)
		end
		for i=1,24 do
		minetest.add_particle({
			pos = {x=pos.x+math.random(-10,10), y=pos.y+math.random(12,17), z=pos.z+math.random(-10,10)},
			velocity = {x=0, y=math.random(-20,-15), z=0},
			acceleration = {x=0, y=-1, z=0},
			expirationtime = 2,
			size = math.random(3,5),
			collisiondetection = true,
			collision_removal = true,
			vertical = true,
			texture = "weather_rain_"..math.random(1,2)..".png",
			glow = 0
		})
		end
	elseif weather_type == "storm" then
		if minetest.get_timeofday()*24000 >= 6000 and minetest.get_timeofday()*24000 <= 19000 then
		player:set_sky({r=101, g=101, b=101}, "plain", nil, true)
		end
		for i=1,48 do
		minetest.add_particle({
			pos = {x=pos.x+math.random(-10,10), y=pos.y+math.random(12,17), z=pos.z+math.random(-10,10)},
			velocity = {x=0, y=math.random(-30,-25), z=0},
			acceleration = {x=0, y=-1, z=0},
			expirationtime = 2,
			size = math.random(3,5),
			collisiondetection = true,
			collision_removal = true,
			vertical = true,
			texture = "weather_rain_3.png",
			glow = 0
		})
		if minetest.get_modpath("lightning") and math.random(1,2000) == 1 then
			lightning.strike()
		end
		end
	elseif weather_type == "dust" then
		if minetest.get_timeofday()*24000 >= 6000 and minetest.get_timeofday()*24000 <= 19000 then
		player:set_sky({r=215, g=156, b=91}, "plain", nil, true)
		end
		for i=1,12 do
		minetest.add_particle({
			pos = {x=pos.x+math.random(-10,10), y=pos.y+math.random(1,3)/10, z=pos.z+math.random(-10,10)},
			velocity = {x=1, y=math.random(1,2), z=1},
			acceleration = {x=4, y=math.random(2,3)/10, z=4},
			expirationtime = 0.5,
			size = math.random(3,5),
			collisiondetection = true,
			collision_removal = true,
			vertical = false,
			texture = "weather_dust_1.png",
			glow = 0
		})
		end
	elseif weather_type == "insects" then
		player:set_sky(nil, "regular", nil, true)
	elseif weather_type == "none" then
		player:set_sky(nil, "regular", nil, true)
		return 
	end
end

minetest.register_on_joinplayer(function()
	if math.random(1,500) == 1 then
		for _, row in ipairs(weathers) do
			local num = math.random(1,7)
			weather.current = num
			weather.weather = row[num]
		end
	end
end)

minetest.register_globalstep(function(dtime)
	if math.random(1,4) ~= 4 then return end
	--select random weather (serverwide)
	if math.random(1,5000) == 1 then
		for _, row in ipairs(weathers) do
			local num = math.random(1,6)
			weather.current = num
			weather.weather = row[num]
		end
	end
	--player specific
	for _, player in ipairs(minetest.get_connected_players()) do
		local pos = player:getpos()
		--check if weather should occur at current location
		local display_weather = false
		for _, row in ipairs(nodes) do
			if row[weather.current] ~= nil and minetest.find_node_near(pos, 5, row[weather.current]) then
				display_weather = true
			elseif row[weather.current] == nil then
				display_weather = true
			else 
				display_weather = false
			end
		end
		if pos.y <= -20 then display_weather = false end
		--apply weather effect
		if display_weather then
			apply_weather(player, pos, weather.weather)
			if minetest.get_timeofday()*24000 <= 6000 or minetest.get_timeofday()*24000 >= 19000 then
				player:set_sky(nil, "regular", nil, true)
			end
		else
			apply_weather(player, pos, "none")
		end
	end
end)


minetest.register_privilege("weather", {
  description = "Allows control of weather",
  give_to_singleplayer = false
})

minetest.register_chatcommand("change_weather", {
	params = "<weather_type>",
	description = "Sets weather to the given type",
	privs = {weather = true},
	func = function(name, param)
		weather.weather = param
		for _, row in ipairs(weathers) do
			for i=1,7 do
				if row[i] == param then
					weather.current = i
				end
			end
		end
	end,
})
end