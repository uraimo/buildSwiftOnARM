#!/bin/bash
. "$(dirname $0)/utils.sh"

SCHEME=swift-5.4.3-RELEASE

echo "♻️  Resetting the repositories..."
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'/.git ] && echo ■ Cleaning '{}' && cd '{}' && git reset --hard HEAD && git clean -fd" \;
echo "✳️  Switching all the repositories to ${SCHEME}..."
./swift/utils/update-checkout --clone --scheme "$SCHEME"
echo "✅ Applying the required cross-platform patches..."
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'.diffs ] && echo ■ Applying patches to '{}' && cd '{}'  && for f in ../'{}'.diffs/*.diff; do [ -e \"\$f\" ] || continue; echo \"Apply \"\$f ; patch -p1 < \"\$f\"; done;" \;


# Patches for a specific arch, arch family, OS, shared version(debian and raspbian can share patches) 
# and OS version go in their own subdirectory.
# To sum up, under every project-specific *.diffs directory you'll be able to  group you patches this way:
# * $ARCHFAMILY/ : aarch32 for the generic arm32 patches and aarch64 for the 64bit-specific ones
# * $ARCH/ : aarch64,armv6,armv7 specific patches, regardless of the OS
# * $OS/ : Regardless of the architecture, patches for a specific OS
# * $VERSION/ : Patches for a specific OS version, regardless of the actual OS name (Debian and Raspbian can both be "Stretch" and the same version of Ubuntu could be reporting a different name when asked)
# * $OS$VERSION/ : Patches for a very specific version of a distribution
# * $ARCH$OS$VERSION/ : Patches that apply only to an OS/Version on a specific architecture.
#
for VARIANT in $ARCH $ARCHFAMILY $OS $VERSION $OS$VERSION $ARCH$OS$VERSION
do 
    echo "✳️  Searching for required $VARIANT patches..."
    find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "[ -d '{}'.diffs/$VARIANT ] && echo ■ Applying patches to '{}' && cd '{}'  && for f in ../'{}'.diffs/$VARIANT/*.diff; do echo \"Apply \"\$f ; patch -p1 < \$f; done;" \;
done
