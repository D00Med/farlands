bosses_farlands.registered_eggs = {}

function bosses_farlands.register_egg(name_item, name_ent, def)
	def.on_place = def.on_place or function(itemstack, placer, pointed_thing)
		-- am I clicking on something with existing on_rightclick function?
		local under = minetest.get_node(pointed_thing.under)
		local def_under = minetest.registered_nodes[under.name]
		if def_under and def_under.on_rightclick then
			return def_under.on_rightclick(pointed_thing.under, under, placer, itemstack)
		end

		minetest.add_entity(pointed_thing.above, name_ent)

		-- if not in creative then take item
		if not minetest.settings:get_bool("creative_mode") then
			itemstack:take_item()
		end

		return itemstack
	end

	minetest.register_craftitem(name_item, def)

	bosses_farlands.registered_eggs[name_item] = name_ent
end
