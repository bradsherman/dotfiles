#!/bin/bash

# Quickly create a new python script

if [ -z $! ]; then
    echo "Usage: $0 filename (without extension)"
    exit 1
fi

newfile=$1
cwd=$(pwd)
filename=${cwd}/${newfile}.py

[[ -f $filename ]] && printf "%s already exists\n" $filename && exit 1

touch $filename
chmod +x $filename
printf "#!/usr/bin/env python2.7\n" > $filename
vim $filename

exit 0
