#!/usr/bin/env bash

mkdir -p "${PREFIX}/etc/grid-security"
cp ./* "${PREFIX}/etc/grid-security"

mkdir -p "${PREFIX}/share/grid-security"
sed "s/###CURRENT_VERSION###/${version}/g" "${RECIPE_DIR}/check_for_updates.py" > "${PREFIX}/share/grid-security/check_for_updates.py"
chmod +x "${PREFIX}/share/grid-security/check_for_updates.py"

mkdir -p "${PREFIX}/etc/conda/activate.d"
cp "${RECIPE_DIR}/activate.sh" "${PREFIX}/etc/conda/activate.d/activate-ca-policy-egi-core.sh"
cp "${RECIPE_DIR}/activate.csh" "${PREFIX}/etc/conda/activate.d/activate-ca-policy-egi-core.csh"
cp "${RECIPE_DIR}/activate.fish" "${PREFIX}/etc/conda/activate.d/activate-ca-policy-egi-core.fish"

mkdir -p "${PREFIX}/etc/conda/deactivate.d"
cp "${RECIPE_DIR}/deactivate.sh" "${PREFIX}/etc/conda/deactivate.d/deactivate-ca-policy-egi-core.sh"
cp "${RECIPE_DIR}/deactivate.csh" "${PREFIX}/etc/conda/deactivate.d/deactivate-ca-policy-egi-core.csh"
cp "${RECIPE_DIR}/deactivate.fish" "${PREFIX}/etc/conda/deactivate.d/deactivate-ca-policy-egi-core.fish"
