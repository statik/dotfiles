# Setup fzf
# ---------
if [[ ! "$PATH" == *${BREWPATH}/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${BREWPATH}/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${BREWPATH}/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${BREWPATH}/opt/fzf/shell/key-bindings.zsh"
