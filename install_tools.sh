#!/bin/bash

# This script installs a set of common and useful CLI tools.

set -euo pipefail

# List of tools to install
TOOLS=(
    htop
    jq
    fzf
    tree
    unzip
    curl
    wget
    ripgrep
    bat
    exa
    tldr
    tmux
)

echo "Updating package lists..."
sudo apt-get update

echo "Installing tools..."
sudo apt-get install -y "${TOOLS[@]}"

echo "All tools have been installed."
