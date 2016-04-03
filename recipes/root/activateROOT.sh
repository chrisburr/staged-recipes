export ROOTSYS=$CONDA_ENV_PATH
export LDFLAGS=-Wl,-rpath,$CONDA_ENV_PATH/lib,-rpath,$CONDA_ENV_PATH/lib/root

if [ ! -z "$LD_LIBRARY_PATH" ]; then
  echo ""
  echo "WARNING: LD_LIBRARY_PATH is currently set to '$LD_LIBRARY_PATH'";
  echo ""
  echo "Unless this is intentional this probably needs to be unset using: 'unset LD_LIBRARY_PATH'"
  echo ""
fi

if [ ! -z "$PYTHONPATH" ]; then
  echo ""
  echo "WARNING: PYTHONPATH is currently set to '$PYTHONPATH'";
  echo ""
  echo "Unless this is intentional this probably needs to be unset using: 'unset PYTHONPATH'"
  echo ""
fi
