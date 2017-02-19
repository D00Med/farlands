--[[

Craft Guide for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-craft_guide
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-craft_guide/master/LICENSE

CRAFT GUIDE API

]]--





-- expose object to other modules
craft_guide = {}


--        vvv  INTERNAL SETTINGS  vvv

-- enable or disable you need feature

craft_guide.you_need=true

-- enable or disable copy craft recipe to crafting grid feature

craft_guide.copy_button=true


-- show items which only have have craft recipes of type "fuel". This are for example: tree trunks, saplings, .. etc.
--Don't matter when craft_guide.show_fuel=false

craft_guide.show_all_fuel_crafts=false


-- don't show any recipes of type fuel in craft guide

craft_guide.show_fuel=true


--shows crafts other then normal crafts in crafting grid or of type "cooking" or "fuel".
--at the moment this are crafts for machines from technic mod

craft_guide.other_crafting_types=true


--don't show crafts which are registered in moreblocks mod to get the original item back from its slabs, panels, microblocks, etc...
--and don't show all ingots, dusts and blocks of uranium with different percentages
craft_guide.remove_cluttering_crafts=true


-- here you can define base items for "you need" feature

--all items with this prefix are base items:

craft_guide.basic_item_prefixes = { 

	"dye:",

}

--all items which belong to this groups are base items

craft_guide.basic_item_groups = { 

	"wood",
	"stone",
	"stick",
	"tree",
	"sand",
	"glass",

}

--all items which end with these strings are base items

craft_guide.basic_item_endings = {

	"ingot",
	"lump",
	"glass",
	"dust",

}

-- here you can define single items as base items.
-- items without crafting recipe or items which match criterias from the tables above are base items too.

craft_guide.basic_items	= { 

	"default:dirt",
	"default:sand",
	"default:cobble",
	"default:snowblock",
	"default:ice",
	"default:wood",
	"default:stone",
	"default:stick",
	"default:clay_brick",
	"default:gravel",
	"default:mossycobble",
	"default:desert_stone",
	"default:desert_cobble",
	"default:desert_sand",
	"default:diamond",
	"default:mese_crystal",
	"default:glass",
	"default:obsidian",
	"default:wheat",
	"bucket:bucket_water",
	"bucket:bucket_lava",
	"technic:uranium",
	"technic:raw_latex",
	"homedecor:roof_tile_terracotta",
	"homedecor:terracotta_base",
	"mesecons_materials:glue",
	"wool:white"
}

-- END OF SETTINGS SECTION




-- define api variables
craft_guide.crafts = {}

craft_guide.alias = {}

craft_guide.fuel = {}

craft_guide.saved_you_need_lists = {}

craft_guide.you_need_list = {}

craft_guide.add_things=true

craft_guide.fuel_to_add=false

-- log
craft_guide.log = function(message)
	--if not craft_guide.DEBUG then return end
	minetest.log("action", "[CraftGuide] "..message)
end


-- register_craft
craft_guide.register_craft = function(options)
	if  options.type == "fuel" and craft_guide.show_fuel and options.recipe~=nil then
		local itemstack = ItemStack(options.recipe)
		if itemstack:is_empty() then
			return
		end

		if craft_guide.fuel[itemstack:get_name()]==nil then
			craft_guide.fuel[itemstack:get_name()] = {}
		end
		table.insert(craft_guide.fuel[itemstack:get_name()],options)
		craft_guide.fuel_to_add=true
		return 
	end

	if  options.output == nil then
		return
	end
	local itemstack = ItemStack(options.output)
	if itemstack:is_empty() then
		return
	end
	--this should remove crafts which craft original item back from stairs, slabs, panels or micros, 
	if craft_guide.remove_cluttering_crafts then
		local mod,_=string.find(itemstack:get_name(),":")
		if mod~=nil then
			mod=string.sub(itemstack:get_name(),1,mod)
			local recipestr=""
			if options.recipe[1]~=nil and type(options.recipe[1])=="string" then
				recipestr=" "..options.recipe[1]
			elseif options.recipe[1]~=nil and type(options.recipe[1][1])=="string" then
				recipestr=" "..options.recipe[1][1]
			elseif options.recipe[2]~=nil and type(options.recipe[2][1])=="string" then
				recipestr=" "..options.recipe[2][1]
			end
			if 			
				--dont show recipes for ingots, dusts and blocks of uranium with different percentages
				string.find(itemstack:get_name(),"technic:uranium._")==nil  
				and string.find(itemstack:get_name(),"technic:uranium.._")==nil
				and 

				(recipestr==""or (options.recipe~=nil and string.find(recipestr," "..mod.."panel_")==nil 
				and string.find(recipestr," "..mod.."stair_")==nil
				and string.find(recipestr," "..mod.."micro_")==nil  and string.find(recipestr," "..mod.."slab_")==nil
				and string.find(recipestr," moreblocks:panel_")==nil and string.find(recipestr," moreblocks:stair_")==nil
				and string.find(recipestr," moreblocks:micro_")==nil  and string.find(recipestr," moreblocks:slab_")==nil)) then


				--craft_guide.log("registered craft for - "..itemstack:get_name())
				if craft_guide.crafts[itemstack:get_name()]==nil then
					craft_guide.crafts[itemstack:get_name()] = {}
				end
			table.insert(craft_guide.crafts[itemstack:get_name()],options)
			end
		end

	end
end


-- register_alias
craft_guide.register_alias = function(alias,convert_to)
	local count=#craft_guide.alias
	craft_guide.alias[count+1]=alias
	craft_guide.alias[count+2]=convert_to
end

-- get_craft_guide_formspec
craft_guide.get_craft_guide_formspec = function(meta, search, page, alternate)
	if craft_guide.add_things then
		craft_guide.add_additional_crafts()
	end
	if search == nil then 
		search = meta:get_string("search")
	end
	if meta:get_string("formspec")=="" then
		meta:set_string("owner","")
		meta:set_string("saved_search","|")
		meta:set_string("saved_page","1")
		meta:set_string("saved_pages","1")
		meta:set_string("switch","bookmarks")
		meta:set_string("poslist","down")
		meta:set_string("globalcount","1")
		meta:set_string("time","0")
		meta:set_string("method","Cook")
		meta:set_string("locked","0")
		meta:set_string("isowner","0")
	end	
	if page == nil then 
		page = craft_guide.get_current_page(meta) 
	end
	if alternate == nil then 
		alternate = craft_guide.get_current_alternate(meta) 
	end
	local inv = meta:get_inventory()
	local size = inv:get_size("main")
	local start = (page-1) * (5*14) --was 1 too much before
	local pages = math.floor((size-1) / (5*14) + 1)
	local alternates = 0
	local stack = inv:get_stack("output",1)
	local crafts = craft_guide.crafts[stack:get_name()]
	if crafts ~= nil then
		alternates = #crafts
	end
	local backbutton=""
	if meta:get_string("saved_search")~="|" then
		backbutton="button[6.3,5.8;2.7,1;back_button;<--- Back]"
	end
	local changeable_part=""
	if meta:get_string("switch")=="youneed" and craft_guide.you_need then
		changeable_part="button[9.7,6.35;0.8,0.7;switch_to_bookmarks;>>]"
				.."tooltip[switch_to_bookmarks;Show your saved bookmarks]"
		if meta:get_string("poslist")=="down" then
			changeable_part= changeable_part.."label[8,6.5;You need:]"
				.."button[10.42,6.35;0.5,0.7;move_up;^]"
				.."tooltip[move_up;Move the list of needed items upwards]"
				.."label[11.4,6.0;Add to]"
				.."label[11.2,6.35;bookmarks]"
				.."label[12.6,6.05;->]"
				.."list[current_name;add;13,6;1,1;]"
				..craft_guide.build_button_list(meta,inv,"youneed",12,29,8,7,6)

		else
			changeable_part= changeable_part.."button[10.42,6.35;0.5,0.7;move_down;v]"
				.."tooltip[move_down;Move the list of needed items downwards]"
				..craft_guide.build_button_list(meta,inv,"youneed",12,29,0,1,14,0)
		end
		changeable_part= changeable_part..craft_guide.get_amounts(meta,inv,"youneed")

	end
 	if meta:get_string("switch")=="bookmarks" or (not craft_guide.you_need) or meta:get_string("poslist")=="up" then

		changeable_part= changeable_part.."label[8,6.5;Bookmarks]"
		if craft_guide.you_need and meta:get_string("switch")=="bookmarks" then
			changeable_part= changeable_part.."button[9.7,6.35;0.8,0.7;switch_to_youneed;>>]"
			.."tooltip[switch_to_youneed;Show amount of basic items needed]"
		end
		changeable_part= changeable_part.."list[current_name;bookmark;8,7;6,3;]"
			.."label[12,6.1;Bin ->]"
			.."list[current_name;bin;13,6;1,1;]"
	end

	local formspec = "size[14,10;]"
	if meta:get_string("switch")=="youneed" and meta:get_string("poslist")=="up" then
		formspec=formspec.."label[0.1,0.3;You need:]"
	else
		formspec=formspec.."list[current_name;main;0,0;14,5;"..tostring(start).."]"
	end
	formspec=formspec.."label[0,5;--== Learn to Craft ==--]"

		.."label[0,5.4;Drag any item to the Output box to see the]"
		.."label[0,5.8;craft. Save your favorite items in Bookmarks.]"

		.."field[6,5.4;2.3,1;craft_guide_search_box;;"..tostring(search).."]"
		.."button[7.8,5.1;1.2,1;craft_guide_search_button;Search]"
		..backbutton
		.."label[9.1,5.2;page "..tostring(page).." of "..tostring(pages).."]"
		.."button[11,5;1.5,1;craft_guide_prev;<<]"
		.."button[12.5,5;1.5,1;craft_guide_next;>>]"

		if inv:get_stack("fuel",1)==nil or inv:get_stack("fuel",1):get_name()==nil or inv:get_stack("fuel",1):get_name()=="" then
			formspec=formspec.."label[0,6.5;Output]"
		end
		formspec=formspec.."list[current_name;output;0,7;1,1;]"

		.."label[2,6.5;Inventory Craft]"
		if not (inv:get_stack("additional",1)==nil or inv:get_stack("additional",1):get_name()==nil 
			or inv:get_stack("additional",1):get_name()=="") then
			formspec=formspec.."list[current_name;additional;0.96,7;1,1;]"
		end
		formspec=formspec..craft_guide.build_button_list(meta,inv,"build",3,11,2,7,3)
		if not (inv:get_stack("cook",1)==nil or inv:get_stack("cook",1):get_name()==nil or inv:get_stack("cook",1):get_name()=="")
			or (inv:get_stack("fuel",1)==nil or inv:get_stack("fuel",1):get_name()==nil or inv:get_stack("fuel",1):get_name()=="") then
			formspec=formspec.."label["..tostring(6.22-string.len(meta:get_string("method"))*0.05)..",6.5;"..meta:get_string("method").."]"
			if not (inv:get_stack("cook",2)==nil or inv:get_stack("cook",2):get_name()==nil or inv:get_stack("cook",2):get_name()=="") then
				formspec=formspec..craft_guide.build_button_list(meta,inv,"cook",1,2,5.5,7,2)
			else
				formspec=formspec..craft_guide.build_button_list(meta,inv,"cook",1,1,6,7,1)
			end
		end
		--add flames from default mod for craft fuel
		if not (inv:get_stack("fuel",1)==nil or inv:get_stack("fuel",1):get_name()==nil or inv:get_stack("fuel",1):get_name()=="") then
			formspec=formspec.."label[6,6.5;Fuel]"
			..craft_guide.build_button_list(meta,inv,"fuel",1,1,6,7,1)
			.."image[6.13,9.1;0.7,0.7;default_furnace_fire_fg.png]"
			if meta:get_string("time")~=nil and meta:get_string("time")~="nil" then	
				formspec=formspec.."label[6.02,8.17;"..meta:get_string("time").." sec]"
			end
		end
		if not (inv:get_stack("cook",1)==nil or inv:get_stack("cook",1):get_name()==nil or inv:get_stack("cook",1):get_name()=="") then
			formspec=formspec.."list[current_name;machine;6,9;1,1;]"
			if meta:get_string("time")~=nil and meta:get_string("time")~="nil" then	
				formspec=formspec.."label[6.02,8.17;"..meta:get_string("time").." sec]"
			end
		end
	if alternates > 1 then
		if alternate>alternates then
			alternate=1	
		end
		formspec = formspec
			.."label[0,8;recipe "..tostring(alternate).." of "..tostring(alternates).."]"
			.."button[0,8.4;2,1;alternate;Alternate]"

	end

		if craft_guide.copy_button 
			and inv:get_stack("output",1)~=nil and inv:get_stack("output",1):get_name()~=nil and inv:get_stack("output",1):get_name()~=nil then
			if craft_guide.crafts[inv:get_stack("output",1):get_name()]~=nil then
				if craft_guide.crafts[inv:get_stack("output",1):get_name()][alternate]~=nil then
					if (craft_guide.crafts[inv:get_stack("output",1):get_name()][alternate]).type==nil
						or (craft_guide.crafts[inv:get_stack("output",1):get_name()][alternate]).type=="shapeless" then
						formspec=formspec.."label[5.45,8.6;Prepare to craft:]"
						.."button[5.6,9.2;0.7,0.8;copy1;1]"
						.."button[6.2,9.2;0.7,0.8;copy10;10]"
						.."button[6.8,9.2;0.7,0.8;copy99;99]"
					end
				end
			end
		end
		formspec=formspec..changeable_part
		.."button_exit[0,9.2;1,0.8;close_mm;ESC]"


	meta:set_string("saved_formspec",formspec)
	--this needs to be added last, so it can be changed when restoring a locked formspec
	if meta:get_string("isowner")=="1" then
		if meta:get_string("locked")=="0" then
			formspec=formspec.."button[0.88,9.2;1.22,0.8;lock;Lock]"
				.."tooltip[lock;Lock Craft Guide in current state]"
		else
			formspec=formspec.."button[0.88,9.2;1.22,0.8;lock;Locked]"
				.."tooltip[lock;Craft Guide is locked - Press again to unlock]"
		end
	else
		if meta:get_string("locked")~="0" and meta:get_string("owner")~=nil and meta:get_string("owner")~="" then
			formspec=formspec.."label[0.88,9.2;Locked]"
				.."tooltip[close_mm;   Owner: "..meta:get_string("owner").."]"
		end
	end


	return formspec
end


-- on_construct
craft_guide.on_construct = function(pos)
	local meta = minetest.env:get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size("output", 1)
	inv:set_size("additional", 1) --here goes the second output of centrifuge recipe, just shown when needed
	inv:set_size("build", 3*3)
	inv:set_size("cook", 2*1)
	inv:set_size("fuel", 1)
	inv:set_size("machine", 1)
	inv:set_size("bookmark", 6*3)
	inv:set_size("youneed", 6*15)
	inv:set_size("bin", 1)
	inv:set_size("add", 1)
	inv:set_size("copylist", 9)
	inv:set_size("tempinv", 42)
	inv:set_size("tempmain", 32)
	inv:set_size("tempresult", 1)
	if meta:get_string("locked")~="1" then
		craft_guide.create_inventory(inv)
	end
	meta:set_string("formspec",craft_guide.get_craft_guide_formspec(meta))
	meta:set_string("out","")
	meta:set_string("addindex","1")
end


-- on_receive_fields
craft_guide.on_receive_fields = function(pos, formname, fields, player)
	local meta = minetest.env:get_meta(pos);
	if meta:get_string("locked")=="1" then
		craft_guide.save_meta(meta)
	end
	if minetest.get_node(pos).name=="craft_guide:sign_wall_locked" or minetest.get_node(pos).name=="craft_guide:lcd_pc_locked" then
		if meta:get_string("owner")=="" then
			meta:set_string("owner",player:get_player_name())
			meta:set_string("isowner","1")
		elseif meta:get_string("owner")==player:get_player_name() then
			meta:set_string("isowner","1")
		end
	end
	local inv = meta:get_inventory()
	if inv:get_size("additional")==nil or inv:get_size("additional")~=1 then  --old version, construct again
		local node=minetest.get_node(pos)
		minetest.set_node(pos, node)
		meta = minetest.env:get_meta(pos)
		inv = meta:get_inventory()
	end
	if inv:get_size("copylist")==nil or inv:get_size("copylist")~=9 then  
	inv:set_size("copylist", 9)
	inv:set_size("tempinv", 42)
	inv:set_size("tempmain", 32)
	inv:set_size("tempresult", 1)
	end
	local size = inv:get_size("main",1)
	local stack = inv:get_stack("output",1)
	local crafts = craft_guide.crafts[stack:get_name()]
	local alternate = craft_guide.get_current_alternate(meta)
	local alternates = 0
	if crafts ~= nil then
		alternates = #crafts
	end

	local page = craft_guide.get_current_page(meta)
	local pages = math.floor((size-1) / (5*14) + 1)

	
	-- search
	local update_search=false
	local search
	search = fields.craft_guide_search_box
	if search~=nil then
		if string.lower(search)==string.upper(search) and tonumber(search)==nil and search~="*" then
			search=""
		end
		update_search=true
	else
			search=meta:get_string("search")
	end
	meta:set_string("search", search)
	if fields.craft_guide_search_button then
		if search==nil then
			meta:set_string("search", "")
		end
		if meta:get_string("switch")=="youneed" and meta:get_string("poslist")=="up" then
			meta:set_string("switch","bookmarks")
		end		
		meta:set_string("saved_search", "|")
		page = 1
		update_search=true
	end

	-- copy buttons:

	local copy=0
	if fields.copy99 then
		copy=99
	elseif fields.copy10 then
		copy=10
	elseif fields.copy1 then
		copy=1
	end
	if copy~=0 and player~=nil then
		local inv2=player:get_inventory()
		if inv2~=nil then
			for i=0,inv:get_size("copylist"),1 do
				inv:set_stack("copylist",i,ItemStack(nil))
			end
			for i=0,inv:get_size("build"),1 do
				local stk=inv:get_stack("build", i)
				if stk:get_count()>0 then
					if string.sub(stk:get_name(),1,6)=="group:" then
						inv:set_stack("copylist",i,ItemStack(stk:get_name().."~|@q 1"))
					else
						inv:add_item("copylist",ItemStack(stk:get_name().."~|@q 1")) --trick, because stacksize of unknown items is 99
					end
				end
			end
			inv:set_list("tempinv",inv2:get_list("main"))
			for i=0,inv2:get_size("craft"),1 do
				local st=inv2:get_stack("craft",i)
				if st:get_count()>0 then
					inv:add_item("tempinv",st)
				end
			end
			local st=inv2:get_stack("craftresult",1)
			if st:get_count()>0 then
				inv:add_item("tempinv",st)
			end
			for i=0,inv:get_size("copylist"),1 do
				local stk=inv:get_stack("copylist", i)
				local stkcount=stk:get_count()
				if stkcount>0 then
					local stkname=stk:get_name()
					if string.sub(stkname,1,6)~="group:" then
						stk=ItemStack(string.sub(stkname,1,string.len(stkname)-4).." "..tostring(stkcount*copy))
						inv:set_stack("copylist",i,ItemStack(nil))
						local lastcheck=0
						local removed=0
						for x=1,9,1 do
							if stk:get_count()>stk:get_stack_max()+removed then
								stk=ItemStack(stk:get_name().." "..tostring(stk:get_stack_max()))
							else
								lastcheck=1
							end
							removed=removed+(inv:remove_item("tempinv",stk)):get_count()
							if lastcheck==1 or not (inv:contains_item("tempinv",ItemStack(stk:get_name().." 1"))) then
								break
							end
						end
						if copy>math.floor(removed/stkcount) then
							inv:add_item("tempinv",ItemStack(stk:get_name().." "..tostring(removed-(math.floor(removed/stkcount)*stkcount))))
							for jj=0,i-1,1 do
								local oldstack=inv:get_stack("copylist", jj)
								if oldstack:get_count()>0 and string.sub(oldstack:get_name(),1,6)~="group:"then
									local newstack=ItemStack(oldstack:get_name().." "..tostring((copy-math.floor(removed/stkcount))*oldstack:get_count()))
									inv:add_item("tempinv", newstack)
								end
							end
							copy=math.floor(removed/stkcount)
						end
						lastcheck=0
						if copy<1 then
							break
						end
							
					end
				end
			end
			if copy>0 then
			for i=0,inv:get_size("copylist"),1 do
				local stk=inv:get_stack("copylist", i)
				local stkcount=stk:get_count()
				if stkcount>0 then
					local stkname=stk:get_name()
					if string.sub(stkname,1,6)=="group:" then
						local success=false
						local groups=string.sub(stkname,7,string.len(stkname)-4)
						for count=copy,0,-1 do
							for i2=0,inv:get_size("tempinv"),1 do
								local check=inv:get_stack("tempinv",i2)
								if check:get_count()>0 then
									local name=check:get_name()
									local hasgroup=1
									for group in string.gmatch(groups,"([^,]+)") do
										if minetest.get_item_group(name, group)==0 then
											hasgroup=0
											break
										end
									end
									if hasgroup==1 then
	
										if inv:contains_item("tempinv",ItemStack(name.." "..tostring(count))) then	
											inv:remove_item("tempinv",ItemStack(name.." "..tostring(count)))
											inv:set_stack("copylist",i,ItemStack(name.." 1"))
											success=true
					                         			break
										end
									end
								end
							end
							if copy>count then
								for jj=0,i-1,1 do
									local oldstack=inv:get_stack("copylist", jj)
									if oldstack:get_count()>0 and string.sub(oldstack:get_name(),1,6)~="group:" then
										local newstack=ItemStack(oldstack:get_name().." "..tostring((copy-count)*oldstack:get_count()))
										inv:add_item("tempinv", newstack)
									end
								end
								copy=count
							end
							if success or count<1 then
								break
							end

						end
					end
				end
				if copy<1 then
					break
				end
			end
			end
			if copy>0 then
				for i=0,inv:get_size("build"),1 do 
					local stk=inv:get_stack("build", i)
					local stkcount=stk:get_count()
					if stkcount>0 then
						local stkname=stk:get_name()
						if string.sub(stkname,1,6)=="group:" then
							stk=inv:get_stack("copylist", i)
							stkname=stk:get_name()
						end

						stk=ItemStack(stkname.." "..tostring(copy))
						inv:set_stack("copylist",i,stk)
					end
				end

				local clean=1
				if copy>0 then
					for i=0,inv:get_size("tempmain"),1 do
						inv:set_stack("tempmain",i,ItemStack(nil))
					end

					local stk=inv2:get_stack("craftresult", 1)
					if stk:get_count()>0 then
						if inv:contains_item("tempinv",stk) then
							inv:remove_item("tempinv",stk)
							inv:add_item("tempresult",1,stk)
						else 
							inv:add_item("tempresult",1,ItemStack(nil))
						end
					end
					for i=0,inv2:get_size("main"),1 do --restore players main inventory
						local stk=inv2:get_stack("main", i)
						if stk:get_count()>0 then
							local removed=(inv:remove_item("tempinv",stk)):get_count()
							if removed>0 then
								inv:set_stack("tempmain",i,ItemStack(stk:get_name().." "..tostring(removed)))
							end
						end
					end
					for i=0,inv:get_size("tempinv"),1 do --check if items left in crafting grid can be moved to players inventory
						local stk=inv:get_stack("tempinv", i)
						if stk:get_count()>0 then
							if inv:room_for_item("tempmain",stk) then
								inv:add_item("tempmain",stk)
								inv:set_stack("tempinv",i,ItemStack(nil))
							else 
								clean=0
							end
						end
					end
					if clean==0 then
						local free=0
						for i=0,inv:get_size("tempmain"),1 do --check if two small stacks of same item can be joined to one big stack
							local stk=inv:get_stack("tempmain", i)
							if stk:get_count()>0 then
								if inv:room_for_item("tempmain",ItemStack(stk:get_name().." "..tostring(stk:get_stack_max()*(1+free)))) then
									inv:set_stack("tempmain",i,ItemStack(nil))
									inv:add_item("tempmain",stk)
									free=free+1
								end
							end
						end
						for i=0,inv:get_size("build"),1 do --try to move more items to crafting grid
							local stk=inv:get_stack("build", i)
							local stkcount=stk:get_count()
							if stkcount>0 then
								local stkname=stk:get_name()
								stk=ItemStack(stkname.." 1")
								local stkmax=ItemStack(stkname.." "..tostring(stk:get_stack_max()-copy))
								if inv:contains_item("tempinv",stk) then
									local removed=inv:remove_item("tempinv",stkmax)
									inv:set_stack("copylist",i,ItemStack(stkname.." "..tostring(removed:get_count()+copy)))
								elseif inv:contains_item("tempmain",stk) then
									local removed=inv:remove_item("tempmain",stkmax)
									inv:set_stack("copylist",i,ItemStack(stkname.." "..tostring(removed:get_count()+copy)))
								end
							end
						end

						for i=0,inv:get_size("tempinv"),1 do --last try to place all left items in main inventory
							local stk=inv:get_stack("tempinv", i)
							if stk:get_count()>0 then
								if inv:room_for_item("tempmain",stk) then
									inv:add_item("tempmain",stk)
									inv:set_stack("tempinv",i,ItemStack(nil))
								else 
									minetest.chat_send_player(player:get_player_name(), "Can't copy this recipe to crafting grid because your inventory is too full to move items around!")

									copy=0
									break
								end
							end
						end
					end
					if copy>0 then --we can successfully craft some of this item
						for i=0,inv:get_size("copylist"),1 do 
							local stk=inv:get_stack("copylist", i)
							local stkcount=stk:get_count()
							if stkcount>copy then --if possible remove additional items back to inventory
								stk=ItemStack(stk:get_name().." 1")
								if inv:room_for_item("tempmain",stk) then
									local left=inv:add_item("tempmain",ItemStack(stk:get_name().." "..tostring(stkcount-copy)))
									if left~=nil and left~=0 then 
										inv:set_stack("copylist", i,ItemStack(stk:get_name().." "..tostring(copy+left:get_count())))	
									end
									
								end
							end
						end
	
						--add wear and metadata to items again
						for t=0,42,1 do 
							local tx=-10
							local invlist="tempmain"
							if t<=9 then
								invlist="copylist"
								tx=0							
							end
							local itemStack=inv:get_stack(invlist, tx+t)
							if itemStack:get_count()==1 then
								if itemStack:get_stack_max()==1 then
									local itempos=t
									local found=false
									local itemStack2=ItemStack(nil)
									for slot=0,42,1 do
										if slot<=9 then
											itemStack2=inv2:get_stack("craft", slot)
											if itemStack2:get_name()==itemStack:get_name() then
												found=true
											end
										else
											itemStack2=inv2:get_stack("main", slot-10)
											if itemStack2:get_name()==itemStack:get_name() then
												found=true
											end
										end
										if found then
											found=false
											inv:set_stack(invlist, t+tx,itemStack2)
											for tt=itempos+1,42,1 do
												if tt<=9 then
													itemStack2=inv:get_stack("copylist", tt)
													if itemStack2:get_name()==itemStack:get_name() then
														itemStack=inv2:get_stack("copylist", tt)
														itempos=tt
														break
													end
												else
													itemStack2=inv:get_stack("tempmain",tt-10)
													if itemStack2:get_name()==itemStack:get_name() then
														itemStack=inv:get_stack("tempmain", tt-10)
														itempos=tt
														break
													end
												end
											end
										end
									end	
								end
							end
						end
						--copy tempinventory to real inventory
						inv2:set_list("craft",inv:get_list("copylist"))
						inv2:set_list("main",inv:get_list("tempmain"))
						inv2:set_list("craftresult",inv:get_list("tempresult"))
					
					end				
				end
			end
		end
	end

	
	-- change page
	if fields.craft_guide_prev then
		page = page - 1
		if page < 1 then
			page = pages
		end
		if meta:get_string("switch")=="youneed" and meta:get_string("poslist")=="up" then
			meta:set_string("switch","bookmarks")
		end
	end

	if fields.craft_guide_next then
		page = page + 1
		if page > pages then
			page = 1
		end
		if meta:get_string("switch")=="youneed" and meta:get_string("poslist")=="up" then
			meta:set_string("switch","bookmarks")
		end
	end

	if page > pages then
		page = pages
	end

	if page < 1 then
		page = 1
	end

	-- go back to search result
	if fields.back_button then
		if meta:get_string("switch")=="youneed" and meta:get_string("poslist")=="up" then
			meta:set_string("switch","bookmarks")
		end		
		local saved_search = meta:get_string("saved_search")
		if saved_search~="|" then
			search=saved_search
			meta:set_string("search", saved_search)
			page=tonumber(meta:get_string("saved_page"))
			pages=tonumber(meta:get_string("saved_pages"))
			meta:set_string("saved_search", "|")
		end
		update_search=true
	end

	--lock current state
	if fields.lock and meta:get_string("owner")==player:get_player_name() then	
		if meta:get_string("locked")=="2" then
			meta:set_string("locked","0")
		else
			meta:set_string("locked","1")
		end
	end


	--toogle between bookmarks/you need
	if fields.switch_to_bookmarks then	
		meta:set_string("switch","bookmarks")
	end

	if fields.switch_to_youneed then	
		meta:set_string("switch","youneed")
		craft_guide.update_recipe(meta, player, stack, alternate)
	end

	--replacing bookmarks or main item list?
	if fields.move_up then	
		if meta:get_string("switch")=="youneed" then
			meta:set_string("poslist","up")
			if meta:get_string("locked")~="0" then
				craft_guide.update_recipe(meta, player, stack, alternate)
			end
		end
	end

	if fields.move_down then	
		if meta:get_string("switch")=="youneed" then
			meta:set_string("poslist","down")
			if meta:get_string("locked")~="0" then
				craft_guide.update_recipe(meta, player, stack, alternate)
			end
		end
	end


	-- get an alternate recipe
	if fields.alternate then
		alternate = alternate+1
		craft_guide.update_recipe(meta, player, stack, alternate)
	end
	if alternate > alternates then
		alternate = 1
	end

	--group buttons, finally a solution with a for loop
	local starts=""
	local ends=""
	local xx=""
	local formspec = meta:get_string("formspec")
	for button_number=1,29,1 do
		if fields[("t_758s"..tostring(button_number))] then 
			--search the group name of pressed group button directly in formspec string
			xx,starts=string.find(formspec,"tooltip%[t_758s"..tostring(button_number)..";")
			if starts~=nil then
				ends,xx=string.find(formspec,"%]",starts+1)
				local group=string.lower(string.sub(formspec,starts+1,ends-2))
				--displaying of items in a group is implemented in search function, just need to set search string
				meta:set_string("search", "group:"..group)
				--save old search string for restoring when "<-- back" is pressed
				if meta:get_string("saved_search")=="|" then
					meta:set_string("saved_search", search)
					meta:set_string("saved_page", tostring(page))
					meta:set_string("saved_pages", tostring(pages))
				end
				page = 1
				search="group:"..group
				update_search=true
			end
		break
		end
	end
	if starts~="" and meta:get_string("switch")=="youneed" and meta:get_string("poslist")=="up" then --button pressed, need to move back to bookmarks
		meta:set_string("switch","bookmarks")
	end
	-- update the formspec
	if meta:get_string("locked")=="2" and (fields["quit"] or fields.close_mm) then
		craft_guide.restore_meta(meta)
	else
		if update_search then
			craft_guide.create_inventory(inv, search)
		end
		meta:set_string("formspec",craft_guide.get_craft_guide_formspec(meta, search, page, alternate))
		if meta:get_string("locked")=="1" then
			craft_guide.save_meta(meta)		
		end
	end
end


-- returns formspec string of a inventory list with buttons for group items
craft_guide.build_button_list = function(meta,inv,list,start_index,end_index,x,y,w,show_empty)
	--button numbers go from start_index to end_index
	--button numbers 1,(2)= cook or fuel
	--button numbers 3-11= inventory craft field
	--button numbers 12-29= you need items
	if show_empty~=0 then
		show_empty=1
	end
	local string=""
	for i=1,end_index-start_index+1,1 do
		local string_old=string
		local stack = inv:get_stack(list,i)
		if stack~=nil then
			local name=stack:get_name()
			if string.sub(name,1,6)=="group:" then
				local groups=string.sub(name,7)
				local saved=""
				for name,def in pairs(minetest.registered_items) do
					local hasgroup=1
					for group in string.gmatch(groups,"([^,]+)") do
						if minetest.get_item_group(name, group)==0 then
							hasgroup=0
						end
					end
					if hasgroup==1 then

                                                --prefer items from default mod
						if string.sub(name,1,8)=="default:" then
							--prefer items with simple short names, because cnc machines adds items under default prefix too
							if string.len(name)<20 then 
								string=string.."item_image_button["..tostring(x+((i-1)%w))..","
								..tostring(y+math.floor((i-1)/w))..";1,1;"
								..name..";t_758s"..tostring(i+start_index-1)..";group]"
								.."tooltip[t_758s"..tostring(i+start_index-1)..";"
								..string.upper(string.sub(groups,1,1))..string.sub(groups.." ",2).."]"
	
								saved=""
								break
							end
						elseif saved=="" then
							saved=name
						end
					end
				end
				if saved~="" then
					string=string.."item_image_button["..tostring(x+((i-1)%w))..","
					..tostring(y+math.floor((i-1)/w))..";1,1;"..saved..";t_758s"..tostring(i+start_index-1)..";group]"
					.."tooltip[t_758s"..tostring(i+start_index-1)..";"
					..string.upper(string.sub(groups,1,1))..string.sub(groups.." ",2).."]"
				end
			end
		end

		if string_old==string and ((stack~=nil and stack:get_name()~="") or show_empty==1) then
			string=string.."list[current_name;"..list..";"..tostring(x+((i-1)%w))..","..tostring(y+math.floor((i-1)/w))
				..";1,1;"..tostring(i-1).."]"
		end
	end
	return string
end


-- returns a formspec string with item amounts
craft_guide.get_amounts = function(meta,inv,list)
	local amounts=""
	local xx=8.1
	local yy=7.45
	local w=6
	local size=18
	if meta:get_string("poslist")=="up" then
		xx=0.1
		yy=1.45
		w=14
		size=70
	end
	for jj=1,size,1 do
		local item=string.lower(inv:get_stack(list,jj):get_name())
		local cnt=meta:get_string("globalcount")
		if item==nil or item=="" then
			break
		end
		local count=craft_guide.you_need_list[item]
		if count~=nil then
			cnt=math.floor(((count)/tonumber(meta:get_string("globalcount")))*1000+0.49)/1000
			if cnt>1000 then
				cnt=math.floor(cnt+0.49)
			elseif cnt>100 then
				cnt=math.floor(cnt*10+0.49)/10
			elseif cnt>10 then
				cnt=math.floor(cnt*100+0.49)/100
			end
			amounts=amounts.."label["..tostring(xx+((jj-1)%w))..","..tostring(yy+math.floor((jj-1)/w))..";"..tostring(cnt).."]"
		end
		jj=jj+1
		if jj > size then
			break
		end

	end
	return amounts
end


-- get_current_page
craft_guide.get_current_page = function(meta)
	local formspec = meta:get_string("formspec")
	local page = string.match(formspec, "label%[[%d.]+,[%d.]+;page (%d+) of [%d.]+%]")
		page = tonumber(page) or 1
	return page
end


-- get_current_alternate
craft_guide.get_current_alternate = function(meta)
	local formspec = meta:get_string("formspec")
	local alternate = string.match(formspec, "label%[[%d.]+,[%d.]+;recipe (%d+) of [%d.]+%]")
	alternate = tonumber(alternate) or 1
	return alternate
end


-- update_recipe
craft_guide.update_recipe = function(meta, player, stack, alternate)
	local globalcount=1
	local list={}
	local list2={}
	local test={}
	local forlist={}
	local inv = meta:get_inventory()

	for i=0,inv:get_size("build"),1 do
		inv:set_stack("build", i, nil)
	end
	for i=0,inv:get_size("youneed"),1 do
		inv:set_stack("youneed", i, nil)
	end

	inv:set_stack("cook", 1, nil)
	inv:set_stack("cook", 2, nil)

	inv:set_stack("fuel", 1, nil)
	inv:set_stack("machine", 1, nil)
	inv:set_stack("additional", 1, nil)

	meta:set_string("method","Cook")

	if stack==nil then return end
	inv:set_stack("output", 1, stack:get_name())
	if alternate==nil then
		alternate=craft_guide.get_current_alternate(meta)
	end
	alternate = tonumber(alternate) or 1
	local crafts = craft_guide.crafts[stack:get_name()]
	if crafts == nil then
		if stack:get_name()~=nil and stack:get_name()~="" then
			minetest.chat_send_player(player:get_player_name(), "no recipe available for "..stack:get_name())
		end
		meta:set_string("formspec",craft_guide.get_craft_guide_formspec(meta))
		return
	end
	if alternate < 1 or alternate > #crafts then
		alternate = 1
	end
	if stack:get_name()~=nil and stack:get_name()~="" then
		if meta:get_string("switch")=="youneed" then
			craft_guide.log(player:get_player_name().." shows needed items for recipe "..alternate.." for "..stack:get_name())
		else
			craft_guide.log(player:get_player_name().." requests recipe "..alternate.." for "..stack:get_name())
		end
	end	
	local craft = crafts[alternate]
	
	-- show me the unknown items

	--craft_guide.log(dump(craft))

	--minetest.chat_send_player(player:get_player_name(), "recipe for "..stack:get_name()..": "..dump(craft))
	
	local itemstack = ItemStack(craft.output)
	inv:set_stack("output", 1, itemstack)

	if craft.type~=nil and craft.type~="shapeless" and craft.type~="fuel" then
		-- cook
		if craft.type=="cooking" then
			if craft.cooktime==nil then
				meta:set_string("time","3")
			else
				meta:set_string("time",tostring(craft.cooktime))
			end
			inv:set_stack("cook", 1, craft.recipe)
		if minetest.get_modpath("default") then
			inv:set_stack("machine", 1, ItemStack("default:furnace"))
		end
		else
		-- custom types added by technic mod
			local input={}
			if type(craft.input)~="table" or craft.input[1]==nil or craft.input[1]=="" then
				table.insert(input,craft.input)
			else 
				input=craft.input
			end
			if type(input)~="table" or input[1]==nil or input[1]=="" then
				input={}
				table.insert(input,craft.input)
			end

			if craft.type=="Grinder" then
				inv:set_stack("machine", 1, ItemStack("technic:lv_grinder"))
				inv:set_stack("cook", 1, input[1])
			
			elseif craft.type=="Extractor" then
				inv:set_stack("machine", 1, ItemStack("technic:extractor"))
				inv:set_stack("cook", 1, input[1])

			elseif craft.type=="Compressor" then
				inv:set_stack("machine", 1, ItemStack("technic:compressor"))
				inv:set_stack("cook", 1, input[1])

			elseif craft.type=="Alloy Furnace" then
				inv:set_stack("machine", 1, ItemStack("technic:lv_alloy_furnace"))
				inv:set_stack("cook", 1, craft.input[2])
				inv:set_stack("cook", 2, craft.input[1])

			elseif craft.type=="Centrifuge" then
				inv:set_stack("machine", 1, ItemStack("technic:mv_centrifuge"))
				inv:set_stack("cook", 1, input[1])
				inv:set_stack("additional", 1, craft.output2)
			end

			meta:set_string("method",craft.type)
			meta:set_string("time",tostring(craft.time))
			meta:set_string("globalcount",tostring(ItemStack(craft.output):get_count()))
		end
		
	else
	-- fuel
		if craft.type == "fuel" then
			meta:set_string("time",tostring(craft.burntime))
			itemstack=ItemStack(craft.recipe)
			inv:set_stack("output", 1, meta:get_string("out"))
			inv:set_stack("fuel", 1, craft.recipe)
		else
	
			-- build (shaped or shapeless)
			if craft.recipe[1] then
				if (type(craft.recipe[1]) == "string") then
					inv:set_stack("build", 1, craft.recipe[1])
				else
					if craft.recipe[1][1] then
						inv:set_stack("build", 1, craft.recipe[1][1])
					end
					if craft.recipe[1][2] then
						inv:set_stack("build", 2, craft.recipe[1][2])
					end
					if craft.recipe[1][3] then
						inv:set_stack("build", 3, craft.recipe[1][3])
					end
				end
			end
			if craft.recipe[2] then
				if (type(craft.recipe[2]) == "string") then
					inv:set_stack("build", 2, craft.recipe[2])
				else
					if craft.recipe[2][1] then
						inv:set_stack("build", 4, craft.recipe[2][1])
					end
					if craft.recipe[2][2] then
						inv:set_stack("build", 5, craft.recipe[2][2])
					end
					if craft.recipe[2][3] then
						inv:set_stack("build", 6, craft.recipe[2][3])
					end
				end
			end
			if craft.recipe[3] then
				if (type(craft.recipe[3]) == "string") then
					inv:set_stack("build", 3, craft.recipe[3])
				else
					if craft.recipe[3][1] then
						inv:set_stack("build", 7, craft.recipe[3][1])
					end
					if craft.recipe[3][2] then
						inv:set_stack("build", 8, craft.recipe[3][2])
					end
					if craft.recipe[3][3] then
						inv:set_stack("build", 9, craft.recipe[3][3])
					end
				end
			end
			if craft.recipe[4] then
				if (type(craft.recipe[4]) == "string") then
					inv:set_stack("build", 4, craft.recipe[4])
				end
			end
			if craft.recipe[5] then
				if (type(craft.recipe[5]) == "string") then
					inv:set_stack("build", 5, craft.recipe[5])
				end
			end
			if craft.recipe[6] then
				if (type(craft.recipe[6]) == "string") then
					inv:set_stack("build", 6, craft.recipe[6])
				end
			end
			if craft.recipe[7] then
				if (type(craft.recipe[7]) == "string") then
					inv:set_stack("build", 7, craft.recipe[7])
				end
			end
			if craft.recipe[8] then
				if (type(craft.recipe[8]) == "string") then
					inv:set_stack("build", 8, craft.recipe[8])
				end
			end
			if craft.recipe[9] then
				if (type(craft.recipe[9]) == "string") then
					inv:set_stack("build", 9, craft.recipe[9])
				end
			end
		end
	end
	if meta:get_string("switch")=="youneed" and craft_guide.you_need then
		craft_guide.you_need_list=nil
		craft_guide.you_need_list={}
		local stack_name=stack:get_name()
		-- get the saved list if we have it already, no need to calcalute all again
		if craft_guide.saved_you_need_lists[stack_name.."@|²"..tostring(alternate)]~=nil then
			craft_guide.you_need_list=craft_guide.saved_you_need_lists[stack_name.."@|²"..tostring(alternate)]
			globalcount=tonumber(craft_guide.saved_you_need_lists[stack_name.."@|³"..tostring(alternate)])
			if globalcount==nil or globalcount<1 then
				globalcount=1
			end
			local v=1
			for _item,_ in pairs(craft_guide.you_need_list) do
				inv:set_stack("youneed", v, _item)
				v=v+1
			end
		else
			list[stack_name] = {}
			list[stack_name] = 1
			for j=1,6,1 do	--main iteration loop for resolving recipes into base items
				local finished=1
				local limit=inv:get_size("youneed")
				local k=0
				for name,count in pairs(list) do
					if k>limit then
						break
					end
					k=k+1
					local isbase=0
					if name==nil or name=="" or count==0 or string.sub(name,1,6)=="group:" then
						isbase=1
					elseif j>1 or k>1 then
						for ii=1,999,1 do
							if craft_guide.basic_item_prefixes[ii]==nil or craft_guide.basic_item_prefixes[ii]=="" then  
								break
							elseif string.sub(name,1,string.len(craft_guide.basic_item_prefixes[ii]))==
								string.lower(craft_guide.basic_item_prefixes[ii]) then
								isbase=1
								break
							end
						end
						if isbase==0 then
							for aa=1,999,1 do
								if craft_guide.basic_item_groups[aa]==nil or craft_guide.basic_item_groups[aa]=="" then  
									break
								elseif minetest.get_item_group(name, string.lower(craft_guide.basic_item_groups[aa]))>0 then
									isbase=1
									break
								end
							end
							if isbase==0 then
								for bb=1,999,1 do
									if craft_guide.basic_item_endings[bb]==nil 
										or craft_guide.basic_item_endings[bb]=="" then  	
										break
									elseif string.sub(name,string.len(name)-
										(string.len(craft_guide.basic_item_endings[bb])-1)	)==
										string.lower(craft_guide.basic_item_endings[bb]) then
										isbase=1
										break
									end
								end
								if isbase==0 then
									for cc=1,999,1 do
										if craft_guide.basic_items[cc]==nil or craft_guide.basic_items[cc]=="" then  
											break
										elseif name==string.lower(craft_guide.basic_items[cc]) then
											isbase=1
											break
										end
									end
								end
							end
						end
					end
					crafts = craft_guide.crafts[name]
					if crafts==nil or ((j>1 or k>1) and crafts[1].type~=nil 
						and crafts[1].type~="cooking" and crafts[1].type~="shapeless") 	then
						isbase=1
					end
					if isbase==0 then
						finished=0
						if crafts ~= nil then
							local istest=1
							local bestcraft=1
							local bestvalue=10 --lower is better


--too much tabs needed, starting here left again till this section is over
for craftnumber=1,#crafts+1,1 do
	if craftnumber>49 then
		craftnumber=#crafts+1
	end
	local index=craftnumber
	if j>1 then
		if #crafts==1 and index<=#crafts then 
			bestvalue=0
			istest=0
		elseif index>#crafts or bestvalue==0 then
			index=bestcraft
			bestvalue=0
			istest=0
		end
	else
		bestvalue=0
		index=alternate
		istest=0
	end
	local craft = crafts[index]
	if craft~=nil and craft.type~="fuel" then
		local amount=count
		if istest==0 then
			list[name]=0
			local output_count=ItemStack(craft.output):get_count()
			if output_count~=1 and (j>1 or k>1) then
				if amount/output_count==math.floor(amount/output_count) then
					amount=amount/output_count
				else
					globalcount=globalcount*output_count
					for _name,_amount in pairs(list) do
						if tonumber(amount)>0 then
							list[_name]=tonumber(_amount)*output_count
						end
					end
				end
			end
		end
		if istest==1 then
			list2=list
			list=nil
			list={}
			list=test
		end
		if craft.type == "cooking" then
			if list[craft.recipe]==nil then
				list[(craft.recipe)]={}
				list[(craft.recipe)]=amount
			else
				local add=amount+tonumber(list[(craft.recipe)])
				list[(craft.recipe)]=add
			end
		elseif craft.type ~=nil and craft.type ~= "fuel" and craft.type ~= "shapeless" then
			local input=ItemStack(craft.input):get_name()
			local _count=ItemStack(craft.input):get_count()
			if input~=nil and input~="" then
				if list[input]==nil then
					list[input]={}
					list[input]=amount*_count
				else
					local add=amount*_count+tonumber(list[input])
					list[input]=add
				end
			else
				input=ItemStack(craft.input[1]):get_name()
				_count=ItemStack(craft.input[1]):get_count()
				if input~=nil and input~="" then
					if list[input]==nil then
						list[input]={}
						list[input]=amount*_count
					else
						local add=amount*_count+tonumber(list[input])
						list[input]=add
					end
					input=ItemStack(craft.input[2]):get_name()
					_count=ItemStack(craft.input[2]):get_count()
					if input~=nil and input~="" then
						if list[input]==nil then
						list[input]={}
						list[input]=amount*_count
					else
						local add=amount*_count+tonumber(list[input])
						list[input]=add
					end
				end
			end
		end
	elseif craft.type==nil or craft.type=="shapeless" then
		if craft.recipe[1] then
			if (type(craft.recipe[1]) == "string") then
				if list[craft.recipe[1]]==nil then
					list[(craft.recipe[1])]={}
					list[(craft.recipe[1])]=amount
				else
					local add =amount+tonumber(list[(craft.recipe[1])])
					list[(craft.recipe[1])]=add
				end
			else
				if craft.recipe[1][1] then
					if list[(craft.recipe[1][1])]==nil then
						list[(craft.recipe[1][1])]={}
						list[(craft.recipe[1][1])]=amount
					else
						local add =amount+tonumber(list[(craft.recipe[1][1])])
						list[(craft.recipe[1][1])]=add
					end
				end
				if craft.recipe[1][2] then
					if list[(craft.recipe[1][2])]==nil then
						list[(craft.recipe[1][2])]={}
						list[(craft.recipe[1][2])]=amount
					else
						local add =amount+tonumber(list[(craft.recipe[1][2])])
						list[(craft.recipe[1][2])]=add
					end
				end
				if craft.recipe[1][3] then
					if list[(craft.recipe[1][3])]==nil then
						list[(craft.recipe[1][3])]={}
						list[(craft.recipe[1][3])]=amount
					else
						local add =amount+tonumber(list[(craft.recipe[1][3])])
						list[(craft.recipe[1][3])]=add
					end
				end
			end
		end
		if craft.recipe[2] then
			if (type(craft.recipe[2]) == "string") then
				if list[(craft.recipe[2])]==nil then
					list[(craft.recipe[2])]={}
					list[(craft.recipe[2])]=amount
				else
					local add =amount+tonumber(list[(craft.recipe[2])])
					list[(craft.recipe[2])]=add
				end
			else
				if craft.recipe[2][1] then
					if list[(craft.recipe[2][1])]==nil then
						list[(craft.recipe[2][1])]={}
						list[(craft.recipe[2][1])]=amount
					else
						local add =amount+tonumber(list[(craft.recipe[2][1])])
						list[(craft.recipe[2][1])]=add
					end
				end
				if craft.recipe[2][2] then
					if list[(craft.recipe[2][2])]==nil then
						list[(craft.recipe[2][2])]={}
						list[(craft.recipe[2][2])]=amount
					else
						local add =amount+tonumber(list[(craft.recipe[2][2])])
						list[(craft.recipe[2][2])]=add
					end
				end
				if craft.recipe[2][3] then
					if list[(craft.recipe[2][3])]==nil then
						list[(craft.recipe[2][3])]={}
						list[(craft.recipe[2][3])]=amount
					else
						local add =amount+tonumber(list[(craft.recipe[2][3])])
						list[(craft.recipe[2][3])]=add
					end
				end
			end
		end
		if craft.recipe[3] then
			if (type(craft.recipe[3]) == "string") then
				if list[(craft.recipe[3])]==nil then
					list[(craft.recipe[3])]={}
					list[(craft.recipe[3])]=amount
				else
					local add =amount+tonumber(list[(craft.recipe[3])])
					list[(craft.recipe[3])]=add
				end
			else
				if craft.recipe[3][1] then
					if list[(craft.recipe[3][1])]==nil then
						list[(craft.recipe[3][1])]={}
						list[(craft.recipe[3][1])]=amount
					else
						local add =amount+tonumber(list[(craft.recipe[3][1])])
						list[(craft.recipe[3][1])]=add
					end
				end
				if craft.recipe[3][2] then
					if list[(craft.recipe[3][2])]==nil then
						list[(craft.recipe[3][2])]={}
						list[(craft.recipe[3][2])]=amount
					else
						local add =amount+tonumber(list[(craft.recipe[3][2])])
						list[(craft.recipe[3][2])]=add
					end
				end
				if craft.recipe[3][3] then
					if list[(craft.recipe[3][3])]==nil then
						list[(craft.recipe[3][3])]={}
						list[(craft.recipe[3][3])]=amount
					else
						local add =amount+tonumber(list[(craft.recipe[3][3])])
						list[(craft.recipe[3][3])]=add
					end
				end
			end
		end
		if craft.recipe[4] then
			if (type(craft.recipe[4]) == "string") then
				if list[(craft.recipe[4])]==nil then
					list[(craft.recipe[4])]={}
					list[(craft.recipe[4])]=amount
				else
					local add =amount+tonumber(list[(craft.recipe[4])])
					list[(craft.recipe[4])]=add
				end
			end
		end
		if craft.recipe[5] then
			if (type(craft.recipe[5]) == "string") then
				if list[(craft.recipe[5])]==nil then
					list[(craft.recipe[5])]={}
					list[(craft.recipe[5])]=amount
				else
					local add =amount+tonumber(list[(craft.recipe[5])])
					list[(craft.recipe[5])]=add
				end
			end
		end
		if craft.recipe[6] then
			if (type(craft.recipe[6]) == "string") then
				if list[(craft.recipe[6])]==nil then
					list[(craft.recipe[6])]={}
					list[(craft.recipe[6])]=amount
				else
					local add =amount+tonumber(list[(craft.recipe[6])])
					list[(craft.recipe[6])]=add
				end
			end
		end
		if craft.recipe[7] then
			if (type(craft.recipe[7]) == "string") then
				if list[(craft.recipe[7])]==nil then
					list[(craft.recipe[7])]={}
					list[(craft.recipe[7])]=amount
				else
					local add =amount+tonumber(list[(craft.recipe[7])])
					list[(craft.recipe[7])]=add
				end
			end
		end
		if craft.recipe[8] then
			if (type(craft.recipe[8]) == "string") then
				if list[(craft.recipe[8])]==nil then
					list[(craft.recipe[8])]={}
					list[(craft.recipe[8])]=amount
				else
					local add =amount+tonumber(list[(craft.recipe[8])])
					list[(craft.recipe[8])]=add
				end
			end
		end
		if craft.recipe[9] then
			if (type(craft.recipe[9]) == "string") then
				if list[(craft.recipe[9])]==nil then
					list[(craft.recipe[9])]={}
					list[(craft.recipe[9])]=amount
				else
					local add =amount+tonumber(list[(craft.recipe[9])])
					list[(craft.recipe[9])]=add
				end
			end
		end
	end
	if istest==1 then
		test=list
		list=nil
		list={}
		list=list2
	end
end
	
if istest==1 then
	local value=0
	local h=0
	for name,testcount in pairs(test) do
		h=h+1
		if h>888 then
			break
		end
		if testcount>0 then
			if name.def==nil or (craft_guide.crafts[name]==nil 
				and string.sub(name,1,8)=="technic:")
				then
				bestvalue=10
				h=999
			else
				local testcrafts = craft_guide.crafts[name]
				local testcraft=""
				if testcrafts~=nil then
					testcraft=testcrafts[1]
				end
				local isbase=0

	
				if name==nil or name==""
					or string.sub(name,1,6)=="group:" 
					or testcrafts==nil or testcraft==nil
					or (testcraft.type~=nil and testcraft.type~="shapeless")
					then
					isbase=1
				else
					for ii=1,999,1 do
						if craft_guide.basic_item_prefixes[ii]==nil or craft_guide.basic_item_prefixes[ii]=="" then  
							break
						elseif string.sub(name,1,string.len(craft_guide.basic_item_prefixes[ii]))==
							string.lower(craft_guide.basic_item_prefixes[ii]) then
							isbase=1
							break
						end
					end
					if isbase==0 then
						for aa=1,999,1 do
							if craft_guide.basic_item_groups[aa]==nil or craft_guide.basic_item_groups[aa]=="" then  
								break
							elseif minetest.get_item_group(name, string.lower(craft_guide.basic_item_groups[aa]))>0 then
								isbase=1
								break
							end
						end
						if isbase==0 then
							for bb=1,999,1 do
								if craft_guide.basic_item_endings[bb]==nil or craft_guide.basic_item_endings[bb]=="" then  
									break
								elseif string.sub(name,string.len(name)-(string.len(craft_guide.basic_item_endings[bb])-1))==
									string.lower(craft_guide.basic_item_endings[bb]) then
									isbase=1
									break
								end
							end
							if isbase==0 then
								for cc=1,999,1 do
									if craft_guide.basic_items[cc]==nil or craft_guide.basic_items[cc]=="" then  
										break
									elseif name==string.lower(craft_guide.basic_items[cc]) then
										isbase=1
										break
									end
								end
							end
						end
					end
				end


			if isbase==0 then
				value=value+1
--				if string.find(name,"slab")~=nil
--					or string.find(name,"panel")~=nil
--					or string.find(name,"microblock")~=nil
--					or string.find(name,"stair")~=nil
--					then
--					value=value+5
--				end
			end
		end
	end
end


--starting with correct tabs here again:
									if value<bestvalue then
										bestcraft=index
										bestvalue=value
									end
								else
									craftnumber=999
									break
								end
							end
						end
					end
				end
				if finished==1 then
					break
				end
			end
		end
		local jj=1
		local duplicate=0
		for name,amount in pairs(list) do
			local count=tonumber(amount)
			if name~=nil and count>0 and string.lower(name)~=string.upper(name) then
				local lower=string.lower(name)
				if craft_guide.you_need_list[lower]~=nil and craft_guide.you_need_list[lower]>0 then
					craft_guide.you_need_list[lower]=count+craft_guide.you_need_list[lower]
				else
					inv:add_item("youneed", lower)
					if inv:get_stack("youneed",jj)==nil or inv:get_stack("youneed",jj):get_name()=="" then
						for jjj=1,jj,1 do
							if inv:get_stack("youneed",jjj):get_count()>1 then
								local alias=string.lower(inv:get_stack("youneed",jjj):get_name())
								if craft_guide.you_need_list[alias]==nil then
									craft_guide.you_need_list[alias]={}
									craft_guide.you_need_list[alias]=count
									inv:set_stack("youneed",jjj,alias)
								else							
									craft_guide.you_need_list[alias]=craft_guide.you_need_list[alias]+count
									inv:set_stack("youneed",jjj,alias)
								end
							end
						end
						inv:set_stack("youneed",jj,ItemStack(nil))
						duplicate=1
						list[lower]=0

					elseif string.lower(inv:get_stack("youneed",jj):get_name())~=lower then
						local alias=string.lower(inv:get_stack("youneed",jj):get_name())
						if craft_guide.you_need_list[alias]~=nil then
							craft_guide.you_need_list[alias]=craft_guide.you_need_list[alias]+count
						else
							if list[alias]==nil then
								craft_guide.you_need_list[alias]={}
								craft_guide.you_need_list[alias]=count
								inv:set_stack("youneed",jj,alias)
							else
								list[alias]=list[alias]+count
							end
						end
						list[lower]=0
					else
						craft_guide.you_need_list[lower]={}
						craft_guide.you_need_list[lower]=count
					end
					if duplicate==0 then
						jj=jj+1
					else
						duplicate=0
					end
					if jj>inv:get_size("youneed") then
						break
					end
				end
			end
			craft_guide.saved_you_need_lists[stack_name.."@|²"..tostring(alternate)]={}
			craft_guide.saved_you_need_lists[stack_name.."@|²"..tostring(alternate)]=craft_guide.you_need_list
			craft_guide.saved_you_need_lists[stack_name.."@|³"..tostring(alternate)]={}
			craft_guide.saved_you_need_lists[stack_name.."@|³"..tostring(alternate)]=tostring(globalcount)
		end
	end
	meta:set_string("globalcount",tostring(globalcount))
	meta:set_string("formspec",craft_guide.get_craft_guide_formspec(meta))
end

-- create_inventory
craft_guide.create_inventory = function(inv, search)
	local craft_guide_list = {}
	for name,def in pairs(minetest.registered_items) do
		-- local craft_recipe = minetest.get_craft_recipe(name);
		-- if craft_recipe.items ~= nil then
		local craft = craft_guide.crafts[name];
		if (not def.groups.not_in_craft_guide or def.groups.not_in_craft_guide == 0)
			and (craft ~= nil or (not def.groups.not_in_creative_inventory or def.groups.not_in_creative_inventory == 0))
			--and (not def.groups.not_in_creative_inventory or def.groups.not_in_creative_inventory == 0)
			and def.description and def.description ~= "" then
			if search and search~="" then
				--search used to display groups of items
				--if you enter something in search field it displays items without crafting recipes too
				search=string.lower(search)
				if string.sub(search,1,6)=="group:" then
					local groups=string.sub(search,7)
					local hasgroup=0
					for group in string.gmatch(groups,"([^,]+)") do
						if minetest.get_item_group(name, group)>0 then
							hasgroup=1
						else
							hasgroup=0
							break
						end
					end
					if hasgroup==1 then
						table.insert(craft_guide_list, name)
					end
				else
					search=string.lower(search)
					local test1=0
					local test2=0
					local test3=0
					test1,test2=string.find(string.lower(def.name.."           "), search)					
					test2,test3=string.find(string.lower(def.description.."           "), search)					
					if (test1~=nil and test1>0) or (test2~=nil and test2>0) or search=="*" then
						table.insert(craft_guide_list, name)
					end
				end
			else
				if craft~=nil and craft[1]~=nil and ((craft[1]).type~="fuel" or craft_guide.show_all_fuel_crafts) then	
					table.insert(craft_guide_list, name)
				end
			end
		end
	end
	table.sort(craft_guide_list)
	for i=0,inv:get_size("main"),1 do
		inv:set_stack("main", i, nil)
	end
	inv:set_size("main", #craft_guide_list)
	for _,itemstring in ipairs(craft_guide_list) do
		inv:add_item("main", ItemStack(itemstring))
	end
end


-- add fuel recipes and recipes from technic machines to craft list
craft_guide.add_additional_crafts = function()
	if craft_guide.other_crafting_types then
		if minetest.get_modpath("technic") then
			local oldversion=false
			local recipelist={}
			if technic.recipes==nil or technic.recipes["grinding"]==nil and technic.grinder_recipes~=nil then
				oldversion=true
				recipelist=technic.grinder_recipes
				for t,recipe in pairs(recipelist) do
					recipe.type="Grinder"
					local name=ItemStack(recipe.output):get_name()
					if name~=nil and name~="" then
						if craft_guide.crafts[name]==nil then
							craft_guide.crafts[name] = {}
						end
						recipe.time=recipe.time or 3
						table.insert(craft_guide.crafts[name],recipe)
					end
				end

			else
				recipelist=technic.recipes["grinding"].recipes
				for t,recipe in pairs(recipelist) do
					recipe.type="Grinder"
					local name=ItemStack(recipe.output):get_name()
					if name~=nil and name~="" and (not craft_guide.remove_cluttering_crafts 
						or (string.find(name,"technic:uranium._")==nil
						and string.find(name,"technic:uranium.._")==nil)) then
						if craft_guide.crafts[name]==nil then
							craft_guide.crafts[name] = {}
						end
						local idx=1
						for _name, _count in pairs(recipe.input) do
							recipe.input[idx]=_name.." ".._count
							break
						end
						recipe.time=recipe.time or 3
						table.insert(craft_guide.crafts[name],recipe)
					end
				end

			end

			if oldversion then
				for t,recipe in pairs(technic.compressor_recipes) do
					recipe.type="Compressor"
					local name=ItemStack(recipe.dst_name):get_name()
					if name~=nil and name~="" then
						if craft_guide.crafts[name]==nil then
							craft_guide.crafts[name] = {}
						end
						recipe.input=t.." "..tostring(recipe.src_count)
						recipe.output=recipe.dst_name.." "..tostring(recipe.dst_count)
						recipe.time=recipe.time or 4
						table.insert(craft_guide.crafts[name],recipe)
					end
				end
			else
				for t,recipe in pairs(technic.recipes["compressing"].recipes) do
					recipe.type="Compressor"
					local name=ItemStack(recipe.output):get_name()
					if name~=nil and name~="" then
						if craft_guide.crafts[name]==nil then
							craft_guide.crafts[name] = {}
						end
						local idx=1
						for _name, _count in pairs(recipe.input) do
							recipe.input[idx]=_name.." ".._count
							break
						end
						recipe.time=recipe.time or 4
						table.insert(craft_guide.crafts[name],recipe)
					end
				end

			end
			if oldversion then
				for t,recipe in pairs(technic.extractor_recipes) do
					recipe.type="Extractor"
					local name=ItemStack(recipe.dst_name):get_name()
					if name~=nil and name~="" then
						if craft_guide.crafts[name]==nil then
							craft_guide.crafts[name] = {}
						end
						recipe.input=t.." "..tostring(recipe.src_count)
						recipe.output=recipe.dst_name.." "..tostring(recipe.dst_count)
						recipe.time=recipe.time or 4
						table.insert(craft_guide.crafts[name],recipe)
					end
				end
			else
				for t,recipe in pairs(technic.recipes["extracting"].recipes) do
					recipe.type="Extractor"
					local name=ItemStack(recipe.output):get_name()
					if name~=nil and name~="" then
						if craft_guide.crafts[name]==nil then
							craft_guide.crafts[name] = {}
						end
						local idx=1
						for _name, _count in pairs(recipe.input) do
							recipe.input[idx]=_name.." ".._count
							break
						end
						recipe.time=recipe.time or 4
						table.insert(craft_guide.crafts[name],recipe)
					end
				end

			end
			if oldversion then
				recipelist=technic.alloy_recipes
				for t,recipe in pairs(recipelist) do
					recipe.type="Alloy Furnace"
					local name=ItemStack(recipe.output):get_name()
					if name~=nil and name~="" then
						if craft_guide.crafts[name]==nil then
							craft_guide.crafts[name] = {}
						end
						recipe.time=recipe.time or 6
						table.insert(craft_guide.crafts[name],recipe)
					end
				end
			else
				recipelist=technic.recipes["alloy"].recipes
				for t,recipe in pairs(recipelist) do
					local rec={}
					rec.type="Alloy Furnace"
					local name=ItemStack(recipe.output):get_name()
					if name~=nil and name~="" then
						if craft_guide.crafts[name]==nil then
							craft_guide.crafts[name] = {}
						end
						local idx=1
						rec.output=recipe.output
						rec.time=recipe.time or 6
						rec.input={}
						for _name, _count in pairs(recipe.input) do
							rec.input[idx]=_name.." ".._count
							idx=idx+1
							if idx>2 then
							break
							end
						end
						table.insert(craft_guide.crafts[name],rec)
					end
				end
			end
			if not oldversion then
				for t,recipe in pairs(technic.recipes["separating"].recipes) do
					local rec={}
					local rec2={}
					
					rec.type="Centrifuge"
					rec2.type="Centrifuge"
					local name=ItemStack(recipe.output[1]):get_name()
					local name2=ItemStack(recipe.output[2]):get_name()
					local count=ItemStack(recipe.output[1]):get_count()
					local count2=ItemStack(recipe.output[2]):get_count()
					if name~=nil and name~="" and (not craft_guide.remove_cluttering_crafts
						or (string.find(name,"technic:uranium._")==nil
						and string.find(name,"technic:uranium.._")==nil)) then
						if craft_guide.crafts[name]==nil then
							craft_guide.crafts[name] = {}
						end
						local idx=1
						rec.input={}
						rec2.input={}
						for _name, _count in pairs(recipe.input) do
							rec.input[idx]=_name.." ".._count
							rec2.input[idx]=_name.." ".._count
							break
						end
						rec.time=recipe.time or 10
						rec2.time=recipe.time or 10
						rec.output2=name2.." "..tostring(count2)
						rec.output=name.." "..tostring(count)
						table.insert(craft_guide.crafts[name],rec)
						if name2~=nil and name2~="" and (not craft_guide.remove_cluttering_crafts
							or (string.find(name2,"technic:uranium._")==nil
							and string.find(name2,"technic:uranium.._")==nil)) then
							if craft_guide.crafts[name2]==nil then
									craft_guide.crafts[name2] = {}
							end
							rec2.output=name2.." "..tostring(count2)
							rec2.output2=name.." "..tostring(count)
							table.insert(craft_guide.crafts[name2],rec2)
						end
					end
				end
				
			end

		end
	end

	craft_guide.other_crafting_types = false
	if craft_guide.fuel_to_add then
		--add crafts with type "fuel"
		for name,def in pairs(minetest.registered_items) do
			if (not def.groups.not_in_craft_guide or def.groups.not_in_craft_guide == 0) then
				if craft_guide.fuel[name]~=nil then
					if craft_guide.crafts[name]==nil then
						craft_guide.crafts[name] = {}
					end
					local fuels=craft_guide.fuel[name]
					local fuel=fuels[1]
					table.insert(craft_guide.crafts[name],fuel)
				else
					local best=0
					local bestgroup=""
					for group,_ in pairs(def.groups) do
						if craft_guide.fuel["group:"..group]~=nil then
							local fuels=craft_guide.fuel["group:"..group]
							local fuel=fuels[1]
							if fuel.burntime>best then
								best=fuel.burntime
								bestgroup=group
							end
						end
					end
					if bestgroup~="" then
						if craft_guide.crafts[name]==nil then
							craft_guide.crafts[name] = {}
						end
						local fuels=craft_guide.fuel["group:"..bestgroup]
						local fuel=fuels[1]
						table.insert(craft_guide.crafts[name],fuel)
					end
				end
			end
		end	
	end

	craft_guide.fuel_to_add=false
	craft_guide.fuel=nil
	craft_guide.fuel={}
	-- all aliases should share the same crafting recipes
	if craft_guide.add_things then
		for i=1,9999,2 do
			local alias=craft_guide.alias[i]
			local convert_to=craft_guide.alias[i+1]
			if alias~=nil and convert_to~=nil and (craft_guide.crafts[convert_to]~=nil or craft_guide.crafts[alias]~=nil) then
				if craft_guide.crafts[convert_to]==nil and craft_guide.crafts[alias]~=nil then
					craft_guide.crafts[convert_to]={}
				elseif craft_guide.crafts[alias]==nil and craft_guide.crafts[convert_to]~=nil then
					craft_guide.crafts[alias]={}
				end
				for ii=1,9999,1 do
					local craft=(craft_guide.crafts[alias])[ii]
					if craft==nil then
						break
					else
						table.insert(craft_guide.crafts[convert_to],craft)
					end
				end
			craft_guide.crafts[alias]={}
				for ii=1,9999,1 do
					local craft=(craft_guide.crafts[convert_to])[ii]
					if craft==nil then
						break
					else
						table.insert(craft_guide.crafts[alias],craft)
					end
				end

			end
		end
	end
	craft_guide.add_things=false
end


-- allow_metadata_inventory_move
craft_guide.allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.env:get_meta(pos)
	if meta:get_string("locked")=="1" then
		craft_guide.save_meta(meta)
	end

	local inv = meta:get_inventory()
	if to_list == "bin" and from_list == "output" then
		inv:set_stack(from_list,from_index,nil)
		craft_guide.update_recipe(meta, player, inv:get_stack(from_list, from_index))
	end
	if to_list == "bin" and from_list == "bookmark" then
		inv:set_stack(from_list,from_index,nil)
		inv:set_stack("add",1,nil)--clear this because bookmarks aren't full anymore
	end
	if to_list == "bookmark" and not inv:contains_item("bookmark",inv:get_stack(from_list, from_index):get_name()) then
		inv:set_stack(to_list, to_index, inv:get_stack(from_list, from_index):get_name())
		if not inv:contains_item("bookmark",ItemStack(nil)) then
			inv:set_stack("add", 1, inv:get_stack("bookmark", tonumber(meta:get_string("addindex"))):get_name())
		end
	end
	if to_list == "add" and not inv:contains_item("bookmark",inv:get_stack(from_list, from_index):get_name()) then
		local index=tonumber(meta:get_string("addindex"))
		local stack=inv:get_stack("bookmark",index)
		local status=0
		if stack~=nil and stack:get_name()~=nil and stack:get_name()~="" then
			for i=1,inv:get_size("bookmark"),1 do
				stack=inv:get_stack("bookmark",i)
				if stack~=nil and stack:get_name()~=nil and stack:get_name()~="" then
				else
					if status==0 then
						inv:set_stack("bookmark", i, inv:get_stack(from_list, from_index):get_name())
						meta:set_string("addindex",tostring(i))
						status=1
					elseif status==1 then
						status=2
					end
				end
			end
			if status==1 then --bookmarks are full now
				inv:set_stack("add", to_index, inv:get_stack(from_list, from_index):get_name())
			elseif status==2 then --bookmarks has still empty slots after adding this stack
				inv:set_stack("add", to_index, nil)
			elseif status==0 then --bookmarks were already full, replace last added item
				inv:set_stack("bookmark", index, inv:get_stack(from_list, from_index):get_name())
				inv:set_stack("add", to_index, inv:get_stack(from_list, from_index):get_name())
			end
		else
			inv:set_stack("bookmark", index, inv:get_stack(from_list, from_index):get_name())
			inv:set_stack("add", to_index, nil)
		end
	end
	if to_list == "output" or from_list == "output" then
		if from_list ~= "output" and to_list == "output" then
			local name=inv:get_stack(from_list, from_index)
			if name~=nil then
				name=name:get_name()
			end
			if name~=nil then
				meta:set_string("out",name)
				inv:set_stack(to_list, to_index, nil)
			end
		end
		if from_list == "output" and (to_list == "bin" or to_list=="add" ) then
			meta:set_string("out","")
		end
		craft_guide.update_recipe(meta, player, inv:get_stack(from_list, from_index))
	end
	if from_list == "bookmark" and to_list == "bookmark"  then
		return count
	end
	return 0
end


-- allow_metadata_inventory_put
craft_guide.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
	return 0
end


-- allow_metadata_inventory_take
craft_guide.allow_metadata_inventory_take = function(pos, listname, index, stack, player)
	return 0
end

craft_guide.save_meta = function (meta)
	meta:set_string("saved_search2",meta:get_string("saved_search"))
	meta:set_string("saved_page2",meta:get_string("saved_page"))
	meta:set_string("saved_pages2",meta:get_string("saved_pages"))
	meta:set_string("switch2",meta:get_string("switch"))
	meta:set_string("poslist2",meta:get_string("poslist"))
	meta:set_string("globalcount2",meta:get_string("globalcount"))
	meta:set_string("time2",meta:get_string("time"))
	meta:set_string("method2",meta:get_string("method"))
	meta:set_string("out2",meta:get_string("out"))
	meta:set_string("addindex2",meta:get_string("addindex"))
	meta:set_string("search2",meta:get_string("search"))
	local inv=meta:get_inventory()
	inv:set_size("main2", inv:get_size("main"))
	inv:set_size("output2", 1)
	inv:set_size("additional2", 1)
	inv:set_size("build2", 3*3)
	inv:set_size("cook2", 2*1)
	inv:set_size("fuel2", 1)
	inv:set_size("machine2", 1)
	inv:set_size("bookmark2", 6*3)
	inv:set_size("youneed2", 6*15)
	inv:set_size("bin2", 1)
	inv:set_size("add2", 1)
	for i=0,inv:get_size("main2"),1 do
		inv:set_stack("main2", i, inv:get_stack("main",i))
	end
	for i=0,inv:get_size("build2"),1 do
		inv:set_stack("build2", i, inv:get_stack("build",i))
	end
	for i=0,inv:get_size("bookmark2"),1 do
		inv:set_stack("bookmark2", i, inv:get_stack("bookmark",i))
	end
	for i=0,inv:get_size("youneed2"),1 do
		inv:set_stack("youneed2", i, inv:get_stack("youneed",i))
	end
	inv:set_stack("cook2", 1, inv:get_stack("cook",1))
	inv:set_stack("cook2", 2, inv:get_stack("cook",2))
	inv:set_stack("output2", 1, inv:get_stack("output",1))
	inv:set_stack("additional2", 1, inv:get_stack("additional",1))
	inv:set_stack("fuel2", 1, inv:get_stack("fuel",1))
	inv:set_stack("bin2", 1, inv:get_stack("bin",1))
	inv:set_stack("machine2", 1, inv:get_stack("machine",1))
	inv:set_stack("add2", 1, inv:get_stack("add",1))
	meta:set_string("locked","2")
	meta:set_string("formspec2",meta:get_string("saved_formspec"))

end

craft_guide.restore_meta = function (meta)
	meta:set_string("saved_search",meta:get_string("saved_search2"))
	meta:set_string("saved_page",meta:get_string("saved_page2"))
	meta:set_string("saved_pages",meta:get_string("saved_pages2"))
	meta:set_string("switch",meta:get_string("switch2"))
	meta:set_string("poslist",meta:get_string("poslist2"))
	meta:set_string("globalcount",meta:get_string("globalcount2"))
	meta:set_string("time",meta:get_string("time2"))
	meta:set_string("method",meta:get_string("method2"))
	meta:set_string("out",meta:get_string("out2"))
	meta:set_string("addindex",meta:get_string("addindex2"))
	meta:set_string("search",meta:get_string("search2"))
	local inv=meta:get_inventory()
	inv:set_size("main",inv:get_size("main2"))
	for i=0,inv:get_size("main"),1 do
		inv:set_stack("main", i, inv:get_stack("main2",i))
	end
	for i=0,inv:get_size("build"),1 do
		inv:set_stack("build", i, inv:get_stack("build2",i))
	end
	for i=0,inv:get_size("bookmark"),1 do
		inv:set_stack("bookmark", i, inv:get_stack("bookmark2",i))
	end
	for i=0,inv:get_size("youneed"),1 do
		inv:set_stack("youneed", i, inv:get_stack("youneed2",i))
	end
	inv:set_stack("cook", 1, inv:get_stack("cook2",1))
	inv:set_stack("cook", 2, inv:get_stack("cook2",2))
	inv:set_stack("output", 1, inv:get_stack("output2",1))
	inv:set_stack("additional", 1, inv:get_stack("additional2",1))
	inv:set_stack("fuel", 1, inv:get_stack("fuel2",1))
	inv:set_stack("bin", 1, inv:get_stack("bin2",1))
	inv:set_stack("machine", 1, inv:get_stack("machine2",1))
	inv:set_stack("add", 1, inv:get_stack("add2",1))
	meta:set_string("isowner","0")
	meta:set_string("locked","1")
local formspec=	meta:get_string("formspec2")
	meta:set_string("saved_formspec",formspec)
	formspec=formspec.."label[0.88,9.2;Locked]"
		.."tooltip[close_mm;   Owner: "..meta:get_string("owner").."]"
	meta:set_string("formspec",formspec)

end
