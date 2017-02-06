
-- Simple Skins mod for minetest (5th June 2016)
-- Adds a simple skin selector to the inventory, using inventory_plus
-- or by using the /skin command to bring up selection list.
-- Released by TenPlus1 and based on Zeg9's code under WTFPL

skins = {}
skins.skins = {}
skins.modpath = minetest.get_modpath("simple_skins")
skins.armor = minetest.get_modpath("3d_armor")
skins.inv = minetest.get_modpath("inventory_plus")

-- load skin list
skins.list = {}
skins.add = function(skin)
	table.insert(skins.list, skin)
end

local id = 1
local f
while true do
	f = io.open(skins.modpath .. "/textures/character_" .. id .. ".png")
	if not f then break end
	f:close()
	skins.add("character_" .. id)
	id = id + 1
end

id = id - 1

-- load Metadata
skins.meta = {}
local f, data
for _, i in pairs(skins.list) do
	skins.meta[i] = {}
	f = io.open(skins.modpath .. "/meta/" .. i .. ".txt")
	data = nil
	if f then
		data = minetest.deserialize("return {" .. f:read('*all') .. "}")
		f:close()
	end
	data = data or {}
	skins.meta[i].name = data.name or ""
	skins.meta[i].author = data.author or ""
end

-- player load/save routines
skins.file = minetest.get_worldpath() .. "/simple_skins.mt"

skins.load = function()
	local input = io.open(skins.file, "r")
	local data = nil
	if input then
		data = input:read('*all')
	end
	if data and data ~= "" then
		local lines = string.split(data, "\n")
		for _, line in pairs(lines) do
			data = string.split(line, ' ', 2)
			skins.skins[data[1]] = data[2]
		end
		io.close(input)
	end
end

-- load player skins now
skins.load()

skins.save = function()
	local output = io.open(skins.file,'w')
	for name, skin in pairs(skins.skins) do
		if name and skin then
			output:write(name .. " " .. skin .. "\n")
		end
	end
	io.close(output)
end

-- skin selection page
skins.formspec = {}
skins.formspec.main = function(name)

	local selected = 1 -- select default
	local formspec = "size[7,7]"
		.. "bgcolor[#08080822;true]"
		.. "label[.5,2;Select Player Skin:]"
		.. "textlist[.5,2.5;5.8,4;skins_set;"

	for i = 1, #skins.list do

		formspec = formspec .. skins.meta[ skins.list[i] ].name .. ","

		if skins.skins[name] == skins.list[i] then
			selected = i
		end
	end

	formspec = formspec .. ";" .. selected .. ";true]"

	local meta = skins.meta[ skins.skins[name] ]

	if meta then
		if meta.name then
			formspec = formspec .. "label[2,.5;Name: " .. meta.name .. "]"
		end
		if meta.author then
			formspec = formspec .. "label[2,1;Author: " .. meta.author .. "]"
		end
	end

	return formspec
end

-- update player skin
skins.update_player_skin = function(player)

	if not player then
		return
	end

	local name = player:get_player_name()

	if skins.armor then
		armor.textures[name].skin = skins.skins[name] .. ".png"
		armor:set_player_armor(player)
	else
		player:set_properties({
			textures = {skins.skins[name] .. ".png"},
		})
	end

	skins.save()
end

-- load player skin on join
minetest.register_on_joinplayer(function(player)

	local name = player:get_player_name()

	if not skins.skins[name] then
		skins.skins[name] = "character_1"
	end

	skins.update_player_skin(player)

	if skins.inv then
		inventory_plus.register_button(player,"skins", "Skin")
	end
end)

-- formspec control
minetest.register_on_player_receive_fields(function(player, formname, fields)

	local name = player:get_player_name()

	if fields.skins then
		inventory_plus.set_inventory_formspec(player,
			skins.formspec.main(name) .. "button[0,.75;2,.5;main;Back]"
		)
	end

	local event = minetest.explode_textlist_event(fields["skins_set"])

	if event.type == "CHG" then

		local index = event.index

		if index > id then index = id end

		skins.skins[name] = skins.list[index]

		if skins.inv then
			inventory_plus.set_inventory_formspec(player,
				skins.formspec.main(name) .. "button[0,.75;2,.5;main;Back]"
			)
		end

		skins.update_player_skin(player)

	end
end)

-- admin command to set player skin (usually for custom skins)
minetest.register_chatcommand("setskin", {
	params = "<player> <skin number>",
	description = "Admin command to set player skin",
	privs = {server = true},
	func = function(name, param)

		if not param or param == "" then return end

		local user, skin = string.match(param, "([^ ]+) (-?%d+)")

		if not user or not skin then return end

		skins.skins[user] = "character_"..tonumber(skin)
		skins.save()

		minetest.chat_send_player(name,
			 "** " .. user .. "'s skin set to character_" .. skin .. ".png")
	end,
})

-- player command to set skin
minetest.register_chatcommand("skin", {
	description = "Set player skin",
	func = function(name, param)
		minetest.show_formspec(name,
			"skins_set",
			skins.formspec.main(name)
			.."button_exit[0,.75;2,.5;;Close]"
		)
	end,
})

print ("[MOD] Simple Skins loaded")
