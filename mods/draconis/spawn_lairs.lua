--- Nodes

minetest.register_node("draconis:spawn_fire_nest", {
	description = "spawn_fire_nest",
	tiles = {"draconis_temp_heat.png",},
	is_ground_content = true,
	drop = '',
})

minetest.register_node("draconis:spawn_ice_nest", {
	description = "spawn_ice_nest",
	tiles = {"draconis_temp_cold.png",},
	is_ground_content = true,
	drop = '',
})

--- Register Ores ---

 minetest.register_ore({
     ore_type = "scatter",
     ore = "draconis:spawn_fire_nest",
     wherein = "default:dirt_with_grass",
     clust_scarcity = 40*40*40,
     clust_num_ores = 1,
     clust_size = 1,
     height_min = 80,
     height_max = 250,
})

 minetest.register_ore({
     ore_type = "scatter",
     ore = "draconis:spawn_fire_nest",
     wherein = "default:dirt_with_dry_grass",
     clust_scarcity = 40*40*40,
     clust_num_ores = 1,
     clust_size = 1,
     height_min = 80,
     height_max = 250,
})

 minetest.register_ore({
     ore_type = "scatter",
     ore = "draconis:spawn_ice_nest",
     wherein = "default:dirt_with_snow",
     clust_scarcity = 40*40*40,
     clust_num_ores = 1,
     clust_size = 1,
     height_min = 80,
     height_max = 250,
})

 minetest.register_ore({
     ore_type = "scatter",
     ore = "draconis:spawn_ice_nest",
     wherein = "default:dirt_with_coniferous_litter",
     clust_scarcity = 40*40*40,
     clust_num_ores = 1,
     clust_size = 1,
     height_min = 80,
     height_max = 250,
})

--- Schematics ---

local ice_lair = minetest.get_modpath("draconis").."/schems/draconis_ice_nest.mts"

minetest.register_abm({
	nodenames = {"draconis:spawn_ice_nest"},
 	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
	minetest.place_schematic(pos, ice_lair, 0, {}, true)
        minetest.set_node(pos, {name = "air"})
	end,
})

local fire_lair = minetest.get_modpath("draconis").."/schems/draconis_fire_nest.mts"

minetest.register_abm({
	nodenames = {"draconis:spawn_fire_nest"},
 	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
	minetest.place_schematic(pos, fire_lair, 0, {}, true)
        minetest.set_node(pos, {name = "air"})
	end,
})

local viking_ship = minetest.get_modpath("draconis").."/schems/draconis_viking_ship.mts"

minetest.register_abm({
	nodenames = {"draconis:spawn_viking_ship"},
 	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
	minetest.place_schematic(pos, viking_ship, 0, {}, true)
	end,
})

