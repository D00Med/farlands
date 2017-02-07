
--= Sugar

minetest.register_craftitem("farming:sugar", {
	description = "Sugar",
	inventory_image = "farming_sugar.png",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "farming:sugar 2",
	recipe = "default:papyrus",
})