unset ROOTSYS
export LD_LIBRARY_PATH=$(python -c "'$LD_LIBRARY_PATH'.replace('$CONDA_ENV_PATH/lib/root', '').replace('::', ':')")
