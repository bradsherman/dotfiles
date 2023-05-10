#!/bin/bash

rm -rf build/
git pull origin master
make CMAKE_INSTALL_PREFIX=/home/bsherman/nvim  CMAKE_BUILD_TYPE=Release
make install
