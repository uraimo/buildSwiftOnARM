# Building Swift on ARM


A few, very simple, bash scripts to clone, configure and build Swift on ARM devices. 

Derived from [package-swift](https://github.com/iachievedit/package-swift) by [@iachievedit](https://twitter.com/iachievedit), some patches from [swift-arm](https://github.com/swift-arm/) by [@hpux735](https://twitter.com/hpux735).

Currently this project builds Swift 3.1.1 (get it [here](https://www.dropbox.com/s/w0fxwqx7t1llixx/swift-3.1.1-RPi23-1604.tgz?dl=0) | [post](https://www.uraimo.com/2017/05/01/An-update-on-Swift-3-1-1-for-raspberry-pi-zero-1-2-3/)) but only on Ubuntu Mate 16.04 (see [#4](https://github.com/uraimo/buildSwiftOnARM/issues/4) for the issue related to Raspbian), [check out the 3.0.2 tag](https://github.com/uraimo/buildSwiftOnARM/tree/3.0.2) for the previous version, that worked on both Ubuntu 16.04 and Raspbian. SPM will compile correctly only on Ubuntu.

Check out Helge Heß's project [dockSwiftOnARM](https://github.com/helje5/dockSwiftOnARM) to build Swift in a Docker container or to [build a cross-compiling toolchain](https://github.com/helje5/dockSwiftOnARM/blob/master/toolchain/README.md) that will allow you to build arm binaries directly from your Mac using a precompiled swiftc for ARM.


The scripts:

- clone.sh - Install dependencies and clones the main Swift repository and all the related projects

- checkoutRelease.sh - Resets all repos, updates them, checks out a specific tag (3.1.1 at the moment) and apply the patches

- build.sh - Build

- clean.sh - Clean all build artifacts 


## Building instructions

First of all, use a suitably sized sd-card, at least 16Gb in size.

Configure a swap file of at least 2Gb, on Ubuntu:

    sudo fallocate -l 2G swapfile
    sudo chmod 600 swapfile
    sudo mkswap swapfile
    sudo swapon swapfile
    
You'll need to manually enable the swap file with `swapon` *each time you reboot* the RaspberryPi (or the system will just run without swap).

On Raspbian, open `/etc/dphys-swapfile` and edit:

    CONF_SWAPSIZE=2048
    
Save the file and:

    sudo /etc/init.d/dphys-swapfile stop
    sudo /etc/init.d/dphys-swapfile start
    
Now, call the included scripts as follows:

1. Launch `clone.sh` that will install the required dependencies (_git cmake ninja-build clang-3.7 python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev libcurl4-openssl-dev autoconf libtool systemtap-sdt-dev_), fix clang links and clone apple/swift with all its dependecies.

2. Run `checkoutRelease.sh` that will select the current release (3.1.1) and apply the needed patches. These patches cover the basic Raspi2/3 with Xenial case, [an additional patch](https://github.com/uraimo/buildSwiftOnARM/blob/master/swift.diffs/otherdebians/noqa_E402_workspace_must_be_an_absolute.diff) could be needed on different boards, or on different Ubuntus/Debians. If you get the E402 error, apply it manually going in the `swift` directory and run `patch -p1 < ../swift.diffs/otherdebians/noqa_E402_workspace_must_be_an_absolute.diff`.

3. Once done, start the build with `build.sh`.

4. Once the build completes a few hours later, you'll have a `swift-3.1.1.tgz` archive containing the whole Swift compiler distribution. Once decompressed you'll find the Swift binaries under `usr/bin`.

I recommend to perform all these operations in a permanent background `tmux` or `screen` session (`CTRL+B d` to detach from the session and `tmux a` to reattach to it when you ssh again into the RaspberryPi).

Additional steps could be required in some cases (usually on a RaspberryPi 1 or for Raspbian) [check the latest ARM posts on my blog for additional info](https://www.uraimo.com/category/raspberry/).
