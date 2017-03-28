#!/bin/sh
REL=3.1

INSTALL_DIR=`pwd`/install
PACKAGE=`pwd`/swift-${REL}.tgz
rm -rf $INSTALL_DIR $PACKAGE


./swift/utils/build-script --build-subdir buildbot_linux -R --lldb --llbuild --xctest --swiftpm --foundation --libdispatch -- --install-libdispatch --install-foundation --install-swift --install-lldb --install-llbuild --install-xctest --install-swiftpm --install-prefix=/usr '--swift-install-components=autolink-driver;compiler;clang-builtin-headers;stdlib;swift-remote-mirror;sdk-overlay;dev' --build-swift-static-stdlib --build-swift-static-sdk-overlay --install-destdir=${INSTALL_DIR} --installable-package=${PACKAGE}

echo "+ Fixing up the install package for ARM"
cp -R swift-corelibs-libdispatch/dispatch/ ${INSTALL_DIR}/usr/lib/swift

cp ./build/buildbot_linux/libdispatch-linux-armv7/src/swift/Dispatch.swiftdoc ${INSTALL_DIR}/usr/lib/swift/linux/armv7/
cp ./build/buildbot_linux/libdispatch-linux-armv7/src/swift/Dispatch.swiftmodule ${INSTALL_DIR}/usr/lib/swift/linux/armv7/
cp ./build/buildbot_linux/libdispatch-linux-armv7/src/libdispatch.la ${INSTALL_DIR}/usr/lib/swift/linux/
cp ./build/buildbot_linux/libdispatch-linux-armv7/src/.libs/libdispatch.so ${INSTALL_DIR}/usr/lib/swift/linux

mkdir -p ${INSTALL_DIR}/usr/lib/swift/os
cp swift-corelibs-libdispatch/os/linux_base.h ${INSTALL_DIR}/usr/lib/swift/os
cp swift-corelibs-libdispatch/os/object.h ${INSTALL_DIR}/usr/lib/swift/os

# Retar
echo "+ Retar installation package"
tar -C ${INSTALL_DIR} -czf ${PACKAGE} .

