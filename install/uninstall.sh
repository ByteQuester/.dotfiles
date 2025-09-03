#!/bin/bash

# Uninstall dotfiles setup by removing symlinks and optionally restoring backups.
# Optional cleanup of helper alternatives/symlinks and installed tools.

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
BACKUPS_ROOT="$HOME/.dotfiles_backup"

restore_backups=false
purge_backups=false
dry_run=false
remove_repo=false
remove_tools=false

print_usage() {
  cat <<EOF
Usage: uninstall.sh [options]

Options:
  --restore           Restore originals from the most recent backup when available
  --purge-backups     Delete ~/.dotfiles_backup after uninstall
  --remove-repo       Remove the ~/.dotfiles repository directory
  --remove-tools      Attempt to remove packages installed by the installer
  --dry-run           Show what would be done without making changes
  -h, --help          Show this help

Notes:
  - Symlinks in your home that point into ~/.dotfiles will be removed.
  - With --restore, originals saved by the installer are restored when found.
  - Tools removal is optional and may remove packages you still want.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --restore) restore_backups=true; shift ;;
    --purge-backups) purge_backups=true; shift ;;
    --remove-repo) remove_repo=true; shift ;;
    --remove-tools) remove_tools=true; shift ;;
    --dry-run) dry_run=true; shift ;;
    -h|--help) print_usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; print_usage; exit 1 ;;
  esac
done

log() { echo "[uninstall] $*"; }

run() {
  if $dry_run; then
    echo "+ $*"
  else
    eval "$*"
  fi
}

is_link_to_dotfiles() {
  local path="$1"
  if [ -L "$path" ]; then
    local target
    target="$(readlink -f "$path" 2>/dev/null || true)"
    [[ "$target" == "$DOTFILES_DIR"/* ]]
  else
    return 1
  fi
}

restore_if_available() {
  local dest="$1"
  local base
  base="$(basename "$dest")"
  $restore_backups || return 0
  [ -d "$BACKUPS_ROOT" ] || return 0
  # Find newest backup directory that contains the file
  local candidate
  candidate="$(ls -1 "$BACKUPS_ROOT" 2>/dev/null | sort -r | while read -r d; do
    if [ -e "$BACKUPS_ROOT/$d/$base" ]; then echo "$BACKUPS_ROOT/$d/$base"; break; fi
  done)"
  if [ -n "$candidate" ]; then
    log "Restoring $base from backup"
    run "mv -f '$candidate' '$dest'"
  fi
}

remove_home_link() {
  local dest="$1"
  if is_link_to_dotfiles "$dest"; then
    log "Removing symlink $dest"
    run "rm -f '$dest'"
    restore_if_available "$dest"
  fi
}

remove_helper_links() {
  # Remove update-alternatives entry for bat if it points to batcat
  if command -v update-alternatives >/dev/null 2>&1; then
    if update-alternatives --display bat >/dev/null 2>&1; then
      if update-alternatives --display bat 2>/dev/null | grep -q "/usr/bin/batcat"; then
        log "Removing update-alternatives candidate for bat -> /usr/bin/batcat"
        run "sudo update-alternatives --remove bat /usr/bin/batcat || true"
      fi
    fi
  fi
  # Remove compatibility symlinks we might have created
  if [ -L /usr/local/bin/exa ]; then
    local target
    target="$(readlink -f /usr/local/bin/exa || true)"
    if echo "$target" | grep -q "/bin/eza"; then
      log "Removing /usr/local/bin/exa symlink to eza"
      run "sudo rm -f /usr/local/bin/exa"
    fi
  fi
  if [ -L /usr/local/bin/tldr ]; then
    local target
    target="$(readlink -f /usr/local/bin/tldr || true)"
    if echo "$target" | grep -q "tealdeer"; then
      log "Removing /usr/local/bin/tldr symlink to tealdeer"
      run "sudo rm -f /usr/local/bin/tldr"
    fi
  fi
}

remove_installed_tools() {
  $remove_tools || return 0
  log "Removing CLI tools (this may remove tools you still use)"
  run "sudo apt-get remove -y htop jq fzf tree unzip ripgrep tmux silversearcher-ag ncdu || true"
  # Optional ones
  run "sudo apt-get remove -y bat exa tldr eza tealdeer || true"
  run "sudo apt-get autoremove -y || true"
}

main() {
  log "Starting uninstall (dry-run: $dry_run)"

  # Remove symlinks created by the installer
  remove_home_link "$HOME/.bashrc"
  [ -e "$DOTFILES_DIR/.gitconfig" ] && remove_home_link "$HOME/.gitconfig"
  [ -e "$DOTFILES_DIR/.vimrc" ] && remove_home_link "$HOME/.vimrc"
  [ -e "$DOTFILES_DIR/.profile" ] && remove_home_link "$HOME/.profile"

  if [ -d "$DOTFILES_DIR/config" ]; then
    for config_file in "$DOTFILES_DIR"/config/*; do
      [ -e "$config_file" ] || continue
      base_file="$(basename "$config_file")"
      remove_home_link "$HOME/$base_file"
    done
  fi

  remove_helper_links
  remove_installed_tools

  if $purge_backups && [ -d "$BACKUPS_ROOT" ]; then
    log "Purging backups at $BACKUPS_ROOT"
    run "rm -rf '$BACKUPS_ROOT'"
  fi

  if $remove_repo && [ -d "$DOTFILES_DIR" ]; then
    log "Removing repo directory $DOTFILES_DIR"
    run "rm -rf '$DOTFILES_DIR'"
  fi

  log "Uninstall complete"
}

main "$@"


