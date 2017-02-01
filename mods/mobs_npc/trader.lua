
local S = mobs.intllib

mobs.human = {
	items = {
		--{item for sale, price, chance of appearing in trader's inventory}
		{"default:apple 10", "default:gold_ingot 2", 10},
		{"farming:bread 10", "default:gold_ingot 4", 5},
		{"default:clay 10", "default:gold_ingot 2", 12},
		{"default:brick 10", "default:gold_ingot 4", 17},
		{"default:glass 10", "default:gold_ingot 4", 17},
		{"default:obsidian 10", "default:gold_ingot 15", 50},
		{"default:diamond 1", "default:gold_ingot 5", 40},
		{"farming:wheat 10", "default:gold_ingot 2", 17},
		{"default:tree 5", "default:gold_ingot 4", 20},
		{"default:stone 10", "default:gold_ingot 8", 17},
		{"default:desert_stone 10", "default:gold_ingot 8", 27},
		{"default:sapling 1", "default:gold_ingot 1", 7},
		{"default:pick_steel 1", "default:gold_ingot 2", 7},
		{"default:sword_steel 1", "default:gold_ingot 2", 17},
		{"default:shovel_steel 1", "default:gold_ingot 1", 17},
	},
	names = {
		"Bob", "Duncan", "Bill", "Tom", "James", "Ian", "Lenny"
	}
}

-- Trader ( same as NPC but with right-click shop )

mobs:register_mob("mobs_npc:trader", {
	type = "npc",
	passive = false,
	damage = 3,
	attack_type = "dogfight",
	attacks_monsters = true,
	pathfinding = false,
	hp_min = 10,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "character.b3d",
	textures = {
		{"mobs_trader.png"}, -- by Frerin
	},
	makes_footstep_sound = true,
	sounds = {},
	walk_velocity = 2,
	run_velocity = 3,
	jump = false,
	drops = {},
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	follow = {"default:diamond"},
	view_range = 15,
	owner = "",
	order = "stand",
	fear_height = 3,
	animation = {
		speed_normal = 30,
		speed_run = 30,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 200,
		punch_end = 219,
	},
	on_rightclick = function(self, clicker)
		mobs_trader(self, clicker, entity, mobs.human)
	end,
})

--This code comes almost exclusively from the trader and inventory of mobf, by Sapier.
--The copyright notice below is from mobf:
-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file inventory.lua
--! @brief component containing mob inventory related functions
--! @copyright Sapier
--! @author Sapier
--! @date 2013-01-02
--
--! @defgroup Inventory Inventory subcomponent
--! @brief Component handling mob inventory
--! @ingroup framework_int
--! @{
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

function mobs.allow_move(inv, from_list, from_index, to_list, to_index, count, player)

	if to_list ~= "selection"
	or from_list == "price"
	or from_list == "payment"
	or from_list == "takeaway"
	or from_list == "identifier" then

		return 0
	end

	-- forbid moving split stacks
	local old_stack = inv.get_stack(inv, from_list, from_index)

	if count ~= old_stack.get_count(old_stack) then
		return 0
	end

	return count
end

function mobs.allow_put(inv, listname, index, stack, player)

	if listname == "payment" then
		return 99
	end

	return 0
end

function mobs.allow_take(inv, listname, index, stack, player)

	if listname == "takeaway"
	or listname == "payment" then

		return 99
	else
		return 0
	end
end

function mobs.on_put(inv, listname, index, stack)

	if listname == "payment" then
		mobs.update_takeaway(inv)
	end
end

function mobs.on_take(inv, listname, count, index, stack, player)

	if listname == "takeaway" then

		local amount = inv:get_stack("payment", 1):get_count()
		local price = inv:get_stack("price", 1):get_count()
		local thing = inv:get_stack("payment", 1):get_name()

		inv.set_stack(inv,"selection", 1, nil)
		inv.set_stack(inv,"price", 1, nil)
		inv.set_stack(inv,"takeaway", 1, nil)
		inv.set_stack(inv,"payment", 1, thing .. " " .. amount - price)
	end

	if listname == "payment" then

		if mobs.check_pay(inv, false) then

			local selection = inv.get_stack(inv, "selection", 1)

			if selection ~= nil then
				inv.set_stack(inv,"takeaway", 1, selection)
			end
		else
			inv.set_stack(inv, "takeaway", 1, nil)
		end
	end
end

function mobs.update_takeaway(inv)

	if mobs.check_pay(inv,false) then

		local selection = inv.get_stack(inv,"selection", 1)

		if selection ~= nil then
			inv.set_stack(inv,"takeaway", 1, selection)
		end
	else
		inv.set_stack(inv,"takeaway", 1, nil)
	end
end

function mobs.check_pay(inv, paynow)

	local now_at_pay = inv.get_stack(inv,"payment", 1)
	local count = now_at_pay.get_count(now_at_pay)
	local name  = now_at_pay.get_name(now_at_pay)
	local price = inv.get_stack(inv, "price", 1)

	if price:get_name() == name then

		local price = price:get_count()

		if price > 0
		and price <= count then

			if paynow then

				now_at_pay.take_item(now_at_pay, price)

				inv.set_stack(inv,"payment", 1, now_at_pay)

				return true
			else
				return true
			end
		else
			if paynow then
				inv.set_stack(inv, "payment", 1, nil)
			end
		end
	end

	return false
end

mobs.trader_inventories = {}

function mobs.add_goods(entity, race)

	local goods_to_add = nil

	for i = 1, 15 do

		if math.random(0, 100) > race.items[i][3] then
			mobs.trader_inventory.set_stack(mobs.trader_inventory,
				"goods", i, race.items[i][1])
		end
	end
end

function mobs_trader(self, clicker, entity, race)

	local player = clicker:get_player_name()

	if not self.id then
		self.id = (math.random(1, 1000) * math.random(1, 10000))
			.. self.name .. (math.random(1, 1000) ^ 2)
	end

	if not self.game_name then

		self.game_name = tostring(race.names[math.random(1, #race.names)])
		self.nametag = S("Trader @1", self.game_name)

		self.object:set_properties({
			nametag = self.nametag,
			nametag_color = "#00FF00"
		})

	end

	local unique_entity_id = self.id
	local is_inventory = minetest.get_inventory({
		type = "detached", name = unique_entity_id})

	local move_put_take = {

		allow_move = mobs.allow_move,
		allow_put = mobs.allow_put,
		allow_take = mobs.allow_take,

		on_move = function(inventory, from_list, from_index, to_list, to_index, count, player)

			if from_list == "goods"
			and to_list == "selection" then

				local inv = inventory
				local moved = inv.get_stack(inv,to_list, to_index)
				local goodname = moved.get_name(moved)
				local elements = moved.get_count(moved)

				if elements > count then

					-- remove the surplus parts
					inv.set_stack(inv,"selection", 1,
						goodname .. " " .. tostring(count))

					-- the slot we took from is now free
					inv.set_stack(inv,"goods",from_index,
						goodname .. " " .. tostring(elements - count))

					-- update the real amount of items in the slot now
					elements = count
				end

				local good = nil

				for i = 1, #race.items, 1 do

					local stackstring = goodname .." " .. count

					if race.items[i][1] == stackstring then
						good = race.items[i]
					end
				end

				if good ~= nil then
					inventory.set_stack(inventory,"price", 1, good[2])
				else
					inventory.set_stack(inventory,"price", 1, nil)
				end

			mobs.update_takeaway(inv)

			end
		end,

		on_put = mobs.on_put,
		on_take = mobs.on_take
	}

	if is_inventory == nil then

		mobs.trader_inventory = minetest.create_detached_inventory(unique_entity_id, move_put_take)
		mobs.trader_inventory.set_size(mobs.trader_inventory,"goods", 15)
		mobs.trader_inventory.set_size(mobs.trader_inventory,"takeaway", 1)
		mobs.trader_inventory.set_size(mobs.trader_inventory,"selection", 1)
		mobs.trader_inventory.set_size(mobs.trader_inventory,"price", 1)
		mobs.trader_inventory.set_size(mobs.trader_inventory,"payment", 1)
		mobs.add_goods(entity, race)
	end

	minetest.chat_send_player(player, S("[NPC] <Trader @1 > Hello, @2, have a look at my wares.",
		self.game_name, player))

	minetest.show_formspec(player, "trade", "size[8,10;]"
		.. default.gui_bg_img
		.. default.gui_slots
		.. "label[0,0;" .. S("Trader @1's stock:", self.game_name) .. "]"
		.. "list[detached:" .. unique_entity_id .. ";goods;.5,.5;3,5;]"
		.. "label[4.5,0.5;" .. S("Selection") .. "]"
		.. "list[detached:" .. unique_entity_id .. ";selection;4.5,1;5.5,2;]"
		.. "label[6,0.5;" .. S("Price") .. "]"
		.. "list[detached:" .. unique_entity_id .. ";price;6,1;7,2;]"
		.. "label[4.5,3.5;" .. S("Payment") .. "]"
		.. "list[detached:" .. unique_entity_id .. ";payment;4.5,4;5.5,5;]"
		.. "label[6,3.5;" .. S("Bought items") .. "]"
		.. "list[detached:" .. unique_entity_id .. ";takeaway;6,4;7.5,5.5;]"
		.. "list[current_player;main;0,6;8,4;]"
	)
end

mobs:register_egg("mobs_npc:trader", S("Trader"), "default_sandstone.png", 1)

-- compatibility
mobs:alias_mob("mobs:trader", "mobs_npc:trader")
