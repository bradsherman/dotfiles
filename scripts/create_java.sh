#!/bin/bash

# Quickly create a new java file 

if [ -z $1 ]; then
    echo "Usage: $0 filename (without extension)"
    exit 1
fi

newfile=$1
cwd=$(pwd)
filename=${cwd}/${newfile}.java

[[ -f $filename ]] && printf "%s already exists\n" $filename && exit 1

touch $filename
printf "public class $newfile {\n" > $filename
printf "\n\tpublic static void main(String[] args) {\n\n\t}\n\n}" >> $filename
# printf "\t%s" "public static void main(String[] args) {" >> $filename

exit 0
