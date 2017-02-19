--[[

Craft Guide for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-craft_guide
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-craft_guide/master/LICENSE

MAIN LOADER

]]--

-- load api
dofile(minetest.get_modpath("craft_guide").."/api_craft_guide.lua")

-- override minetest.register_craft
local minetest_register_craft = minetest.register_craft
minetest.register_craft = function (options) 
	minetest_register_craft(options) 
	craft_guide.register_craft(options)
end

-- override minetest.register_alias
local minetest_register_alias = minetest.register_alias
minetest.register_alias = function (name, convert_to) 
	minetest_register_alias(name,convert_to) 
	craft_guide.register_alias(name, convert_to)
end

-- register entities
dofile(minetest.get_modpath("craft_guide").."/register_node.lua")
dofile(minetest.get_modpath("craft_guide").."/register_craft.lua")

-- log that we started
minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))
