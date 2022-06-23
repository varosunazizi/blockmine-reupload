tnt_extras = {}

-- Load settings
local lava_chance = minetest.setting_get("lava_chance") or 150
local gravel_chance = minetest.setting_get("gravel_chance") or 8
local glass_chance = minetest.setting_get("glass_chance") or 6
local damage_blast_resistant = minetest.setting_get("damage_blast_resistant") or 24
local glass_block_chance = minetest.setting_get("glass_block_chance") or 48
local melt_chance = minetest.setting_get("melt_chance") or 3

function tnt_extras.register_stone(name)
	minetest.override_item(name, {
		on_blast = function(pos)
			if math.random(1, gravel_chance) == 1 then
				minetest.set_node(pos, {name = "default:gravel"})
			elseif math.random(1, lava_chance) == 1 then
				minetest.set_node(pos, {name = "default:lava_source"})
			else 
				minetest.remove_node(pos)
			end
		end
	})
end

function tnt_extras.register_sand(name)
	minetest.override_item(name, {
		on_blast = function(pos)
			if math.random(1, glass_block_chance) == 1 then
				minetest.set_node(pos, {name = "default:glass"})
				return
			elseif math.random(1, glass_chance) == 1 then
				minetest.add_item(pos, "vessels:glass_fragments")
			end
			minetest.remove_node(pos)
		end
	})
end

function tnt_extras.register_blast_resistant(name, strength)
	minetest.override_item(name, {
		on_blast = function(pos) 
			if math.random(1, damage_blast_resistant * strength) == 1 then
				minetest.remove_node(pos)
			end
		end
	})
end

function tnt_extras.register_can_melt(name)
	minetest.override_item(name,{
		on_blast = function(pos)
			if math.random(1, melt_chance) == 1 then
				minetest.set_node(pos, {name = "default:water_source"})
			end
		end
	})
end

-- Register stonelike nodes
tnt_extras.register_stone("default:stone")
tnt_extras.register_stone("default:cobble")
tnt_extras.register_stone("default:mossycobble")
tnt_extras.register_stone("default:desert_stone")
tnt_extras.register_stone("default:desert_cobble")
tnt_extras.register_stone("default:sandstone")

-- Register sandlike nodes
tnt_extras.register_sand("default:sand")
tnt_extras.register_sand("default:desert_sand")

-- Register blast resistant nodes
tnt_extras.register_blast_resistant("default:diamondblock" ,2)
tnt_extras.register_blast_resistant("default:obsidian" ,1)
tnt_extras.register_blast_resistant("default:obsidianbrick" ,.9)
tnt_extras.register_blast_resistant("default:mese" ,.6)
tnt_extras.register_blast_resistant("default:desert_stonebrick",.35)
tnt_extras.register_blast_resistant("default:sandstonebrick",.35)
tnt_extras.register_blast_resistant("default:stonebrick",.35)
tnt_extras.register_blast_resistant("default:brick",.35)
tnt_extras.register_blast_resistant("default:cloud",10)

-- Check if nyancats are registered
if minetest.registered_nodes["nyancat:nyancat"] ~= nil then
	tnt_extras.register_blast_resistant("nyancat:nyancat" ,.8)
	tnt_extras.register_blast_resistant("nyancat:nyancat_rainbow" ,.8)
elseif minetest.registered_nodes["default:nyancat"] ~= nil then
	tnt_extras.register_blast_resistant("default:nyancat" ,.8)
	tnt_extras.register_blast_resistant("default:nyancat_rainbow" ,.8)
end

-- Register nodes that melt into water_source
tnt_extras.register_can_melt("default:snowblock")
tnt_extras.register_can_melt("default:ice")