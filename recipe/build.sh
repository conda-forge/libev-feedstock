#!/usr/bin/env bash
set -euxo pipefail

cp "$BUILD_PREFIX/share/gnuconfig/config."* .

configure_args=(--prefix="$PREFIX")
if [[ "$target_platform" == win-* ]]; then
  configure_args+=(LIBS=-lws2_32)
fi
if [[ "$target_platform" == win-arm64 ]]; then
  target="--target=aarch64-pc-windows-msvc"
  CFLAGS="$CFLAGS $target"
  CXXFLAGS="$CXXFLAGS $target"
  CPPFLAGS="$CPPFLAGS $target"
  LDFLAGS="$LDFLAGS $target"
  configure_args+=(--build=x86_64-w64-mingw32 --host=aarch64-w64-mingw32)
fi
export CFLAGS CXXFLAGS CPPFLAGS LDFLAGS

./configure "${configure_args[@]}"
[[ "$target_platform" == win-* ]] && patch_libtool
make -j"${CPU_COUNT}"
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" != "1" ]]; then
  make check
fi
make install
