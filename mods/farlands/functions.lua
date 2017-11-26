
function default.grow_new_baobab_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/baobab.mts"
	minetest.place_schematic({x = pos.x - 8, y = pos.y - 1, z = pos.z - 8},
		path, "random", nil, false)
	minetest.set_node(pos, {name="mapgen:baobab_tree"})
end

function default.grow_new_bamboo_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/bamboo1.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "random", nil, false)
	minetest.set_node(pos, {name="mapgen:bamboo"})
end

function default.grow_new_ipe_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/ipe.mts"
	minetest.place_schematic({x = pos.x - 7, y = pos.y - 1, z = pos.z - 6},
		path, "random", nil, false)
	minetest.set_node(pos, {name="mapgen:yellow_ipe_tree"})
end

function default.grow_new_palm_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/palmtree.mts"
	minetest.place_schematic({x = pos.x - 3, y = pos.y - 1, z = pos.z - 3},
		path, "random", nil, false)
	minetest.set_node(pos, {name="mapgen:palm_tree"})
end

function default.grow_new_big_pine_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/pine.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 3},
		path, "random", nil, false)
	minetest.set_node(pos, {name="default:pine_tree"})
end

function default.grow_new_willow_tree(pos)
	local path = minetest.get_modpath("mapgen") ..
		"/schematics/willow.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "random", nil, false)
	minetest.set_node(pos, {name="mapgen:willow_tree"})
end
