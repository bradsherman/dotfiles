#!/bin/sh
# shellcheck disable=3024,3037

copy_area="Screenshot area to clipboard"
area_to_file="Screenshot area to file"
all_displays_to_file="Screenshot all displays to file"
copy_all_displays="Screenshot all displays to clipboard"
copy_area_ocr="Screenshot area to copy text"
copy_window="Screenshot focused window to clipboard"
window_to_file="Screenshot focused window to file"
copy_monitor="Screenshot focused monitor to clipboard"
monitor_to_file="Screenshot focused monitor to file"

# Store each option in a single string seperated by newlines.
options="${copy_area}\n${area_to_file}\n${all_displays_to_file}\n${copy_all_displays}\n${copy_area_ocr}\n${copy_window}\n${window_to_file}\n${copy_monitor}\n${monitor_to_file}"

# Prompt the user with wofi.
choice="$(echo "$options" | rofi -width 600 -dmenu -p \>)"

# Make sure that all pictures are saved in the screenshots folder.
stamp=$(date +'%s_grim.png')
output="$HOME/Pictures/screenshots/$stamp"
cmd="grim ${output}"

case $choice in
    "$copy_area")
        grim -g "$(slurp)" - | wl-copy
        ;;
    "$area_to_file")
        ${cmd} -g "$(slurp)"
        ;;
    "$all_displays_to_file")
        ${cmd}
        ;;
    "${copy_all_displays}")
        grim - | wl-copy
        ;;
    "$copy_area_ocr")
        ${cmd} -g "$(slurp)" - | tesseract - - | wl-copy
        ;;
    "$copy_window")
        ${cmd} -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" - | wl-copy
        ;;
    "$window_to_file")
        ${cmd} -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')"
        ;;
    "$copy_monitor")
        ${cmd} -o "$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')" - | wl-copy
        ;;
    "$monitor_to_file")
        ${cmd} -o "$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')"
        ;;
esac
