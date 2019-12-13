set -o errexit
set -o xtrace

export CFLAGS='-O2 -march=corei7 -mtune=skylake'

pushd deps/zlib
./configure
popd

rm -rf build
mkdir build

pushd build
cmake -DUSE_HTTPS=OFF -DREGEX_BACKEND=builtin -DUSE_BUNDLED_ZLIB=ON ..
cmake --build .
./libgit2_clar -spack::packbuilder::get_hash
popd
