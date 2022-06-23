--Creates a storage block
local function registerNode(color, name, onOpen, onClose)
    minetest.register_node("shared_storage:" .. color, {
        description = name .. " Shared Storage",
        tiles = {
            "top_" .. color .. ".png",
            "bottom.png",
            "side.png",
            "side.png",
            "side.png",
            "side.png",
        },

        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            local metadata = clicker:get_meta()
            if metadata:get_int("shared_storage:version") < shared_storage.version then
                shared_storage.new_player(clicker)
            end

            local inv = clicker:get_inventory()

            minetest.show_formspec(clicker:get_player_name(), "shared_storage_storage", 
                "size[10.25,11]" ..
                "real_coordinates[true]" ..

                "listring[current_player;shared_storage_" .. color .. "]" ..
                "listring[current_player;main]" ..

                "list[current_player;shared_storage_" .. color .. ";0.25,0.25;8,4;]" ..
                "list[current_player;main;0.25,6;8,4;]"
            )
        end,

        groups = {cracky = 3}
    }
)
end

registerNode("black", "Black")
registerNode("blue", "Blue")
registerNode("brown", "Brown")
registerNode("cyan", "Cyan")
registerNode("dark_grey", "Dark Grey")
registerNode("dark_green", "Dark Green")
registerNode("green", "Green")
registerNode("light_grey", "Light Grey")
registerNode("magenta", "Magenta")
registerNode("orange", "Orange")
registerNode("pink", "Pink")
registerNode("red", "Red")
registerNode("violet", "Violet")
registerNode("white", "White")
registerNode("yellow", "Yellow")
