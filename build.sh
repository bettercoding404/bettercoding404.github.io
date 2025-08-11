#!/bin/bash


# Get the current timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

COMMIT_MESSAGE="Add more blogs $TIMESTAMP"

git config user.name "bettercoding404"
git config user.email "bettercoding404"

# Ensure the branch is tracking the remote
git branch --set-upstream-to=origin/main main

# Run git commands
git add .
git commit -m "$COMMIT_MESSAGE"
git push
