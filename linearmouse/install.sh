#!/bin/bash
# LinearMouse — macOS only.
# Works around a macOS 26 bug in the discrete scroll-wheel path where fast
# scrolling emits wrong-signed deltas (~1 event in 4 goes backwards). Enabling
# LinearMouse's smoothed scrolling converts discrete wheel ticks into
# continuous deltas, bypassing the broken accelerator. Trackpads are unaffected
# by the bug because they already emit continuous events.
[ "$(uname -s)" = "Darwin" ] || exit 0

CONFIG_LINEARMOUSE="$HOME/.config/linearmouse"
DOTFILES_LINEARMOUSE="$HOME/.dotfiles/linearmouse"

mkdir -p "$HOME/.config"

# Already linked - nothing to do.
if [ "$(readlink "$CONFIG_LINEARMOUSE")" = "$DOTFILES_LINEARMOUSE" ]; then
    echo "linearmouse config already linked"
    exit 0
fi

# Back up anything real that is already there rather than destroying it.
if [ -e "$CONFIG_LINEARMOUSE" ] || [ -L "$CONFIG_LINEARMOUSE" ]; then
    backup="$CONFIG_LINEARMOUSE.backup.$(date +%Y%m%d%H%M%S)"
    echo "Backing up existing linearmouse config: $backup"
    mv "$CONFIG_LINEARMOUSE" "$backup"
fi

echo "Creating symlink: $CONFIG_LINEARMOUSE -> $DOTFILES_LINEARMOUSE"
ln -s "$DOTFILES_LINEARMOUSE" "$CONFIG_LINEARMOUSE"
