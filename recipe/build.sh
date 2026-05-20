# Get an updated config.sub and config.guess
set -ex
if [[ "${target_platform}" != "win-64" ]]; then
  cp $BUILD_PREFIX/share/libtool/build-aux/config.* .
fi
./configure --prefix="${PREFIX}"
if [[ "${target_platform}" == "win-64" ]]; then
  patch_libtool
fi
make -j${CPU_COUNT:-1}
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
  make check
fi

if [[ "${target_platform}" == "win-64" ]]; then
  make install
fi
