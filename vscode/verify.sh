#!/bin/bash
#
# VSCode Configuration Verification Script
#

set -e

echo "🔍 VSCode Configuration Verification"
echo "====================================="
echo ""

# Check if VSCode is installed
if ! command -v code &> /dev/null; then
    echo "❌ VSCode 'code' command not found"
    echo "   Please install VSCode and ensure 'code' is in your PATH"
    exit 1
fi
echo "✅ VSCode 'code' command found"

# Check config directory
VSCODE_DIR="$HOME/Library/Application Support/Code/User"
if [ ! -d "$VSCODE_DIR" ]; then
    echo "❌ VSCode config directory not found: $VSCODE_DIR"
    exit 1
fi
echo "✅ VSCode config directory exists"

# Check if settings.json is symlinked
if [ -L "$VSCODE_DIR/settings.json" ]; then
    TARGET=$(readlink "$VSCODE_DIR/settings.json")
    echo "✅ settings.json is symlinked to:"
    echo "   $TARGET"
else
    echo "❌ settings.json is NOT a symlink"
    exit 1
fi

# Check if keybindings.json is symlinked
if [ -L "$VSCODE_DIR/keybindings.json" ]; then
    TARGET=$(readlink "$VSCODE_DIR/keybindings.json")
    echo "✅ keybindings.json is symlinked to:"
    echo "   $TARGET"
else
    echo "❌ keybindings.json is NOT a symlink"
    exit 1
fi

# Check for required extensions
echo ""
echo "📦 Checking VSCode Extensions:"
echo "------------------------------"

EXTENSIONS=$(code --list-extensions)

if echo "$EXTENSIONS" | grep -q "vscodevim.vim"; then
    echo "✅ Vim extension installed (vscodevim.vim)"
else
    echo "❌ Vim extension NOT installed"
    echo "   Install with: code --install-extension vscodevim.vim"
fi

if echo "$EXTENSIONS" | grep -q "golang.go"; then
    echo "✅ Go extension installed (golang.go)"
else
    echo "⚠️  Go extension NOT installed (recommended for Go development)"
    echo "   Install with: code --install-extension golang.go"
fi

# Validate JSONC (JSON with Comments) syntax
echo ""
echo "📝 Validating Configuration Files:"
echo "----------------------------------"

# VSCode uses JSONC format (JSON with Comments), so basic JSON parsers will fail
# Instead, check if files exist and have basic structure
if [ -f "$VSCODE_DIR/settings.json" ]; then
    if grep -q '"vim.leader"' "$VSCODE_DIR/settings.json" 2>/dev/null; then
        echo "✅ settings.json appears valid (JSONC format with comments)"
    else
        echo "⚠️  settings.json exists but may be incomplete"
    fi
else
    echo "❌ settings.json not found"
fi

if [ -f "$VSCODE_DIR/keybindings.json" ]; then
    KEY_COUNT=$(grep -c '"key":' "$VSCODE_DIR/keybindings.json" 2>/dev/null || echo "0")
    if [ "$KEY_COUNT" -gt 0 ]; then
        echo "✅ keybindings.json appears valid (JSONC format with comments)"
    else
        echo "⚠️  keybindings.json exists but may be empty"
    fi
else
    echo "❌ keybindings.json not found"
fi

# Check if Vim is enabled in settings
echo ""
echo "⚙️  Checking Vim Configuration:"
echo "-----------------------------"

if grep -q '"vim.leader"' "$HOME/Library/Application Support/Code/User/settings.json" 2>/dev/null; then
    echo "✅ Vim leader key configured"
else
    echo "⚠️  Vim leader key not found in settings"
fi

if grep -q '"editor.lineNumbers": "relative"' "$HOME/Library/Application Support/Code/User/settings.json" 2>/dev/null; then
    echo "✅ Relative line numbers enabled"
else
    echo "⚠️  Relative line numbers not enabled"
fi

# Count custom keybindings
BINDING_COUNT=$(grep -c '"key":' "$HOME/Library/Application Support/Code/User/keybindings.json" 2>/dev/null || echo "0")
echo ""
echo "⌨️  Custom Keybindings:"
echo "---------------------"
echo "✅ Found $BINDING_COUNT custom keybinding(s)"

echo ""
echo "📋 Summary:"
echo "----------"
echo "Configuration files are properly installed and symlinked!"
echo ""
echo "Next steps:"
echo "1. Restart VSCode (or reload window with Cmd+Shift+P → 'Developer: Reload Window')"
echo "2. Test shortcuts using the verification guide: ~/.dotfiles/vscode/verify.md"
echo "3. Note: 'Shift+Shift' doesn't work in VSCode (not supported)"
echo "   Use 'Cmd+P' for quick file open or 'Cmd+Shift+T' for symbol search instead"
echo ""
echo "✨ Happy coding!"
