#!/bin/bash

# Git functions

# Get current git branch
git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# Get git status in a short format
git_status() {
    git status -s
}
