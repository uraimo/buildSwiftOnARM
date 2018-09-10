#!/bin/bash

echo "🍓 \033[1m Installing Raspbian dependencies...\033[0m"

sudo apt-get install libpcre3 libpcre3-dev
wget http://prdownloads.sourceforge.net/swig/swig-3.0.12.tar.gz

tar xzf swig-3.0.12.tar.gz
cd swig-3.0.12

./configure
make
sudo make install

cd ..
rm -rf swig-3.0.12     
                                                

