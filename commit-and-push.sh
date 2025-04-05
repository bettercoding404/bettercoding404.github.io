#!/bin/zsh


switch bettercoding404
# Get the current timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

COMMIT_MESSAGE="auto-commit $TIMESTAMP"
# Run git commands
git pull
git add .
git commit -m "$COMMIT_MESSAGE"
git push

switch default