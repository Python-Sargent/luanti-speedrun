speedrun.timers = {}
speedrun.times = {} -- stashed times (when a run is finished the time will be put here, but it is not saved to file)

speedrun.add_timer = function(player)
    speedrun.timers[player:get_player_name()] = {
        elapsed = 0,
        start = 0,
        hudidx = {},
        playing = 0, -- starts as false, and then you turn it on
    }
    local timer_text = player:hud_add({
        hud_elem_type = "text",
        position  = {x = 0, y = 0},
        offset    = {x = 16, y = 16},
        text      = "0:0:0",
        number = 0x44AA22,
        size     = { x = 3, y = 3},
        alignment = { x = 1, y = 1 },
        z_index   = 1,
    })
    speedrun.timers[player:get_player_name()].hudidx.timer_text = timer_text
end

speedrun.remove_timer = function(player)
    if speedrun.timers[player:get_player_name()] ~= nil
        and speedrun.timers[player:get_player_name()].hudidx ~= nil
            and speedrun.timers[player:get_player_name()].hudidx.timer_text ~= nil then -- make sure there is a timer hud to remove
        player:hud_remove(speedrun.timers[player:get_player_name()].hudidx.timer_text)
    end
    speedrun.timers[player:get_player_name()] = nil
end

speedrun.start = function(player)
    speedrun.timers[player:get_player_name()].playing = true
    speedrun.timers[player:get_player_name()].start = os.time() -- not very precise, only gives seconds
end

speedrun.stop = function(player)
    if speedrun.timers[player:get_player_name()] ~= nil then speedrun.timers[player:get_player_name()].playing = false end
end

speedrun.formatTime = function(seconds)
  
    local minutes = math.floor(seconds / 60)
    local remainingSeconds = seconds % 60
    local wholeSeconds = math.floor(remainingSeconds)
    local milliseconds = math.floor((remainingSeconds - wholeSeconds) * 1000)
  
    return string.format("%02d:%02d:%03d", minutes, wholeSeconds, milliseconds)
  end

speedrun.step = function(dtime)
    for i, v in pairs(speedrun.timers) do
        if speedrun.timers[i] ~= nil and v.playing == true then
            speedrun.timers[i].elapsed = v.elapsed + dtime
            local player = core.get_player_by_name(i)
            local etime = speedrun.formatTime(speedrun.timers[i].elapsed) 
            player:hud_change(speedrun.timers[i].hudidx.timer_text, "text", etime)
        end
    end
end

core.register_globalstep(function(dtime)
    speedrun.step(dtime)
end)

core.register_on_joinplayer(function(player, last_login)
    speedrun.add_timer(player)
    speedrun.start(player)
end)

core.register_on_leaveplayer(function(player, timed_out)
    speedrun.remove_timer(player)
    speedrun.stop(player)
end)