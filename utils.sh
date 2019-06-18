#!/bin/sh

# Set PLATFORM and ARCH
PLATFORM="unknown"
if [[ $(cat /etc/os-release) = *"Ubuntu"* ]]; then
  PLATFORM="ubuntu"
elif [[ $(cat /etc/os-release) = *"Raspbian"* ]]; then
  PLATFORM="raspbian"
fi

case `uname -m` in
    aarch64)
	ARCH=aarch64;;
    armv6*)
        ARCH=armv6;;
    *)
        ARCH=armv7;;
esac
 
