#!/usr/bin/env bash


echo "======================"
echo "Installing zsh plugins"
echo "======================"

PLUGINS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

echo "Installing zsh-vi-mode..."
git clone https://github.com/jeffreytse/zsh-vi-mode \
  "$PLUGINS_DIR"/zsh-vi-mode

echo "Installing fzf-tab..."
git clone https://github.com/Aloxaf/fzf-tab "$PLUGINS_DIR"/fzf-tab

echo "Installing fast-syntax-highlighting..."
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  "$PLUGINS_DIR"/fast-syntax-highlighting

echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR"/zsh-autosuggestions

echo "Installing zsh-nix-shell..."
git clone https://github.com/chisui/zsh-nix-shell.git "$PLUGINS_DIR"/nix-shell

echo "Installing nix-zsh-completions..."
git clone git@github.com:nix-community/nix-zsh-completions.git "$PLUGINS_DIR"/nix-zsh-completions
