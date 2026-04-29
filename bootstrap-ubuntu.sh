#!/bin/bash

# Upgrade current packages
sudo apt update && sudo apt upgrade -y

# Mise
sudo install -dm 755 /etc/apt/keyrings
curl -fSs https://mise.en.dev/gpg-key.pub | sudo tee /etc/apt/keyrings/mise-archive-keyring.asc 1> /dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.asc] https://mise.en.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list

# Go repo
sudo add-apt-repository ppa:longsleep/golang-backports

# Python repo
sudo add-apt-repository ppa:deadsnakes/ppa

# Bun
curl -fsSL https://bun.com/install | bash

# btop
sudo snap install btop

# Claude Code
curl -fsSL https://claude.ai/install.sh | bash

# Install packages
sudo apt update -y && sudo apt install -y bat cloc fd-find fzf git golang-go jq lazygit mise neovim nmap python3.14-pip python3.14-venv pwgen ripgrep starship tree

# Lazyvim
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Python - uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Ruff
uv tool install ruff
uv tool update-shell

# Generate new SSH keys
ssh-keygen -t ed25519 -C "angelospanag@protonmail.com"
