# ls aliases — use gls on macOS (via coreutils), native ls on Linux
if [[ "$(uname -s)" = "Darwin" ]]; then
  if command -v gls &>/dev/null; then
    alias ls="gls -F --color"
    alias l="gls -lAh --color"
    alias ll="gls -l --color"
    alias la='gls -A --color'
  fi
else
  alias ls="ls -F --color=auto"
  alias l="ls -lAh --color=auto"
  alias ll="ls -l --color=auto"
  alias la='ls -A --color=auto'
fi