#!/bin/bash
set -e

# Get the current timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

COMMIT_MESSAGE="auto-update history $TIMESTAMP"

git config user.name "jenkins-bot"
git config user.email "ixuhangyi@gmail.com"

# Ensure the branch is tracking the remote
git branch --set-upstream-to=origin/main main

# Run git commands
git add .
git commit -m "$COMMIT_MESSAGE"
git push