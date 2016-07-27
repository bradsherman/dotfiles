#!/bin/bash

# Quickly create a new cpp file 

if [ -z $1 ]; then
    echo "Usage: $0 filename (without extension)"
    exit 1
fi

newfile=$1
cwd=$(pwd)
filename=${cwd}/${newfile}.cpp

[[ -f $filename ]] && printf "%s already exists\n" $filename && exit 1

touch $filename
printf "#include <iostream>\n" > $filename
printf "using namespace std;\n" >> $filename
printf "\nint main() {\n\n}" >> $filename

exit 0
