#!/bin/bash

NVIM_CONFIG="$HOME/.config/nvim"
DOTFILES_NVIM="$HOME/.dotfiles/nvim"

if [ -e "$NVIM_CONFIG" ]; then
    echo "Removing existing Neovim config: $NVIM_CONFIG"
    rm -rf "$NVIM_CONFIG"
fi

echo "Creating symlink: $NVIM_CONFIG -> $DOTFILES_NVIM"
ln -s "$DOTFILES_NVIM" "$NVIM_CONFIG"
