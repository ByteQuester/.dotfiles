#!/bin/bash

# This script sets the shell prompt.

# Load a theme
# The default theme is 'default'. You can change it by setting the DOTFILES_THEME variable.
if [ -z "$DOTFILES_THEME" ]; then
    DOTFILES_THEME="default"
fi

if [ -f "$HOME/.dotfiles/shell/prompt/themes/$DOTFILES_THEME.theme.sh" ]; then
    . "$HOME/.dotfiles/shell/prompt/themes/$DOTFILES_THEME.theme.sh"
else
    echo "Prompt theme '$DOTFILES_THEME' not found. Using default prompt."
    PS1='\u@\h:\w\$ '
fi
