#!/usr/bin/env bash
set -eu

mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    ..

make -j1
# make -j${CPU_COUNT}
make install
