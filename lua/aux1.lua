--[[
When user is holding the aux1 key (E):
* if player is sneaking
* and if user is not walking
* then
    * start cycling their inventory
    * at their personally configured speed
--]]

local global_timer = 0
local player_timers = {}
local global_cycle_interval = tonumber(minetest.settings:get("inventory_cycler.default_global_cycle_interval")) or 0.5
local default_player_interval = tonumber(minetest.settings:get("inventory_cycler.default_player_cycle_interval")) or 1
local must_stand_still = tonumber(minetest.settings:get("inventory_cycler.must_stand_still")) ~= false

local required_controls = minetest.settings:get("inventory.cycler.required_controls") or "aux1,sneak"
local forbidden_controls = minetest.settings:get("inventory.cycler.forbidden_controls") or ""

required_controls = required_controls:split(",")
forbidden_controls = forbidden_controls:split(",")

local function holding_all_of(player, controls)
    local pcon = player:get_player_control()

    for _,c in ipairs(controls) do
        if not pcon[c] then return false end
    end

    return true
end

local function holding_none_of(player, controls)
    local pcon = player:get_player_control()

    for _,c in ipairs(controls) do
        if pcon[c] then return false end
    end

    return true
end

local function player_is_cycling(player)
    local pinv = minetest.get_inventory({type='player', name = player:get_player_name()})

    return holding_all_of(player, required_controls) and holding_none_of(player, forbidden_controls)
end

minetest.register_on_leaveplayer(function(player)
    local playername = player:get_player_name()
    player_timers[playername] = nil
end)

minetest.register_chatcommand("icycler", {
    description = "Configure inventory cycler",
    params = "period <N>",
    func = function(playername, params)
        params = params:split(" ")

        if #params == 2 and params[1] == "period" then
            local newperiod = tonumber(params[2]) or default_player_interval
            player_timers[playername].interval  = newperiod
            minetest.chat_send_player(playername, "Cycle period set to "..tostring(newperiod))
            return
        end

        minetest.chat_send_player(playername, "Invalid request - see /help icycler")
    end,
})

minetest.register_globalstep(function(dtime)
    global_timer = global_timer + dtime
    if global_timer < global_cycle_interval then
        return
    end

    local all_players = minetest.get_connected_players()

    for _,player in ipairs(all_players) do
        local playername = player:get_player_name()

        if player_is_cycling(player) then
            if player_timers[playername].timer == 0 then
                -- Get it before incrementing the timer up from zero
                -- So that a quick "tap" of required key combo
                --   activates the cycling
                inventory_cycler:upward(player:get_player_name())
            end

            player_timers[playername].timer = player_timers[playername].timer + global_timer

            if player_timers[playername].timer < player_timers[playername].interval then
                return
            end
            player_timers[playername].timer = 0
        else
            if player_timers[playername] == nil then
                player_timers[playername] = {timer=0, interval=default_player_interval}
            end

            player_timers[playername].timer = 0
        end
    end

    global_timer = 0
end)
