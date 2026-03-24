#!/usr/bin/env bash
#
# Install packages for Debian-based Linux (Linux Mint, Ubuntu, etc.)
# This is the Linux equivalent of `brew bundle` using the Brewfile.

set -e

echo "› Installing Linux packages via apt..."

# ─── Helper ──────────────────────────────────────────────────────────────────

install_if_missing() {
  if ! command -v "$1" &>/dev/null; then
    echo "  Installing $2..."
    sudo apt-get install -y -qq "$2"
  else
    echo "  $1 already installed"
  fi
}

# ─── Add external repos (only if not already present) ────────────────────────

add_ppa_if_missing() {
  local ppa="$1"
  if ! grep -rq "${ppa}" /etc/apt/sources.list.d/ 2>/dev/null; then
    echo "  Adding PPA: $ppa"
    sudo add-apt-repository -y "ppa:${ppa}"
  fi
}

echo "› Adding external repositories..."

# Neovim (latest)
add_ppa_if_missing "neovim-ppa/unstable"

# Lazygit
if ! command -v lazygit &>/dev/null; then
  echo "  Adding lazygit repo..."
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  sudo tar xf /tmp/lazygit.tar.gz -C /usr/local/bin lazygit
  rm -f /tmp/lazygit.tar.gz
fi

# Lazydocker
if ! command -v lazydocker &>/dev/null; then
  echo "  Installing lazydocker..."
  curl -fsSL https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
fi

sudo apt-get update -qq

# ─── Core CLI tools ─────────────────────────────────────────────────────────

echo "› Installing core CLI tools..."

install_if_missing rg        ripgrep
install_if_missing fzf       fzf
install_if_missing jq        jq
install_if_missing go        golang
install_if_missing nvim      neovim
install_if_missing htop      htop
install_if_missing curl      curl
install_if_missing xclip     xclip
install_if_missing tldr      tldr
install_if_missing batcat    bat

# ─── Kubernetes tools ────────────────────────────────────────────────────────

echo "› Installing Kubernetes tools..."

# kubectl
if ! command -v kubectl &>/dev/null; then
  echo "  Installing kubectl..."
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg 2>/dev/null || true
  echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null
  sudo apt-get update -qq
  sudo apt-get install -y -qq kubectl
fi

install_if_missing kubectx kubectx

# k9s (binary)
if ! command -v k9s &>/dev/null; then
  echo "  Installing k9s..."
  K9S_VERSION=$(curl -s "https://api.github.com/repos/derailed/k9s/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
  curl -Lo /tmp/k9s.tar.gz "https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz"
  sudo tar xf /tmp/k9s.tar.gz -C /usr/local/bin k9s
  rm -f /tmp/k9s.tar.gz
fi

# helm
if ! command -v helm &>/dev/null; then
  echo "  Installing helm..."
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
fi

# ─── Desktop apps ───────────────────────────────────────────────────────────

echo "› Installing desktop apps..."

install_if_missing vlc vlc

# Docker
if ! command -v docker &>/dev/null; then
  echo "  Installing docker..."
  sudo apt-get install -y -qq docker.io
  sudo usermod -aG docker "$USER" || true
fi

# Google Chrome
if ! command -v google-chrome &>/dev/null; then
  echo "  Installing Google Chrome..."
  wget -q -O /tmp/google-chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  sudo apt-get install -y -qq /tmp/google-chrome.deb
  rm -f /tmp/google-chrome.deb
fi

# Antigravity IDE (via apt repo)
if ! command -v antigravity &>/dev/null; then
  echo "  Installing Antigravity IDE..."
  if [ ! -f /etc/apt/keyrings/antigravity-repo-key.gpg ]; then
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-debian/key | sudo gpg --dearmor -o /etc/apt/keyrings/antigravity-repo-key.gpg
  fi
  echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | sudo tee /etc/apt/sources.list.d/antigravity.list > /dev/null
  sudo apt-get update -qq
  sudo apt-get install -y -qq antigravity
fi

echo ""
echo "✓ Linux packages installed!"
echo ""
echo "Packages skipped (macOS-only): mactop, skhd, rectangle"
echo "To install manually: ghostty, postman (see https://www.postman.com/downloads/)"
