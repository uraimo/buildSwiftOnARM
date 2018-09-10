#!/bin/bash

sudo apt-get install libpcre3 libpcre3-dev

wget http://prdownloads.sourceforge.net/swig/swig-3.0.12.tar.gz
tar xzf swig-3.0.12.tar.gz
cd swig-3.0.12
./configure
make
sudo make install