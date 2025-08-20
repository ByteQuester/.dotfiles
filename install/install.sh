#!/bin/bash

# This is the main installation script for the dotfiles.

set -euo pipefail

echo "Welcome to the dotfiles installer!"

echo "Installing command-line tools..."
"$HOME/.dotfiles/install/tools.sh"

echo "Creating symbolic links for dotfiles..."
"$HOME/.dotfiles/install/symlinks.sh"

echo "Installation complete!"
