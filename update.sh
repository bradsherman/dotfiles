#!/usr/bin/env bash

function usage () {
    echo "usage: $0 [-h] [-a (application)]"
    echo ""
    echo "-h help"
    echo "-a application to update"
    echo "APPLICATION OPTIONS:"
    echo "  - alacritty"
    echo "  - display_handler"
    echo "  - dunst"
    echo "  - fontconfig"
    echo "  - fonts"
    echo "  - ghostty"
    echo "  - gitconfig"
    echo "  - i3"
    echo "  - jj"
    echo "  - kanshi"
    echo "  - mako"
    echo "  - nix"
    echo "  - nvim"
    echo "  - nvim-rocks"
    echo "  - polybar"
    echo "  - rofi-solarized-light"
    echo "  - rofi-nord"
    echo "  - tmux"
    echo "  - update-nvim"
    echo "  - waybar"
    echo "  - wezterm"
    echo "  - wofi"
    echo "  - wofi-bluetooth"
    echo "  - zellij"
    echo "  - zsh"
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
# any other args are passed to 'rsync'
function copy_config () {
  if [[ $app == "all" || $app == "$1" ]]; then
    echo "Updating application: $1"
    params=()
    for var in "${@:4}"; do
        params+=("$var")
    done
    if [[ -d "$2" || -f "$2" ]]; then
      rsync --recursive --delete-after --inplace "${params[@]}" "$2" "$3"
    fi
  else
    echo "Skipping application: $1"
  fi
}

copy_config "alacritty" ~/.config/alacritty .
copy_config "display_handler" ~/.local/bin/display_handler .
copy_config "dunst" ~/.config/dunst .
copy_config "fontconfig" ~/.config/fontconfig .
copy_config "fonts" ~/.fonts.conf fonts.conf
copy_config "ghostty" ~/.config/ghostty .
copy_config "gitconfig" ~/.gitconfig gitconfig
copy_config "i3" ~/.config/i3 .
copy_config "jj" ~/.config/jj .
copy_config "kanshi" ~/.config/kanshi .
copy_config "mako" ~/.config/mako .
copy_config "nix" ~/nixos .
copy_config "nvim" ~/.config/nvim .
copy_config "nvim-rocks" ~/.config/nvim-rocks .
copy_config "polybar" ~/.config/polybar .
copy_config "rofi-solarized-light" ~/.local/share/rofi/themes/solarized-light.rasi .
copy_config "rofi-nord" ~/.local/share/rofi/themes/nord.rasi .
copy_config "sway" ~/.config/sway .
copy_config "swaylock" ~/.config/swaylock .
copy_config "tmux" ~/.tmux.conf tmux.conf
copy_config "update-nvim" ~/.local/bin/update-neovim.sh .
copy_config "waybar" ~/.config/waybar .
copy_config "wezterm" ~/.config/wezterm .
copy_config "wofi" ~/.config/wofi .
copy_config "wofi-bluetooth" ~/.local/bin/wofi-bluetooth .
copy_config "zellij" ~/.config/zellij .
copy_config "zsh" ~/.zshrc zsh/zshrc
