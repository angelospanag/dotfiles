#!/bin/bash

set -euo pipefail

# Upgrade current packages
sudo apt update && sudo apt upgrade -y

# Install mise via apt
sudo install -dm 755 /etc/apt/keyrings
curl -fSs https://mise.jdx.dev/gpg-key.pub | sudo tee /etc/apt/keyrings/mise-archive-keyring.asc 1> /dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.asc] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
sudo apt update -y
sudo apt install -y mise

# Activate mise for this session
eval "$(mise activate bash)"

# Install CLI tools via mise
mise use --global \
  aqua:boyter/scc bat bun fd ffmpeg fzf \
  github-cli go golangci-lint hugo jq lazygit \
  neovim python@3.14 restish ripgrep ruff sqlc \
  starship uv yt-dlp

# gopls
go install golang.org/x/tools/gopls@latest

# VS Code repo
sudo apt-get install -y wget gpg apt-transport-https
wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor > /tmp/packages.microsoft.gpg
sudo install -D -o root -g root -m 644 /tmp/packages.microsoft.gpg \
  /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
  | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f /tmp/packages.microsoft.gpg
sudo apt update -y
sudo apt install -y code

# System tools that stay in apt
sudo DEBIAN_FRONTEND=noninteractive apt install -y \
  exiftool git gnupg nmap pwgen

# VS Code extensions
TARGET_USER="${SUDO_USER:-$USER}"
EXTENSIONS=(
  anthropic.claude-code
  biomejs.biome
  catppuccin.catppuccin-vsc
  catppuccin.catppuccin-vsc-icons
  charliermarsh.ruff
  golang.go
  hverlin.mise-vscode
  ms-python.debugpy
  ms-python.python
  ms-python.vscode-pylance
  ms-python.vscode-python-envs
  redhat.vscode-yaml
  repreng.csv
  tamasfe.even-better-toml
  yzhang.markdown-all-in-one
)
for ext in "${EXTENSIONS[@]}"; do
  sudo -u "$TARGET_USER" code --install-extension "$ext" --force \
    || echo "Failed to install: $ext"
done

# LazyVim
[ -d ~/.config/nvim ] && mv ~/.config/nvim{,.bak}
[ -d ~/.local/share/nvim ] && mv ~/.local/share/nvim{,.bak}
[ -d ~/.local/state/nvim ] && mv ~/.local/state/nvim{,.bak}
[ -d ~/.cache/nvim ] && mv ~/.cache/nvim{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Generate new SSH keys
ssh-keygen -t ed25519 -C "angelospanag@protonmail.com" -f ~/.ssh/id_ed25519 -N ""
