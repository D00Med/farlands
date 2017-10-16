local function register_plant(name, y_min, y_max, spawnby, num)
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "mapgen:dirt_with_leafy_grass",},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.006,
			spread = {x = 100, y = 100, z = 100},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		y_min = y_min,
		y_max = y_max,
		decoration = "farming:" .. name,
		spawn_by = spawnby,
		num_spawn_by = num,
	})
end

function farming.register_mgv6_decorations()
	register_plant("potato_4", 15, 40, "", -1)
	register_plant("raddish_4", 5, 20, "", -1)
	register_plant("carrot_4", 1, 30, "group:water", 1)
	register_plant("corn_4", 12, 22, "", -1)
	register_plant("corn_4", 10, 20, "", -1)
	register_plant("melon_4", 1, 20, "group:water", 1)
	register_plant("pumpkin_4", 1, 20, "group:water", 1)
end

-- v7 maps have a beach so plants growing near water is limited to 6- high
function farming.register_mgv7_decorations()
	register_plant("potato_4", 15, 40, "", -1)
	register_plant("raddish_4", 5, 20, "", -1)
	register_plant("carrot_4", 1, 6, "", -1)
	register_plant("corn_4", 12, 22, "", -1)
	register_plant("corn_4", 10, 20, "", -1)
	register_plant("melon_4", 1, 6, "", -1)
	register_plant("pumpkin_4", 1, 6, "", -1)
end

