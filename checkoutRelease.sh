#!/bin/sh

BRANCH=swift-3.0.2-RELEASE

find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "echo Cleaning '{}';cd '{}'; git reset --hard HEAD" \;
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd Updating '{}'; git pull; git fetch --tags" \;
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd Switching '{}' to ${BRANCH}; git checkout ${BRANCH}" \;
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd Applying patches to '{}'; patch -p1 < DIFFS/*.diff" \;
