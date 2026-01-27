#!/bin/bash
set -ex

mkdir -p build || true
pushd build

export CFLAGS="$CFLAGS $CPPFLAGS"
export BUILD_TYPE="Release"

if [[ "$target_platform" == "osx-"* ]]; then
    SSL_OPTIONS="-DCURL_USE_OPENSSL=ON -DCURL_USE_SECTRANSP=ON"
else
    SSL_OPTIONS="-DCURL_USE_OPENSSL=ON"
fi

# Configure the build with CMake
cmake \
    -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_STATIC_LIBS=OFF \
    -DCURL_CA_BUNDLE=${PREFIX}/ssl/cacert.pem \
    ${SSL_OPTIONS} \
    -DCURL_ZLIB=ON \
    -DCURL_USE_LIBSSH2=ON \
    -DUSE_NGHTTP2=ON \
    -DBUILD_CURL_EXE=ON \
    -DCURL_USE_LIBPSL=OFF \
    -DCURL_DISABLE_LDAP=ON \
    -DCURL_ZSTD=ON \
    -DCURL_USE_GSSAPI=ON \
    -DCURL_USE_LIBSSH2=ON \
    -DBUILD_TESTING=OFF \
    ..

cmake --build . --config ${BUILD_TYPE} --parallel ${CPU_COUNT} --target install --verbose

popd
