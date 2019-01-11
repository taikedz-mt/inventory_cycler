local function inventory_copy(playerinventory)
    local new_t = {}
    for i = 1,4 do
        new_t[i] = {}
        for j = 1,8 do
            new_t[i][j] = playerinventory:get_stack("main", (i-1)*8+j)
        end
    end

    return new_t
end

local function apply_inventory(playerinventory, new_inv)
    for i = 1,4 do
        for j = 1,8 do
            if (j-1) % 8 ~= 0 then
                local entry = ((i-1)*8+j)
                playerinventory:set_stack("main", entry, new_inv[i][j])
            end
        end
    end
end

local function inventory_move(playername, direction)
    local inv_ref = minetest.get_inventory({type="player", name=playername})
    local inv_copy = inventory_copy(inv_ref)
    local shifted_t = {}

    for i = 0,3 do
        local newpos = (i+direction)%4+1
        shifted_t[newpos] = inv_copy[i+1]
    end

    apply_inventory(inv_ref, shifted_t)
end

function inventory_cycler:upward(playername)
    inventory_move(playername, -1)
end

function inventory_cycler:downward(playername)
    inventory_move(playername, 1)
end
