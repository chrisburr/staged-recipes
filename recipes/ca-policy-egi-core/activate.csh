#!/usr/bin/env csh

# TODO Check if X509_CERT_DIR and X509_VOMS_DIR is already set
setenv X509_CERT_DIR "${CONDA_PREFIX}/etc/grid-security/certificates"
setenv X509_VOMS_DIR "${CONDA_PREFIX}/etc/grid-security/vomsdir"

${CONDA_PREFIX}/share/grid-security/check_for_updates.py
