
minetest.register_craftitem("tools:doompick", {
	description = "Pickaxe of Doom",
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