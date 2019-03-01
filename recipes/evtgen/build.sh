#!/usr/bin/env bash
set -eu

cd R??-??-??

./configure \
  --prefix="${PREFIX}" \
  --hepmcdir="${PREFIX}" \
  --pythiadir="${PREFIX}"
  # --photosdir="${PREFIX}"
  # --tauoladir="${PREFIX}"

# Parallel builds are unreliable
make -j1
make install

SHARE_DIR="${PREFIX}/share/evtgen"
mkdir -p "${SHARE_DIR}"
cp config.mk "${SHARE_DIR}"
cp DECAY.DEC "${SHARE_DIR}"
cp evt.pdl "${SHARE_DIR}"
