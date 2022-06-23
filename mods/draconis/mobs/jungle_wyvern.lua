
local S = mobs.intllib

-- Walking and Flying animation sets

local animation_fly = {
		speed_normal = 10,
		speed_sprint = 20,
		stand_start = 140,
		stand_end = 160,
		walk_start = 110,
		walk_end = 130,
		}
local animation_land = {
		speed_normal = 10,
		speed_sprint = 20,
		stand_start = 50,
		stand_end = 100,
		walk_start = 1,
		walk_end = 40,
		}

-- Jungle Wyvern by ElCeejo

mobs:register_mob("draconis:jungle_wyvern", {
	type = "monster",
	hp_min = 41,
	hp_max = 41,
	armor = 120,
	passive = false,
	walk_velocity = 4,
	run_velocity = 8,
        walk_chance = 75,
        jump = false,
        jump_height = 1.1,
        stepheight = 1.5,
        fly = true,
        fly_in = "air",
        runaway = true,
        pushable = false,
        view_range = 40,
        knock_back = 0,
        damage = 7,
	fear_height = 6,
	fall_speed = -8,
	fall_damage = 20,
	water_damage = 0,
	lava_damage = 3,
	light_damage = 0,
        suffocation = false,
        floats = 1,
	owner = "",
	follow = {"farming:cocoa_beans"},
        reach = 2,
        attack_chance = 30,
        attack_animals = true,
        attack_npcs = true,
        attack_players = true,
        owner_loyal = true,
        attacks_monsters = true,
        attack_type = "dogfight",
        group_attack = true,
	pathfinding = 1,
	makes_footstep_sound = true,
	sounds = {
		random = "draconis_wyvern_small_random",
		attack = "draconis_wyvern_small_attack",
	},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 3, max = 5},
	},
	visual = "mesh",
	visual_size = {x=3, y=3},
	collisionbox = {-0.3, -0.2, -0.3, 0.3, 0.5, 0.3},
	textures = {
		{"draconis_jungle_wyvern1.png"},
		{"draconis_jungle_wyvern2.png"},
		{"draconis_jungle_wyvern3.png"},
		{"draconis_jungle_wyvern4.png"},
	},
	child_texture = {
		{"draconis_jungle_wyvern1.png"},
		{"draconis_jungle_wyvern2.png"},
		{"draconis_jungle_wyvern3.png"},
		{"draconis_jungle_wyvern4.png"},
	},
	mesh = "draconis_wyvern.b3d",
	animation = animation_fly,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end

		if self.owner == "" then
			self.owner = clicker:get_player_name()
		else
			if self.order == "follow" then
				self.order = "stand"
				self.fly = false
				self.animation = animation_land
			else
				self.order = "follow"
				self.fly = true
				self.animation = animation_fly

			end

		end

	end,

	do_custom = function(self, dtime)

	if self.child == true then

	self.hp_min = 56
	self.hp_max = 56
	self.passive = true
        self.attack_animals = false
        self.attack_players = false
        self.attack_monsters = false
	self.walk_velocity = 0.4
	self.run_velocity = 0.4
			return
		end

	if self.tamed == true then

	self.type = "animal"
	self.passive = false
        self.attack_animals = true
        self.attack_monsters = true
        self.attack_players = true
        self.owner_loyal = true
	self.walk_velocity = 4
	self.run_velocity = 10
			return
		end
	end,
})
mobs:register_egg("draconis:jungle_wyvern", S("Jungle Wyvern"), "default_jungleleaves.png", 1)

-- Jungle Wyvern Egg by ElCeejo

minetest.register_node("draconis:jungle_wyvern_egg", {
        description = "Jungle Wyvern Egg",
	tiles = {"draconis_jungle_wyvern_egg.png"},
        inventory_image = "draconis_jungle_egg.png",
        wield_image = "draconis_jungle_egg.png",
	drawtype = "mesh",
        mesh = "draconis_small_egg.obj",
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.1875, 0.1875, 0.0625, 0.25},
		}
	},
	is_ground_content = false,
	paramtype2 = "facedir",
	groups = {snappy = 2},
	sounds = default.node_sound_stone_defaults(),
	drop = "draconis:jungle_wyvern_egg",
	on_construct = function(pos)

	local pos_under= { 
       	x = pos.x,
       	y = pos.y - 1,
   	z = pos.z,
   	}

        local nest = minetest.get_node_or_nil(pos_under) 

    	if nest.name == "default:dirt_with_rainforest_litter" then

		minetest.get_node_timer(pos):start(math.min(10), math.max(10))
                        return
                end
        end,

	on_timer = function(pos)

		mob = minetest.add_entity(pos, "draconis:jungle_wyvern")
                ent2 = mob:get_luaentity()
		minetest.remove_node(pos)

		mob:set_properties({
			textures = ent2.child_texture[1],
			visual_size = {
				x = ent2.base_size.x / 5,
				y = ent2.base_size.y / 5
			},
			collisionbox = {
				ent2.base_colbox[1] / 5,
				ent2.base_colbox[2] / 5,
				ent2.base_colbox[3] / 5,
				ent2.base_colbox[4] / 5,
				ent2.base_colbox[5] / 5,
				ent2.base_colbox[6] / 5
			},
		})



		ent2.child = true
                ent2.tamed = false
	end,
})
