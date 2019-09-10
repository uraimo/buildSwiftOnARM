#!/bin/bash

echo "🍓 Fixing clang links..."

sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.8 100

