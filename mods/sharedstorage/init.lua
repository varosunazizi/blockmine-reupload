shared_storage = {}

shared_storage.version = 2

local path = minetest.get_modpath("shared_storage")

--Load the storage
dofile(path.."/storage.lua")

--Load the nodes
dofile(path.."/nodes.lua")

--Load the items
dofile(path.."/items.lua")

--Load the recipies
dofile(path.."/recipies.lua")
