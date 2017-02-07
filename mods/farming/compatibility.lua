-- is Ethereal mod installed?
local eth = minetest.get_modpath("ethereal") or nil

-- Banana
if eth then
	minetest.register_alias("farming_plus:banana_sapling", "ethereal:banana_tree_sapling")
	minetest.register_alias("farming_plus:banana_leaves", "ethereal:bananaleaves")
	minetest.register_alias("farming_plus:banana", "ethereal:banana")
else
	minetest.register_alias("farming_plus:banana_sapling", "default:sapling")
	minetest.register_alias("farming_plus:banana_leaves", "default:leaves")
	minetest.register_alias("farming_plus:banana", "default:apple")
end

-- Carrot
minetest.register_alias("farming_plus:carrot_seed", "farming:carrot")
minetest.register_alias("farming_plus:carrot_1", "farming:carrot_1")
minetest.register_alias("farming_plus:carrot_2", "farming:carrot_4")
minetest.register_alias("farming_plus:carrot_3", "farming:carrot_6")
minetest.register_alias("farming_plus:carrot", "farming:carrot_8")

-- Cocoa

minetest.register_alias("farming_plus:cocoa_sapling", "farming:cocoa_beans")
minetest.register_alias("farming_plus:cocoa_leaves", "default:leaves")
minetest.register_alias("farming_plus:cocoa", "default:apple")
minetest.register_alias("farming_plus:cocoa_bean", "farming:cocoa_beans")

-- Orange
minetest.register_alias("farming_plus:orange_1", "farming:tomato_1")
minetest.register_alias("farming_plus:orange_2", "farming:tomato_4")
minetest.register_alias("farming_plus:orange_3", "farming:tomato_6")
minetest.register_alias("farming_plus:orange", "farming:tomato_8")

if eth then
	minetest.register_alias("farming_plus:orange_item", "ethereal:orange")
	minetest.register_alias("farming_plus:orange_seed", "ethereal:orange_tree_sapling")
else
	minetest.register_alias("farming_plus:orange_item", "default:apple")
	minetest.register_alias("farming_plus:orange_seed", "default:sapling")
end

-- Potato
minetest.register_alias("farming_plus:potato_item", "farming:potato")
minetest.register_alias("farming_plus:potato_1", "farming:potato_1")
minetest.register_alias("farming_plus:potato_2", "farming:potato_2")
minetest.register_alias("farming_plus:potato", "farming:potato_3")
minetest.register_alias("farming_plus:potato_seed", "farming:potato")

-- Pumpkin
minetest.register_alias("farming:pumpkin_seed", "farming:pumpkin_slice")
minetest.register_alias("farming:pumpkin_face", "farming:pumpkin")
minetest.register_alias("farming:pumpkin_face_light", "farming:jackolantern")
minetest.register_alias("farming:big_pumpkin", "farming:pumpkin")
minetest.register_alias("farming:big_pumpkin_side", "air")
minetest.register_alias("farming:big_pumpkin_corner", "air")
minetest.register_alias("farming:big_pumpkin_top", "air")
minetest.register_alias("farming:scarecrow", "farming:pumpkin")
minetest.register_alias("farming:scarecrow_bottom", "default:fence_wood")
minetest.register_alias("farming:scarecrow_light", "farming:jackolantern")
minetest.register_alias("farming:pumpkin_flour", "farming:pumpkin_dough")

-- Rhubarb
minetest.register_alias("farming_plus:rhubarb_seed", "farming:rhubarb")
minetest.register_alias("farming_plus:rhubarb_1", "farming:rhubarb_1")
minetest.register_alias("farming_plus:rhubarb_2", "farming:rhubarb_2")
minetest.register_alias("farming_plus:rhubarb", "farming:rhubarb_3")
minetest.register_alias("farming_plus:rhubarb_item", "farming:rhubarb")

-- Strawberry
if eth then
	minetest.register_alias("farming_plus:strawberry_item", "ethereal:strawberry")
	minetest.register_alias("farming_plus:strawberry_seed", "ethereal:strawberry")
	minetest.register_alias("farming_plus:strawberry_1", "ethereal:strawberry_1")
	minetest.register_alias("farming_plus:strawberry_2", "ethereal:strawberry_3")
	minetest.register_alias("farming_plus:strawberry_3", "ethereal:strawberry_5")
	minetest.register_alias("farming_plus:strawberry", "ethereal:strawberry_7")
else
	minetest.register_alias("farming_plus:strawberry_item", "farming:raspberries")
	minetest.register_alias("farming_plus:strawberry_seed", "farming:raspberries")
	minetest.register_alias("farming_plus:strawberry_1", "farming:raspberry_1")
	minetest.register_alias("farming_plus:strawberry_2", "farming:raspberry_2")
	minetest.register_alias("farming_plus:strawberry_3", "farming:raspberry_3")
	minetest.register_alias("farming_plus:strawberry", "farming:raspberry_4")

end

-- Tomato
minetest.register_alias("farming_plus:tomato_seed", "farming:tomato")
minetest.register_alias("farming_plus:tomato_item", "farming:tomato")
minetest.register_alias("farming_plus:tomato_1", "farming:tomato_2")
minetest.register_alias("farming_plus:tomato_2", "farming:tomato_4")
minetest.register_alias("farming_plus:tomato_3", "farming:tomato_6")
minetest.register_alias("farming_plus:tomato", "farming:tomato_8")

-- Weed
minetest.register_alias("farming:weed", "default:grass_2")