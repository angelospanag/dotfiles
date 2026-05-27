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

# CLI tools that stay in brew
brew install exiftool git gnupg nmap pwgen

# GUI apps
brew install --cask brave-browser docker-desktop draw-things font-fira-code-nerd-font \
  ghostty goland keepassxc netnewswire pearcleaner pycharm signal spotify \
  visual-studio-code vlc wireshark-app

# VS Code extensions
code --install-extension anthropic.claude-code
code --install-extension catppuccin.catppuccin-vsc
code --install-extension catppuccin.catppuccin-vsc-icons
code --install-extension charliermarsh.ruff
code --install-extension golang.go
code --install-extension hverlin.mise-vscode
code --install-extension ms-python.debugpy
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-python.vscode-python-envs
code --install-extension redhat.vscode-yaml
code --install-extension repreng.csv
code --install-extension tamasfe.even-better-toml
code --install-extension yzhang.markdown-all-in-one

# gopls
go install golang.org/x/tools/gopls@latest

# LazyVim
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Generate new SSH keys
ssh-keygen -t ed25519 -C "angelospanag@protonmail.com"
