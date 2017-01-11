
hud = {}

local path = minetest.get_modpath("hud")

dofile(path .. "/api.lua")
dofile(path .. "/builtin.lua")
dofile(path .. "/legacy.lua")

if hud.item_wheel then
	dofile(path .. "/itemwheel.lua")
end
