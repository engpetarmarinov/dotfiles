#!/bin/bash

SSH_CONFIG="$HOME/.ssh/config"
DOTFILES_SSH_CONFIG="$HOME/.dotfiles/ssh/config"

mkdir -p "$HOME/.ssh"

if [ -e "$SSH_CONFIG" ] || [ -L "$SSH_CONFIG" ]; then
    echo "Removing existing ssh config: $SSH_CONFIG"
    rm -f "$SSH_CONFIG"
fi

echo "Creating symlink: $SSH_CONFIG -> $DOTFILES_SSH_CONFIG"
ln -s "$DOTFILES_SSH_CONFIG" "$SSH_CONFIG"
chmod 600 "$DOTFILES_SSH_CONFIG"
