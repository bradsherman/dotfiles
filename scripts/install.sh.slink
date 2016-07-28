#!/bin/bash

# install the generation scripts

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root to put the scripts in your path"
    exit 1
fi

files=~/dotfiles/scripts/*
dir=~/dotfiles/scripts/

for file in $files; do
    source=$(basename $file)
    destination=/usr/bin/${source}
    if [ $file == ~/dotfiles/scripts/install.sh ]; then
        continue
    fi
    if [ -f $destination ];then
        echo "$destination exists, would you like to replace it? (y/n): "
        read choice
        if [ $choice == "y" ]; then
            cp -v $source $destination
        else
            continue
        fi
    fi
done

exit 0
