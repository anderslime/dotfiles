# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# ZSH Theme
ZSH_THEME="anderslime"

# oh-my-zsh plugins
plugins=(git)

# User configuration
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Show contents of directory after cd-ing into it
chpwd() {
  ls -lrthG
}

# Fsharp stuf
export MONO_GAC_PREFIX="/usr/local"
alias fslex="mono ~/code/FSharpPowerPack-4.0.0.0/bin/fslex.exe"
alias fsyacc="mono ~/code/FSharpPowerPack-4.0.0.0/bin/fsyacc.exe"

# Node Version Manager
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Load oh my zsh
source $ZSH/oh-my-zsh.sh

# PATH
export PATH=$HOME/bin:$HOME/.dotfiles/bin:/usr/local/bin:/usr/local/sbin:$PATH

# Loklaebase stuff
export PATH=$HOME/code/lb/bin:$PATH
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/anderslime/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

# Section CLI
export PATH=$HOME/code/section.cli:$PATH

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export EDITOR='vim'

source /Users/anderslime/.dotfiles/zsh/aliases
source /Users/anderslime/.dotfiles/zsh/functions
source /Users/anderslime/.dotfiles/zsh/credentials
# source /Users/anderslime/.dotfiles/zsh/prompt
# source ~/.bin/tmuxinator.zsh

# added by travis gem
[ -f /Users/anderslime/.travis/travis.sh ] && source /Users/anderslime/.travis/travis.sh
