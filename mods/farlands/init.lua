farlands = {}

farlands.path = minetest.get_modpath("farlands")

dofile(farlands.path.."/doors.lua")
dofile(farlands.path.."/stairs.lua")

-- unregister unwanted items, nodes an recipes
minetest.clear_craft({output = 'default:sword_mese'})
minetest.unregister_item("default:sword_mese")
minetest.clear_craft({output = 'default:pick_mese'})
minetest.unregister_item("default:pick_mese")
minetest.clear_craft({output = 'default:shovel_mese'})
minetest.unregister_item("default:shovel_mese")
minetest.clear_craft({output = 'default:axe_mese'})
minetest.unregister_item("default:axe_mese")
minetest.unregister_item("default:stone_with_mese")
minetest.unregister_item("default:mese")
minetest.unregister_item("default:meselamp")
minetest.clear_craft({output = 'default:meselamp'})
minetest.unregister_item("default:mese_post_light")
minetest.clear_craft({output = 'default:mese_post_light'})

-- override items
minetest.override_item("default:tree", {description = "Oak Tree"})
minetest.override_item("default:wood", {description = "Oakwood Planks"})
minetest.override_item("default:sapling", {description = "Oak Sapling"})
minetest.override_item("default:leaves", {description = "Oak Leaves"})

