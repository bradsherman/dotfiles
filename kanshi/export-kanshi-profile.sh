#!/bin/bash
# Script to generate kanshi profile from current display configuration
# Usage: ./export-kanshi-profile.sh profile_name

PROFILE_NAME=${1:-"current"}

echo "# Generated kanshi profile: $PROFILE_NAME"
echo "profile $PROFILE_NAME {"

swaymsg -t get_outputs | jq -r '.[] | select(.active == true) |
    "    output " + .name +
    " mode " + (.current_mode.width | tostring) + "x" + (.current_mode.height | tostring) +
    (if .current_mode.refresh then "@" + (.current_mode.refresh/1000 | floor | tostring) else "" end) +
    " position " + (.rect.x | tostring) + "," + (.rect.y | tostring) +
    " scale " + (.scale | tostring)'

echo "}"
