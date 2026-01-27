mkdir -p %SRC_DIR%\build
cd %SRC_DIR%\build

set BUILD_TYPE=Release

cmake -G "Ninja" ^
    %CMAKE_ARGS% ^
    -DCMAKE_BUILD_TYPE="%BUILD_TYPE%" ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DBUILD_SHARED_LIBS=ON ^
    -DBUILD_STATIC_LIBS=OFF ^
    -DCURL_USE_SCHANNEL=ON ^
    -DCURL_ZLIB=ON ^
    -DCURL_USE_LIBSSH2=ON ^
    -DUSE_NGHTTP2=ON ^
    -DBUILD_CURL_EXE=ON ^
    -DCURL_WINDOWS_SSPI=ON ^
    -DENABLE_UNICODE=ON ^
    -DCURL_USE_LIBPSL=OFF ^
    -DCURL_DISABLE_LDAP=ON ^
    -DCURL_ZSTD=ON ^
    -DUSE_WIN32_IDN=OFF ^
    -DBUILD_TESTING=OFF ^
    %SRC_DIR%
if errorlevel 1 exit 1

cmake --build . --config %BUILD_TYPE% --target install --verbose
if errorlevel 1 exit 1
