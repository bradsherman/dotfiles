#!/bin/bash

# Install dotfiles on a new system

cd ~/dotfiles
DF_ROOT=$(pwd)

# exit if any pipeline exits with non-zero status
# set -e

# make pretty prompts
info (){
     printf " [ \033[00;34m..\033[0m ] $1\n"   
}

user (){
    printf "\r [ \033[0;33m?\033[0m ] $1\n"
}

success (){
    printf "\r\033[2K [ \033[00;32mOK\033[0m ] $1\n"
}

fail (){
    printf "\r\033[2K [\033[0;31mFAIL\033[0m] $1\n"
    exit
}

link_file() {
    local src=$1
    local dst=$2
    local overwrite= action= skip=
    # if dst exists somehow, figure out what to do
    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
    then
        if [ "$overwrite_all" == "false" ] && [ "$skip_all" == "false" ]
        then
            # see if dst is a link
            local currentSrc="$(readlink $dst)"

            if [ "$currentSrc" == "$src" ]
            then
                skip=true
            else
            # if not, skip or overwrite it
                user "File already exists: $(basename "$src"), what do you want
                to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all?"

                # only let user input one char
                read -n 1 choice

                case "$choice" in
                    o)
                        overwrite=true;;
                    O)
                        overwrite_all=true;;
                    s)
                        skip=true;;
                    S)
                        skip_all=true;;
                    *)
                        ;;
                esac
            fi
        fi

        # use overwrite unless it is not set
        overwrite=${overwrite:-$overwrite_all}
        # use skip unless it is not set
        skip=${skip:-$skip_all}

        if [ "$overwrite" == "true" ]
        then
            rm -rf "$dst"
            success "removed $dst"
        fi

        if [ "$skip" == "true" ]
        then
            success "skipped $src"
        fi

    fi
    
    # if file does not exist then just link it right away
    if [ "$skip" != "true" ]
    then
        ln -s "$1" "$2"
        success "linked $1 to $2"
    fi
}

install_dotfiles () {
    info "installing dotfiles"

    local overwrite_all=false skip_all=false

    for src in $(find "$DF_ROOT" -maxdepth 1 -name '*.slink')
    do
        dst="$HOME/.$(basename "${src%.*}")"
        link_file "$src" "$dst"
    done
}

install_i3files () {
    info "installing i3files"

    local overwrite_all=false skip_all=false

    for src in $(find "$DF_ROOT/i3" -maxdepth 1 -name '*.slink')
    do
        dst="$HOME/.i3/$(basename "${src%.*}")"
        link_file "$src" "$dst"
    done
}

install_scripts () {
    info "installing scripts"

    local overwrite_all=false skip_all=false

    for src in $(find "$DF_ROOT/scripts" -maxdepth 1 -name '*.slink')
    do
        dst="/usr/local/bin/$(basename "${src%.*}")"
        link_file "$src" "$dst"
    done

}

install_vimfiles () {
    info "installing vimfiles"

    local overwrite_all=false skip_all=false
    if [[ ! -d ~/.vim/bundle/Vundle.vim ]]
    then
        echo "Cloning Vundle repository..."
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi

    # install syntax 
    if [ ! -d "$HOME/.vim/syntax" ]
    then
        mkdir -p "$HOME/.vim/syntax"
        chown -R "$SUDO_USER" "$HOME/.vim/syntax"
        chgrp -R "$SUDO_USER" "$HOME/.vim/syntax"
    fi

    for src in $(find "$DF_ROOT/vim/syntax" -maxdepth 1 -name '*.vim')
    do
        dst="$HOME/.vim/syntax/$(basename "$src")"
        link_file "$src" "$dst"
    done

    # install plugins
    if [ ! -d "$HOME/.vim/plugin" ]
    then
        mkdir -p "$HOME/.vim/plugin"
        chown -R "$SUDO_USER" "$HOME/.vim/plugin"
        chgrp -R "$SUDO_USER" "$HOME/.vim/plugin"
    fi

    for src in $(find "$DF_ROOT/vim/plugin" -maxdepth 1 -name '*.vim')
    do
        dst="$HOME/.vim/plugin/$(basename "$src")"
        link_file "$src" "$dst"
    done   

    info "installing vim plugins"
    sleep 2
    /usr/bin/vim -c "PlugInstall" -c "q" -c "q"
}

install_nvimfiles () {

    info "installing neovimfiles"

    if ! [ -e "/usr/bin/nvim" ] 
    then
        fail "Please install neovim before continuing"
    fi
    if [[ ! -d ~/.config/nvim/bundle/Vundle.vim ]]
    then
	    echo "Cloning Vundle repository..."
	    git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
    fi

    local overwrite_all=false skip_all=false

    # install plugins
    if [ ! -d "$HOME/.config/nvim" ]
    then
        mkdir -p "$HOME/.config/nvim/" 
        chown -R "$SUDO_USER" "$HOME/.config/nvim"
        chgrp -R "$SUDO_USER" "$HOME/.config/nvim"
    fi

    for src in $(find "$DF_ROOT/nvim" -maxdepth 1 -name '*.vim')
    do
        dst="$HOME/.config/nvim/$(basename "$src")"
        link_file "$src" "$dst"
    done   

    for src in $(find "$DF_ROOT/nvim/plugin" -maxdepth 1 -name '*.vim')
    do
        dst="$HOME/.config/nvim/plugin/$(basename "$src")"
        link_file "$src" "$dst"
    done   

    for src in $(find "$DF_ROOT/nvim/syntax" -maxdepth 1 -name '*.vim')
    do
        dst="$HOME/.config/nvim/syntax/$(basename "$src")"
        link_file "$src" "$dst"
    done

    info "installing neovim plugins"
    sleep 2
    /usr/bin/nvim -c ":PlugInstall" -c "q" -c "q"
}

install_programs () {
    info "installing programs"

    user "Would you like to install all programs? (y/n)"
    read -n 1 choice

    # only do this on ubuntu since we are using apt-get,
    # and if the user wants to install everything
    if [[ "$(uname -n)" == "ubuntu" && "$choice" == "y" ]]
    then
        local progfile="ubuntuprograms.txt"

        # read in the file using a file descriptor,
        # since we want to take standard input as well
        while read -r line <&9
        do
            # if we are installing, find out what it is
            program=$(echo "$line" | grep "install" | awk '{print $4}')
            # only prompt user for installing programs
            if [ ! -z $program ]
            then
                user "You are about to install $program, continue? (y/n)"
                read -s -n 1 choice
                if [ "$choice" == "y" ]
                then
                    $line
                else
                    continue
                fi
            fi
        done 9< $progfile
    fi

}

# make sure we are root, since we need to create symlinks to /usr/bin
if [[ "$EUID" -ne 0 ]]
then
    fail "This script must be run as root"
fi

install_programs
install_dotfiles
install_i3files
install_scripts
install_vimfiles
install_nvimfiles

echo ""
success "Installation completed!"


# old_dir=~/old_dotfiles
# echo "Creating $old_dir for backup files"
# [[ -d $old_dir ]] && rm -rf $old_dir
# mkdir $old_dir
# 
# ##################################
# #####     BASH
# ##################################
# 
# echo "Setting up ~/.bashrc..."
# source=~/dotfiles/bashrc
# destination=~/.bashrc
# [[ -f $destination ]] && rm -f $destination
# ln -sf $source $destination
# 
# ##################################
# #####    XMODMAP
# ##################################
# 
# echo "Setting up ~/.Xmodmap"
# source=~/dotfiles/Xmodmap
# destination=~/.Xmodmap
# [[ -f $destination ]] && rm -f $destination
# ln -s $source $destination
# 
# ##################################
# #####     i3
# ##################################
# 
# echo "Setting up ~/.i3..."
# source=~/dotfiles/config
# destination=~/.i3/config
# [[ ! -d ~/.i3 ]] && echo "Making ~/.i3 directory..." && mkdir ~/.i3
# [[ -f $destination ]] && rm -f $destination
# ln -s $source $destination
# 
# source=~/dotfiles/i3blocks.conf
# destination=~/.i3/i3blocks.conf
# [[ -f $destination ]] && rm -f $destination
# ln -s $source $destination
# 
# source=~/dotfiles/i3status.conf
# destination=~/.i3/i3status.conf
# [[ -f $destination ]] && rm -f $destination
# ln -s $source $destination

# ##################################
# #####     NVIM
# ##################################
# 
# echo "Setting up ~/config/nvim/init.vim"
# source=~/dotfiles/nvim/init.vim
# destination=~/.config/nvim/init.vim
# [[ -f $destination ]] && rm -f $destination
# if [[ ! -d ~/.config/nvim/bundle/Vundle.vim ]]
# then
# 	echo "Cloning Vundle repository..."
# 	git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
# fi
# ln -s $source $destination
# 
# ##################################
# #####     VIM   
# ##################################
# 
# echo "Setting up ~/.vimrc..."
# source=~/dotfiles/vim/vimrc
# destination=~/.vimrc
# [[ -f $destination ]] && rm -f $destination
# if [[ ! -d ~/.vim/bundle/Vundle.vim ]]
# then
# 	echo "Cloning Vundle repository..."
# 	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# fi
# ln -s $source $destination
# # echo "Setting up custom plugins in ~/.vim/plugin"
# # source=~/dotfiles/vim/plugin/*
# # destination=~/.vim/plugin/
# # for file in $source
# # do
# #     echo $file
# #     [[ -f $destination ]] && rm -f $destination
# #     ln -s $file $destination
# # done
# 
# echo "Would you like to install your vim plugins now? (y/n)"
# read response
# [[ $response == "y" ]] && vim -c ":PluginInstall" && nvim -c ":PluginInstall"
# 
