# Uses git's autocompletion for inner commands.
if (( $+commands[brew] )); then
  completion="$(brew --prefix)/share/zsh/site-functions/_git"
else
  completion='/usr/share/zsh/vendor-completions/_git'
fi

if test -f $completion
then
  source $completion
fi
