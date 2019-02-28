#!/usr/bin/env bash
set -eu

mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_OSX_SYSROOT="${CONDA_BUILD_SYSROOT}" \
    -DCMAKE_OSX_DEPLOYMENT_TARGET="${MACOSX_DEPLOYMENT_TARGET}" \
    -DCMAKE_INSTALL_RPATH="${PREFIX}/lib" \
    -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
    -Dmomentum:STRING=MEV \
    -Dlength:STRING=MM \
    ../hepmc_source

make -j${CPU_COUNT}
make install
