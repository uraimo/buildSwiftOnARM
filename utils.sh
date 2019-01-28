#!/bin/sh

# Set PLATFORM and ARCH
PLATFORM="Unknown"
if [[ $(cat /etc/os-release) = *"Ubuntu"* ]]; then
  PLATFORM="Ubuntu"
elif [[ $(cat /etc/os-release) = *"Raspbian"* ]]; then
  PLATFORM="Raspbian"
fi

case `uname -m` in
    aarch64)
	ARCH=aarch64;;
    armv6*)
        ARCH=armv6;;
    *)
        ARCH=armv7;;
esac
 
