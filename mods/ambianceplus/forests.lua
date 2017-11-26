local forest_sound_status = 1
local forestnodelist = {}

minetest.register_abm({
	nodenames = {"default:tree", "default:aspen_tree", "valleys_c:birch_tree", "valleys_c:cherry_blossom_tree", "valleys_c:fir_tree"},
	neighbors = {"group:leaves"},
	interval = 21,
	chance = 5,
	catch_up = false,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if forest_sound_status == 0 then
			return
		end
		local ppos
		for _,player in ipairs(minetest.get_connected_players()) do
			ppos = player:getpos()
		end

		if vector.distance(pos,ppos) > 10 then
			return
		end

		forest_sound_status = 0
		local daytime = minetest.get_timeofday()*24000

		if daytime > 5000 and daytime < 19250 then -- day
			minetest.sound_play("ambplus_forest", {
			  pos = pos,
			  max_hear_distance = 40,
			  gain = 1 --0.2+1/#path*5,
			})
		else                                       -- night
			minetest.sound_play("ambplus_forest_night", {
			  pos = pos,
			  max_hear_distance = 40,
			  gain = 1-- 0.2+1/#path*5,
			})
		end

		minetest.after(5,  function()
			forest_sound_status = 1
		end) -- minetest.after() end

	end,
})



local pine_sound_status = 1
local pinenodelist = {}

minetest.register_abm({
  nodenames = {"default:pine_tree"},
  neighbors = {"group:leaves"},
  interval = 19,
  chance = 20,
  catch_up = false,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if pine_sound_status == 0 then
		return
	end
	local ppos
	for _,player in ipairs(minetest.get_connected_players()) do
		ppos = player:getpos()
	end

	if vector.distance(pos,ppos) > 10 then
		return
	end

	local snowy_biome = minetest.find_node_near(pos, 10, "default:snow") ~= nil


	pine_sound_status = 0
    local daytime = minetest.get_timeofday()*24000

	if snowy_biome then

		if daytime > 5000 and daytime < 19250 then -- day
		minetest.sound_play("ambplus_snowy_coniferous", {
		  pos = pos,
		  max_hear_distance = 40,
		  gain = 1 --0.2+1/#path*5,
		})
		else                                       -- night
		minetest.sound_play("ambplus_snowy_coniferous_night", {
		  pos = pos,
		  max_hear_distance = 40,
		  gain = 1-- 0.2+1/#path*5,
		})
		end

	else

		if daytime > 5000 and daytime < 19250 then -- day
		minetest.sound_play("ambplus_coniferous", {
		  pos = pos,
		  max_hear_distance = 40,
		  gain = 1 --0.2+1/#path*5,
		})
		else                                       -- night
		minetest.sound_play("ambplus_coniferous_night", {
		  pos = pos,
		  max_hear_distance = 40,
		  gain = 1-- 0.2+1/#path*5,
		})
		end
	end

      minetest.after(5,  function()

          pine_sound_status = 1
        end) -- minetest.after() end

  end,
})
