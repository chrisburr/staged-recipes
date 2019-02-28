#!/usr/bin/env bash
set -eu

sed -i.bak 's@Core RIO Tree@Core RIO RooFit RooFitCore RooStats Hist Tree Matrix Physics MathCore@g' CMakeLists.txt
rm CMakeLists.txt.bak
sed -i.bak 's@Core RIO RooFit RooFitCore RooStats Hist Tree Matrix Physics MathCore@${ROOT_LIBRARIES}@g' src/CMakeLists.txt
rm src/CMakeLists.txt.bak

mkdir build
cd build
cmake \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_OSX_SYSROOT="${CONDA_BUILD_SYSROOT}" \
    -DCMAKE_OSX_DEPLOYMENT_TARGET="${MACOSX_DEPLOYMENT_TARGET}" \
    -DCMAKE_INSTALL_RPATH="${PREFIX}/lib" \
    -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
    ..

make -j${CPU_COUNT}
make install
