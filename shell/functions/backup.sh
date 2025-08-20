#!/bin/bash

# Simple backup function
backup() {
    tar -czvf "$1.tar.gz" "$1"
}
