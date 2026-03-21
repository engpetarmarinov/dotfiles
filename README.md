# dotfiles

My personal dotfiles. Works on **macOS** and **Debian-based Linux** (apt).

## Install

```sh
git clone git@github.com:engpetarmarinov/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

## Update

Run `dot` periodically to pull latest changes, update packages, and re-run installers.

## Structure

- **`topic/`** — each directory is a topic (git, nvim, zsh, etc.)
- **`topic/*.zsh`** — loaded automatically into your shell
- **`topic/path.zsh`** — loaded first, sets up `$PATH`
- **`topic/completion.zsh`** — loaded last, sets up autocomplete
- **`topic/install.sh`** — run by `script/install`
- **`topic/*.symlink`** — symlinked to `$HOME` as dotfiles (e.g. `.gitconfig`)
- **`bin/`** — added to `$PATH`

## OS-Specific

| macOS | Linux |
|---|---|
| Homebrew (`Brewfile`) | apt (`linux/install-packages.sh`) |
| `macos/set-defaults.sh` | — |
| `skhd`, `rectangle` | skipped |

Based on [holman/dotfiles](https://github.com/holman/dotfiles).
