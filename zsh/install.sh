#!/bin/sh

# Install oh-my-zsh
rm -rf "$HOME"/.oh-my-zsh
ZSH=$HOME/.oh-my-zsh/ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions                                                                                                                                                                               ✔  09:40:09
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-$HOME~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
