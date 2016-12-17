#!/bin/sh

BRANCH=swift-3.0.2-RELEASE

find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}'; git reset --hard HEAD" \;
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}'; git pull --tags" \;
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}'; git checkout $BRANCH" \;
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}'; patch -p1 < DIFFS/*.diff" \;
 
