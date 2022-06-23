
local S = mobs.intllib

-- Fire Breathing

function fire_breath(pos)
	for i=pos.x-math.random(0, 1), pos.x+math.random(0, 1), 1 do
		for j=pos.y-1, pos.y+2, 1 do
			for k=pos.z-math.random(0, 1), pos.z+math.random(0, 1), 1 do
				local p = {x=i, y=j, z=k}
				local n = minetest.env:get_node(p).name
				if minetest.get_item_group(n, "unbreakable") == 1 or minetest.is_protected(p, "") then
				else
					minetest.set_node({x=i, y=j, z=k}, {name="draconis:dragon_fire"})
				end
			end
		end
	end
end


mobs:register_arrow("draconis:dragon_fire_breath", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"fire_basic_flame.png"},
	collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
	velocity = 7,
	tail = 1,
	tail_texture = "fire_basic_flame.png",
	tail_size = 10,
	glow = 5,
	expire = 0.1,

	on_activate = function(self, staticdata, dtime_s)
		self.object:set_armor_groups({immortal = 1, fleshy = 100})
	end,

	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 18},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 28},
		}, nil)
	end,

	-- node hit
	hit_node = function(self, pos, node)
		mobs:boom(self, pos, 1)
		fire_breath(pos)
	end
})

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

-- Fire Dragon by ElCeejo

mobs:register_mob("draconis:fire_dragon", {
	type = "monster",
	hp_min = 582,
	hp_max = 582,
	armor = 80,
	passive = false,
	walk_velocity = 3,
	run_velocity = 5,
        walk_chance = 35,
        jump = false,
        jump_height = 1.1,
        stepheight = 1.5,
        fly = true,
        fly_in = "air",
        runaway = false,
        pushable = false,
        view_range = 100,
        knock_back = 0,
        damage = 34,
	fear_height = 6,
	fall_speed = -8,
	fall_damage = 20,
	water_damage = 0,
	lava_damage = 3,
	light_damage = 0,
        suffocation = false,
        floats = 1,
        reach = 5,
        attack_chance = 30,
        attack_animals = true,
        attack_npcs = true,
        attack_players = true,
        attacks_monsters = true,
        attack_type = "dogshoot",
        shoot_interval = 1,
	     dogshoot_switch = 2,
	     dogshoot_count = 0,
	     dogshoot_count_max =5,
        arrow = "dragon_fire_breath",
        shoot_offset = 1,
        group_attack = true,
	pathfinding = 1,
	makes_footstep_sound = true,
	sounds = {
		random = "draconis_dragon_random",
		shoot_attack = "draconis_dragon_attack",
	},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 8, max = 11},
		{name = "draconis:fire_dragon_egg", chance = 1, min = 1, max = 1},
	},
	visual = "mesh",
	visual_size = {x=20, y=20},
	collisionbox = {-1.3, -1.0, -1.3, 1.3, 1.8, 1.3},
	textures = {
		{"draconis_fire_dragon1.png"},
		{"draconis_fire_dragon2.png"},
		{"draconis_fire_dragon3.png"},
	},
	child_texture = {
		{"draconis_fire_dragon1.png"},
		{"draconis_fire_dragon2.png"},
		{"draconis_fire_dragon3.png"},
	},
	mesh = "draconis_dragon.b3d",
	animation = animation_fly,

})

mobs:spawn({
	name = "draconis:fire_dragon",
	nodes = "default:stone",
        neighbours = "air",
	min_light = 14,
	interval = 100,
	chance = 8000, -- 15000
	min_height = 80,
	max_height = 200,
	day_toggle = true,
})

mobs:register_egg("draconis:fire_dragon", S("Fire Dragon"), "fire_basic_flame.png", 1)

--  Tamed Fire Dragon by ElCeejo

mobs:register_mob("draconis:hatched_fire_dragon", {
	type = "npc",
	hp_min = 582,
	hp_max = 582,
	armor = 80,
	passive = false,
	walk_velocity = 3,
	run_velocity = 5,
        walk_chance = 35,
        jump = true,
        jump_height = 3,
        stepheight = 1,
        runaway = false,
        pushable = false,
        view_range = 26,
        knock_back = 0,
        damage = 34,
	fear_height = 0,
	fall_speed = -8,
	fall_damage = 0,
	water_damage = 38,
	lava_damage = -15,
	light_damage = 0,
        suffocation = false,
        floats = 1,
	owner = "",
	follow = {"mobs:mutton_raw"},
        reach = 10,
        attack_chance = 100,
        attack_animals = true,
        attack_npcs = true,
        attack_players = true,
        owner_loyal = true,
        group_attack = true,
	pathfinding = 1,
	makes_footstep_sound = true,
	sounds = {
		random = "draconis_fire_dragon",
	},
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 8, max = 11},
	},
	visual = "mesh",
	visual_size = {x=20, y=20},
	collisionbox = {-1.3, -1.0, -1.3, 1.3, 1.8, 1.3},
	textures = {
		{"draconis_fire_dragon1.png"},
		{"draconis_fire_dragon2.png"},
		{"draconis_fire_dragon3.png"},
	},
	child_texture = {
		{"draconis_fire_dragon1.png"},
		{"draconis_fire_dragon2.png"},
		{"draconis_fire_dragon3.png"},
	},
	mesh = "draconis_dragon.b3d",
	animation = animation_land,

	do_custom = function(self, dtime, player)

		-- set needed values if not already present
	if not self.v2 then
		self.v2 = 0
		self.max_speed_forward = 7
		self.max_speed_reverse = 2
		self.accel = 6
		self.terrain_type = 3
		self.driver_attach_at = {x = 0, y = 1.22, z = 0.5}
		self.driver_eye_offset = {x = 0, y = 24, z = 0}
	end

        if not self.driver then

                self.animation = animation_land

			return true
		end

	if self.driver then

		mobs.drive(self, "walk", "stand", true, dtime)
                mobs.fly(self, dtime, 5, true, "draconis:dragon_fire_breath", "walk", "stand")
                self.animation = animation_fly
                self.driver:set_properties({visual_size = {x=0.05, y=0.05}})

			return false
		end

		return true
	end,

	on_die = function(self, pos)

		if self.driver then
			minetest.add_item(pos, "mobs:saddle")
			mobs.detach(self.driver, {x = 1, y = 0, z = 1})
self.saddle = nil
		end
	end,

	on_rightclick = function(self, clicker)

		if not clicker or not clicker:is_player() then
			return
		end

		if mobs:protect(self, clicker) then
			return
		end

-- Babies can't be ridden, but can be imprinted

	        if self.child
                and (clicker:get_wielded_item():get_name() == "mobs:saddle") then

		mobs.detach(clicker, {x = 0, y = 0, z = 0})

			return true
		end

	        if self.tamed == false then

                self.tamed = true
                self.owner = clicker:get_player_name()

			return false
		end

-- Dragon can be ordered with the Dragon Staff

		if self.owner == "" then
			self.owner = clicker:get_player_name()
		else
                        if (clicker:get_wielded_item():get_name() == "draconis:dragon_staff")
			and self.order == "roam" then
                                self.jump = false
				self.order = "sit"
                                self.walk_chance = 0
                                self.animation =  animation_tamed
                                mobs:set_animation(self, self.animation.stand)
			else
                                self.jump = true
				self.order = "roam"
                                self.walk_chance = 15
			end

		end


		if self.tamed and self.owner == clicker:get_player_name() then

			local inv = clicker:get_inventory()


			if self.driver and clicker == self.driver then

				mobs.detach(clicker, {x = 0, y = 2, z = 0})

				-- add saddle back to inventory
				if inv:room_for_item("main", "mobs:saddle") then
					inv:add_item("main", "mobs:saddle")
				else
					minetest.add_item(clicker:get_pos(), "mobs:saddle")
				end

self.saddle = nil


			elseif (not self.driver
			and clicker:get_wielded_item():get_name() == "mobs:saddle")
			or self.saddle then

				self.object:set_properties({stepheight = 1.1})
				mobs.attach(self, clicker)


				if not self.saddle then
					inv:remove_item("main", "mobs:saddle")
				end

self.saddle = true
			end
		end


		mobs:capture_mob(self, clicker, 0, 0, 80, false, nil)
	end
})

mobs:register_egg("draconis:hatched_fire_dragon", S("Tame Fire Dragon"), "fire_basic_flame.png", 1)

-- Fire Dragon Egg by ElCeejo

minetest.register_node("draconis:fire_dragon_egg", {
        description = "Fire Dragon Egg",
	tiles = {"draconis_fire_dragon_nest.png"},
        inventory_image = "draconis_fire_egg2.png",
        wield_image = "draconis_fire_egg2.png",
	drawtype = "mesh",
        mesh = "draconis_large_egg.obj",
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
	drop = "draconis:fire_dragon_egg",
	on_construct = function(pos)

	local pos_under= { 
       	x = pos.x,
       	y = pos.y - 1,
   	z = pos.z,
   	}

        local nest = minetest.get_node_or_nil(pos_under) 

    	if nest.name == "draconis:hot_obsidian" then

		minetest.get_node_timer(pos):start(math.min(10), math.max(10))
                        return
                end
        end,

	on_timer = function(pos)

		mob = minetest.add_entity(pos, "draconis:hatched_fire_dragon")
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
