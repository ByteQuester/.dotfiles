#!/bin/bash

# This script creates symbolic links for the dotfiles.

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"

mkdir -p "$BACKUP_DIR"

link() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "Backing up $dest to $BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    fi

    echo "Linking $src to $dest"
    ln -snf "$src" "$dest"
}

# Link shell configuration to modular entrypoint
link "$DOTFILES_DIR/shell/main.sh" "$HOME/.bashrc"

# Link common dotfiles if present
[ -e "$DOTFILES_DIR/.gitconfig" ] && link "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
[ -e "$DOTFILES_DIR/.vimrc" ] && link "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
[ -e "$DOTFILES_DIR/.profile" ] && link "$DOTFILES_DIR/.profile" "$HOME/.profile"

# Link any additional top-level config files under config/ to $HOME
if [ -d "$DOTFILES_DIR/config" ]; then
  for config_file in "$DOTFILES_DIR"/config/*; do
      [ -e "$config_file" ] || continue
      base_file=$(basename "$config_file")
      link "$config_file" "$HOME/$base_file"
  done
fi
