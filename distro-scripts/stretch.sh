#!/bin/bash

echo "🍓 \033[1m Installing Strech dependencies...\033[0m"

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

