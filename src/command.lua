core.register_chatcommand("speedrun", {
    params = "finish\n" ..
             "restart\n" ..
             "help",
    description = "Speedrunning helper functions:\nfinish (stops timer, overwrites time)\nrestart (resets timer & respawns)",
    privs = {},
    func = function(name, param)
        local player = core.get_player_by_name(name)
        local params = param:split(" ")
        if params[1] == "finish" then
			speedrun.stop(player) -- stop the timer\
            local elapsed = speedrun.timers[name].elapsed
            if speedrun.times[name] ~= nil then
                if elapsed < speedrun.times[name] then
                    speedrun.times[name] = elapsed -- save the time if it's better
                    core.chat_send_player(name, "You beat your previous record in this session")
                else
                    core.chat_send_player(name, "Your time was " .. speedrun.formatTime(elapsed)) -- otherwise show the time
                end
            else
                speedrun.times[name] = speedrun.timers[name].elapsed -- save the time
            end
            core.chat_send_player(name, "Your best time is " .. speedrun.formatTime(speedrun.times[name]))
            speedrun.remove_timer(player)
        elseif params[1] == "restart" then
            speedrun.stop(player) --         1: stop the timer so that we're not tryin to access deleted stuff
			speedrun.remove_timer(player) -- 2: remove the timer
            player:respawn() --              3: respawn the player
            speedrun.add_timer(player) --    4: add a new timer
            speedrun.start(player) --        5: start the new timer
        elseif params[1] == "help" then
            return false -- give the usage text
        end
    end,
})