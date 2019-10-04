<p align="center" style="margin-bottom:30px;">
<img src="https://raw.githubusercontent.com/uraimo/buildSwiftOnARM/master/logo.svg?sanitize=true"/>
<i>Scripts to clone, configure, patch and build Swift 5.1 on Linux ARM devices.</i> 
</p>



For precompiled Swift 5.1 binaries see the *[Prebuilt binaries](#prebuilt-binaries)* section, if you want to build Swift on your own instead, check out the *[Building on ARM](#building-on-arm)* section and the step-by-step instructions.

### Summary

- [Supported Architectures](#supported-architectures)
- [Prebuilt binaries](#prebuilt-binaries)
- [Usage](#usage)
    - [Dependencies](#dependencies) 
- [Building on ARM](#building-on-arm)
    - [Step by step instructions](#step-by-step-instructions)
- [GitHub CI on ARM](#github-ci-on-arm)
- [REPL Issues](#repl-issues)
- [Acknowledgments](#acknowledgments) 
- [Previous Releases](#previous-releases)


## Supported Architectures

* ✅  ARMv6 32bit: _Original RaspberryPi, Pi Zero, etc..._
* ✅  ARMv7/8 32bit: _All versions of RaspberryPi 2/3, OrangePi, ODroid, CHIP, etc..._
* ✅  aarch64: _RaspberryPis or other ARMv8 boards with a 64 bit OS, Pine64, etc..._


## Prebuilt binaries

| OS | Architecture | Boards | Download |                                                                          
| -- | ------------ | ------ | -------- |
| Raspbian Stretch | ARMv6 | All RaspberryPis: Classic, Zero, 2, 3 | [5.0.3](https://github.com/uraimo/buildSwiftOnARM/releases/download/5.0.3/swift-5.0.3-armv6-RPi0123-RaspbianStretch.tgz) |
| Raspbian Buster | ARMv6 | All RaspberryPis: Classic, Zero, 2, 3, 4 | [5.0.3](https://github.com/uraimo/buildSwiftOnARM/releases/download/5.0.3/swift-5.0.3-armv6-RPi01234-RaspbianBuster.tgz) |
| Debian Stretch | ARMv7 | Every ARMv7 board, RaspberryPis 2, 3 included | [5.0.3](https://github.com/uraimo/buildSwiftOnARM/releases/download/5.0.3/swift-5.0.3-armv7-DebianStretch.tgz) |
| Debian Buster | ARMv7 | Every ARMv7 board, RaspberryPis 2, 3, 4 included | [5.0.3](https://github.com/uraimo/buildSwiftOnARM/releases/download/5.0.3/swift-5.0.3-armv7-DebianBuster.tgz) |
| Ubuntu 16.04 | ARMv7 | All versions of RaspberryPi 2/3, other ARMv7 boards | [5.0.3](https://github.com/uraimo/buildSwiftOnARM/releases/download/5.0.3/swift-5.0.3-armv7-Ubuntu1604.tgz) |
| Ubuntu 18.04 | ARMv7 | All versions of RaspberryPi 2/3, other ARMv7 boards | [5.0.3](https://github.com/uraimo/buildSwiftOnARM/releases/download/5.0.3/swift-5.0.3-armv7-Ubuntu1804.tgz) |
| Ubuntu 18.04 | aarch64 | All versions of RaspberryPi 2/3, other ARMv7 boards | [5.0.1](https://github.com/uraimo/buildSwiftOnARM/releases/download/5.0.1/swift-5.0.1-aarch64-RPi234-Ubuntu1804_64.tgz) |
| Fedora/CentOS/RHEL | aarch64 | All versions of RaspberryPi 3 or later, other ARMv7 boards | `sudo dnf install swift-lang` |
 
For binaries of older releases, check out the [releases page](https://github.com/uraimo/buildSwiftOnARM/releases).

For alternative ways to install these Swift binaries on your ARM board, check out [Swift on Balena](https://github.com/wlisac/swift-on-balena/) by Will Lisac, Helge Heß's [dockSwiftOnARM](https://github.com/helje5/dockSwiftOnARM), both based on Docker, and the [Swift Deb Repository](https://swift-arm.com/install-swift/) maintained by Neil Jones.

To quickly cross-compile your Swift applications for ARM on a Mac (a time saver) check out the [Swift Cross Compilation Toolchains](https://github.com/CSCIX65G/SwiftCrossCompilers) project built by Van Simmons.

## Usage

When using the Swift Package Manager on one of these boards, that usually have limited memory/cpu, you'll need to use the new `-j` option to reduce the number of threads spawned by the tool and be able to compile.
For example, when building an SPM project most of the times we'll limit the number of jobs to one:

```
    pi@raspberrypi:> swift build -j 1 
```

### Dependencies 

In order to use the provided prebuilt binaries you'll need to install the following dependencies:

**Raspbian Stretch and Ubuntu 16.04**

    sudo apt install clang-3.8 libicu-dev libcurl4-nss-dev
    sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100
    sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.8 100

**Raspbian Buster, Ubuntu 18.04 and newer**

    sudo apt install clang libicu-dev libcurl4-nss-dev curl

Decompress the archive on the RaspberryPi, you'll find the Swift binaries in `usr/bin/` relative to where you decompressed the archive.

    tar -xzf <archivename.tgz>

Ensure that the path you decompressed to is in your `PATH` environment variable: `echo $PATH`. If it's not then add it to your path for your shell.

    PATH="$HOME/usr/bin:$PATH"

To permanently add this to your `PATH` variable, you can add the following block of code to the end of your `~/.profile` file:

    if [ -d "$HOME/usr/bin" ] ; then
        PATH="$HOME/usr/bin:$PATH"
    fi

Verify the swift version is setup: 

    $ swift --version
    
    Swift version 5.1 (swift-5.1-RELEASE)
    Target: armv7-unknown-linux-gnueabihf



## Building on ARM

For the latest updates on Swift on ARM, check out my blog [here](https://www.uraimo.com/category/raspberry/).

Check out Helge Heß's project [dockSwiftOnARM](https://github.com/helje5/dockSwiftOnARM) to build Swift in a Docker container or to [build a cross-compiling toolchain](https://github.com/AlwaysRightInstitute/swift-mac2arm-x-compile-toolchain) that will allow you to build arm binaries directly from your Mac using a precompiled swiftc for ARM.

The scripts that buildSwiftOnARM provides:

- clone.sh - Install dependencies and clones the main Swift repository and all the related projects

- checkoutRelease.sh - Resets all repos, updates them, checks out a specific tag (5.1 at the moment) and apply the patches.

- build.sh - Builds Swift producing a tgz archive with the Swift distributions. 

- clean.sh - Cleans all build artifacts, only needed when you want to start again from scratch.



### Step by step instructions

First of all, use a suitably sized sd-card, at least 32Gb in size, but I recommend to use an external USB drive to clone the project and build Swift.

Configure a swap file of at least 2Gb, on Ubuntu:

    sudo fallocate -l 2G swapfile
    sudo chmod 600 swapfile
    sudo mkswap swapfile
    sudo swapon swapfile
    
You'll need to manually enable the swap file with `swapon` *each time you reboot* the RaspberryPi (or the system will just run without swap).

On Raspbian, since the swapfile is already configured, open `/etc/dphys-swapfile` and edit `CONF_SWAPSIZE` to increase the size:

    CONF_SWAPSIZE=2048
    
Save the file and:

    sudo /etc/init.d/dphys-swapfile stop
    sudo /etc/init.d/dphys-swapfile start
    
Now, call the included scripts as follows:

1. Launch `clone.sh` that will install the required dependencies (_git cmake ninja-build clang-3.8 python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev libcurl4-openssl-dev autoconf libtool systemtap-sdt-dev libcurl4-openssl-dev libz-dev_), fix clang links and clone apple/swift with all its dependecies.

2. Run `checkoutRelease.sh` that will select the current release (5.1) and apply the needed patches.

3. Once done, start the build with `build.sh`.

4. Once the build completes a few hours later, you'll have a `swift-5.1-armv7.tgz` archive containing the whole Swift compiler distribution. Once decompressed you'll find the Swift binaries under `usr/bin`.

I recommend to perform all these operations in a permanent background `tmux` or `screen` session (`CTRL+B d` to detach from the session and `tmux a` to reattach to it when you ssh again into the RaspberryPi).

Additional steps could be required in some cases [check the latest ARM posts on my blog for additional info](https://www.uraimo.com/category/raspberry/).

To build a different release than the one currently configured in the script, open `checkoutRelease.sh` and `build.sh` and modify the variables on top, with the branch name for the release and the release name for the tgz respectively.

## GitHub CI on ARM

ARM projects can be tested in an environment simulated through QEMU on GitHub using the [Run-On-Architecture](https://github.com/uraimo/run-on-arch-action) action.
While you will not be able to use hardware interfaces available on real ARM boards, this environment should be more than enough to perform some basic testing or even build your projects and deploy them directly to your target ARM board (with considerable time savings).

## REPL Issues

Since the first releases of Swift on ARM32, the REPL has never been available on this platform, but that doesn't impact the compiler itself. Considering this, as you would expect, launching `swift` without parameters will result in an error instead of the REPL prompt.

## Acknowledgments 

We wouldn't have Swift on ARM and most of the patches included on buildSwiftOnARM without the work done by these developers:

 * [@Kaiede](https://github.com/Kaiede)
 * [@chnmrc](https://github.com/chnmrc)
 * [@futurejones](https://github.com/futurejones)
 * [@jasonm128](https://github.com/jasonm128)
 * [@hpux735](https://twitter.com/hpux735)
 * [@iachievedit](https://twitter.com/iachievedit)
 
The community can be reached at the [swift-arm](https://launchpass.com/swift-arm) Slack channel.

## Previous Releases

You can compile old releases checking out the specific tag:


* [Swift 5.0.3](https://github.com/uraimo/buildSwiftOnARM/tree/5.0.3)
* [Swift 5.0.2](https://github.com/uraimo/buildSwiftOnARM/tree/5.0.2)
* [Swift 5.0.1](https://github.com/uraimo/buildSwiftOnARM/tree/5.0.1)
* [Swift 5.0](https://github.com/uraimo/buildSwiftOnARM/tree/5.0)
* [Swift 4.2.3](https://github.com/uraimo/buildSwiftOnARM/tree/4.2.3)
* [Swift 4.2.2](https://github.com/uraimo/buildSwiftOnARM/tree/4.2.2)
* [Swift 4.2.1](https://github.com/uraimo/buildSwiftOnARM/tree/4.2.1)
* [Swift 4.1.3](https://github.com/uraimo/buildSwiftOnARM/tree/4.1.3)
* [Swift 3.1.1](https://github.com/uraimo/buildSwiftOnARM/tree/3.1.1)
* [Swift 3.1](https://github.com/uraimo/buildSwiftOnARM/tree/3.1)
* [Swift 3.0.2](https://github.com/uraimo/buildSwiftOnARM/tree/3.0.2)

