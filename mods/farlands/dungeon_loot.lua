dungeon_loot.registered_loot = {
	-- buckets
	{name = "bucket:bucket_empty", chance = 0.55},
	-- water in deserts or above ground, lava otherwise
	{name = "bucket:bucket_water", chance = 0.45, types = {"sandstone", "desert"}},
	{name = "bucket:bucket_water", chance = 0.45, y = {0, 32768}, types = {"normal"}},
	{name = "bucket:bucket_lava", chance = 0.45, y = {-32768, -1}, types = {"normal"}},

	-- various items
	{name = "default:stick", chance = 0.6, count = {3, 6}},
	{name = "default:flint", chance = 0.4, count = {1, 3}},
	{name = "vessels:glass_fragments", chance = 0.35, count = {1, 4}},
	{name = "carts:rail", chance = 0.35, count = {1, 6}},

	-- farming / consumable
	{name = "farming:string", chance = 0.5, count = {1, 8}},
	{name = "farming:wheat", chance = 0.5, count = {2, 5}},
	{name = "default:apple", chance = 0.4, count = {1, 4}},
	{name = "farming:seed_cotton", chance = 0.4, count = {1, 4}, types = {"normal"}},
	{name = "default:cactus", chance = 0.4, count = {1, 4}, types = {"sandstone", "desert"}},

	-- minerals
	{name = "default:coal_lump", chance = 0.9, count = {1, 12}},
	{name = "default:gold_ingot", chance = 0.5},
	{name = "default:steel_ingot", chance = 0.4, count = {1, 6}},
	--~ {name = "default:mese_crystal", chance = 0.1, count = {2, 3}},

	-- tools
	{name = "default:sword_wood", chance = 0.6},
	{name = "default:pick_stone", chance = 0.3},
	{name = "default:axe_diamond", chance = 0.05},

	-- natural materials
	{name = "default:sand", chance = 0.8, count = {4, 32}, y = {-64, 32768}, types = {"normal"}},
	{name = "default:desert_sand", chance = 0.8, count = {4, 32}, y = {-64, 32768}, types = {"sandstone"}},
	{name = "default:desert_cobble", chance = 0.8, count = {4, 32}, types = {"desert"}},
	{name = "default:dirt", chance = 0.6, count = {2, 16}, y = {-64, 32768}},
	{name = "default:obsidian", chance = 0.25, count = {1, 3}, y = {-32768, -512}},
	--~ {name = "default:mese", chance = 0.15, y = {-32768, -512}},
}
