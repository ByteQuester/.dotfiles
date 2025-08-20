#!/bin/bash

# This is the main entry point for the shell setup.
# It sources all the other shell configuration files.

# Source exports
if [ -f "$HOME/.dotfiles/shell/exports.sh" ]; then
    . "$HOME/.dotfiles/shell/exports.sh"
fi

# Source aliases
for alias_file in $HOME/.dotfiles/shell/aliases/*.sh; do
    if [ -f "$alias_file" ]; then
        . "$alias_file"
    fi
done

# Source functions
for function_file in $HOME/.dotfiles/shell/functions/*.sh; do
    if [ -f "$function_file" ]; then
        . "$function_file"
    fi
done

# Source prompt
if [ -f "$HOME/.dotfiles/shell/prompt/prompt.sh" ]; then
    . "$HOME/.dotfiles/shell/prompt/prompt.sh"
fi
