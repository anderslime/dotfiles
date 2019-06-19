# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# ZSH Theme
ZSH_THEME="anderslime"

# oh-my-zsh plugins
plugins=(
  git
  docker
  hub
)

# User configuration
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Show contents of directory after cd-ing into it
chpwd() {
  ls -lrthG
}

# Load oh my zsh
source $ZSH/oh-my-zsh.sh

# Python
export PYTHONIOENCODING=utf-8
export PATH=~/Library/Python/3.6/bin:$PATH
export PATH=~/code/bat:$PATH

# PATH
# export PATH=$HOME/bin:$HOME/.dotfiles/bin:/usr/local/bin:/usr/local/sbin:$PATH

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=da_DK.UTF-8
export EDITOR='vim'

source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions

# NVM
# export NVM_DIR="$HOME/.nvm"
# . "/usr/local/opt/nvm/nvm.sh"

# Secret stuff
[ -f $HOME/.private-dotfiles/shell-init ] && source $HOME/.private-dotfiles/shell-init

# Oddset CLI
eval "$($HOME/code/oddset-cli/bin/oddset init -)"

# Shp Docker CLI
eval "$(/Users/andersemil/code/shpdocker/bin/shpdocker init -)"

# Nordisk Film CLI
eval "$(/Users/andersemil/code/nf-deploy/nf-cli/bin/nf init -)"

# Danske Spil CLI
eval "$(/Users/andersemil/code/ds-cli/bin/ds init -)"

# added by travis gem
[ -f /Users/anderslime/.travis/travis.sh ] && source /Users/anderslime/.travis/travis.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
