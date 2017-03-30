# Building Swift on ARM


A few, very simple, bash scripts to clone, configure and build Swift on ARM devices. 

Derived from [package-swift](https://github.com/iachievedit/package-swift) by [@iachievedit](https://twitter.com/iachievedit), some patches from [swift-arm](https://github.com/swift-arm/) by [@hpux735](https://twitter.com/hpux735).


- clean.sh - Clean all build artifacts 

- clone.sh - Clone the main Swift repository and all the related projects

- checkoutRelease.sh - Reset all repos, updates them, check out a specific tag (3.1 at the moment) and apply the patches

- build.sh - Build


## Building instructions

**Update 3/17:** Currently 3.1 builds only with Ubuntu 16.04, check out the 3.0.2 tag for the previous version.

First of all, use a suitably sized sd-card, at least 16Gb in size.

Configure a swap file of at least 2Gb, on Ubuntu:

    sudo fallocate -l 2G swapfile
    sudo chmod 600 swapfile
    sudo mkswap swapfile
    sudo swapon swapfile

On Raspbian, open `/etc/dphys-swapfile` and edit:

    CONF_SWAPSIZE=2048
    
Save the file and:

    sudo /etc/init.d/dphys-swapfile stop
    sudo /etc/init.d/dphys-swapfile start
    
Once this is done, install the required dependencies:

    sudo apt-get install git cmake ninja-build clang-3.7 python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev libcurl4-openssl-dev autoconf libtool systemtap-sdt-dev
    
Additional steps could be required in some cases (usually on a RaspberryPi 1) [check the latest posts on my blog for additional info](https://uraimo.com).

Clone this repository and download apple/swift with all its dependecies with `clone.sh`.

Once done, start the build with `build.sh`.

I recommend to compile in a background `tmux` session (`CTRL+B d` to detach from the session and `tmux a` to reattach to it when you ssh again into the RaspberryPi).
