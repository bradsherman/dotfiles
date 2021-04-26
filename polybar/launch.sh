#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch top and bottom bars
echo "---" | tee -a /tmp/polybartop.log /tmp/polybarbottom.log
polybar top 2>&1 | tee -a /tmp/polybartop.log & disown
polybar bottom 2>&1 | tee -a /tmp/polybarbottom.log & disown

echo "Bars launched..."
