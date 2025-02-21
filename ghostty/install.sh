#!/bin/bash

CONFIG_GHOSTTY="$HOME/.config/ghostty"
DOTFILES_GHOSTTY="$HOME/.dotfiles/ghostty"

mkdir -p "$CONFIG_GHOSTTY"

if [ -e "$CONFIG_GHOSTTY" ]; then
    echo "Removing existing ghostty config: $CONFIG_GHOSTTY"
    rm -rf "$CONFIG_GHOSTTY"
fi

echo "Creating symlink: $CONFIG_GHOSTTY -> $DOTFILES_GHOSTTY"
ln -s "$DOTFILES_GHOSTTY" "$CONFIG_GHOSTTY"
