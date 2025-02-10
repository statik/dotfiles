#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

autoload zmv
alias zcp='zmv -C'
alias zln='zmv -L'

alias assume=". assume"

fpath=($HOME/.granted/zsh_autocomplete/assume/ $fpath)

fpath=($HOME/.granted/zsh_autocomplete/granted/ $fpath)
