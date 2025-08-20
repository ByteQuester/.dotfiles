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

# Link shell configuration
link "$DOTFILES_DIR/shell/main.sh" "$HOME/.bashrc" # Overwriting .bashrc to source the new setup

# Link config files
for config_file in $DOTFILES_DIR/config/*; do
    base_file=$(basename "$config_file")
    link "$config_file" "$HOME/$base_file"
done
