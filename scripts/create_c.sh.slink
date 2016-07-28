#!/bin/bash

# Quickly create a new c file 

if [ -z $1 ]; then
    echo "Usage: $0 filename (without extension)"
    exit 1
fi

newfile=$1
cwd=$(pwd)
filename=${cwd}/${newfile}.c

[[ -f $filename ]] && printf "%s already exists\n" $filename && exit 1

touch $filename
printf "#include <stdio.h>\n" > $filename
printf "\nint main() {\n\n}" >> $filename

exit 0
