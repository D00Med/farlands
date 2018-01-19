
--texture format: paintings_[name].png, must be the same as the node name (NOT the description)
--sizes are: 1X1, 1X2 (wide), 2X1 (tall), 2X2
local paintings = {
	--{"name/texture", "description", "size"}
	{"dragon", "Dragon Painting", "2X1", "D00Med"},
	{"landscape", "Landscape Painting", "1X2", "D00Med"},
	{"forest", "Forest Painting", "1X2", "D00Med"},
	{"waterlilie", "Water Lily Painting", "1X1", "toby109tt"},
	{"cthulhu", "Cthulhu Painting", "2X2", "toby109tt"},
	{"mistiriusgirl", "Mysterious Girl Painting", "1X2", "toby109tt"},
	{"possessedwoman", "Possessed Woman Painting", "1X2", "D00Med"},
	{"rose", "Rose Painting", "1X1", "toby109tt"},
}

local painting_crafts = {
	{"dye:red", "paintings:possessedwoman", "paintings:rose", "", "", "", "", "", "", "", "", "", ""},
	{"dye:blue", "", "", "", "", "", "", "", "", "", "", "", ""},
	{"dye:yellow", "", "", "", "", "", "", "", "", "", "", "", ""},
	{"dye:orange", "", "", "", "", "", "", "", "", "", "", "", ""},
	{"dye:pink", "", "", "", "", "", "", "", "", "", "", "", ""},
	{"dye:magenta", "paintings:landscape", "", "", "", "", "", "", "", "", "", "", ""},
	{"dye:purple", "paintings:dragon", "", "", "", "", "", "", "", "", "", "", ""},
	{"dye:brown", "", "", "", "", "", "", "", "", "", "", "", ""},
	{"dye:cyan", "paintings:mistiriusgirl", "", "", "", "", "", "", "", "", "", "", ""},
	{"dye:green", "paintings:cthulhu", "", "paintings:waterlilie", "", "", "", "", "", "", "", "", ""},
	{"dye:darkgreen", "", "", "", "", "", "", "", "", "", "", "", ""},
	{"dye:white", "", "", "", "", "", "", "", "", "", "", "", ""},
	{"dye:black", "paintings:forest", "", "", "", "", "", "", "", "", "", "", ""},
	{"dye:grey", "", "", "", "", "", "", "", "", "", "", "", ""},
	{"dye:darkgrey", "", "", "", "", "", "", "", "", "", "", "", ""},
	--{"", "", "", "", "", "", "", "", "", "", "", "", ""},
}

local small = {-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5}
local medium = {-1.5, -0.5, 0.4375, 0.5, 0.5, 0.5}
local tall = {-0.5, -0.5, 0.4375, 0.5, 1.5, 0.5}
local large = {-0.5, -0.5, 0.4375, 1.5, 1.5, 0.5}

for _, row in ipairs(paintings) do
	local name = row[1]
	local description = row[2]
	local size = row[3]
	local artist = row[4]
	local box = small
	if size == "1X2" then
	box = medium
	elseif size == "2X2" then
	box = large
	elseif size == "2X1" then
	box = tall
	end
	minetest.register_node("paintings:"..name, {
	description = description,
	drawtype = "mesh",
	mesh = size..".obj",
	tiles = {
		"paintings_"..name..".png",
	},
	visual_scale = 0.5,
	wield_scale = {x=0.5, y=0.5, z=0.5},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=1},
	selection_box = {
		type = "fixed",
		fixed = box
	},
	collision_box = {
		type = "fixed",
		fixed = {0,0,0,0,0,0}
	},
	on_construct = function(pos)
	local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Artist: "..artist)
	end,
	sounds = default.node_sound_wood_defaults()
})
end

local easel_formspec = 
	"size[8,9]" ..
	default.gui_bg ..
	default.gui_bg_img ..
	default.gui_slots ..
	"list[current_name;input;1,1;1,1;]" ..
	"list[current_name;output;3,0;4,3;]" ..
	"list[current_player;main;0,4.85;8,1;]" ..
	"list[current_player;main;0,6.08;8,3;8]" ..
	"listring[current_name;input]" ..
	"listring[current_name;output]" ..
	"listring[current_player;main]" ..
	default.get_hotbar_bg(0,4.85)
	
minetest.register_node("paintings:easel", {
	description = "Easel",
	drawtype = "mesh",
	mesh = "easel.obj",
	tiles = {"paintings_easel.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=1},
	selection_box = {
		type = "fixed",
		fixed = {
		{-0.4,-0.5,-0.2,0.4,1.5,0.2},
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
		{-0.2,-0.5,-0.4,0,0.5,0},
		{-0.4,-0.5,0.1,0.4,1.4,0.3},
		}
	},
	on_construct = function(pos)
	local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Painting Easel")
		meta:set_string("formspec", easel_formspec)
		local inv = meta:get_inventory()
		inv:set_size("output", 4 * 3)
		inv:set_size("input", 1 * 1)
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local player_inv = player:get_inventory()
		if listname == "output" then
			player_inv:add_item("main", stack)
			inv:set_stack("output", index, "")
		end
		if listname == "input" then
			for _, row in ipairs(painting_crafts) do
				local item = row[1]
				if inv:contains_item("input", item) then
					inv:set_stack("output", 1, row[2])
					inv:set_stack("output", 2, row[3])
					inv:set_stack("output", 3, row[4])
					inv:set_stack("output", 4, row[5])
					inv:set_stack("output", 5, row[6])
					inv:set_stack("output", 6, row[7])
					inv:set_stack("output", 7, row[8])
					inv:set_stack("output", 8, row[9])
					inv:set_stack("output", 9, row[10])
					inv:set_stack("output", 10, row[11])
					inv:set_stack("output", 11, row[12])
					inv:set_stack("output", 12, row[13])
				end
			end			
		end
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
			local stack = inv:get_stack("input", 1)
			local stack_name = stack:get_name()
			inv:remove_item("input", stack_name.." 1")
			
			inv:set_stack("output", 1, "")
			inv:set_stack("output", 2, "")
			inv:set_stack("output", 3, "")
			inv:set_stack("output", 4, "")
			inv:set_stack("output", 5, "")
			inv:set_stack("output", 6, "")
			inv:set_stack("output", 7, "")
			inv:set_stack("output", 8, "")
			inv:set_stack("output", 9, "")
			inv:set_stack("output", 10, "")
			inv:set_stack("output", 11, "")
			inv:set_stack("output", 12, "")
	end,
	sounds = default.node_sound_wood_defaults()
})
