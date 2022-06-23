local invitories = {}

--Creates an list in the player's inventory
local function create_inventory(inv, color)
    inv:set_size("shared_storage_" .. color, 32)
    inv:set_width("shared_storage_" .. color, 8)
end

--Create all the colored lists
function shared_storage.new_player(player)
    local metadata = player:get_meta()
    local inv = player:get_inventory()

    create_inventory(inv, "black")
    create_inventory(inv, "blue")
    create_inventory(inv, "brown")
    create_inventory(inv, "cyan")
    create_inventory(inv, "dark_grey")
    create_inventory(inv, "dark_green")
    create_inventory(inv, "green")
    create_inventory(inv, "light_grey")
    create_inventory(inv, "magenta")
    create_inventory(inv, "orange")
    create_inventory(inv, "pink")
    create_inventory(inv, "red")
    create_inventory(inv, "violet")
    create_inventory(inv, "white")
    create_inventory(inv, "yellow")

    metadata:set_int("shared_storage:version", shared_storage.version)
end
