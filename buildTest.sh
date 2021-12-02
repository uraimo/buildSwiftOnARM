#!/bin/bash
. "$(dirname $0)/utils.sh"

REL=swift-5.4.3-RELEASE
INSTALL_DIR=`pwd`/install
PACKAGE=`pwd`/swift-${REL}_${ARCH}.tgz

#rm -rf $INSTALL_DIR $PACKAGE

./swift/utils/build-script --test --preset=buildbot_linux,swiftlang-min install_destdir=$INSTALL_DIR installable_package=$PACKAGE



