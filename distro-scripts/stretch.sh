#!/bin/bash

echo "🍓 Fixing clang links..."

sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.8 100

echo "🍓 Installing Stretch dependencies..."

sudo apt remove swig swig3.0
sudo apt-get install libpcre3 libpcre3-dev
wget http://prdownloads.sourceforge.net/swig/swig-3.0.12.tar.gz

tar xzf swig-3.0.12.tar.gz
pushd swig-3.0.12

./configure
make
sudo make install

popd
rm -rf swig-3.0.12     
rm  swig-3.0.12.tar.gz                          

