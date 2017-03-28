#!/bin/sh

BRANCH=swift-3.1-RELEASE

find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "echo Cleaning '{}';cd '{}'; git reset --hard HEAD" \;
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "echo Updating '{}';cd '{}'; git pull; git fetch --tags" \;
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "echo Switching '{}' to ${BRANCH};cd '{}'; git checkout ${BRANCH}" \;
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "echo Applying patches to '{}';cd '{}'; patch -p1 < ../'{}'.diffs/*.diff" \;
