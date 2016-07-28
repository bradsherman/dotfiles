#!/bin/bash

# Install dotfiles on a new system

DF_ROOT=$(pwd)

# exit if any pipeline exits with non-zero status
set -e

# make pretty prompts
info (){
     printf " [ \033[00;34m..\033[0m ] $1"   
}

user (){
    printf "\r [ \033[0;33m?\033[0m ] $1"
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

    for src in $(find "$DF_ROOT" -maxdepth 2 -name '*.slink')
    do
        dst="$HOME/.$(basename "${src%.*}")"
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

    # install plugins
    mkdir -p "$home/.vim/plugin"

    for src in $(find "$df_root/vim" -maxdepth 4 -name '*.vim')
    do
        dst="$home/.vim/plugin/$(basename "$src")"
        link_file "$src" "$dst"
    done   

    info "installing plugins"
    sleep 2
    vim -c "plugininstall" -c "q" -c "q"
}

install_nvimfiles () {
    info "installing neovimfiles"

    local overwrite_all=false skip_all=false

    # install plugins
    mkdir -p "$home/.config/nvim/"

    for src in $(find "$df_root/nvim" -maxdepth 4 -name '*.vim')
    do
        dst="$home/.config/nvim/$(basename "$src")"
        link_file "$src" "$dst"
    done   

    info "installing plugins"
    sleep 2
    nnvim -c "plugininstall" -c "q" -c "q"
}

install_dotfiles
install_scripts
install_vimfiles

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
