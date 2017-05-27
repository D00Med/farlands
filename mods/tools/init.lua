
minetest.register_craftitem("tools:superpick", {
	description = "Super Pickaxe",
	inventory_image = "default_tool_diamondpick.png^[colorize:red:100",
	liquids_pointable = true,
	on_use = function(item, placer, pointed_thing)
		if pointed_thing.under == nil then
		return end
		if minetest.get_node(pointed_thing.under) ~= nil then
			minetest.remove_node(pointed_thing.under)
		end
	end,
})

minetest.register_tool("tools:bigstone_sword", {
	description = "Big Stone Sword",
	inventory_image = "tools_bigstone_sword.png",
	wield_scale = {x=2, y=2, z=2},
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.4, [3]=0.40}, uses=25, maxlevel=1},
		},
		damage_groups = {fleshy=5, choppy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("tools:big_iron_battleaxe", {
	description = "Big Iron Battleaxe",
	inventory_image = "tools_big_iron_battleaxe.png",
	wield_scale = {x=2, y=2, z=2},
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.4, [3]=0.40}, uses=25, maxlevel=1},
		},
		damage_groups = {fleshy=5, choppy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("tools:sword_crystal", {
	description = "Crystal Sword",
	inventory_image = "tools_sword_crystal.png",
	wield_scale = {x=2, y=2, z=2},
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.4, [3]=0.40}, uses=25, maxlevel=1},
		},
		damage_groups = {fleshy=5, choppy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_craftitem("tools:gameboy", {
	description = "GameBoy",
	inventory_image = "tools_gameboy.png",
})





