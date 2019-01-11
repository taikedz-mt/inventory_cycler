local image="default_glass.png^default_stick.png^default_sapling.png" -- TODO make a custom texture

local function cycleback(itemstack, user, extra)
        if user:get_wield_index() == 1 then
            inventory_cycler:downward(user:get_player_name())
        end
    end

minetest.register_craftitem("inventory_cycler:icycler", {
    description = "Inventory Cycler",
    inventory_image = image,
    stack_max = 1,
    on_use = function(itemstack, user, pointedthing)
        if user:get_wield_index() == 1 then
            inventory_cycler:upward(user:get_player_name())
        end
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
