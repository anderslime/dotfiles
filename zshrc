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
source $ZSH/oh-my-zsh.sh
export PATH=$HOME/bin:$HOME/.dotfiles/bin:/usr/local/bin:$PATH

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export EDITOR='vim'

source /Users/anderslime/.dotfiles/zsh/aliases
# source /Users/anderslime/.dotfiles/zsh/prompt
alias gs="git status"
