#!/bin/bash
. "$(dirname $0)/utils.sh"

BRANCH=swift-5.0-branch
TAG=swift-5.0.1-RELEASE

echo "♻️  Resetting the repositories..."
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'/.git ] && echo \\* Cleaning '{}' && cd '{}' && git reset --hard HEAD && git clean -fd" \;
echo "✳️  Switching all the repositories to ${BRANCH} @ ${TAG}..."
./swift/utils/update-checkout --scheme ${BRANCH} --tag ${TAG}
echo "✅ Applying the required cross-platform patches..."
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'.diffs ] && echo \\* Applying patches to '{}' && cd '{}'  && for f in ../'{}'.diffs/*.diff; do patch -p1 < \$f; done;" \;


# Patches for a specific arch, OS, shared version(debian and raspbian can share patches) 
# and OS version go in their own subdirectory
for VARIANT in $ARCH $OS $VERSION $OS$VERSION
do 
    echo "✅ Applying the required $VARIANT patches..."
    find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'.diffs/$VARIANT ] && echo \\* Applying patches to '{}' && cd '{}'  && for f in ../'{}'.diffs/$VARIANT/*.diff; do patch -p1 < \$f; done;" \;
done
