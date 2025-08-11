#!/bin/bash


# Get the current timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

COMMIT_MESSAGE="auto-commit $TIMESTAMP"

git config user.name "jenkins-bot"
git config user.email "ixuhangyi@gmail.com"

# Ensure the branch is tracking the remote
git branch --set-upstream-to=origin/main main

# Run git commands
git add .
git commit -m "$COMMIT_MESSAGE"
git push

npm install

hugo

chmod -R 777 ./public
rsync -avz -i --exclude ".git/" --exclude ".idea/" ./public/ ubuntu@43.128.116.181:/root/data/disk/www/bettercoding404.github.io/