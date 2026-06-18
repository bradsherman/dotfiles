#!/bin/bash

if makoctl mode | grep -q "do-not-disturb"; then
    makoctl mode -r do-not-disturb
    notify-send "Notifications unmuted"
else
    notify-send "Silencing notifications"
    sleep 1
    makoctl mode -a do-not-disturb
fi
