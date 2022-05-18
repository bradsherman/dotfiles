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
    echo "Deploying application: $1"
    params=()
    for var in "${@:4}"; do
        params+=("$var")
    done
    cp "${params[@]}" $2 $3
  else
    echo "Skipping application: $1"
  fi
}

copy_config "alacritty" ./alacritty ~/.config "-r"
copy_config "display_handler" ./display_handler ~/.local/bin/
copy_config "dunst" ./dunst ~/.config "-r"
copy_config "fontconfig" ./fontconfig ~/.config "-r"
copy_config "fonts" ./fonts.conf ~/.fonts.conf
copy_config "gitconfig" ./gitconfig ~/.gitconfig
copy_config "i3" ./i3 ~/.config "-r"
copy_config "nvim" ./nvim ~/.config "-r"
copy_config "polybar" ./polybar ~/.config "-r"
copy_config "sway" ./sway ~/.config "-r"
copy_config "waybar" ./waybar ~/.config "-r"
copy_config "rofi-solarized-light" ./solarized-light.rasi ~/.local/share/rofi/themes/
copy_config "rofi-nord" ./nord.rasi ~/.local/share/rofi/themes/
copy_config "tmux" ./tmux.conf ~/.tmux.conf
copy_config "zsh" ./zsh/zshrc ~/.zshrc
