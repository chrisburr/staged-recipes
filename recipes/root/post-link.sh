#!/usr/bin/env bash

# In contrast to the conda documentation $RECIPE_DIR isn't actually available:
# http://conda.pydata.org/docs/building/build-scripts.html
# https://github.com/conda/conda/blob/7f1bb674a47caf9bb25de827c0e0192a1aa0cdf9/conda/install.py#L408
# Instead figure out $RECIPE_DIR by finding the location of this file.
python $PREFIX/share/root/fix-binary.py
