#!/bin/bash

# ship function
ship() {
    git add .
    git commit -am "$COMMIT_MSG"
    git push origin main

    echo "sleep abit for page rendering ...!"
    sleep 10

    echo "https://ahaxu.github.io/ updated!"
}

COMMIT_MSG=$1

echo "cleaning ..."
stack exec ahaxu-blog clean

echo "building ..."
stack exec ahaxu-blog build

GIT_STATUS=$(git status 2>&1 | grep "nothing to commit")
if [[ -z "$GIT_STATUS" ]]; then
  echo "shipping to prod ..."  
  ship
else
  echo "nothing to do !"
fi
exit 1

