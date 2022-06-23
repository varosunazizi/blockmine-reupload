-- Adds numerous glow in the dark fungi

minetest.register_node("nightscape:mycena_clorophos", {
	description = "Mycena clorophos",
	drawtype ="plantlike",
	floodable = true,
	tiles = {"nightscape_mycena_clorophos.png"},
	groups = {snappy=3, oddly_breakable_by_hand=3},
	walkable = false,
	light_source = 6,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
	},
	paramtype = "light",
})
minetest.register_decoration({
	deco_type = "simple",
	noise_params = {offset=0, scale=0.005, spread={x=100, y=100, z=100}, seed=56, octaves=3, persist=0.7},
	place_on = {"default:dirt_with_coniferous_litter"},
	sidelen = 32,
	fill_ratio = 0.1,
	decoration = "nightscape:mycena_clorophos",
	height = 1,
	height_max = 0,
})
minetest.register_node("nightscape:glow_worms", {
	description = "Glow Worms",
	drawtype = "plantlike",
	floodable = true,	
	is_ground_content = true,
	tiles = {"nightscape_glow_worms_1.png"},
	groups = {snappy=3, oddly_breakable_by_hand=3},
	walkable = false,
	light_source = 8,
	sunlight_propagates = true,
	drop = "nightscape:glow_worms_1",
	paramtype = "light",
})
minetest.register_abm({
	label = "place glow worms",
	nodenames = {"air"},
	neighbors = {"default:stone"},
	interval = 10,
	chance = 800,
	action = function(pos)
		local node = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
		if node.name == "default:stone" then
			minetest.set_node(pos, {name="nightscape:glow_worms"})
		end
	end,
})
minetest.register_abm({
	label = "place air on glow worms",
	nodenames = {"nightscape:glow_worms"},
	neighbors = {"air"},
	interval = 3,
	chance = 5,
	action = function(pos)
		minetest.set_node(pos, {name="air"})
	end,	
})
minetest.register_node("nightscape:blue_ghost_firefly", {
	description = "Blue Ghost Firefly",
	drawtype = "glasslike",
	wield_image = "nightscape_bg_wield.png",
	inventory_image = "nightscape_bg_wield.png",
	tiles = {{
		name = "nightscape_gf.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 8,
			aspect_h = 8,
			length = 1.8
		},
	}},
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 7,
	walkable = false,
	groups = {catchable=1},
	floodable = true,
	on_place = function(itemstack, placer, pointed_thing)
		local player = placer:get_player_name()
		local pos = pointed_thing.above
		minetest.set_node(pos, {name = "nightscape:blue_ghost_firefly"})
		minetest.get_node_timer(pos):start(2)
		itemstack:take_item()
		return itemstack
		
	end,
	on_timer = function(pos, elapsed)
		if minetest.get_timeofday()*24000 >5500 and minetest.get_timeofday()*24000 < 19500 then
			minetest.set_node(pos, {name = "nightscape:hf"})
		elseif minetest.get_timeofday()*24000 <=5500 or minetest.get_timeofday()*24000 >= 19500 then
			new_pos = {x=pos.x+math.random(-1, 1), y=pos.y, z=pos.z+math.random(-1, 1)}
			if minetest.get_node(new_pos).name == "air" then
				minetest.set_node(new_pos, {name = "nightscape:blue_ghost_firefly"})
				minetest.set_node(pos, {name= "air"})
				minetest.get_node_timer(new_pos):start(2)
			end
		end
		minetest.get_node_timer(pos):start(2)
	end,
})
minetest.register_node("nightscape:hf", {
	description = "Hidden Blue Ghost Firefly",
	drawtype = "airlike",
	wield_image = "bg_wield.png",
	inventory_image = "bg_wield.png",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	floodable = true,
	diggable = false,
	groups = {not_in_creative_inventory = 1},
	on_place = function(itemstack, placer, pointed_thing)
		local player = placer:get_player_name()
		local pos = pointed_thing.above
		minetest.set_node(pos, {name = "nightscape:hf"})
		minetest.get_node_timer(pos):start(2)
		itemstack:take_item()
		return itemstack
	end,
	on_timer = function(pos, elapsed)
	if minetest.get_timeofday()*24000 <= 5500 or minetest.get_timeofday()*24000 >= 19500 then
			minetest.set_node(pos, {name = "nightscape:blue_ghost_firefly"})
		end
		minetest.get_node_timer(pos):start(2)
	end,
})
minetest.register_decoration({
	name = "nightscape:set_fireflies_high",
	deco_type = "simple",
	place_on = {
			"default:dirt_with_grass",
			"default:dirt_with_coniferous_litter",
			"default:dirt_with_rainforest_litter",
			"default:dirt"
	},
	place_offset_y = 3,
	sidlen = 80,
	biomes = {
			"deciduous_forest",
			"coniferous_forest",
			"rainforest",
			"rainforest_swamp"
	},
	fill_ratio = 0.0002,
	y_max = 1000,
	y_min = -5,
	decoration = "nightscape:nightscape:blue_ghost_firefly",
})
minetest.register_decoration({
	name = "nightscape:set_fireflies_low",
	deco_type = "simple",
	place_on = {
			"default:dirt_with_grass",
			"default:dirt_with_coniferous_litter",
			"default:dirt_with_rainforest_litter",
			"default:dirt"
	},
	place_offset_y = 2,
	sidlen = 80,
	biomes = {
			"deciduous_forest",
			"coniferous_forest",
			"rainforest",
			"rainforest_swamp"
	},
	fill_ratio = 0.0002,
	y_max = 1000,
	y_min = -5,
	decoration = "nightscape:blue_ghost_firefly",
})
minetest.register_node("nightscape:motyxia", {
	description = "Motyxia On Stone",
	tiles = {"default_stone.png^nightscape_motyxia.png", "default_stone.png"},
	groups = {cracky=3, stone=1},
	light_source = 4,
	sounds = default.node_sound_stone_defaults(),
	drop = "nightscape:glow_powder",
})
minetest.register_abm({
	label = "place motyxia",
	nodenames = {"default:stone"},
	neighbors = {"air"},
	interval = 10,
	chance = 1400,
	action = function(pos)
		local node = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
		if node.name == "air" then
			minetest.set_node(pos, {name="nightscape:motyxia"})
		end
	end,
})
minetest.register_abm({
	label = "place air on motyxia",
	nodenames = {"nightscape:motyxia"},
	neighbors = {"air"},
	interval = 3,
	chance = 10,
	action = function(pos)
		minetest.set_node(pos, {name="default:stone"})
	end,
})
minetest.register_node("nightscape:glowing_plankton", {
	description = "Bioluminescent Plankton",
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "nightscape_noth.png", name = "nightscape_b_plankt.png", tileable_verticle = true}},
	groups = {snappy = 3},
	light_source = 15,
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.under
		if minetest.get_node(pos).name ~= "default:sand" then
			return itemstack
		end
		local height = 1
		local top_pos = {x = pos.x, y=pos.y+height, z=pos.z}
		local node_def = minetest.get_node(top_pos)
		local top_node = minetest.registered_nodes[node_def.name]
		if top_node and top_node.liquidtype == "source" and minetest.get_item_group(top_node.name, "water") > 0 then
			minetest.set_node(pos, {name="nightscape:glowing_plankton", param2 = height*16})
			itemstack:take_item()
		end
		return itemstack

	end,
})
minetest.register_abm({
	label = "place plankton",
	nodenames = {"default:sand"},
	neighbors = {"default:water_source"},
	interval = 10,
	chance = 3000,
	action = function(pos)
		local node = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
		if node.name == "default:water_source" then
			minetest.set_node(pos, {name="nightscape:glowing_plankton"})
		end
	end,
})
minetest.register_abm({
	label = "place water on plankton",
	nodenames = {"nightscape:glowing_plankton"},
	neighbors = {"default:sand"},
	interval = 3,
	chance = 3,
	action = function(pos)
		minetest.set_node(pos, {name="default:sand"})
	end,
})
minetest.register_node("nightscape:open_anemone", {
	description = "Biofluorescent Anemone",
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	damage_per_second = 1,
	special_tiles = {{name = "nightscape_anemone_1.png", tileable_verticle = true}},
	groups = {snappy = 3, not_in_creative_inventory=1},
	light_source = 8,
	waving = 1,
	drop = {
		max_items = 1,
		items = {
				{
				items = {"nightscape:large_anemone_tentacle", "nightscape:closed_anemone"},
				rarity = 55,
				},
			{items={"nightscape:closed_anemone"}}
			
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(1)
		local time = minetest.get_timeofday()*24000
		if time > 5500 and time < 19500 then
			minetest.set_node(pos, {name="nightscape:closed_anemone"})
		end
		minetest.get_node_timer(pos):start(1)
		return true
	end,
	on_timer = function(pos, elapsed)
		local time = minetest.get_timeofday()*24000
		if time > 5500 and time < 19500 then
			minetest.set_node(pos, {name="nightscape:closed_anemone"})
		end
		minetest.get_node_timer(pos):start(1)
		return true
	end,
})
minetest.register_node("nightscape:closed_anemone", {
	description = "Biofluorescent Anemone (Closed)",
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "nightscape_anemone_3.png", tileable_verticle = true}},
	groups = {snappy = 3},
	light_source = 3,
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.under
		if minetest.get_node(pos).name ~= "default:sand" then
			return itemstack
		end
		minetest.get_node_timer(pos):start(1)
		local height = 5
		local top_pos = {x = pos.x, y=pos.y+height, z=pos.z}
		local node_def = minetest.get_node(top_pos)
		local top_node = minetest.registered_nodes[node_def.name]
		if top_node and top_node.liquidtype == "source" and minetest.get_item_group(top_node.name, "water") > 0 then
			minetest.set_node(pos, {name="nightscape:closed_anemone", param2 = height*16})
			itemstack:take_item()
		end
	end,
	on_timer = function(pos, elapsed)
		local time = minetest.get_timeofday()*24000
		if time <= 5500 or time >= 19500 then
			minetest.set_node(pos, {name="nightscape:open_anemone"})
		end
		minetest.get_node_timer(pos):start(1)
		return true
	end,
})
minetest.register_decoration({
	name = "nightscape:set_anemonies",
	deco_type = "simple",
	decoration = "nightscape:closed_anemone",
	fill_ratio = 0.0002,
	sidelen = 80,
	spawn_by = "default:water_source",
	flags = "force_placement",
	y_min = -100,
	y_max = -30,
	place_on = {"default:sand"},
	num_spawn_by = 1,
	place_offset_y = -1,
})
local low_fireflies =minetest.get_decoration_id("nightscape:set_fireflies_low")
local high_fireflies =minetest.get_decoration_id("nightscape:set_fireflies_high")
local anemonies =minetest.get_decoration_id("nightscape:set_anemonies")

minetest.set_gen_notify({decoration = true}, {low_fireflies, high_fireflies, anemonies})
minetest.register_on_generated(function(minp, maxp, blockseed)
	local gennotify = minetest.get_mapgen_object("gennotify")
	local poslist = {}

	for _, pos in ipairs(gennotify["decoration#"..low_fireflies] or {}) do
		local low_firefly_pos = {x = pos.x, y = pos.y+3, z = pos.z}
		table.insert(poslist, low_firefly_pos)
	end
	for _, pos in ipairs(gennotify["decoration#"..high_fireflies] or {}) do
		local high_firefly_pos = {x = pos.x, y = pos.y+4, z = pos.z}
		table.insert(poslist, high_firefly_pos)
	end
	for _, pos in ipairs(gennotify["decoration#"..anemonies] or {}) do
		local anemone_pos = {x = pos.x, y = pos.y, z = pos.z}
		table.insert(poslist, anemone_pos)
	end
	if #poslist ~= 0 then
		for i = 1, #poslist do
			local pos = poslist[i]
			minetest.get_node_timer(pos):start(1)
		end
	end
end)
minetest.register_node("nightscape:small_glow_worms", {
	description = "Small Glow Worms",
	tiles = {"default_stone.png^nightscape_small_gw.png"},
	groups = {cracky = 3, stone = 1},
	light_source = 5,
	sounds = default.node_sound_stone_defaults(),
	drop = "nightscape:glow_worms_1",
})
minetest.register_ore({
	ore_type = "scatter",
	ore = "nightscape:small_glow_worms",
	wherein = "default:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 3,
	clust_size = 3,
	height_min = -31000,
	height_max = -10,
})
minetest.register_node("nightscape:glow_worms_1", {
	description = "Glow Worm Larva",
	drawtype = "plantlike",
	tiles = {'nightscape_gw_1.png'},
	groups = {snappy = 3},
	on_place = function(itemstack, placer, pointed_thing)
		local player = placer:get_player_name()
		local pos = pointed_thing.above
		local pos2 = pointed_thing.under
		local node_check = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})	
		if node_check.name == "default:cobble" then
			minetest.set_node(pos, {name="nightscape:glow_worms_1"})
			itemstack:take_item() 
			return itemstack
		end
	end,
	light_source = 4,
	walkable = false,
	sunlight_propagates = true,
	floodable = true,	
	paramtype = "light",
}) 
minetest.register_node("nightscape:glow_worms_2", {
	description = "Growable Glow Worms 2",
	drawtype = "plantlike",
	tiles = {'nightscape_gw_2.png'},
	groups = {snappy = 3, not_in_creative_inventory=1},
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		local node_check = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})	
		if node_check.name == "default:cobble" then
			minetest.set_node(pos, {name="nightscape:glow_worms_2"})
			itemstack:take_item() 
			return itemstack
		end
	end,
	light_source = 5,
	walkable = false,
	sunlight_propagates = true,
	floodable = true,
	drop = "nightscape:glow_worms_1",
	paramtype = "light",
})
minetest.register_node("nightscape:glow_worms_3", {
	description = "Growable Glow Worms 3",
	drawtype = "plantlike",
	tiles = {'nightscape_gw_3.png'},
	groups = {snappy = 3, not_in_creative_inventory=1},
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		local node_check = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})	
		if node_check.name == "default:cobble" then
			minetest.set_node(pos, {name="nightscape:glow_worms_3"})
			itemstack:take_item() 
			return itemstack
		end
	end,
	light_source = 6,
	walkable = false,
	sunlight_propagates = true,
	floodable = true,
	drop = "nightscape:glow_worms_1",
	paramtype = "light",
}) 
minetest.register_node("nightscape:glow_worms_4", {
	description = "Growable Glow Worms 4",
	drawtype = "plantlike",
	tiles = {'nightscape_gw_4.png'},
	groups = {snappy = 3, not_in_creative_inventory=1},
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		local node_check = minetest.get_node({x=pos.x, y=pos.y+1,z= pos.z})	
		if node_check.name == "default:cobble" then
			minetest.set_node(pos, {name="nightscape:glow_worms_4"})
			itemstack:take_item() 
			return itemstack
		end
	end,
	light_source = 7,
	walkable = false,
	sunlight_propagates = true,
	floodable = true,
	drop = "nightscape:glow_worms_1",
	paramtype = "light",
}) 
minetest.register_node("nightscape:glow_worms_5", {
	description = "Growable Glow Worms 5",
	drawtype = "plantlike",
	tiles = {'nightscape_gw_5.png'},
	groups = {snappy = 3, not_in_creative_inventory=1},
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		local node_check = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})	
		if node_check.name == "default:cobble" then
			minetest.set_node(pos, {name="nightscape:glow_worms_5"})
			itemstack:take_item() 
			return itemstack
		end
	end,
	light_source = 10,
	walkable = false,
	sunlight_propagates = true,
	floodable = true,
	drop = "nightscape:glow_powder",
	paramtype = "light",
}) 
minetest.register_abm({
	label = "1",
	nodenames = {"nightscape:glow_worms_1"},
	interval = 10,
	chance = 3,
	action = function(pos)
		minetest.set_node(pos, {name="nightscape:glow_worms_2"})
	end,
})
minetest.register_abm({
	label = "2",
	nodenames = {"nightscape:glow_worms_2"},
	interval = 10,
	chance = 3,
	action = function(pos)
		minetest.set_node(pos, {name="nightscape:glow_worms_3"})
	end,
})															 						minetest.register_abm({
	label = "3",
	nodenames = {"nightscape:glow_worms_3"},
	interval = 10,
	chance = 3,
	action = function(pos)
		minetest.set_node(pos, {name="nightscape:glow_worms_4"})
	end,
})
minetest.register_abm({
	label = "4",
	nodenames = {"nightscape:glow_worms_4"},
	interval = 20,
	chance = 3,
	action = function(pos)
		minetest.set_node(pos, {name="nightscape:glow_worms_5"})
	end,
})
minetest.register_craftitem("nightscape:glow_powder", {
	description = "Bioluminescent Powder",
	inventory_image = "nightscape_glow_powder.png",
})
minetest.register_node("nightscape:glow", {
	description = "Glow Air",
	drawtype = "airlike",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	pointable = false,
	groups = {not_in_creative_inventory = 1},
	light_source = 12,
})
-- Inspiration for glowstick object and mechanic comes from Geominer by CoderForTheBetter (c) 2017
minetest.register_entity("nightscape:glowstick_entity", {
	initial_properties = {
		hp_max = 1,
		physical = true,
		collisionbox = {-0.14, -0.14, -0.14, 0.14, 0.14, 0.14},
		visual = "sprite",
		visual_size = {x=0.6, y=0.6},
		textures = {"nightscape_glowstick.png"},
		spritediv = {x=1, y=1},
		initial_sprite_basepos = {x=0, y=0},
		is_visible = "true",
		timer = 0,
		physical = true,
		collide_with_objects = true,
	},
	on_activate = function(self, staticdata, dtime_s)
		last_pos = self.object:get_pos()
	end,
	last_pos = {x=-1, y=-1, z=-1},
	on_step = function(self, dtime)
		temp = self.object:getpos()
		if self.last_pos.y ~= temp.y then
			minetest.set_node(self.last_pos, {name="air"})
			self.last_pos = temp
			minetest.set_node(self.last_pos, {name = "nightscape:glow"})
		end
		node = minetest.get_node({x=self.last_pos.x, y=self.last_pos.y-0.3, z=self.last_pos.z})
		if minetest.registered_nodes[node.name].walkable then
			self.object:setvelocity({x=0, y=-2, z=0})
			self.object:setacceleration({x=0, y=-10, z=0})
		end
	end,
	on_punch = function(self, hitter)
		nodes_in_area = minetest.find_nodes_in_area({x=self.last_pos.x-1, y=self.last_pos.y-1, z=self.last_pos.z-1}, {x=self.last_pos.x+1, y=self.last_pos.y+1, z=self.last_pos.z+1}, {"nightscape:glow"})
		for i=1, table.getn(nodes_in_area) do
			minetest.set_node(nodes_in_area[i], {name = "air"})
		end
		hitter:get_inventory():add_item("main", "nightscape:glowstick")
	end,
})
minetest.register_craftitem("nightscape:glowstick", {
	description = "Glowstick",
	inventory_image = "nightscape_glowstick.png",
	on_drop = function(itemstack, dropper, pos)
		obj = minetest.add_entity({x=pos.x, y=pos.y+1.3, z=pos.z}, "nightscape:glowstick_entity")
		dir = dropper:get_look_dir()
		obj:setvelocity({x=dir.x*16, y=dir.y*4, z=dir.z*16})
		obj:setacceleration({x=dir.x*-3, y=-10, z=dir.z*-3})
		itemstack:take_item()
		return itemstack
	end,
})
minetest.register_craft({
	output = "nightscape:glowstick",
	recipe = {
		{"default:glass"},
		{"nightscape:glow_powder"},
		{"nightscape:glow_powder"},
		},
})
minetest.register_node("nightscape:jack_mushroom", {
	description = "Omphalotus illudens",
	drawtype = "plantlike",
	tiles = {"nightscape_JOL_mushroom.png"},
	groups = {snappy = 3, oddly_breakable_by_hand = 2},
	on_use = minetest.item_eat(-4),
	walkable = false,
	light_source = 3,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
	},
	paramtype = "light",
})
minetest.register_decoration({
	deco_type = "simple",
	noise_params = {offset=0, scale=0.005, spread={x=100, y=100, z=100}, seed=56, octaves=3, persist=0.7},
	place_on = {"default:dirt_with_grass"},
	biomes = {
			"deciduous_forest",
	},
	sidelen = 32,
	fill_ratio = 0.1,
	decoration = "nightscape:jack_mushroom",
	height = 1,
	height_max = 0,
})
minetest.register_node("nightscape:novodinia_block", {
	description = "Novodinia Starfish On Sand",
	tiles = {"default_sand.png^nightscape_star_fish_1.png", "default_sand.png"},
	groups = {oddly_breakable_by_hand = 2, crumbly = 3, cracky = 2},
	drop = "nightscape:novodinia",
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.under
		if minetest.get_node(pos).name ~= "default:sand" then
			return itemstack
		end
		minetest.get_node_timer(pos):start(1)
		local height = 6
		local top_pos = {x = pos.x, y=pos.y+height, z=pos.z}
		local node_def = minetest.get_node(top_pos)
		local top_node = minetest.registered_nodes[node_def.name]
		if top_node and top_node.liquidtype == "source" and minetest.get_item_group(top_node.name, "water") > 0 then
			minetest.set_node(pos, {name="nightscape:novodinia_block"})
			itemstack:take_item()
		end
	end,
	on_timer = function(pos, elapsed)
		local time = minetest.get_timeofday()*24000
		if time <= 5500 or time >= 19500 then
			minetest.set_node(pos, {name="nightscape:glowing_novodinia_block"})
		end
		minetest.get_node_timer(pos):start(math.floor(math.random(1, 3)))
	end,
--	on_dig = function(pos, node, player)
--		minetest.set_node(pos, {name = "default:sand"})
--	end,
})
minetest.register_node("nightscape:glowing_novodinia_block", {
	description = "Glowing Novodinia Starfish On Sand",
	tiles = {"default_sand.png^nightscape_star_fish_2.png", "default_sand.png"},
	groups = {oddly_breakable_by_hand = 2, crumbly = 3, cracky = 2, not_in_creative_inventory = 1},
	drop = "nightscape:novodinia",
	light_source = 5,
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.under
		if minetest.get_node(pos).name ~= "default:sand" then
			return itemstack
		end
		minetest.get_node_timer(pos):start(1)
		local height = 5
		local top_pos = {x = pos.x, y=pos.y+height, z=pos.z}
		local node_def = minetest.get_node(top_pos)
		local top_node = minetest.registered_nodes[node_def.name]
		if top_node and top_node.liquidtype == "source" and minetest.get_item_group(top_node.name, "water") > 0 then
			minetest.set_node(pos, {name="nightscape:glowing_novodinia_block"})
			itemstack:take_item()
		end
	end,
	on_timer = function(pos, elapsed)
		local time = minetest.get_timeofday()*24000
		if time > 5500 or time < 19500 then
			minetest.set_node(pos, {name="nightscape:novodinia_block"})
		end
		minetest.get_node_timer(pos):start(math.floor(math.random(1, 3)))
	end,
--	on_dig = function(pos, node, player)
--		minetest.set_node(pos, {name = "default:sand"})
--	end,
})
minetest.register_craftitem("nightscape:novodinia", {
	description = "Novodinia Starfish",
	inventory_image = "nightscape_star_fish_1.png",
})
minetest.register_craft({
	output = "nightscape:novodinia_block",	
	recipe = {
		{"nightscape:novodinia"},
		{"default:sand"},
	},
})
minetest.register_decoration({
	name = "nightscape:set_starfish",
	deco_type = "simple",
	decoration = "nightscape:novodinia_block",
	fill_ratio = 0.0002,
	sidelen = 80,
	spawn_by = "default:water_source",
	flags = "force_placement",
	y_min = -100,
	y_max = -40,
	place_on = {"default:sand"},
	num_spawn_by = 1,
	place_offset_y = -1,
})
local starfish = minetest.get_decoration_id("nightscape:set_starfish")
minetest.set_gen_notify({decoration = true}, {starfish})
minetest.register_on_generated(function(minp, maxp, blockseed)
	local gennotify = minetest.get_mapgen_object("gennotify")
	local poslist = {}
	for _, pos in ipairs(gennotify["decoration#"..starfish] or {}) do
		local low_firefly_pos = {x = pos.x, y = pos.y, z = pos.z}
		table.insert(poslist, low_firefly_pos)
	end
	if #poslist ~= 0 then
		for i = 1, #poslist do
			local pos = poslist[i]
			minetest.get_node_timer(pos):start(1)
		end
	end
end)
minetest.register_tool("nightscape:large_anemone_tentacle", {
	description = "Large Anemone Tentacle",
	inventory_image = "nightscape_anemone_tentacle.png",
	wield_image = "nightscape_anemone_tentacle.png",
	tool_capabilities = {
		full_punch_interval = 0.3,
		damage_groups = {fleshy = 6},
	},
})
minetest.register_node("nightscape:bioluminescent_sea_urchin", {
	description = "Bioluminescent Sea Urchin",
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "nightscape_sea_urchin_2.png", tileable_verticle = true}},
	groups = {crumbly = 3, snappy = 2},
	light_source = 6,
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.under
		if minetest.get_node(pos).name ~= "default:sand" then
			return itemstack
		end
		local height = 5
		local top_pos = {x = pos.x, y=pos.y+height, z=pos.z}
		local node_def = minetest.get_node(top_pos)
		local top_node = minetest.registered_nodes[node_def.name]
		if top_node and top_node.liquidtype == "source" and minetest.get_item_group(top_node.name, "water") > 0 then
			minetest.set_node(pos, {name="nightscape:bioluminescent_sea_urchin", param2 = height*16})
			itemstack:take_item()
		end
	end,
})
minetest.register_decoration({
	name = "nightscape:set_urchin",
	deco_type = "simple",
	decoration = "nightscape:bioluminescent_sea_urchin",
	fill_ratio = 0.0002,
	sidelen = 80,
	spawn_by = "default:water_source",
	flags = "force_placement",
	y_min = -100,
	y_max = -35,
	place_on = {"default:sand"},
	num_spawn_by = 1,
	place_offset_y = -1,
})
minetest.register_node("nightscape:dried_sea_urchin", {
	drawtype = "plantlike",
	description = "Dried Sea Urchin",
	tiles = {"nightscape_sea_urchin_1.png"},
	damage_per_second = 5,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
	},
	groups = {crumbly = 1.5, snappy = 1.3},
	floodable = true,
	sunlight_propagates = true,
	walkable = false,
	paramtype = "light",
})
minetest.register_craft({
	output = "nightscape:dried_sea_urchin",
	recipe = {
		{"nightscape:bioluminescent_sea_urchin"},
	},
})
minetest.register_node("nightscape:latia_snail", {
	description = "Latia Fresh Water Snail",
	drawtype = "plantlike_rooted",
	tiles = {"default_sand.png"},
	special_tiles = {{name = "nightscape_latia_snail.png", tileable_verticle = true}},
	groups = {crumbly = 3, snappy = 2},
	light_source = 6,
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
		},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.under
		if minetest.get_node(pos).name ~= "default:sand" then
			return itemstack
		end
		local height = 5
		local top_pos = {x = pos.x, y=pos.y+1, z=pos.z}
		local node_def = minetest.get_node(top_pos)
		local top_node = minetest.registered_nodes[node_def.name]
		if top_node and top_node.liquidtype == "source" and node_def.name == "default:river_water_source" then
			minetest.set_node(pos, {name="nightscape:latia_snail"})
			itemstack:take_item()
		end
	end,
})
minetest.register_decoration({
	name = "nightscape:set_latia",
	deco_type = "simple",
	decoration = "nightscape:latia_snail",
	fill_ratio = 0.005,
	sidelen = 80,
	spawn_by = "default:river_water_source",
	flags = "force_placement",
	y_min = -100,
	y_max = 1000,
	place_on = {"default:sand"},
	num_spawn_by = 1,
	place_offset_y = -1,
})
minetest.register_node("nightscape:bg_fireflies_bottle", {
	drawtype = "plantlike",
	description = "Blue Ghost Fireflies In A Bottle",
	groups = {oddly_breakable_by_hand = 3},
	inventory_image = "nightscape_bgfb.png",
	wield_image = "nightscape_bgfb.png",
	tiles = {{
		name = "nightscape_bbgfba.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 8,
			aspect_h = 8,
			length = 1.8
		},
	}},
	sunlight_propagates = true,
	light_source = 10,
	walkable = false,
	sounds = default.node_sound_glass_defaults(),
	paramtype = "light",
})
minetest.register_craft({
	output = "nightscape:bg_fireflies_bottle",
	recipe = {
		{"nightscape:blue_ghost_firefly"},
		{"vessels:glass_bottle"},
	},
})
minetest.register_craft({
	output = "nightscape:blue_ghost_firefly",
	recipe = {
		{"nightscape:bg_fireflies_bottle"},
	},
	replacements = {{"nightscape:bg_fireflies_bottle", "vessels:glass_bottle"}},
})	