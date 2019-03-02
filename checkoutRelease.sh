#!/bin/bash
. "$(dirname $0)/utils.sh"

BRANCH=swift-4.2-branch
TAG=swift-4.2.3-RELEASE

echo "♻️ \033[1m Resetting the repositories...\033[0m"
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'/.git ] && echo \\* Cleaning '{}' && cd '{}' && git reset --hard HEAD && git clean -fd" \;
echo "✳️ \033[1m Switching all the repositories to ${BRANCH} @ ${TAG}...\033[0m"
./swift/utils/update-checkout --scheme ${BRANCH} --tag ${TAG}
echo "✅ \033[1m Applying the required cross-platform patches...\033[0m"
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'.diffs ] && echo \\* Applying patches to '{}' && cd '{}'  && for f in ../'{}'.diffs/*.diff; do patch -p1 < \$f; done;" \;
echo "✅ \033[1m Applying the required $ARCH patches...\033[0m"
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'.diffs/$ARCH ] && echo \\* Applying patches to '{}' && cd '{}'  && for f in ../'{}'.diffs/$ARCH/*.diff; do patch -p1 < \$f; done;" \;
