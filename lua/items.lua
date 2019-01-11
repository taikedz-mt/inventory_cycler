
local function get_player_inventory(player)
    minetest.get_inventory({type = "player", name = player:get_player_name()})
end

local function set_player_inventory(player, inventory)
end

minetest.register_craftitem("inventory_cycler:icycler", {
    description = "Inventory Cycler",
    inventory_texture = "default_glass.png^default_stick.png^default_sapling.png", -- TODO make a custom texture
    on_use = function(itemstack, user, pointedthing)
        inventory_cycler:upward(get_player_inventory(user) )
    end,
    on_place = function(itemstack, user, pointedthing) -- FIXME check API
        inventory_cycler:downward(get_player_inventory(user) )
    end,
})

minetest.register_craft({
    output = "inventory_cycler:icycler",
    recipe = {
        {"group:tree", "", ""},
        {"", "group:sand", ""},
        {"", "", "group:stone"},
    }
})

minetest.register_craft({
    output = "inventory_cycler:icycler",
    recipe = {
        {"", "", "group:tree"},
        {"", "group:sand", ""},
        {"group:stone", "", ""},
    }
})
