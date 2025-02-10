cmake -B build -G "Ninja" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DBUILD_SHARED_LIBS=ON ^
    -DBUILD_STATIC_LIBS=ON ^
    -DSTATIC_LIB_SUFFIX=_a ^
    -DCURL_STATICLIB=ON ^
    -DCURL_USE_SCHANNEL=ON ^
    -DCURL_ZLIB=ON ^
    -DCURL_USE_SSH=ON ^
    -DENABLE_IDN=OFF ^
    -DCURL_ENABLE_SSPI=ON ^
    -DCURL_ENABLE_UNICODE=ON ^
    -DCURL_USE_LIBPSL=OFF ^
    -DCMAKE_SYSTEM_PROCESSOR=%ARCH_STRING%

cmake --build build --config Release
cmake --install build

if errorlevel 1 exit 1
exit 0

