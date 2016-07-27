#!/bin/bash

# Install dotfiles on a new system

old_dir=~/old_dotfiles
echo "Creating $old_dir for backup files"
[[ -d $old_dir ]] && rm -rf $old_dir
mkdir $old_dir

##################################
#####     BASH
##################################

echo "Setting up ~/.bashrc..."
source=~/dotfiles/bashrc
destination=~/.bashrc
[[ -f $destination ]] && rm -f $destination
ln -sf $source $destination

##################################
#####    XMODMAP
##################################

echo "Setting up ~/.Xmodmap"
source=~/dotfiles/Xmodmap
destination=~/.Xmodmap
[[ -f $destination ]] && rm -f $destination
ln -s $source $destination

##################################
#####     i3
##################################

echo "Setting up ~/.i3..."
source=~/dotfiles/config
destination=~/.i3/config
[[ ! -d ~/.i3 ]] && echo "Making ~/.i3 directory..." && mkdir ~/.i3
[[ -f $destination ]] && rm -f $destination
ln -s $source $destination

source=~/dotfiles/i3blocks.conf
destination=~/.i3/i3blocks.conf
[[ -f $destination ]] && rm -f $destination
ln -s $source $destination

source=~/dotfiles/i3status.conf
destination=~/.i3/i3status.conf
[[ -f $destination ]] && rm -f $destination
ln -s $source $destination

##################################
#####     NVIM
##################################

echo "Setting up ~/config/nvim/init.vim"
source=~/dotfiles/nvim/init.vim
destination=~/.config/nvim/init.vim
[[ -f $destination ]] && rm -f $destination
if [[ ! -d ~/.config/nvim/bundle/Vundle.vim ]]
then
	echo "Cloning Vundle repository..."
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
fi
ln -s $source $destination

##################################
#####     VIM   
##################################

echo "Setting up ~/.vimrc..."
source=~/dotfiles/vim/vimrc
destination=~/.vimrc
[[ -f $destination ]] && rm -f $destination
if [[ ! -d ~/.vim/bundle/Vundle.vim ]]
then
	echo "Cloning Vundle repository..."
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
ln -s $source $destination
# echo "Setting up custom plugins in ~/.vim/plugin"
# source=~/dotfiles/vim/plugin/*
# destination=~/.vim/plugin/
# for file in $source
# do
#     echo $file
#     [[ -f $destination ]] && rm -f $destination
#     ln -s $file $destination
# done

echo "Would you like to install your vim plugins now? (y/n)"
read response
[[ $response == "y" ]] && vim -c ":PluginInstall"
