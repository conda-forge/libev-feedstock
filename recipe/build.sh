# Get an updated config.sub and config.guess
set -ex
extra_args=""
if [[ "${target_platform}" == "win-64" ]]; then
  extra_args="${extra_args} --ld=${LD}"

  extra_args="${extra_args} --target-os=win64"
  extra_args="${extra_args} --enable-cross-compile"
  extra_args="${extra_args} --toolchain=msvc"
  extra_args="${extra_args} --host-cc=${CC}"
  extra_args="${extra_args} --extra-libs=ucrt.lib --extra-libs=vcruntime.lib --extra-libs=oldnames.lib"
else
cp $BUILD_PREFIX/share/libtool/build-aux/config.* .
fi
./configure --prefix="${PREFIX}" ${extra_args}
make
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
make check
fi

if [[ "${target_platform}" == "win-64" ]]; then
make install
fi
