#!/bin/bash
. "$(dirname $0)/utils.sh"

REL=4.2.3

INSTALL_DIR=`pwd`/install
PACKAGE=`pwd`/swift-${REL}_${ARCH}.tgz

rm -rf $INSTALL_DIR $PACKAGE

./swift/utils/build-script \
    -R --test \
    --build-subdir buildbot_linux --install-prefix=/usr \
    --install-destdir=${INSTALL_DIR} --installable-package=${PACKAGE}


