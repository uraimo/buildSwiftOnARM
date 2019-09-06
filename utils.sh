#!/bin/sh

# Set OS, VERSION and ARCH
OS="unknown"
VERSION="unknown"
ARCH="unknown"
ARCHFAMILY="unknown"

if [[ $(cat /etc/os-release) = *"Ubuntu"* ]]; then
    OS="ubuntu"
    VERSION=`cat /etc/os-release | sed -n 's/VERSION_ID=\"\([0-9].*\)\"/\1/p'`
elif [[ $(cat /etc/os-release) = *"Raspbian"* ]]; then
    OS="raspbian"
    if [[ $(cat /etc/os-release) = *"stretch"* ]]; then
        VERSION="stretch"
    elif [[ $(cat /etc/os-release) = *"buster"* ]]; then
        VERSION="buster"
    fi
elif [[ $(cat /etc/os-release) = *"stretch"* ]]; then
    OS="debian"
    VERSION="stretch"
elif [[ $(cat /etc/os-release) = *"buster"* ]]; then
    OS="debian"
    VERSION="buster"
fi

case `uname -m` in
    aarch64)
        ARCH="aarch64"
        ARCHFAMILY="aarch64";;
    armv6*)
        ARCH="armv6"
        ARCHFAMILY="aarch32";;
    *)
        ARCH="armv7"
        ARCHFAMILY="aarch32";;
esac
