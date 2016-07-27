#!/bin/bash

# Quickly create a new bash script

if [ -z $1 ]; then
    echo "Usage: $0 filename (without extension)"
    exit 1
fi

newfile=$1
cwd=$(pwd)
filename=${cwd}/${newfile}.sh

[[ -f $filename ]] && printf "%s already exists\n" $filename && exit 1

touch $filename
chmod +x $filename
printf "%s\n" "#!/bin/bash" > $filename
vim $filename

exit 0
