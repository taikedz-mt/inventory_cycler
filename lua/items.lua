local function cycleback(itemstack, user, extra)
    inventory_cycler:downward(user:get_player_name(), user:get_wield_index())
end

minetest.register_craftitem("inventory_cycler:icycler", {
    description = "Inventory Cycler",
    inventory_image = "inventory_cycler_icycler.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointedthing)
        inventory_cycler:downward(user:get_player_name(), user:get_wield_index())
    end,
    on_place = cycleback, -- only works if pointing at a node!
    on_drop = cycleback,
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
