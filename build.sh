#!/bin/sh
REL=4.2

INSTALL_DIR=`pwd`/install

#Determine architecture
case `uname -m` in
    aarch64)
	ARCH=aarch64;;
    armv6*)
        ARCH=armv6;;
    *)
        ARCH=armv7;;
esac

PACKAGE=`pwd`/swift-${REL}_${ARCH}.tgz

rm -rf $INSTALL_DIR $PACKAGE


./swift/utils/build-script \
    -R \
    --build-subdir buildbot_linux --install-prefix=/usr \
    --install-destdir=${INSTALL_DIR} --installable-package=${PACKAGE} \
    --lldb --llbuild --xctest --swiftpm --foundation --libdispatch \
    -- --install-libdispatch --install-foundation --install-swift --install-lldb --install-llbuild --install-xctest --install-swiftpm \
    '--swift-install-components=autolink-driver;compiler;clang-builtin-headers;stdlib;swift-remote-mirror;sdk-overlay;dev' \
    --build-swift-static-stdlib --build-swift-static-sdk-overlay


