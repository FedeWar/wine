# Runs a game through Wine and Steam with the Pulseaudio fix.
# Usage:
#	launch-game.sh <int game_id> <string process_name> <bool use_optirun> <bool keep_logs>

# +----Name-----+--ID---+-----Process-----+
# | Skyrim      | 72850 | TESV.exe        |
# | Bulletstorm | 99810 | ShippingPC-Stor |
# +-------------+-------+-----------------+

# Fixes the audio cracklings in some games
# $1 process name
function audiofix {

	# Waits for Steam to start
	sleep 30;

	# Waits for the game to start
	while ! pgrep -x $1 > /dev/null; do
		# If the game won't start this will avoid an endless loop
		if ! pgrep -x "steam.exe" > /dev/null; then
			exit 0;
		else
			sleep 10;
		fi
	done
	# echo "[DEBUG]: $1 running."

	# Fixes audio until the game closes
	while pgrep -x $1 > /dev/null; do
		pasuspender sleep 0.02;
		sleep 60;
	done
	# echo "[DEBUG]: $1 terminated."
}

# Launches a game through Wine and Steam
# $1 game's id in Steam
# $2 do I have to keep logs?
function winerun {
	# keep_logs == true
	if [ "$2" -eq "1" ]; then
		# echo "[DEBUG]: keep_logs = true"
		sudo chmod 777 /var/log
		nohup wine C:\\windows\\command\\start.exe steam://rungameid/$1 > /var/log/$1.log &
	else
		# echo "[DEBUG]: keep_logs = false"
		nohup wine C:\\windows\\command\\start.exe steam://rungameid/$1 > /dev/null &
	fi
}

# Recursive script
if [ "$3" -eq "1" ]; then
	# echo "[DEBUG]: is_optirun = true"
	optirun bash $0 $1 $2 0 $4
else
	# echo "[DEBUG]: is_optirun = false"
	winerun $1 $4
	audiofix $2
fi

