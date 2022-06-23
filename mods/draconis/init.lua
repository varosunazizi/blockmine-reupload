draconis = {}

local path = minetest.get_modpath("draconis")

-- Mobs
dofile(path .. "/mobs/fire_dragon.lua")
dofile(path .. "/mobs/fire_wyvern.lua")
dofile(path .. "/mobs/ice_wyvern.lua")
dofile(path .. "/mobs/jungle_wyvern.lua")

-- Items
dofile(path .. "/craftitems.lua")
dofile(path .. "/bestiary.lua")

-- Nodes
dofile(path .. "/nodes.lua")

-- Map Generation
dofile(path .. "/spawn_lairs.lua")

minetest.log("action", "[MOD] Draconis v0.11 Beta loaded")
