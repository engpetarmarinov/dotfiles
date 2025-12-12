#!/bin/sh
#
# VSCode installation script
# This installs VSCode configuration files

set -e

echo "Installing VSCode configuration..."

# Determine the VSCode config directory based on OS
if [ "$(uname -s)" = "Darwin" ]; then
  VSCODE_DIR="$HOME/Library/Application Support/Code/User"
else
  VSCODE_DIR="$HOME/.config/Code/User"
fi

# Create VSCode config directory if it doesn't exist
mkdir -p "$VSCODE_DIR"

# Get the directory where this script is located
DOTFILES_ROOT=$(cd "$(dirname "$0")/.." && pwd)

# Symlink settings.json
if [ -f "$VSCODE_DIR/settings.json" ] || [ -L "$VSCODE_DIR/settings.json" ]; then
  echo "  Backing up existing settings.json to settings.json.backup"
  mv "$VSCODE_DIR/settings.json" "$VSCODE_DIR/settings.json.backup"
fi
ln -s "$DOTFILES_ROOT/vscode/settings.json.symlink" "$VSCODE_DIR/settings.json"
echo "  Linked settings.json"

# Symlink keybindings.json
if [ -f "$VSCODE_DIR/keybindings.json" ] || [ -L "$VSCODE_DIR/keybindings.json" ]; then
  echo "  Backing up existing keybindings.json to keybindings.json.backup"
  mv "$VSCODE_DIR/keybindings.json" "$VSCODE_DIR/keybindings.json.backup"
fi
ln -s "$DOTFILES_ROOT/vscode/keybindings.json.symlink" "$VSCODE_DIR/keybindings.json"
echo "  Linked keybindings.json"

echo "VSCode configuration installed!"
echo ""
echo "Make sure you have the Vim extension installed:"
echo "  code --install-extension vscodevim.vim"
echo ""
echo "For Go development, also install:"
echo "  code --install-extension golang.go"
