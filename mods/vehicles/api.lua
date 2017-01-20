--vehicles/mounts api by D00Med, based on lib_mount(see below)

--License of lib_mount:
-- Minetest mod: lib_mount
-- =======================
-- by blert2112

-- Based on the Boats mod by PilzAdam.


-- -----------------------------------------------------------
-- -----------------------------------------------------------


-- Minetest Game mod: boats
-- ========================
-- by PilzAdam

-- License of source code:
-- -----------------------
-- WTFPL


--from lib_mount (required by new functions)


--attach position seems broken, and eye offset will cause problems if the vehicle/mount/player is destroyed whilst driving/riding

local function force_detach(player)
	local attached_to = player:get_attach()
	if attached_to and attached_to:get_luaentity() then
		local entity = attached_to:get_luaentity()
		if entity.driver then
			if entity ~= nil then entity.driver = nil end
		end
		player:set_detach()
	end
	default.player_attached[player:get_player_name()] = false
	player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
	player:set_properties({visual_size = {x=1, y=1}})
end

function object_attach(entity, player, attach_at, visible, eye_offset)
	force_detach(player)
	entity.driver = player
	entity.loaded = true
	entity.loaded2 = true
	player:set_attach(entity.object, "", attach_at, {x=0, y=0, z=0})
	-- this is to hide the player when the attaching doesn't work properly
	if not visible then
	player:set_properties({visual_size = {x=0, y=0}})
	else
	player:set_properties({visual_size = {x=1, y=1}})
	end
	player:set_eye_offset(eye_offset, {x=eye_offset.x, y=eye_offset.y+1, z=-40})
	default.player_attached[player:get_player_name()] = true
	minetest.after(0.2, function()
		default.player_set_animation(player, "sit" , 30)
	end)
	entity.object:setyaw(player:get_look_yaw() - math.pi / 2)
end

function object_detach(entity, player, offset)
	entity.driver = nil
	entity.object:setvelocity({x=0, y=0, z=0})
	player:set_detach()
	default.player_attached[player:get_player_name()] = false
	default.player_set_animation(player, "stand" , 30)
	player:set_properties({visual_size = {x=1, y=1}})
	player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
	local pos = player:getpos()
	pos = {x = pos.x + offset.x, y = pos.y + 0.2 + offset.y, z = pos.z + offset.z}
	minetest.after(0.1, function()
		player:setpos(pos)
	end)
end
-------------------------------------------------------------------------------


minetest.register_on_leaveplayer(function(player)
	force_detach(player)
end)

minetest.register_on_shutdown(function()
    local players = minetest.get_connected_players()
	for i = 1,#players do
		force_detach(players[i])
	end
end)

minetest.register_on_dieplayer(function(player)
	force_detach(player)
	return true
end)

-------------------------------------------------------------------------------

--mixed code(from this mod and lib_mount)


timer = 0

--New vehicle function, combines all of the others

function object_drive(entity, dtime, def)
	--definition
	local speed = def.speed or 10
	local fixed = def.fixed or false
	local decell = def.decell or 0
	local shoots = def.shoots or false
	local arrow = def.arrow or nil
	local reload_time = def.reload_time or 1
	local shoot_y = def.shoot_y or 1.5
	local shoot_angle = def.shoot_angle or 0
	local infinite_arrow = def.infinite_arrow or false
	local shoots2 = def.shoots2 or false
	local arrow2 = def.arrow2 or nil
	local reload_time2 = def.reload_time2 or 1
	local shoot_y2 = def.shoot_y2 or 1.5
	local infinite_arrow2 = def.infinite_arrow2 or false
	local jump = def.jump_type or nil
	local fly = def.fly or nil
	local fly_mode = def.fly_mode or "hold"
	local rise_speed = def.rise_speed or 0.1
	local gravity = def.gravity or 1
	local boost = def.boost or false
	local boost_duration = def.boost_duration or 5
	local boost_charge = def.boost_charge or 4
	local boost_effect = def.boost_effect
	local hover_speed = def.hover_speed or 1.5
	local jump_speed = def.jump_speed or 5
	local simple_vehicle = def.simple_vehicle or false
	local is_watercraft = def.is_watercraft or false
	local swims = def.swims or false
	local driving_sound = def.driving_sound or nil
	local sound_duration = def.sound_duration or 5
	local extra_yaw = def.extra_yaw or 0
	
	local moving_anim = def.moving_anim
	local stand_anim = def.stand_anim
	local jump_anim = def.jump_anim
	local shoot_anim = def.shoot_anim
	local shoot_anim2 = def.shoot_anim2
	
	--variables
	local ctrl = entity.driver:get_player_control()
	local velo = entity.object:getvelocity()
	local dir = entity.driver:get_look_dir();
	local vec_backward = {x=-dir.x*speed/4,y=velo.y+1*-2,z=-dir.z*speed/4}
	local vec_stop = {x=velo.x*decell,y=velo.y+1*-2,z=velo.z*decell}
	local yaw = entity.driver:get_look_yaw();
	local pos = entity.object:getpos()
	local node = minetest.get_node(pos).name
	local accell = 1
	
	--dummy variables
	local vec_rise = {}
	local vec_forward_simple = {}
	local inv = nil
	
	--definition dependant variables
	if fly then
		vec_rise = {x=velo.x, y=speed*rise_speed, z=velo.z}
	end
	if simple_vehicle then
		vec_forward_simple = {x=dir.x*speed,y=velo.y+1*-2,z=dir.z*speed}
	end
	if shoots then
		local pname = entity.driver:get_player_name();
		inv = minetest.get_inventory({type="player", name=pname});
	end
	
	--timer
	local absolute_speed = math.sqrt(math.pow(velo.x, 2)+math.pow(velo.z, 2))
	if absolute_speed <= speed and ctrl.up then
	timer = timer + 1*dtime
	end
	if not ctrl.up then
	timer = 0
	end
	
	--timer dependant variables
	local vec_forward_hover = {x=dir.x*(speed*0.2)*math.log(timer+0.5)+4*dir.x,y=hover_speed,z=dir.z*(speed*0.2)*math.log(timer+0.5)+4*dir.z}
	local vec_forward_jump = {x=dir.x*speed/4*math.atan(0.5*timer-2)+8*dir.x,y=jump_speed,z=dir.z*speed/4*math.atan(0.5*timer-2)+8*dir.z}
	local vec_forward = {x=dir.x*(speed*0.2)*math.log(timer+0.5)+4*dir.x,y=velo.y-0.5,z=dir.z*(speed*0.2)*math.log(timer+0.5)+4*dir.z}
	local boat_forward = {x=dir.x*(speed*0.2)*math.log(timer+0.5)+4*dir.x,y=0,z=dir.z*(speed*0.2)*math.log(timer+0.5)+4*dir.z}
	local vec_forward_fly = {x=dir.x*(speed*0.2)*math.log(timer+0.5)+4*dir.x,y=dir.y*(speed*0.2)*math.log(timer+0.5)+4*dir.y+1,z=dir.z*(speed*0.2)*math.log(timer+0.5)+4*dir.z}
	local vec_boost = {x=dir.x*(speed*0.2)*math.log(timer+0.5)+8*dir.x,y=velo.y-0.5,z=dir.z*(speed*0.2)*math.log(timer+0.5)+8*dir.z}
	local vec_backward = {x=-dir.x*(speed/4)*accell,y=velo.y-0.5,z=-dir.z*(speed/4)*accell}
	local boat_backward = {x=-dir.x*(speed/4)*accell,y=0,z=-dir.z*(speed/4)*accell}
	local vec_stop = {x=velo.x*decell,y=velo.y-gravity,z=velo.z*decell}
	
	--boost reset
	if boost and not entity.boost then
		minetest.after(boost_charge, function()
		entity.boost = true
		end)
	end
	
	--respond to controls
	--check for water
	if node == "default:river_water_source" or node == "default:water_source" or node == "default:river_water_flowing" or node == "default:water_flowing" or node == "mapgen:dirty_water_source" or node == "mapgen:dirty_water_flowing" then
	entity.on_water = true
	else 
	entity.on_water = false
	end

	--apply water effects
	if is_watercraft and entity.on_water == false then
		entity.object:setvelocity({x=0, y=0, z=0})
	elseif entity.on_water and not is_watercraft then
		entity.object:setvelocity({x=velo.x*0.9, y=-1, z=velo.z*0.9})
	--boost
	elseif ctrl.up and not shoots2 and ctrl.aux1 and entity.boost then
		entity.object:setyaw(yaw+math.pi+math.pi/2+extra_yaw)
		entity.object:setvelocity(vec_boost)
		if boost_effect ~= nil then
			minetest.add_particlespawner(
			5, --amount
			1, --time
			{x=pos.x-0.5, y=pos.y, z=pos.z-0.5}, --minpos
			{x=pos.x+0.5, y=pos.y, z=pos.z+0.5}, --maxpos
			{x=-velo.x, y=-velo.y, z=-velo.z}, --minvel
			{x=-velo.x, y=-velo.y, z=-velo.z}, --maxvel
			{x=-0,y=-0,z=-0}, --minacc
			{x=0,y=1,z=0}, --maxacc
			0.1, --minexptime
			0.2, --maxexptime
			5, --minsize
			10, --maxsize
			false, --collisiondetection
			boost_effect --texture
			)
		end
			minetest.after(boost_duration, function()
			entity.nitro = false
			end)
	--animation
	if moving_anim ~= nil and not entity.moving and not hovering then
		entity.object:set_animation(move_anim, 20, 0)
		entity.moving = true
	end
	--rise
	elseif ctrl.jump and fly and fly_mode == "rise" then
		entity.object:setyaw(yaw+math.pi+math.pi/2+extra_yaw)
		entity.object:setvelocity(vec_rise)
		--lib_mount animation
	if moving_anim ~= nil and not entity.moving then
		entity.object:set_animation(moving_anim, 20, 0)
		entity.moving = true
	end
	--hover in place
	elseif ctrl.jump and ctrl.up and fly and fly_mode == "hold" then
		entity.object:setvelocity({x=dir.x*speed, y=0, z=dir.z*speed})
	--move forward
	elseif ctrl.up and not fixed then
		entity.object:setyaw(yaw+math.pi+math.pi/2+extra_yaw)
		if not fly and not is_watercraft then
		entity.object:setvelocity(vec_forward)
		elseif not fly then
		entity.object:setvelocity(boat_forward)
		else
		entity.object:setvelocity(vec_forward_fly)
		end
	--animation
	if moving_anim ~= nil and not entity.moving and not hovering then
		entity.object:set_animation(moving_anim, 20, 0)
		entity.moving = true
	end
	--move backward
	elseif ctrl.down and not fixed then
		entity.object:setyaw(yaw+math.pi+math.pi/2+extra_yaw)
		if not is_watercraft then
		entity.object:setvelocity(vec_backward)
		else
		entity.object:setvelocity(boat_backward)
		end
	--animation
	if moving_anim ~= nil and not entity.moving and not hovering then
		entity.object:set_animation(moving_anim, 20, 0)
		entity.moving = true
	end
	--stop
	elseif not ctrl.down or ctrl.up then
		entity.object:setyaw(yaw+math.pi+math.pi/2+extra_yaw)
		entity.object:setvelocity(vec_stop)
	--animation
	if moving_anim ~= nil and entity.moving and not hovering then
		entity.object:set_animation(stand_anim, 20, 0)
		entity.moving = false
	end
	end
	--shoot weapons
	if ctrl.sneak and shoots and entity.loaded then
			if inv:contains_item("main", arrow.."_item") or infinite_arrow then
			local remov = inv:remove_item("main", arrow.."_item")
			entity.loaded = false
			local obj = minetest.env:add_entity({x=pos.x+0+dir.x*2,y=pos.y+shoot_y+dir.y,z=pos.z+0+dir.z*2}, arrow)
			local vec = {x=dir.x*14,y=dir.y*14+shoot_angle,z=dir.z*14}
			obj:setyaw(yaw+math.pi/2+extra_yaw)
			obj:setvelocity(vec)
			local object = obj:get_luaentity()
			object.launcher = entity.driver
			--lib_mount animation
			if shoot_anim ~= nil and entity.object:get_animation().range ~= shoot_anim then
			entity.object:set_animation(shoot_anim, 20, 0)
			end
			minetest.after(reload_time, function()
			entity.loaded = true
			if stand_anim ~= nil and shoot_anim ~= nil then
			entity.object:set_animation(stand_anim, 20, 0)
			end
			end)
			end
	end
	
	if ctrl.aux1 and shoots2 and entity.loaded2 then
			if inv:contains_item("main", arrow2.."_item") or infinite_arrow2 then
			local remov = inv:remove_item("main", arrow2.."_item")
			entity.loaded2 = false
			local obj = minetest.env:add_entity({x=pos.x+0+dir.x*2,y=pos.y+shoot_y2+dir.y,z=pos.z+0+dir.z*2}, arrow2)
			local vec = {x=dir.x*14,y=dir.y*14+shoot_angle,z=dir.z*14}
			obj:setyaw(yaw+math.pi/2+extra_yaw)
			obj:setvelocity(vec)
			local object = obj:get_luaentity()
			object.launcher = entity.driver
			--lib_mount animation
			if shoot_anim2 ~= nil and entity.object:get_animation().range ~= shoot_anim2 then
			entity.object:set_animation(shoot_anim2, 20, 0)
			end
			minetest.after(reload_time2, function()
			entity.loaded2 = true
			if stand_anim ~= nil and shoot_anim2 ~= nil then
			entity.object:set_animation(stand_anim, 20, 0)
			end
			end)
			end
	end
	--jump(hover) without moving forward
	if jump == "hover" and ctrl.jump and not entity.jumpcharge then
		if not ctrl.up then
		local vec_hover = {x=velo.x+0,y=hover_speed,z=velo.z+0}
		entity.object:setvelocity(vec_hover)
		else
		entity.object:setvelocity(vec_forward_hover)
		end
		hovering = true
		if jump_anim ~= nil and entity.object:get_animation().range ~= jump_anim and hovering then
			entity.object:set_animation(jump_anim, 20, 0)
		end
		minetest.after(5, function()
		entity.jumpcharge =  true
		end)
		minetest.after(10, function()
		entity.jumpcharge =  false
		hovering = false
		end)
	end
	--jump (jump) without moving forward
	if jump == "jump" and ctrl.jump and not entity.jumpcharge then
		if not ctrl.up then
		local vec_jump = {x=velo.x+0,y=jump_speed,z=velo.z+0}
		entity.object:setvelocity(vec_jump)
		else
		entity.object:setvelocity(vec_forward_hover)
		end
		hovering = true
		if jump_anim ~= nil and entity.object:get_animation().range ~= jump_anim and hovering then
			entity.object:set_animation(jump_anim, 20, 0)
		end
		minetest.after(0.5, function()
		entity.jumpcharge =  true
		end)
		minetest.after(1, function()
		entity.jumpcharge =  false
		hovering = false
		end)
	end
	
	--play sound
	if entity.sound_ready then
	minetest.sound_play(driving_sound, 
		{gain = 4, max_hear_distance = 3, loop = false})
	entity.sound_ready = false
	minetest.after(sound_duration, function()
	entity.sound_ready = true
	end)
	end
	
end

--simplified in an attempt to reduce lag

function object_drive_simple(entity, dtime, speed, decell)
	local ctrl = entity.driver:get_player_control()
	local velo = entity.object:getvelocity()
	local dir = entity.driver:get_look_dir();
	local vec_forward = {x=dir.x*speed,y=velo.y+1*-2,z=dir.z*speed}
	local vec_backward = {x=-dir.x*speed,y=velo.y+1*-2,z=-dir.z*speed}
	local vec_stop = {x=velo.x*decell,y=velo.y+1*-2,z=velo.z*decell}
	local yaw = entity.driver:get_look_yaw();
		entity.object:setyaw(yaw+math.pi+math.pi/2)
	if ctrl.up then
		entity.object:setvelocity(vec_forward)
	elseif ctrl.down then
		entity.object:setvelocity(vec_backward)
	elseif not ctrl.down or ctrl.up then
		entity.object:setvelocity(vec_stop)
	end
end

function object_glide(entity, dtime, speed, decell, gravity, moving_anim, stand_anim)
	local ctrl = entity.driver:get_player_control()
	local dir = entity.driver:get_look_dir();
	local velo = entity.object:getvelocity();
	local vec_glide = {x=dir.x*speed*decell, y=velo.y, z=dir.z*speed*decell}
	local yaw = entity.driver:get_look_yaw();
	if not ctrl.sneak then
		entity.object:setyaw(yaw+math.pi+math.pi/2)
		entity.object:setvelocity(vec_glide)
		entity.object:setacceleration({x=0, y=gravity, z=0})
	end
	if ctrl.sneak then
			local vec = {x=0,y=gravity*15,z=0}
			local yaw = entity.driver:get_look_yaw();
			entity.object:setyaw(yaw+math.pi+math.pi/2)
			entity.object:setvelocity(vec)
	end
	if velo.y == 0 then
		local pos = entity.object:getpos()
		for dx=-1,1 do
						for dy=-1,1 do
							for dz=-1,1 do
								local p = {x=pos.x+dx, y=pos.y-1, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "massdestruct:parachute" and n ~= "air" then
									local pos = entity.object:getpos()
									entity.object:remove()
									return
								end
							end
						end
					end
	 end
end

--spawner

function register_vehicle_spawner(vehicle, desc, texture, is_boat)
minetest.register_craftitem(vehicle.."_spawner", {
	description = desc,
	inventory_image = texture,
	liquids_pointable = is_boat,
	wield_scale = {x = 1.5, y = 1.5, z = 1},
	on_place = function(item, placer, pointed_thing)
			local dir = placer:get_look_dir();
			local playerpos = placer:getpos();
			if pointed_thing.type == "node" and not is_boat then
			local obj = minetest.env:add_entity(pointed_thing.above, vehicle)
			local object = obj:get_luaentity()
			object.owner = placer
			item:take_item()
			return item
			elseif pointed_thing.type == "node" and minetest.get_item_group(pointed_thing.name, "water") then
			local obj = minetest.env:add_entity(pointed_thing.under, vehicle)
			obj:setvelocity({x=0, y=-1, z=0})
			local object = obj:get_luaentity()
			object.owner = placer
			item:take_item()
			return item
			end
	end,
})
end

--explodinate

function explode(ent, radius)
	local pos = ent.object:getpos()
	minetest.add_particlespawner({
			amount = 90,
			time = 4,
			minpos = {x=pos.x-0.6, y=pos.y, z=pos.z-0.6},
			maxpos = {x=pos.x+0.6, y=pos.y+1, z=pos.z+0.6},
			minvel = {x=-0.1, y=3.5, z=-0.1},
			maxvel = {x=0.1, y=4.5, z=0.1},
			minacc = {x=-1.3, y=-0.7, z=-1.3},
			maxacc = {x=1.3, y=-0.7, z=1.3},
			minexptime = 2,
			maxexptime = 3,
			minsize = 15,
			maxsize = 25,
			collisiondetection = false,
			texture = "vehicles_explosion.png"
		})
	minetest.after(1, function()
	minetest.add_particlespawner({
			amount = 30,
			time = 4,
			minpos = {x=pos.x-1, y=pos.y+2, z=pos.z-1},
			maxpos = {x=pos.x+1, y=pos.y+3, z=pos.z+1},
			minvel = {x=0, y=-1, z=0},
			maxvel = {x=0, y=-2, z=0},
			minacc = {x=0, y=-0.6, z=0},
			maxacc = {x=0, y=-0.6, z=0},
			minexptime = 1,
			maxexptime = 3,
			minsize = 1,
			maxsize = 2,
			collisiondetection = false,
			texture = "vehicles_explosion.png"
		})
		end)
end