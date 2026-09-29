#!/bin/sh
#
# Claude installation script
# This installs Claude Code and Claude Desktop configuration files

set -e

echo "Installing Claude configuration..."

# Get the directory where this script is located
DOTFILES_ROOT=$(cd "$(dirname "$0")/.." && pwd)

# 1. Claude Code CLI configuration (Cross-platform)
CLAUDE_CODE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_CODE_DIR"

if [ -f "$CLAUDE_CODE_DIR/settings.json" ] || [ -L "$CLAUDE_CODE_DIR/settings.json" ]; then
  echo "  Backing up existing settings.json to settings.json.backup"
  mv "$CLAUDE_CODE_DIR/settings.json" "$CLAUDE_CODE_DIR/settings.json.backup"
fi
ln -s "$DOTFILES_ROOT/claude/settings.json" "$CLAUDE_CODE_DIR/settings.json"
echo "  Linked Claude Code settings.json"


# 2. Claude Desktop configuration (OS-specific)
if [ "$(uname -s)" = "Darwin" ]; then
  # macOS
  CLAUDE_DESKTOP_DIR="$HOME/Library/Application Support/Claude"
else
  # Linux
  CLAUDE_DESKTOP_DIR="$HOME/.config/Claude"
fi

mkdir -p "$CLAUDE_DESKTOP_DIR"

if [ -f "$CLAUDE_DESKTOP_DIR/claude_desktop_config.json" ] || [ -L "$CLAUDE_DESKTOP_DIR/claude_desktop_config.json" ]; then
  echo "  Backing up existing claude_desktop_config.json to claude_desktop_config.json.backup"
  mv "$CLAUDE_DESKTOP_DIR/claude_desktop_config.json" "$CLAUDE_DESKTOP_DIR/claude_desktop_config.json.backup"
fi
ln -s "$DOTFILES_ROOT/claude/claude_desktop_config.json" "$CLAUDE_DESKTOP_DIR/claude_desktop_config.json"
echo "  Linked Claude Desktop claude_desktop_config.json"

# 3. Install Claude CLI via npm if not present
if ! command -v claude >/dev/null 2>&1; then
  echo "  Installing Claude Code CLI via npm..."
  if command -v npm >/dev/null 2>&1; then
    # Try installing without sudo first
    if ! npm install -g @anthropic-ai/claude-code 2>/dev/null; then
      echo "  Requires sudo to install global npm packages. Running sudo..."
      sudo npm install -g @anthropic-ai/claude-code
    fi
  else
    echo "  Warning: npm is not installed. Skipping Claude Code CLI installation."
  fi
fi

# 4. Remote-control daemon (Linux systemd), survives reboots via lingering
if [ "$(uname -s)" = "Linux" ] && command -v systemctl >/dev/null 2>&1; then
  SYSTEMD_USER_DIR="$HOME/.config/systemd/user"
  mkdir -p "$SYSTEMD_USER_DIR"
  ln -sf "$DOTFILES_ROOT/claude/claude-remote-control.service" "$SYSTEMD_USER_DIR/claude-remote-control.service"
  loginctl enable-linger "$USER" 2>/dev/null || sudo loginctl enable-linger "$USER"
  systemctl --user daemon-reload
  systemctl --user enable --now claude-remote-control.service
  echo "  Enabled claude-remote-control.service"
fi

echo "Claude configuration installed!"
