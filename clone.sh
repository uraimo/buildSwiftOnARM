#!/bin/bash

CLANG_VERSION=3.8

sudo apt-get install git cmake ninja-build clang-$CLANG_VERSION python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev libcurl4-openssl-dev autoconf libtool systemtap-sdt-dev libcurl4-openssl-dev libz-dev

sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-$CLANG_VERSION 100
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-$CLANG_VERSION 100

git clone https://github.com/apple/swift

./swift/utils/update-checkout --clone
