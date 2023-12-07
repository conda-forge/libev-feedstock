# Get an updated config.sub and config.guess
set -ex
cp $BUILD_PREFIX/share/libtool/build-aux/config.* .
./configure --prefix="${PREFIX}"
make
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
make check
fi

if [[ "${target_platform}" == "win-64" ]]; then
    make install
fi
