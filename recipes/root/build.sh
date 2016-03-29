#!/usr/bin/env bash

if [ -f ${RECIPE_DIR}/patches/${PKG_VERSION}_${PY_VER}.diff ]; then
    patch -p1 < ${RECIPE_DIR}/patches/${PKG_VERSION}_${PY_VER}.diff
fi

if [ "$PY3K" = "1" ]; then
    if [ -f ${RECIPE_DIR}/patches/${PKG_VERSION}_3.diff ]; then
        patch -p1 < ${RECIPE_DIR}/patches/${PKG_VERSION}_3.diff
    fi

    2to3 -w etc/dictpch/makepch.py > /dev/null 2>&1
else
    if [ -f ${RECIPE_DIR}/patches/${PKG_VERSION}_2.diff ]; then
        patch -p1 < ${RECIPE_DIR}/patches/${PKG_VERSION}_2.diff
    fi
fi

mkdir build_dir
cd build_dir || exit

if [ "$(uname)" == "Darwin" ]; then
    source ${RECIPE_DIR}/build_osx.sh
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    source ${RECIPE_DIR}/build_linux.sh
else
    exit 1
fi
