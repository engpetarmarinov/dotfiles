if [[ "$(uname -s)" = "Darwin" ]]; then
    export PATH="$HOME/go/bin/:$PATH"
else
    export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin/"
fi

