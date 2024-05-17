#!/usr/bin/env sh

# Terminate already running bar instances
# killall -q waybar
ps aux | grep waybar | grep -v nvim | grep -v waybar.sh | awk '{print $2}' | xargs kill -9

# Wait until the processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; done

# Launch main
/home/bsherman/.nix-profile/bin/waybar
