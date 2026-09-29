#!/bin/bash

HERDR_CONFIG="$HOME/.config/herdr"
DOTFILES_HERDR="$HOME/.dotfiles/herdr"

mkdir -p "$HERDR_CONFIG"

if [ -e "$HERDR_CONFIG" ]; then
    echo "Removing existing herdr config: $HERDR_CONFIG"
    rm -rf "$HERDR_CONFIG"
fi

echo "Creating symlink: $HERDR_CONFIG -> $DOTFILES_HERDR"
ln -s "$DOTFILES_HERDR" "$HERDR_CONFIG"
