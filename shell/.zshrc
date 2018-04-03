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
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="false"
HIST_STAMPS="yyyy-mm-dd"
HIST_IGNORE_SPACE="true"

# should not be needed with modern go 
#launchctl setenv GOPATH $HOME/go

export GOPATH=$HOME/go
export PATH=$HOME/bin:$PATH:$GOPATH/bin
export GO15VENDOREXPERIMENT=1

source ~/.aliases
source ~/.functions
source ~/.private

export EDITOR=vim
export VISUAL=vim

# dat node version manager
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# android SDK
export ANDROID_HOME=/usr/local/opt/android-sdk

if [[ -f "$HOME/.rbenv/version" ]]; then
  # dat ruby
  eval "$(rbenv init -)"
fi


# nix package manager
if [[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
  . $HOME/.nix-profile/etc/profile.d/nix.sh
fi

# yubikey protected ssh
#GPG_TTY=$(tty)
#export GPG_TTY

#if [ -f ~/.gpg-agent-info ]; then
#    source ~/.gpg-agent-info
#    export GPG_AGENT_INFO
#    export SSH_AUTH_SOCK
#fi

function npm-do { (PATH=$(npm bin):$PATH; eval $@;) }

export PATH=$PATH:/usr/local/pgsql/bin

export PATH=$PATH:/usr/local/opt/go/libexec/bin

# maven 3. what have I done with my life?
# TODO make this conditional for OSX
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home
export PATH=$PATH:~/apache-maven-3.5.0/bin

# z, jump around
# TODO make this conditional
#. /usr/local/etc/profile.d/z.sh


# added by travis gem
#[ -f /Users/emurphy/.travis/travis.sh ] && source /Users/emurphy/.travis/travis.sh

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/Users/emurphy/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/emurphy/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/emurphy/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/emurphy/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="/home/emurphy/.linuxbrew/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# virtualenvwrapper

2
export WORKON_HOME=~/.venv
source /usr/local/bin/virtualenvwrapper.sh

# fasd https://github.com/clvv/fasd
# inspired by autojump and Z
eval "$(fasd --init auto)"

# rust path
export PATH="$HOME/.cargo/bin:$PATH"
