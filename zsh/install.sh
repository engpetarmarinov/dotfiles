#!/bin/bash
set -e
# Install oh-my-zsh
rm -rf "$HOME"/.oh-my-zsh
ZSH=$HOME/.oh-my-zsh KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
