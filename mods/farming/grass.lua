
-- Override default grass and have it drop Wheat Seeds

for i = 1, 5 do

	minetest.override_item("default:grass_" .. i, {
		drop = {
			max_items = 1,
			items = {
				{items = {'farming:seed_wheat'}, rarity = 5},
				{items = {'default:grass_1'}},
			}
		},
	})

end

-- Override default Jungle Grass and have it drop Cotton Seeds

minetest.override_item("default:junglegrass", {
	drop = {
		max_items = 1,
		items = {
			{items = {'farming:seed_cotton'}, rarity = 8},
			{items = {'default:junglegrass'}},
		}
	},
})