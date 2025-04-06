#!/bin/zsh

/usr/local/bin/switch bettercoding404
# Get the current timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

COMMIT_MESSAGE="Add more blog posts $TIMESTAMP"
# Run git commands
git pull
git add .
git commit -m "$COMMIT_MESSAGE"
git push

/usr/local/bin/switch default