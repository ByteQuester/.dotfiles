#!/bin/bash

# A script to clean up local git branches that have been merged to main/master

git checkout main || git checkout master
git pull
git branch --merged | egrep -v "(^\*|main|master)" | xargs git branch -d
