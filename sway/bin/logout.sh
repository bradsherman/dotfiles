#!/usr/bin/env bash
# Manage logout with rofi
option=$(echo -e "suspend\nlock screen\nlogout\nreboot\npoweroff\nKill user $USER" | wofi --show dmenu -p \> )
case $option in
    suspend)
        /usr/bin/systemctl suspend #-then-hibernate
        ;;
    'lock screen')
        swaylock
        ;;
    logout)
        swaynag -t warning -m 'Are you sure you  want to exit sway? This will end your session.' -b 'Yes, exit sway' 'swaymsg exit'
        ;;
    reboot)
        /usr/bin/systemctl reboot
        ;;
    poweroff)
        /usr/bin/systemctl poweroff
        ;;
    "kill user $USER")
        loginctl kill-user "$USER"
        ;;
esac
