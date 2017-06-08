#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

setopt MENU_COMPLETE
setopt GLOB_COMPLETE
export GOPATH=$HOME/go
export PATH=$HOME/bin:$PATH:$GOPATH/bin

source ~/.aliases
source ~/.functions
source ~/.private

export EDITOR=vim
export VISUAL=vim

# dat ruby
eval "$(rbenv init -)"
