#!/bin/sh
REL=4.1.3

INSTALL_DIR=`pwd`/install
PACKAGE=`pwd`/swift-${REL}.tgz
#Determine architecture
case `uname -m` in
    aarch64)
	ARCH=aarch64;;
    armv6*)
        ARCH=armv6;;
    *)
        ARCH=armv7;;
esac	

rm -rf $INSTALL_DIR $PACKAGE


./swift/utils/build-script --build-subdir buildbot_linux -j1 -R --llbuild --xctest --swiftpm --foundation --libdispatch -- --install-libdispatch --install-foundation --install-swift --install-lldb --install-llbuild --install-xctest --install-swiftpm --install-prefix=/usr '--swift-install-components=autolink-driver;compiler;clang-builtin-headers;stdlib;swift-remote-mirror;sdk-overlay;dev' --build-swift-static-stdlib --build-swift-static-sdk-overlay --install-destdir=${INSTALL_DIR} --installable-package=${PACKAGE}
