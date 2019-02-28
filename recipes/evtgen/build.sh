#!/usr/bin/env bash
set -eu

cd R??-??-??

./configure \
  --prefix="${PREFIX}" \
  --hepmcdir="${PREFIX}" \
  --pythiadir="${PREFIX}"
  # --photosdir="${PREFIX}"
  # --tauoladir="${PREFIX}"

make -j${CPU_COUNT}
make install
