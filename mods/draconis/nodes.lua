-- Draconis Nodes

-- Fire Wyvern Nest

minetest.register_node("draconis:fire_wyvern_nest", {
        description = "Fire Wyvern Nest",
	tiles = {"draconis_fire_wyvern_nest.png"},
	drawtype = "mesh",
        mesh = "draconis_nest.obj",
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
			{-0.5, -0.5, -0.5, 0.5, -0.25, -0.375},
			{0.375, -0.5, -0.5, 0.5, -0.25, 0.5},
			{-0.5, -0.5, 0.375, 0.5, -0.25, 0.5},
			{-0.5, -0.5, -0.5, -0.375, -0.25, 0.5},
		}
	},
	is_ground_content = false,
	paramtype2 = "facedir",
	groups = {snappy = 2},
	sounds = default.node_sound_leaves_defaults(),
	drop = "draconis:fire_wyvern_egg",
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
-- Make Wyvern spawn above the nest
	local spawn_above = {
            	x = pos.x,
            	y = pos.y + 3.5,
            	z = pos.z,
        }    
		minetest.add_entity(spawn_above, "draconis:fire_wyvern")
	end,
})

-- Ice Wyvern Nest

minetest.register_node("draconis:ice_wyvern_nest", {
        description = "Ice Wyvern Nest",
	tiles = {"draconis_ice_wyvern_nest.png"},
	drawtype = "mesh",
        mesh = "draconis_nest.obj",
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
			{-0.5, -0.5, -0.5, 0.5, -0.25, -0.375},
			{0.375, -0.5, -0.5, 0.5, -0.25, 0.5},
			{-0.5, -0.5, 0.375, 0.5, -0.25, 0.5},
			{-0.5, -0.5, -0.5, -0.375, -0.25, 0.5},
		}
	},
	is_ground_content = false,
	paramtype2 = "facedir",
	groups = {snappy = 2},
	sounds = default.node_sound_leaves_defaults(),
	drop = "draconis:ice_wyvern_egg",
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
-- Make Wyvern spawn above the nest
	local spawn_above = {
            	x = pos.x,
            	y = pos.y + 3.5,
            	z = pos.z,
        }    
		minetest.add_entity(spawn_above, "draconis:ice_wyvern")
	end,
})

-- Dragon Fire

minetest.register_node("draconis:dragon_fire", {
	description = "Dragon Fire",
	drawtype = "firelike",
	tiles = {{
		name = "draconis_dragon_fire_animated.png",
		animation = {type = "vertical_frames",
			aspect_w = 16, aspect_h = 16, length = 1},
	}},
	inventory_image = "draconis_dragon_fire.png",
	light_source = 15,
	groups = {igniter = 3, snappy=1},
	drop = '',
	walkable = false,
	buildable_to = false,
	damage_per_second = 8,
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.min(10), math.max(10))
	end,
	on_timer = function(pos)
		local f = minetest.find_node_near(pos, 1, {"group:flammable"})
		if not fire_enabled or not f then
			minetest.remove_node(pos)
			return
		end
		return true
	end,
})

-- Hatching Blocks

minetest.register_node("draconis:hot_obsidian", {
	description = "Super-Heated Obsidian",
	tiles = {"draconis_hot_obsidian.png"},
	damage_per_second = 2,
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2, igniter = 1},
})

minetest.register_node("draconis:cold_ice", {
	description = "Super-Cooled Ice",
	tiles = {"draconis_cold_ice.png"},
	is_ground_content = false,
	damage_per_second = 2,
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_abm({
	nodenames = {"draconis:hot_obsidian"},
	interval = 1,
	chance = 2,
	action = function(pos, node)
		minetest.add_particlespawner(
			32,
			4,
			{x=pos.x-0.1, y=pos.y-0.25, z=pos.z-0.1},
			{x=pos.x+0.1, y=pos.y+0.25, z=pos.z+0.1},
			{x=-0.2, y=-0.8, z=-0.2},
			{x=0, y=0.8, z=0},
			{x=0,y=0,z=0},
			{x=0,y=0,z=0},
			1.4,
			1.5,
			1,
			2,
			false,
			"draconis_dragon_fire.png"
		)
	end,
})

minetest.register_abm({
	nodenames = {"draconis:cold_ice"},
	interval = 1,
	chance = 2,
	action = function(pos, node)
		minetest.add_particlespawner(
			32,
			4,
			{x=pos.x-0.1, y=pos.y-0.25, z=pos.z-0.1},
			{x=pos.x+0.1, y=pos.y+0.25, z=pos.z+0.1},
			{x=-0.2, y=-0.8, z=-0.2},
			{x=0, y=0.8, z=0},
			{x=0,y=0,z=0},
			{x=0,y=0,z=0},
			1.4,
			1.5,
			1,
			2,
			false,
			"draconis_frost_flame.png"
		)
	end,
})

