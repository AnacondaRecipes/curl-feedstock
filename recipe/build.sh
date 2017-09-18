#!/bin/bash

export PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig"
export C_INCLUDE_PATH="${PREFIX}/include"

if [ $(uname) == "Darwin" ]; then
    export DYLD_FALLBACK_LIBRARY_PATH="${PREFIX}/lib"
fi

./configure \
    --prefix=${PREFIX} \
    --host=${HOST} \
    --disable-ldap \
    --with-ca-bundle=${PREFIX}/ssl/cacert.pem \
    --with-ssl=${PREFIX} \
    --with-zlib=${PREFIX} \
    --with-gssapi=${PREFIX} \
    --with-libssh2=${PREFIX} \
|| cat config.log

make -j$CPU_COUNT
make test -j$CPU_COUNT
make install -j$CPU_COUNT

# Includes man pages and other miscellaneous.
rm -rf "${PREFIX}/share"
