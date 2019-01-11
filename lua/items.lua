local function register_items(downward, upward)
    minetest.register_craftitem("icycle:icycler", {
        description = "Inventory Cycler",
        textures = {"default_glass.png^default_stick.png^default_sapling.png"}, -- TODO make a custom texture
        on_use = function(itemstack, user, pointedthing) -- FIXME check API
            local newinventory = upward(user:get_player_inventory() )
            user:set_player_inventory(newinventory) -- FIXME check API
        end,
        on_place = function(itemstack, user, pointedthing) -- FIXME check API
            local newinventory = downward(user:get_player_inventory() )
            user:set_player_inventory(newinventory) -- FIXME check API
        end,
    })

    minetest.register_craftrecipe({
        output = "icycler:icycle",
        recipe = {
            {"group:tree", "", ""},
            {"", "group:sand", ""},
            {"", "", "group:stone"},
        }
    })
end

local function initialize(ifuncs)
    register_items(ifuncs.downward, ifuncs.updaward)
end

return initialize
