#!/bin/bash

if makoctl mode | grep -q "do-not-disturb"; then
    echo '{"text": "", "tooltip": "Notifications muted", "class": "muted"}'
else
    echo '{"text": "", "tooltip": "Notifications active", "class": "unmuted"}'
fi
