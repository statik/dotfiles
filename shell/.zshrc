# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
#
#

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi

export GOPATH=$HOME/go
export GO15VENDOREXPERIMENT=1
if [[ $platform == 'linux' ]]; then
  export PATH=$HOME/bin:$PATH:$GOPATH/bin:$HOME/.local/bin
  #export PATH=$PATH:/usr/lib/go-1.10/bin
  alias open=xdg-open
  source /home/emurphy/.linuxbrew/opt/asdf/libexec/asdf.sh
elif [[ $platform == 'osx' ]]; then
  export PATH=$HOME/bin:$PATH:$GOPATH/bin:/usr/local/opt/go/libexec/bin
  # maven 3. what have I done with my life?
  #export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home
  #export PATH=$PATH:~/apache-maven-3.5.0/bin
  # python3 user path (for stuff installed with pip install --user)
  export PATH=$PATH:/Users/emurphy/Library/Python/3.9/bin
  # Postgres.app path
  export PATH=/Applications/Postgres.app/Contents/Versions/10/bin:$PATH

  # these next settings are so that Xcode 12.4 can find homebrew SSL
  # when compiling python3 psycopg2-binary package
  # https://github.com/psycopg/psycopg2/issues/1200
  #For compilers to find openssl@1.1 you may need to set:
  export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
  export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
  #For pkg-config to find openssl@1.1 you may need to set:
  # export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
fi

# used for the HavenGRC deployment of helm/tiller on OpenShift
# project is named haven-tiller
export TILLER_NAMESPACE=haven-tiller


source ~/.aliases
source ~/.functions
source ~/.private

export EDITOR=vim
export VISUAL=vim

test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# dat node version manager
export NVM_DIR=~/.nvm
#source $(brew --prefix nvm)/nvm.sh

# android SDK
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export JAVA_HOME='/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home'
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

if [[ -f "$HOME/.rbenv/version" ]]; then
  # dat ruby
  eval "$(rbenv init -)"
fi

if [[ -x $(command -v pyenv) ]]; then
  echo "Loading pyenv"
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
else
  # echo "not loading pyenv"
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

#export PATH=$PATH:/usr/local/pgsql/bin
export PGHOST=localhost



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

export WORKON_HOME=~/.venv
if [ -f '/usr/local/bin/virtualenvwrapper.sh' ]; then source /usr/local/bin/virtualenvwrapper.sh; fi

# fasd https://github.com/clvv/fasd
# inspired by autojump and Z
eval "$(fasd --init auto)"

# rust path
export PATH="$HOME/.cargo/bin:$PATH"

# Added by Krypton
export GPG_TTY=$(tty)

if [[ $(hostname) == "havendev" ]]; then
	#echo "HAVENDEV"
	#tmux has-session && exec tmux attach || exec tmux
else
	echo "not tmuxing"
fi

USER_BASE_PATH=$(python -m site --user-base)
export PATH=$PATH:$USER_BASE_PATH/bin

# tweak fzf fuzzy finder to ignore some directories
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!{.git,vendor,bazel-bin,bazel-out}/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# fuzzyvim () { vim $(fzf); }
#zle -N fuzzyvim
#bindkey '^t' fuzzyvim

# this is a hack to get capybara-webkit gem installed on OSX Mojave
# in order to do some client work on a TOP SECRET THING
# https://github.com/thoughtbot/capybara-webkit/issues/1072#issuecomment-430311949
#export PATH="/Users/emurphy/Qt5.5.0/5.5/clang_64/bin/:$PATH"
export PATH="/usr/local/opt/Qt/bin:$PATH"


# set up direnv
eval "$(direnv hook zsh)"

# announce if working in aws-shell
if [ -n "${AWS_VAULT}" ] ; then
    echo -e "$(tput setab 1)WARNING: working in aws-vault env ${AWS_VAULT}$(tput sgr0)"
    export PS1="$(tput setab 5)<<${AWS_VAULT}>>$(tput sgr0) ${PS1}";
fi;

# make aws vault login last longer than 15 minutes
# export AWS_ASSUME_ROLE_TTL=60m
#

# CodeQL security scanning tools
export PATH="$PATH":"$HOME/codeql-home/codeql"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
