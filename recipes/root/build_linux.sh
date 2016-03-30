#!/usr/bin/env bash

# When root builds xrootd it fails to find "com_err.h", just symlink it to
# /usr/include until I can figure out how to properly fix it
ln -s ${PREFIX}/include/com_err.h /usr/include/com_err.h

CXXFLAGS="-D_GLIBCXX_USE_CXX11_ABI=0" \
CFLAGS="-D_GLIBCXX_USE_CXX11_ABI=0" \
CPPFLAGS="-D_GLIBCXX_USE_CXX11_ABI=0" \
CLINGCXXFLAGS="-D_GLIBCXX_USE_CXX11_ABI=0" \
LD_LIBRARY_PATH="$PREFIX/lib" \
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -Dgnuinstall=ON \
    -Droofit=ON \
    -Dtesting=OFF \
    -Dcastor=OFF \
    -Dbuiltin_davix=ON \
    -Dbuiltin_ftgl=ON \
    -Dbuiltin_freetype=ON \
    -Dbuiltin_glew=ON \
    -Dbuiltin_gsl=ON \
    -Dbuiltin_pcre=ON \
    -Dbuiltin_zlib=ON \
    -Dbuiltin_lzma=ON \
    -Dbuiltin_xrootd=ON

CXXFLAGS="-D_GLIBCXX_USE_CXX11_ABI=0" \
CFLAGS="-D_GLIBCXX_USE_CXX11_ABI=0" \
CPPFLAGS="-D_GLIBCXX_USE_CXX11_ABI=0" \
CLINGCXXFLAGS="-D_GLIBCXX_USE_CXX11_ABI=0" \
LD_LIBRARY_PATH="$PREFIX/lib/" \
make -j$CPU_COUNT

make install

# Make symlinks to python's site-packages directory
SITE_PACKAGES_DIR=$(python -c "import site; print(site.getsitepackages()[0])")
ln -s $PREFIX/lib/root $SITE_PACKAGES_DIR/root
ln -s $PREFIX/lib/root/ROOT.py $SITE_PACKAGES_DIR/ROOT.py
ln -s $PREFIX/lib/root/ROOT.pyc $SITE_PACKAGES_DIR/ROOT.pyc
ln -s $PREFIX/lib/root/ROOT.pyo $SITE_PACKAGES_DIR/ROOT.pyo

# Modify ROOT.py to append to the path
sed -i 's/import os, sys, types/import os, sys, types\nsys.path.append(os.path.join(os.path.dirname(__file__), "root"))/g' $PREFIX/lib/root/ROOT.py

# Copy a script into the bin directory which can be used for fixing paths inside
# the various binary files
cp ${RECIPE_DIR}/fix-binary.py $PREFIX/share/root/fix-binary.py
cp ${RECIPE_DIR}/cleanup.py $PREFIX/share/root/cleanup.py

# Add scripts to (un)set $ROOTSYS and $LD_LIBRARY_PATH on (de)activation
mkdir -p $PREFIX/etc/conda/activate.d
mkdir -p $PREFIX/etc/conda/deactivate.d
cp ${RECIPE_DIR}/activateROOT.sh $PREFIX/etc/conda/activate.d
cp ${RECIPE_DIR}/deactivateROOT.sh $PREFIX/etc/conda/deactivate.d

# Clean up
rm /usr/include/com_err.h
