# Homebrew (Apple Silicon)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# ZSH Theme
ZSH_THEME="awesomepanda"

# oh-my-zsh plugins
plugins=(
  git
  docker
  aws
)

# User configuration
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Show contents of directory after cd-ing into it
chpwd() {
  ls -lrthG
}

# Ngrok
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

# Load oh my zsh
source $ZSH/oh-my-zsh.sh

# Python
export PYTHONIOENCODING=utf-8

# Locale
export LC_ALL=en_US.UTF-8
export LANG=da_DK.UTF-8
export EDITOR='vim'
export LC_CTYPE="en_US.UTF-8"

source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions

# Java
export JAVA_21_HOME=$(/usr/libexec/java_home -v21)
alias java21='export JAVA_HOME=$JAVA_21_HOME'

bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

eval "$(nodenv init -)"

# User-local binaries (Claude Code lives here)
export PATH="$HOME/.local/bin:$PATH"

export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
