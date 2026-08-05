#!/usr/bin/env bash
set -euxo pipefail

if [[ "$target_platform" != win-* ]]; then
  cp "$BUILD_PREFIX/share/gnuconfig/config."* .
fi

./configure --prefix="$PREFIX"
[[ "$target_platform" == win-* ]] && patch_libtool
make -j"${CPU_COUNT}"
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" != "1" ]]; then
  make check
fi
make install
