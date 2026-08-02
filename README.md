# dotfiles

My personal dotfiles for macOS and Linux.

## Setup

### macOS

```bash
git clone https://github.com/angelospanag/dotfiles ~/dotfiles
cd ~/dotfiles
./bootstrap-macos.sh
./install.sh
```

### Linux (Ubuntu)

```bash
git clone https://github.com/angelospanag/dotfiles ~/dotfiles
cd ~/dotfiles
./bootstrap-ubuntu.sh
./install.sh
```

## Contents

| File                  | Description                                      |
| --------------------- | ------------------------------------------------ |
| `.zshrc`              | Zsh config, aliases, environment variables       |
| `.gitconfig`          | Git config with GPG commit signing               |
| `.hushlogin`          | Suppress console login message                   |
| `starship.toml`       | Starship prompt config                           |
| `install.sh`          | Symlinks all dotfiles to their correct locations |
| `bootstrap-macos.sh`  | macOS machine setup                              |
| `bootstrap-ubuntu.sh` | Ubuntu machine setup                             |
