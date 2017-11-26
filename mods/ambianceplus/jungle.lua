local jungle_sound_status = 1
local junglenodelist = {}

minetest.register_abm({
  nodenames = {"default:jungletree"},
  neighbors = {"default:jungleleaves", "valleys_c:jungleleaves2", "valleys_c:jungleleaves3"},
  interval = 15,
  chance = 20,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if jungle_sound_status == 0 then
		return
	end
	local ppos
	for _,player in ipairs(minetest.get_connected_players()) do
		ppos = player:getpos()
	end
	
	if vector.distance(pos,ppos) > 15 then
		return
	end
	
	jungle_sound_status = 0
    local daytime = minetest.get_timeofday()*24000

	if daytime > 5000 and daytime < 19250 then -- day
	minetest.sound_play("ambplus_jungle", {
	  pos = pos,
	  max_hear_distance = 20,
	  gain = 1 --0.2+1/#path*5,
	})
	else                                       -- night
	minetest.sound_play("ambplus_jungle_night", {
	  pos = pos,
	  max_hear_distance = 20,
	  gain = 1-- 0.2+1/#path*5,
	})
	end

	minetest.after(5,  function()
		jungle_sound_status = 1
	end) -- minetest.after() end

  end,
})
