if [[ "$(uname -s)" = "Darwin" ]]; then
    export PATH="/opt/homebrew/opt/fzf/bin:$PATH"
else
    export PATH="$HOME/.fzf/bin:$PATH"
fi
