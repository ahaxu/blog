#!/bin/bash

COMMIT_MSG=$1

echo "cleaning ..."
stack exec ahaxu-blog clean

echo "building ..."
stack exec ahaxu-blog build

git add .
git commit -am "$COMMIT_MSG"
git push origin main

echo "sleep abit for page rendering ...!"
sleep 10

echo "https://ahaxu.github.io/ updated!"

