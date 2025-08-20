#!/usr/bin/env bash
set -euo pipefail

backup_dir="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"

link() {
  local src="$1"; local dest="$2"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$backup_dir/"
  fi
  ln -snf "$src" "$dest"
}

for f in .bashrc .profile .gitconfig; do
  [ -e "$HOME/.dotfiles/$f" ] && link "$HOME/.dotfiles/$f" "$HOME/$f"
done
