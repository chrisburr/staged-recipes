#!/usr/bin/env bash
set -eu

cd PhysTools/Meerkat

make --makefile StandAloneMakefile -j1 SHELL='bash -x'

mkdir -p "${PREFIX}/lib"
cp lib/libMeerkat* "${PREFIX}/lib"

mkdir -p "${PREFIX}/include"
cp -r Meerkat "${PREFIX}/include"
