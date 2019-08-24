#!/bin/bash
. "$(dirname $0)/utils.sh"

# Distributions derived by Stretch need an older clang, use the default for the rest
if [ $VERSION = "stretch" ] || [ $VERSION = "16.04" ]; then
    CLANG_VERSION=-3.8
fi

# Basic dependencies
echo "✅ Installing dependencies..."
sudo apt-get install make patch rsync git cmake ninja-build clang$CLANG_VERSION python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev libcurl4-openssl-dev autoconf libtool systemtap-sdt-dev libcurl4-openssl-dev libz-dev

# Fix clang links
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++$CLANG_VERSION 100
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang$CLANG_VERSION 100

# Some OS or specific versions could have additional requirements, if they do
# a script will be present in distro-scripts and we'll run it right after the more generic configuration
for VARIANT in $OS $VERSION $OS$VERSION
do 
    if [ -f ./distro-scripts/$VARIANT.sh ]; then
        echo "✅ Running configuration script for $VARIANT..."
        ./distro-scripts/$VARIANT.sh
    fi   
done 

# Clone Swift and all the related projects
git clone https://github.com/apple/swift

./swift/utils/update-checkout --clone
