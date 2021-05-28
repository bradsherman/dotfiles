#!/bin/bash


cp zsh/zshrc ~/.zshrc

cp -r ./alacritty ~/.config/
cp -r ./dunst ~/.config/
cp -r ./i3 ~/.config/
cp -r ./nvim ~/.config/
cp -r ./polybar ~/.config/
cp -r ./fontconfig ~/.config/

cp -r ./display_handler ~/.local/bin/
cp ./solarized-light.rasi ~/.local/share/rofi/themes/

cp /fonts.conf ~/.fonts.conf
