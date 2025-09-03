#!/bin/bash

# This is the main installation script for the dotfiles.

set -euo pipefail

echo "[dotfiles] Welcome to the installer"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[dotfiles] Installing command-line tools..."
"$SCRIPT_DIR/tools.sh"

echo "[dotfiles] Creating symbolic links for dotfiles..."
"$SCRIPT_DIR/symlinks.sh"

echo "[dotfiles] Installation complete! Open a new terminal or run:"
echo "[dotfiles]   source \"$HOME/.dotfiles/shell/main.sh\""

