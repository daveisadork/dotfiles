#!/usr/bin/env zsh
#
set -e

if [[ `uname` == 'Darwin'  ]]; then
    if (( ! $+commands[brew] )); then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew tap homebrew/command-not-found
    brew tap homebrew/cask-fonts
    brew install -q \
        alacritty \
        ansifilter \
        coreutils \
        font-sauce-code-pro-nerd-font \
        fzf \
        git \
        neovim \
        iterm2 \
        pipx \
        poetry \
        pyenv \
        pyenv-virtualenv \
        reattach-to-user-namespace \
        ripgrep \
        tig \
        tmux \
        tmux \
        xz \
        zsh \
    ; 
    ~/.dotfiles/term.sh
fi

[ ! -f ~/.zshrc ] && ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
[ ! -f ~/.profile ] && ln -s ~/.dotfiles/zsh/profile ~/.profile
[ ! -f ~/.zprofile ] && ln -s ~/.dotfiles/zsh/profile ~/.zprofile
[ ! -d ~/.config/nvim ] && ln -s ~/.dotfiles/nvim ~/.config/nvim
[ ! -d ~/.config/alacritty ] && ln -s ~/.dotfiles/alacritty ~/.config/alacritty
[ ! -d ~/.tmux ] && ln -s ~/.dotfiles/tmux ~/.tmux
[ ! -f ~/.tmux.conf ] && ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
[ ! -f ~/.ruff.toml ] && ln -s ~/.dotfiles/ruff.toml ~/.ruff.toml
[ ! -f ~/.gitignore ] && ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore
[ ! -f ~/.gitconfig ] && ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig

