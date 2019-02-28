#!/usr/bin/env bash
set -eu

./configure \
  --prefix="${PREFIX}" \
  --with-hepmc="${PREFIX}"

make -j${CPU_COUNT}
make install
