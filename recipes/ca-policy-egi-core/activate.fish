#!/usr/bin/env fish

# TODO Check if X509_CERT_DIR and X509_VOMS_DIR is already set
set -gx X509_CERT_DIR "$CONDA_PREFIX/etc/grid-security/certificates"
set -gx X509_VOMS_DIR "$CONDA_PREFIX/etc/grid-security/vomsdir"

$CONDA_PREFIX/share/grid-security/check_for_updates.py
