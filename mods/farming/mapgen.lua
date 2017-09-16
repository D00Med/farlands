local function register_plant(name, min, max, spawnby, num)
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
		y_min = min,
		y_max = max,
		decoration = "farming:" .. name,
		spawn_by = spawnby,
		num_spawn_by = num,
	})
end

function farming.register_mgv6_decorations()
	register_plant("potato_3", 15, 40, "", -1)
	register_plant("raddish_4", 5, 20, "", -1)
	register_plant("carrot_8", 1, 30, "group:water", 1)
	register_plant("corn_7", 12, 22, "", -1)
	register_plant("corn_8", 10, 20, "", -1)
	register_plant("melon_8", 1, 20, "group:water", 1)
	register_plant("pumpkin_8", 1, 20, "group:water", 1)
end

-- v7 maps have a beach so plants growing near water is limited to 6- high
function farming.register_mgv7_decorations()
	register_plant("potato_3", 15, 40, "", -1)
	register_plant("raddish_4", 5, 20, "", -1)
	register_plant("carrot_8", 1, 6, "", -1)
	register_plant("corn_7", 12, 22, "", -1)
	register_plant("corn_8", 10, 20, "", -1)
	register_plant("melon_8", 1, 6, "", -1)
	register_plant("pumpkin_8", 1, 6, "", -1)
end

