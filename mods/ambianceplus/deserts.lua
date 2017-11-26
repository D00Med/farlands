local desert_sound_status = 1

minetest.register_abm({
  nodenames = {"default:desert_sand"},
  neighbors = {"default:desert_stone"},
  interval = 16,
  chance = 500,
  catch_up = false,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if desert_sound_status == 0 then
		return
	end
	local ppos
	for _,player in ipairs(minetest.get_connected_players()) do
		ppos = player:getpos()
	end
	
	if vector.distance(pos,ppos) > 20 then
		return
	end
	
	desert_sound_status = 0
    local daytime = minetest.get_timeofday()*24000

	if daytime > 5000 and daytime < 19250 then -- day
	minetest.sound_play("ambplus_desert", {
	  pos = pos,
	  max_hear_distance = 40,
	  gain = 1 --0.2+1/#path*5,
	})
	else                                       -- night
	minetest.sound_play("ambplus_desert", {
	  pos = pos,
	  max_hear_distance = 40,
	  gain = 1-- 0.2+1/#path*5,
	})
	end

      minetest.after(5,  function()

          desert_sound_status = 1
        end) -- minetest.after() end

  end,
})

local sand_sound_status = 1

minetest.register_abm({
  nodenames = {"default:sand"},
  neighbors = {"default:sandstone"},
  interval = 17,
  chance = 500,
  catch_up = false,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if sand_sound_status == 0 then
		return
	end
	local ppos
	for _,player in ipairs(minetest.get_connected_players()) do
		ppos = player:getpos()
	end
	
	if vector.distance(pos,ppos) > 20 then
		return
	end
	
	sand_sound_status = 0
    local daytime = minetest.get_timeofday()*24000

	if daytime > 5000 and daytime < 19250 then -- day
	minetest.sound_play("ambplus_desert", {
	  pos = pos,
	  max_hear_distance = 40,
	  gain = 1 --0.2+1/#path*5,
	})
	else                                       -- night
	minetest.sound_play("ambplus_desert", {
	  pos = pos,
	  max_hear_distance = 40,
	  gain = 1-- 0.2+1/#path*5,
	})
	end

      minetest.after(5,  function()

          sand_sound_status = 1
        end) -- minetest.after() end

  end,
})

local cold_sound_status = 1

minetest.register_abm({
  nodenames = {"default:silver_sand"},
  neighbors = {"default:stone"},
  interval = 15,
  chance = 500,
  catch_up = false,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if cold_sound_status == 0 then
		return
	end
	local ppos
	for _,player in ipairs(minetest.get_connected_players()) do
		ppos = player:getpos()
	end
	
	if vector.distance(pos,ppos) > 20 then
		return
	end
	
	cold_sound_status = 0
    local daytime = minetest.get_timeofday()*24000

	if daytime > 5000 and daytime < 19250 then -- day
	minetest.sound_play("ambplus_desert", {
	  pos = pos,
	  max_hear_distance = 40,
	  gain = 1 --0.2+1/#path*5,
	})
	else                                       -- night
	minetest.sound_play("ambplus_desert", {
	  pos = pos,
	  max_hear_distance = 40,
	  gain = 1-- 0.2+1/#path*5,
	})
	end

      minetest.after(5,  function()

          cold_sound_status = 1
        end) -- minetest.after() end

  end,
})

