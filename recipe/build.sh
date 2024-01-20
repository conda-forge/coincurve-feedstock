#!/bin/bash

build_dll() {
    # Prevent calling 'sh', which seems to drop-off the BASH framework on windows
    sed -i 's@#!/bin/sh@@' ./autogen.sh
    bash ./autogen.sh
    ./configure --disable-dependency-tracking \
                --enable-benchmark=no \
                --enable-experimental \
                --enable-exhaustive-tests=no \
                --enable-module-recovery \
                --enable-module-ecdh \
                --enable-module-extrakeys \
                --enable-module-schnorrsig \
                --enable-static \
                --enable-tests=no \
                --with-pic
    make
    make check
}

set -eox pipefail

rm -rf ${SRC_DIR}/libsecp256k1
rm -rf ${SRC_DIR}/coincurve.egg-info

if [[ "$target_platform" == win* ]]; then
 	export CFLAGS+=" -Wno-error=unused-function "
 	export GCC_ARCH=x86_64-w64-mingw32
 	export EXTRA_FLAGS=-DMS_WIN64

  mv ./coincurve/_windows_libsecp256k1.py ./coincurve/_libsecp256k1.py
  curl -sLO "https://github.com/bitcoin-core/secp256k1/archive/$COINCURVE_UPSTREAM_REF.tar.gz")
  tar xzf "$COINCURVE_UPSTREAM_REF.tar.gz"
  mv "secp256k1-$COINCURVE_UPSTREAM_REF" secp256k1

  (cd secp256k1; build_dll; cp .libs/secp256k1-0.dll ../coincurve/libsecp256k1.dll)

  ${PYTHON} setup.py bdist_wheel --plat-name=win_amd64
else
  ${PYTHON} -m pip install . --no-deps --ignore-installed -vv
fi
