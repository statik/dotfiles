# Setup fzf
# ---------
if [[ ! "$PATH" == *${HOME}/.homebrew/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${HOME}/.homebrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${HOME}/.homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${HOME}/.homebrew/opt/fzf/shell/key-bindings.zsh"
