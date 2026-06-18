#!/bin/bash
# swayidle-toggle.sh

if pgrep -x swayidle > /dev/null; then
    notify-send "Pausing swayidle"
    killall swayidle
else
    notify-send "Resuming swayidle"
    swayidle -w -C "$HOME/.config/swayidle/config" &
fi
