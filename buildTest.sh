#!/bin/bash
. "$(dirname $0)/utils.sh"

REL=5.1.3

INSTALL_DIR=`pwd`/install
PACKAGE=`pwd`/swift-${REL}_${ARCH}.tgz

./swift/utils/build-script \
    -R --test \
    --build-subdir buildbot_linux --install-prefix=/usr \
    --install-destdir=${INSTALL_DIR} --installable-package=${PACKAGE}


