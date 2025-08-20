#!/bin/bash

# Create a new directory and enter it
mkcd() {
    mkdir -p "$1" && cd "$1"
}
