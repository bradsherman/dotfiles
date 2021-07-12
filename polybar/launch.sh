#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch top and bottom bars
echo "---" | tee -a /tmp/polybartop.log /tmp/polybarbottom.log
polybar laptop 2>&1 | tee -a /tmp/polybarlaptop.log & disown
polybar external 2>&1 | tee -a /tmp/polybarexternal.log & disown

echo "Bars launched..."
