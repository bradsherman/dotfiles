#!/usr/bin/env bash

function usage () {
    echo "usage: $0 [-h] [-a (application)]"
    echo ""
    echo "-h help"
    echo "-a application to update"
    echo "APPLICATION OPTIONS:"
    echo "  - aerospace"
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
    echo "  - nvim-rocks"
    echo "  - pgcli"
    echo "  - starship"
    echo "  - git-ignore"
    echo "  - polybar"
    echo "  - psql"
    echo "  - readline"
    echo "  - rofi-solarized-light"
    echo "  - rofi-nord"
    echo "  - sway"
    echo "  - swayidle"
    echo "  - swaylock"
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
    echo "Deploying application: $1"
    params=()
    for var in "${@:4}"; do
        params+=("$var")
    done
    mkdir -p "$(dirname "$3")"
    rsync --recursive --delete-after --inplace "${params[@]}" "$2" "$3"
  else
    echo "Skipping application: $1"
  fi
}

copy_config "alacritty" ./alacritty ~/.config
copy_config "display_handler" ./display_handler ~/.local/bin/
copy_config "dunst" ./dunst ~/.config
copy_config "fontconfig" ./fontconfig ~/.config
copy_config "fonts" ./fonts.conf ~/.fonts.conf
copy_config "ghostty" ./ghostty ~/.config
copy_config "gitconfig" ./gitconfig ~/.gitconfig
copy_config "i3" ./i3 ~/.config
copy_config "jj" ./jj ~/.config --exclude=repos/
copy_config "kanshi" ./kanshi ~/.config
copy_config "mako" ./mako ~/.config
copy_config "nix" ./nixos ~/nixos
copy_config "nvim" ./nvim ~/.config --exclude=.claude/
copy_config "nvim-rocks" ./nvim-rocks ~/.config/nvim-rocks
copy_config "nvim-next" ./nvim-next ~/.config/nvim-next
copy_config "polybar" ./polybar ~/.config
copy_config "psql" ./psql/psqlrc ~/.psqlrc
copy_config "readline" ./readline/inputrc ~/.inputrc
copy_config "rofi-solarized-light" ./solarized-light.rasi ~/.local/share/rofi/themes/
copy_config "rofi-nord" ./nord.rasi ~/.local/share/rofi/themes/
copy_config "sway" ./sway ~/.config
copy_config "swaylock" ./swaylock ~/.config
copy_config "swayidle" ./swayidle ~/.config
copy_config "tmux" ./tmux.conf ~/.tmux.conf
copy_config "update-nvim" ./update-neovim.sh ~/.local/bin/
copy_config "waybar" ./waybar ~/.config
copy_config "wezterm" ./.wezterm.lua ~/.wezterm.lua
copy_config "wofi" ./wofi ~/.config
copy_config "wofi-bluetooth" ./wofi-bluetooth ~/.local/bin/
copy_config "zellij" ./zellij ~/.config
copy_config "zsh" ./zsh/zshrc ~/.zshrc

copy_config "starship" ./starship.toml ~/.config/starship.toml
copy_config "pgcli" ./pgcli/config ~/.config/pgcli/config
copy_config "git-ignore" ./git/ignore ~/.config/git/ignore

copy_config "aerospace" ./aerospace.toml ~/.aerospace.toml
