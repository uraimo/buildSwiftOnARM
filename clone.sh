#!/bin/bash

CLANG_VERSION=3.7

## Use 3.8 on Ubuntu Mate, 3.7 everywhere else
if [[ $((/usr/bin/lsb_release -a) 2>&1) =~ "Ubuntu" ]]; then
  CLANG_VERSION=3.8
fi


sudo apt-get install git cmake ninja-build clang-$CLANG_VERSION python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev libcurl4-openssl-dev autoconf libtool systemtap-sdt-dev

sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-$CLANG_VERSION 100
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-$CLANG_VERSION 100

git clone https://github.com/apple/swift

./swift/utils/update-checkout --clone
