#!/bin/bash

set -eox pipefail

rm -rf ${SRC_DIR}/libsecp256k1
rm -rf ${SRC_DIR}/coincurve.egg-info

${PYTHON} -m pip install . --no-deps --ignore-installed -vv
