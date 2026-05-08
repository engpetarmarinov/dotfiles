#!/bin/sh
#
# JetBrains IDEs installation script
# Symlinks config overrides into every detected JetBrains IDE config dir
# (GoLand, IntelliJIdea, PyCharm, WebStorm, RubyMine, ...).
# Re-run after a major IDE upgrade so symlinks point at the new version dir.

set -e

case "$(uname -s)" in
  Darwin) JETBRAINS_DIR="$HOME/Library/Application Support/JetBrains"; OS_SUBDIR="macos" ;;
  Linux)  JETBRAINS_DIR="$HOME/.config/JetBrains";                    OS_SUBDIR="linux" ;;
  *)      exit 0 ;;
esac

if [ ! -d "$JETBRAINS_DIR" ]; then
  echo "JetBrains: no config root at $JETBRAINS_DIR; launch any JetBrains IDE once, then re-run."
  exit 0
fi

DOTFILES_JETBRAINS=$(cd "$(dirname "$0")" && pwd)
KEYMAPS_SRC="$DOTFILES_JETBRAINS/keymaps/$OS_SUBDIR"

if [ ! -d "$KEYMAPS_SRC" ]; then
  echo "JetBrains: no keymaps for $OS_SUBDIR at $KEYMAPS_SRC"
  exit 0
fi

echo "Installing JetBrains configuration ($OS_SUBDIR)..."

link_path() {
  ide_dir="$1"
  name="$2"
  src="$3"
  dst="$ide_dir/$name"

  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "    Backing up existing $name/ to $name.backup"
    mv "$dst" "$dst.backup"
  fi

  ln -s "$src" "$dst"
  echo "    Linked $name/ -> keymaps/$OS_SUBDIR/"
}

found=0
for ide_dir in "$JETBRAINS_DIR"/*; do
  # Filter to actual IDE config dirs (they always contain an options/ subdir).
  [ -d "$ide_dir/options" ] || continue
  found=1
  echo "  $(basename "$ide_dir")"
  link_path "$ide_dir" keymaps "$KEYMAPS_SRC"
done

if [ "$found" = "0" ]; then
  echo "  No IDE config dirs found under $JETBRAINS_DIR."
  exit 0
fi

echo "JetBrains configuration installed!"
echo ""
echo "Next: in each IDE → Settings → Keymap → select 'Custom'."
