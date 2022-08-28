#!/bin/bash

# ship function
ship() {
    git add .
    git commit -am "$COMMIT_MSG"
    git push origin main

    echo "λ> sleep abit for page rendering ...!"
    sleep 10

    echo "λ> https://ahaxu.github.io/ updated!"
}

COMMIT_MSG=$1

echo "λ> cleaning ..."
stack exec ahaxu-blog clean

echo "λ> building ..."
stack exec ahaxu-blog build

GIT_STATUS=$(git status 2>&1 | grep "nothing to commit")
if [[ -z "$GIT_STATUS" ]]; then
  echo "λ> shipping to prod ..."  
  ship
else
  echo "λ> nothing to do !"
fi
exit 1

