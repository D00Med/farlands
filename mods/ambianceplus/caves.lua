--~ print(dump(minetest.registered_biomes))
--~ id =minetest.get_biome_id("deciduous_forest_shore")
--~ print(id)
--~ print(dump(minetest.registered_biomes["deciduous_forest_shore"]))
--[[local willow_schematic = minetest.get_modpath("mapgen") .. "/schematics/willow2.mts"

minetest.register_on_generated(function(minp, maxp)
	local zstride = maxp.x - minp.x
	local biomemap = minetest.get_mapgen_object("biomemap")
	--~ local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	--~ local a = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
	--~ local data = vm:get_data()
	--~ local c_air = minetest.get_content_id("air")
	--~ local c_ignore = minetest.get_content_id("ignore")
	--~ local c_glass = minetest.get_content_id("default:meselamp")
	--~ local heightmap = minetest.get_mapgen_object("heightmap")
	--~ local csize = vector.add(vector.subtract(maxp, minp), 1)
	local nodes, count = minetest.find_nodes_in_area_under_air(minp, maxp, {"mapgen:dirt_with_swampgrass"})
	for _, node in ipairs(nodes) do
		local above = {x = node.x, y = node.y + 1, z = node.z}
		local rand = math.random(100)
		if rand == 1 then
			minetest.place_schematic(above, willow_schematic, "random", nil, false)
		elseif rand > 1 and rand < 10 then
			minetest.place_node(above, {name = "mapgen:swamp_grass_5"})
		end
	end
--~ print(dump(count))
	--~ for z = minp.z, maxp.z do
	--for y = minp.y, maxp.y do
	--~ for x = minp.x, maxp.x do
		--~ local index = (z - minp.z) * zstride + (x - minp.x) + 1
		--~ local biome = biomemap[index]
		--~ print(biome)
		--local index2d = (z - minp.z) * csize.x + (x - minp.x) + 1
		----~ local y = heightmap[index2d]
		----~ print(y)
		----~ if y > -31 then
			--local vi = a:index(x, y, z)

		--if data[vi] == c_air or data[vi] == c_ignore then
			--data[vi] = c_glass
		--end
	--~ end
	--end
	--~ end

	--~ vm:set_data(data)
	--~ vm:write_to_map()
end)
]]--

--minetest.register_on_generated(function(minp, maxp)

	----~ local nodes, count = minetest.find_nodes_in_area(minp, maxp, {"air"})
	--local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	--local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	--local data = vm:get_data()
	--local c_air = minetest.get_content_id("air")
	--local c_glass = minetest.get_content_id("default:meselamp")
	--local heightmap = minetest.get_mapgen_object("heightmap")
	--local csize = a:getExtent()

	--for z = minp.z, maxp.z do
	--for y = minp.y, maxp.y do
	--for x = minp.x, maxp.x do
		--local index2d = (z - minp.z) * csize.x + (x - minp.x) + 1
		--local y = heightmap[index2d]
		----~ if y > -31000 then
			----~ print(y)
			----~ y = 0
			--local vi = a:index(x, y, z)
		----~ if data[vi] == c_air then
			--data[vi] = c_glass
		----~ end
		--end
	--end
	--end

	--vm:set_data(data)
	--vm:write_to_map()
--end)

local dripping_sound_status = 1


minetest.register_abm({
	nodenames = {"default:coal", "default:stone_with_coal"},
	label = "cave dripping",
	interval = 30,
	chance = 10,
	catch_up = false,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if dripping_sound_status == 0 then
			return
		end


		local ppos
		for _,player in ipairs(minetest.get_connected_players()) do
			ppos = player:getpos()
		end

		if ppos.y > 0 then
			return
		end

		if vector.distance(pos,ppos) > 20 then
			return
		end

		if math.random(0,3) > 0 then
			dripping_sound_status = 0
			minetest.after(2,  function()
				dripping_sound_status = 1
			end) -- minetest.after() end

			return
		end

		minetest.sound_play("ambplus_caves_dripping", {
		  pos = pos,
		  max_hear_distance = 21,
		  gain = 1 --0.2+1/#path*5,
		})

		dripping_sound_status = 0

		  minetest.after(5,  function()

			  dripping_sound_status = 1
			end) -- minetest.after() end


	end,
})


local ambiance_sound_status = 1


minetest.register_abm({
	nodenames = {"default:coal", "default:stone_with_coal"},
	label = "cave ambiance",
	interval = 30,
	chance = 10,
	catch_up = false,
	action = function(pos, node, active_object_count, active_object_count_wider)

		if ambiance_sound_status == 0 then
			return
		end


		local ppos
		for _,player in ipairs(minetest.get_connected_players()) do
			ppos = player:getpos()
		end

		if ppos.y > 0 then
			return
		end

		if vector.distance(pos,ppos) > 20 then
			return
		end

		if math.random(0,2) > 0 then
			ambiance_sound_status = 0
			minetest.after(2,  function()
				ambiance_sound_status = 1
			end) -- minetest.after() end

			return
		end
		minetest.sound_play("ambplus_caves_ambiance", {
		  pos = pos,
		  max_hear_distance = 21,
		  gain = 1 --0.2+1/#path*5,
		})

		ambiance_sound_status = 0

		minetest.after(5,  function()
			ambiance_sound_status = 1
		end
		) -- minetest.after() end


	end,
})


local water_sound_status = 1


minetest.register_abm({
	nodenames = {"default:water_source", "default:river_water_source"},
	neighbors = {"air"},
	label = "cave water",
	interval = 24,
	chance = 10,
	catch_up = false,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if water_sound_status == 0 then
			return
		end


		local ppos
		for _,player in ipairs(minetest.get_connected_players()) do
			ppos = player:getpos()
		end

		if ppos.y > 0 then
			return
		end


		if pos.y > -5 then
			return
		end

		if vector.distance(pos,ppos) > 25 then
			return
		end


		minetest.sound_play("ambplus_caves_water", {
		  pos = pos,
		  max_hear_distance = 26,
		  gain = 1 --0.2+1/#path*5,
		})

		water_sound_status = 0

		minetest.after(5,  function()
			water_sound_status = 1
			end
		)


	end,
})

local waterflowing_sound_status = 1


minetest.register_abm({
	nodenames = {"default:water_flowing",  "default:river_water_flowing"},
	neighbors = {"air"},
	label = "cave water flowing",
	interval = 12,
	chance = 5,
	catch_up = false,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if waterflowing_sound_status == 0 then
			return
		end


		local ppos
		for _,player in ipairs(minetest.get_connected_players()) do
			ppos = player:getpos()
		end

		if ppos.y > 0 then
			return
		end

		if vector.distance(pos,ppos) > 25 then
			return
		end


		minetest.sound_play("ambplus_caves_water_flowing", {
		  pos = pos,
		  max_hear_distance = 26,
		  gain = 1	--0.2+1/#path*5,
		})

		waterflowing_sound_status = 0

		minetest.after(5,  function()

			waterflowing_sound_status = 1
			end
		)


	end,
})

local lava_sound_status = 1


minetest.register_abm({
	nodenames = {"default:lava_source", "default:lava_flowing"},
	neighbors = {"air"},
	interval = 14,
	chance = 20,
	catch_up = false,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if lava_sound_status == 0 then
			return
		end


		local ppos
		for _,player in ipairs(minetest.get_connected_players()) do
			ppos = player:getpos()
		end

		if ppos.y > 0 then
			return
		end

		if vector.distance(pos,ppos) > 25 then
			return
		end


		minetest.sound_play("ambplus_caves_lava", {
		  pos = pos,
		  max_hear_distance = 26,
		  gain = 1	--0.2+1/#path*5,
		})

		lava_sound_status = 0

		minetest.after(5,  function()

			lava_sound_status = 1
			end
		)


	end,
})
