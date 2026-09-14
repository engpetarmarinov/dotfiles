# fzf shell integration: Ctrl-R (history), Ctrl-T (files), Alt-C (cd) + completion
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi
