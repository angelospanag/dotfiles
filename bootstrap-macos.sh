#!/bin/bash
set -uo pipefail

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Put brew on PATH (Apple Silicon; use /usr/local/bin/brew on Intel)
eval "$(/opt/homebrew/bin/brew shellenv)"

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
extensions=(
  anthropic.claude-code
  catppuccin.catppuccin-vsc
  catppuccin.catppuccin-vsc-icons
  charliermarsh.ruff
  golang.go
  hashicorp.terraform
  hverlin.mise-vscode
  ms-azuretools.vscode-containers
  ms-ossdata.vscode-pgsql
  ms-python.debugpy
  ms-python.python
  ms-python.vscode-pylance
  ms-python.vscode-python-envs
  redhat.vscode-xml
  redhat.vscode-yaml
  repreng.csv
  tamasfe.even-better-toml
  yzhang.markdown-all-in-one
)
for ext in "${extensions[@]}"; do
  code --install-extension "$ext" --force
done

# gopls
go install golang.org/x/tools/gopls@latest

# LazyVim
for d in ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim; do
  [ -e "$d" ] && mv "$d" "$d.bak"
done
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Generate new SSH key (non-interactive, no passphrase; drop -N "" to be prompted)
ssh-keygen -t ed25519 -C "angelospanag@protonmail.com" -f ~/.ssh/id_ed25519 -N ""
