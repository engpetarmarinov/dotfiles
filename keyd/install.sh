#!/bin/bash
# keyd — Linux only. Remaps the Dygma's Alt+F1..F9 app macros to Super+1..9.
[ "$(uname -s)" = "Linux" ] || exit 0
cd "$(dirname "$0")" || exit 1

if ! command -v keyd >/dev/null; then
  # keyd is in the main archive from Ubuntu 25.04 / Debian 13; older bases need the PPA
  if [ -z "$(apt-cache search --names-only '^keyd$')" ]; then
    sudo add-apt-repository -y ppa:keyd-team/ppa
    sudo apt-get update -qq
  fi
  sudo apt-get install -y keyd
fi

# Copied rather than symlinked: the root daemon should not read config from $HOME.
sudo install -Dm644 dygma-raise2.conf /etc/keyd/dygma-raise2.conf
sudo systemctl enable keyd
# restart rather than `keyd reload`: the Debian/PPA package names the binary keyd.rvaiya
sudo systemctl restart keyd
