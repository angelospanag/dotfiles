#!/bin/bash

DOTFILES="$HOME/dotfiles"

ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"
