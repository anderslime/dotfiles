# Dotfiles

Personal macOS dotfiles (Apple Silicon). Shell, vim, git, tmux, and a `Brewfile`.

## Install on a fresh Mac

1. Install Xcode Command Line Tools (`xcode-select --install`) and restore SSH keys to `~/.ssh`.
2. Clone the repo and create the `~/.dotfiles` symlink the rest of the config expects:
   ```sh
   mkdir -p ~/code
   git clone git@github.com:<you>/dotfiles.git ~/code/dotfiles
   ln -s ~/code/dotfiles ~/.dotfiles
   ```
3. Symlink every dotfile into `$HOME`:
   ```sh
   cd ~/.dotfiles && rake install
   ```
4. Install Homebrew, then the bundle:
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   brew bundle --file=~/.dotfiles/Brewfile
   ```
   Sign in to the App Store first if `mas` entries fail, then re-run `brew bundle`.
5. Install oh-my-zsh (the repo doesn't vendor it; `zshrc` expects it at `~/.oh-my-zsh`):
   ```sh
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
   ```
   `--keep-zshrc` is critical — without it the installer overwrites the `~/.zshrc` symlink created in step 3.
6. Vim plugins (Vundle):
   ```sh
   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   vim +PluginInstall +qall
   ```
7. Install Claude Code via Anthropic's official installer (not Homebrew):
   ```sh
   curl -fsSL https://claude.ai/install.sh | bash
   ```

## Notes

- Single branch (`master`), commits are SSH-signed (see `gitconfig`).
- Editing files in this repo updates the live config immediately — they're symlinked into `$HOME`. Run `so` (alias for `source ~/.zshrc`) after editing zsh files.
