# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Personal macOS dotfiles. Originally forked from Ben Orenstein's (r00k) dotfiles. Contains shell, editor, git, and tmux configuration plus a Brewfile and a tiny macOS setup script.

## Layout & install model

This repo lives at `~/code/dotfiles`. `~/.dotfiles` is a symlink to it, and individual dotfiles in `$HOME` (e.g. `~/.zshrc`, `~/.vimrc`, `~/.gitconfig`, `~/.tmux.conf`, `~/.bin`, `~/.oh-my-zsh`) are symlinks back into this repo. Both paths therefore show identical contents.

`rake install` (see `Rakefile`) is the installer: it iterates every top-level entry and creates `~/.<file>` → `$PWD/<file>` symlinks, prompting before overwriting. There is no uninstall task — clean up by removing the symlinks manually.

Consequence for edits: changing a file here changes the live config immediately. Re-run `source ~/.zshrc` (`so` alias) after editing zsh files. Run `` ` `` + `r` inside tmux to reload `tmux.conf`.

## Key files

- `zshrc` — entry point. Sources `zsh/aliases` and `zsh/functions`, plus `~/.private-dotfiles/shell-init` if present (private repo at `~/code/private-dotfiles`, symlinked as `~/.private-dotfiles`, for secrets and machine-specific env). Uses oh-my-zsh with theme `awesomepanda` and plugins `git docker aws`.
- `zsh/aliases`, `zsh/functions` — heavy use of short git aliases (`g`, `gs`, `gp`, `gpcb`, `grom`, …). Prefer extending these over adding new shell scripts.
- `zsh/func/` — autoloaded zsh functions (prompt themes, `awsso`, `zgitinit`).
- `vimrc` + `vim/` — Vim config; plugins managed by **Vundle** (not vim-plug). After editing the plugin list, run `:PluginInstall` in vim. Vundle itself is not vendored — bootstrap with `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`.
- `oh-my-zsh/` — full vendored copy of the oh-my-zsh repo, not a submodule. Don't edit files inside it; put customizations in `oh-my-zsh/custom/` or in `zsh/`.
- `gitconfig` — signs commits via SSH key (`gpg.format = ssh`, `commit.gpgsign = true`); `pull.ff = only`; rich `git l`/`git r`/`git hp` aliases backed by `githelpers`.
- `Brewfile` — `brew bundle --file=Brewfile` to install.
- `bin/` — small one-off scripts, exposed on `$PATH` via the `~/.bin` symlink.
- `claude/` — Claude Code config. Handled specially by the Rakefile: NOT symlinked as `~/.claude` (that would clobber the live cache). Instead, individual entries listed in `CLAUDE_LINKS` in the Rakefile are symlinked into `~/.claude/` (e.g. `claude/settings.json` → `~/.claude/settings.json`, `claude/commands/build-cli.md` → `~/.claude/commands/build-cli.md`). Run `rake claude` to (re)apply just these links, or `rake install` to do everything. Add new tracked entries by appending to `CLAUDE_LINKS`.

## Common commands

- Install/refresh symlinks: `rake install` (from repo root).
- Install Homebrew packages: `brew bundle --file=Brewfile`.
- Reload shell: `so` (alias for `source ~/.zshrc`).
- Jump to repo: `dot` (alias for `cd ~/.dotfiles`).
- Edit aliases quickly: `aliases` (opens `zsh/aliases` in vim).

There is no test suite, linter, or CI — this is config, not code.

## Conventions when editing

- Adding shell aliases or functions: put them in `zsh/aliases` or `zsh/functions`. Don't create new top-level files unless they need to land in `$HOME` as a dotfile (the Rakefile will symlink every top-level entry).
- Secrets, work-specific env vars, and per-machine config belong in `~/.private-dotfiles/shell-init`, not here. The public `zshrc` only sources it if present.
- The `master` branch is the only branch; commit directly. Commits are SSH-signed automatically via `gitconfig`.
