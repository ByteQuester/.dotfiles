#!/bin/bash

# This script installs a set of common and useful CLI tools.

set -euo pipefail

if ! command -v sudo >/dev/null 2>&1; then
    echo "sudo is required to install packages" >&2
    exit 1
fi

echo "Updating package lists..."
sudo apt-get update -y

echo "Installing base tools..."
sudo apt-get install -y \
    htop jq fzf tree unzip curl wget ripgrep tmux silversearcher-ag ncdu || true

# Handle package name differences
# bat -> batcat on some Debian/Ubuntu
if ! command -v bat >/dev/null 2>&1; then
    if apt-cache show bat 2>/dev/null | grep -q '^Package: bat$'; then
        sudo apt-get install -y bat || true
    fi
    if ! command -v bat >/dev/null 2>&1 && command -v batcat >/dev/null 2>&1; then
        sudo update-alternatives --install /usr/local/bin/bat bat /usr/bin/batcat 1 || true
    elif ! command -v bat >/dev/null 2>&1; then
        # Try backport via apt if available
        echo "bat not available; consider installing batcat or using cargo" >&2
    fi
fi

# exa is renamed to eza in newer repos
if ! command -v exa >/dev/null 2>&1; then
    if apt-cache show exa 2>/dev/null | grep -q '^Package: exa$'; then
        sudo apt-get install -y exa || true
    elif apt-cache search -n eza | grep -q '^eza'; then
        sudo apt-get install -y eza || true
        if command -v eza >/dev/null 2>&1 && [ ! -e /usr/local/bin/exa ]; then
            sudo ln -snf "$(command -v eza)" /usr/local/bin/exa || true
        fi
    fi
fi

# tldr vs tealdeer
if ! command -v tldr >/dev/null 2>&1; then
    if apt-cache show tldr 2>/dev/null | grep -q '^Package: tldr$'; then
        sudo apt-get install -y tldr || true
    elif apt-cache search -n tealdeer | grep -q '^tealdeer'; then
        sudo apt-get install -y tealdeer || true
        if command -v tealdeer >/dev/null 2>&1 && [ ! -e /usr/local/bin/tldr ]; then
            sudo ln -snf "$(command -v tealdeer)" /usr/local/bin/tldr || true
        fi
    fi
fi

echo "All tools have been installed or had best-effort fallbacks applied."

