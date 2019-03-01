#!/usr/bin/env bash
set -eux

export CONDA_BUILD_SYSROOT=$HOME/Development/MacOSX-SDKs/MacOSX10.9.sdk

cd R01-07-00/validation
pwd

sed -i 's#INCLUDEDIR = ${BASEDIR}#INCLUDEDIR = ${BASEDIR}/include#g' Makefile

find . -type f -exec sed -i "s#\.\./#${CONDA_PREFIX}/share/evtgen/#g" {} \;

./configure

make

bash genAllDecayExamples.sh

bash compareAllDecays.sh

# - ./testCPVDecays.cc
