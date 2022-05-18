#!/bin/bash

function usage () {
    echo "usage: $0 [-h] [-a (application)]"
    echo ""
    echo "-h help"
    echo "-a application to update"
}

app="all"

while getopts ":ha:" option; do
    case ${option} in
        h ) usage; exit;;
        a ) app=$OPTARG;;
        ? ) echo "error: option -$OPTARG is not implemented"; usage; exit;;
    esac
done
shift $((OPTIND -1))

# first arg is app
# second arg is src
# third arg is dst
# any other args are passed to 'cp'
function copy_config () {
  if [[ $app == "all" || $app == $1 ]]; then
    echo "Updating application: $1"
    params=()
    for var in "${@:4}"; do
        params+=("$var")
    done
    cp "${params[@]}" $2 $3
  else
    echo "Skipping application: $1"
  fi
}

copy_config "alacritty" ~/.config/alacritty . "-r"
copy_config "display_handler" ~/.local/bin/display_handler .
copy_config "dunst" ~/.config/dunst . "-r"
copy_config "fontconfig" ~/.config/fontconfig . "-r"
copy_config "fonts" ~/.fonts.conf fonts.conf
copy_config "gitconfig" ~/.gitconfig gitconfig
copy_config "i3" ~/.config/i3 . "-r"
copy_config "nvim" ~/.config/nvim . "-r"
copy_config "polybar" ~/.config/polybar . "-r"
copy_config "sway" ~/.config/sway . "-r"
copy_config "waybar" ~/.config/waybar . "-r"
copy_config "rofi-solarized-light" ~/.local/share/rofi/themes/solarized-light.rasi .
copy_config "rofi-nord" ~/.local/share/rofi/themes/nord.rasi .
copy_config "tmux" ~/.tmux.conf tmux.conf
copy_config "zsh" ~/.zshrc zsh/zshrc
