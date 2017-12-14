stm_nodes = {}

function stm_nodes.power(pos, is_corner)
	--find_node
	local node = minetest.get_node(pos)
	local param2 = node.param2
	--find direction
	local dir = minetest.facedir_to_dir(param2)
	local next_pos = {x=pos.x+1*dir.x, z=pos.z+1*dir.z, y=pos.y+1*dir.y}
	local pos_string = minetest.pos_to_string(next_pos, 0)
	local next_pos = minetest.string_to_pos(pos_string)
	--check for power
	local positions = {
	{x=pos.x+1,y=pos.y,z=pos.z},
	{x=pos.x-1,y=pos.y,z=pos.z},
	{x=pos.x,y=pos.y,z=pos.z-1},
	{x=pos.x,y=pos.y,z=pos.z+1},
	{x=pos.x,y=pos.y-1,z=pos.z},
	{x=pos.x,y=pos.y+1,z=pos.z},
	}
	local powered = false
	for _, row in ipairs(positions) do
	local check_pos = row
	if check_pos ~= next_pos then
		local check_node = minetest.get_node(check_pos).name
		if minetest.get_item_group(check_node, "power_source") == 1 then
		powered = true
		end
	end
	end
	if not powered then
		if node.name == "stm_nodes:pipe_active" then
			minetest.set_node(pos, {name="stm_nodes:pipe", param2=node.param2})
			return
		end
	end
	--change nearby nodes
	local next_node = minetest.get_node(next_pos)
	if minetest.get_item_group(next_node.name, "powered") == 1 then
	minetest.set_node(next_pos, {name=next_node.name.."_active", param2=next_node.param2})
	end
end

minetest.register_node("stm_nodes:pipe", {
	description = "Pipe",
	tiles = {
		"stm_nodes_pipe_top.png",
		"stm_nodes_pipe_top.png",
		"stm_nodes_pipe.png",
	},
	paramtype2 = "facedir",
	groups = {cracky = 1, ventilation = 1, powered = 1},
	on_place = minetest.rotate_node,
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("stm_nodes:pipe_active", {
	tiles = {
		"stm_nodes_pipe_top.png",
		"stm_nodes_pipe_top.png",
		"stm_nodes_pipe.png",
	},
	paramtype2 = "facedir",
	drop = "stm_nodes:pipe",
	groups = {cracky=1, ventilation=1, pressure=1, powered = 2},
	on_place = minetest.rotate_node,
	sounds = default.node_sound_metal_defaults()
})

minetest.register_abm({
	nodenames = {"stm_nodes:pipe_active"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		stm_nodes.power(pos, false)
	end
})