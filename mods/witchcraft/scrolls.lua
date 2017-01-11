--scrolls


minetest.register_craftitem("witchcraft:scroll_day", {
	description = "Scroll of day",
	inventory_image = "witchcraft_scroll.png^witchcraft_sun_over.png",
	stack_max = 1,
	on_use = function(item)
	minetest.set_timeofday(0.5)
	item:take_item()
	return item
	end,
})

minetest.register_craftitem("witchcraft:scroll_night", {
	description = "Scroll of night",
	inventory_image = "witchcraft_scroll.png^witchcraft_moon_over.png",
	stack_max = 1,
	on_use = function(item)
	minetest.set_timeofday(0)
	item:take_item()
	return item
	end,
})

if minetest.get_modpath("pmobs")then
minetest.register_craftitem("witchcraft:scroll_wild", {
	description = "Scroll of Wild",
	inventory_image = "witchcraft_scroll.png^witchcraft_dark_over.png",
	stack_max = 1,
	on_use = function(item, placer)
	local pos = placer:getpos();
	minetest.env:add_entity(pos, "pmobs:dog")
	item:take_item()
	return item
	end,
})
end

minetest.register_craftitem("witchcraft:scroll_fireball", {
	description = "Scroll of fireball",
	inventory_image = "witchcraft_scroll.png^witchcraft_fire_over.png",
	stack_max = 1,
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:fireball")
	local obj2 = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:fireball")
	local obj3 = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:fireball")
	local obj4 = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:fireball")
	obj2:setvelocity({x=dir.x*7+0.5,y=dir.y*7,z=dir.z*7+0.5})
	obj3:setvelocity({x=dir.x*7-0.5,y=dir.y*7,z=dir.z*7-0.5})
	obj4:setvelocity({x=dir.x*7,y=dir.y*7-0.5,z=dir.z*7})
	obj:setvelocity({x=dir.x*7,y=dir.y*7+0.5,z=dir.z*7})
		item:take_item()
		return item
	end,
})

if minetest.get_modpath("lightning") then
minetest.register_craftitem("witchcraft:scroll_lightning", {
	description = "Scroll of lightning",
	inventory_image = "witchcraft_scroll.png^witchcraft_thunder_over.png",
	stack_max = 1,
	on_use = function(item, placer, pos)
	local playerpos = placer:getpos();
	local dir = placer:get_look_dir();
	lightning.strike({x=playerpos.x+dir.x*2,y=playerpos.y+0+dir.y,z=playerpos.z+dir.z*2})
		item:take_item()
		return item
	end,
})
end

minetest.register_craftitem("witchcraft:scroll_icicle", {
	description = "Scroll of icicle",
	inventory_image = "witchcraft_scroll.png^witchcraft_ice_over.png",
	stack_max = 1,
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*7,y=dir.y*7,z=dir.z*7}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:ice")
	local obj2 = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+1+dir.z}, "witchcraft:ice")
	local obj3 = minetest.env:add_entity({x=playerpos.x+1+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:ice")
	obj:setvelocity(vec)
	obj2:setvelocity(vec)
	obj3:setvelocity(vec)
	
		item:take_item()
		return item
	end,
})


minetest.register_craftitem("witchcraft:scroll_nature", {
	description = "Scroll of nature",
	inventory_image = "witchcraft_scroll.png^witchcraft_leaf_over.png",
	stack_max = 1,
	on_use = function(item, placer, pos)
	local dir = placer:get_look_dir();
	local playerpos = placer:getpos();
	local vec = {x=dir.x*6,y=dir.y*6,z=dir.z*6}
	local obj = minetest.env:add_entity({x=playerpos.x+dir.x*1.5,y=playerpos.y+1.5+dir.y,z=playerpos.z+0+dir.z}, "witchcraft:tree")
	obj:setvelocity(vec)
	
		item:take_item()
		return item
	end,
})

minetest.register_craftitem("witchcraft:scroll", {
	description = "Blank Scroll",
	inventory_image = "witchcraft_scroll.png",
})

minetest.register_craftitem("witchcraft:scroll_recipe", {
	description = "Recipe Scroll",
	inventory_image = "witchcraft_scroll.png^witchcraft_writing_over.png",
	on_use = function(itemstack, user, pointed_thing)
    
	local formspec = "size[10,9]"..
		"background[-0.6,-0.5;11.5,10.4;witchcraft_recipes.png]";
	
    minetest.show_formspec(user:get_player_name(), "witchcraft:scroll", formspec);	
	
	end,
})

if minetest.get_modpath("pmobs")then
minetest.register_craft({
	output = 'witchcraft:scroll_wild',
	recipe = {
		{'mobs:meat_raw'},
		{'witchcraft:scroll'},
	}
})

end

minetest.register_craft({
	output = 'witchcraft:scroll',
	recipe = {
		{'default:paper', 'default:paper', ''},
		{'default:paper', 'default:paper', ''},
	}
})

minetest.register_craft({
	output = 'witchcraft:scroll_recipe',
	recipe = {
		{'dye:black'},
		{'witchcraft:scroll'},
	}
})

minetest.register_craft({
	output = 'witchcraft:scroll_icicle',
	recipe = {
		{'default:ice'},
		{'default:diamond'},
		{'witchcraft:scroll'},
	}
})

minetest.register_craft({
	output = 'witchcraft:scroll_fireball',
	recipe = {
		{'default:obsidian_shard'},
		{'default:diamond'},
		{'witchcraft:scroll'},
	}
})

minetest.register_craft({
	output = 'witchcraft:scroll_nature',
	recipe = {
		{'default:leaves'},
		{'default:diamond'},
		{'witchcraft:scroll'},
	}
})

minetest.register_craft({
	output = 'witchcraft:scroll_day',
	recipe = {
		{'default:torch'},
		{'default:diamond'},
		{'witchcraft:scroll'},
	}
})

minetest.register_craft({
	output = 'witchcraft:scroll_night',
	recipe = {
		{'default:coal_lump'},
		{'default:diamond'},
		{'witchcraft:scroll'},
	}
})


minetest.register_craft({
	output = 'witchcraft:scroll_lightning',
	recipe = {
		{'default:steel_ingot'},
		{'default:diamond'},
		{'witchcraft:scroll'},
	}
})


--scroll powers

minetest.register_entity("witchcraft:fireball", {
	textures = {"tnt_boom.png"},
	velocity = 0.1,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "witchcraft:fireball" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=3},
						}, nil)
					self.object:remove()
					end
				end
			end
			for dx=0,1 do
						for dy=0,1 do
							for dz=0,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "witchcraft:fireball" and n ~="default:dirt_with_grass" and n ~="default:dirt_with_dry_grass" and n ~="default:stone"  then	
									if minetest.registered_nodes[n].groups.flammable --[[or math.random(1, 100) <= 1]] then
										minetest.env:set_node(t, {name="fire:basic_flame"})
									self.object:remove()
									return
									end
								end
							end
						end
					end
			hit_node = function(self, pos, node)
--	local pos = self.object:getpos()
		for dx=-4,4 do
			for dy=-4,4 do
				for dz=-4,4 do
					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local n = minetest.env:get_node(pos).name
					if math.random(1, 50) <= 35 then
						minetest.env:remove_node(p)
					end
					if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <=5 then
										minetest.env:set_node(t, {name="fire:basic_flame"})
					end
				end
			end
		end
		end

		local apos = self.object:getpos()
		local vec = self.object:getvelocity()
		local part = minetest.add_particlespawner(
			6, --amount
			0.3, --time
			{x=apos.x-0.3, y=apos.y-0.3, z=apos.z-0.3}, --minpos
			{x=apos.x+0.3, y=apos.y+0.3, z=apos.z+0.3}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=0,y=-0.5,z=0}, --minacc
			{x=-vec.x,y=-vec.y,z=-vec.z}, --maxacc
			0.1, --minexptime
			0.3, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_flame.png" --texture
		)
		
	end,
})



minetest.register_entity("witchcraft:tree", {
	textures = {"witchcraft_skin.png"},
	velocity = 1,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "witchcraft:tree" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:remove()
						local treepos = self.object:getpos()
						default.grow_new_jungle_tree(treepos)
					self.object:remove()
					end
				end
			end
			for dx=0,1 do
						for dy=0,1 do
							for dz=0,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "witchcraft:tree" and n ~="air" then	
						local treepos = self.object:getpos()
						default.grow_new_jungle_tree(treepos)
						self.object:remove()
								elseif n == "default:wood" or n =="default:tree" or n =="default:dirt_with_grass" or n =="default:dirt_with_dry_grass" then
									self.hit_node(self, pos, node)
									self.object:remove()
									return
								end
							end
						end
					end
			hit_node = function(self, pos, node)
						local treepos = self.object:getpos()
						default.grow_new_jungle_tree(treepos)
		end

		local apos = self.object:getpos()
		local part = minetest.add_particlespawner(
			6, --amount
			0.3, --time
			{x=apos.x-0.3, y=apos.y-0.3, z=apos.z-0.3}, --minpos
			{x=apos.x+0.3, y=apos.y+0.3, z=apos.z+0.3}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=0,y=-0.5,z=0}, --minacc
			{x=0.5,y=0.5,z=0.5}, --maxacc
			0.1, --minexptime
			0.3, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"witchcraft_leaf_over.png" --texture
		)
		
	end,
})

minetest.register_entity("witchcraft:ice", {
	visual="sprite",
	visual_size={x=1,y=1},
	physical=false,
	textures={"witchcraft_ice.png"},
	velocity = 1,
    rotate = 90,
	auto_rotate = true,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(10, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "witchcraft:ice" and obj:get_luaentity().name ~= "__builtin:item" then
					obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=1},
						}, nil)
					self.object:remove()
				end
				end
			for dx=0,1 do
						for dy=0,1 do
							for dz=0,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n == "default:water_source" or n =="default:river_water_source" then	
								local pos = self.object:getpos()
								minetest.set_node(pos, {name="default:ice"})
								self.object:remove()
								elseif n ~= "air" then
									local velo = self.object:getvelocity()
									self.object:setvelocity({x=velo.x*-1, y=velo.y*0, z=velo.z*1})
									--self.object:remove()
									return
								end
							end
						end
					end

		local apos = self.object:getpos()
		local part = minetest.add_particlespawner(
			10, --amount
			0.3, --time
			{x=apos.x-0.3, y=apos.y-0.3, z=apos.z-0.3}, --minpos
			{x=apos.x+0.3, y=apos.y+0.3, z=apos.z+0.3}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=0,y=-0.5,z=0}, --minacc
			{x=0.5,y=0.5,z=0.5}, --maxacc
			0.1, --minexptime
			0.3, --maxexptime
			0.2, --minsize
			0.5, --maxsize
			false, --collisiondetection
			"witchcraft_light_over.png" --texture
		)
	end
	end
})