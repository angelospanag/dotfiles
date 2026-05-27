#!/bin/bash

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install mise via brew
brew install mise
eval "$(mise activate bash)"

# Install CLI tools via mise
mise use --global \
  aqua:boyter/scc bat bun fd ffmpeg fzf \
  github-cli go golangci-lint hugo jq lazygit \
  neovim python@3.14 restish ripgrep ruff sqlc \
  starship uv yt-dlp

# Packages and apps (Brewfile handles remaining tools + casks + vscode extensions)
brew bundle install

# Install remaining CLI tools brew still handles
brew install exiftool git gnupg nmap pwgen

# LazyVim
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Generate new SSH keys
ssh-keygen -t ed25519 -C "angelospanag@protonmail.com"
