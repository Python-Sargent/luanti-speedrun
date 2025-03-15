# luanti-speedrun
Speedrunning tools mod for Luanti

## Timer

The timer is a green HUD element that automatically shows up in the top left of your screen when you join the game. It automatically counts the time using globalsteps.

## Speedrun Chatcommand

There is a command to use when speedrunnning that gives you a few options.

`/speedrun` allows you to perform actions interacting with your speedrun.

`/speedrun restart` will reset your timer, by removing it, respawning the player, and then adding a new one.

`/speedrun finish` will stop the timer and save the time in the session times if it is better than any other times in that session.
Each session the times are reset, leaving the game will not reset the session times if you are in multiplayer and the server is still running.

### Restarting

When you restart currently you perform the player respawn method, some games require another method to be called in order to correctly restart.
Eventually I will add the ability to automatically check what game you are playing and make the correct calls to fully restart your run.

## Words and Jargon

## Session
A session is your particular session, not the time the server is up.

## Run
A run is a single run in your session.
