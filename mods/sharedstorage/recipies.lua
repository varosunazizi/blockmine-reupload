local function register_recipie(color, dye)
    dye = dye or color

    --Regular chest
    minetest.register_craft({
        output = "shared_storage:" .. color,
        recipe = {
            {"default:obsidian", "dye:" .. dye, "default:obsidian"},
            {"default:diamond", "default:chest", "default:diamond"},
            {"default:obsidian", "default:diamond", "default:obsidian"}
        }
    })

    --Locked chest
    minetest.register_craft({
        output = "shared_storage:" .. color,
        recipe = {
            {"default:obsidian", "dye:" .. dye, "default:obsidian"},
            {"default:diamond", "default:chest_locked", "default:diamond"},
            {"default:obsidian", "default:diamond", "default:obsidian"}
        }
    })
end

register_recipie("black")
register_recipie("blue")
register_recipie("brown")
register_recipie("cyan")
register_recipie("dark_grey")
register_recipie("dark_green")
register_recipie("green")
register_recipie("light_grey", "grey")
register_recipie("magenta")
register_recipie("orange")
register_recipie("pink")
register_recipie("red")
register_recipie("violet")
register_recipie("white")
register_recipie("yellow")
