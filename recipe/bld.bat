mkdir %SRC_DIR%\build
if errorlevel 1 exit 1
pushd %SRC_DIR%\build
if errorlevel 1 exit 1

set BUILD_TYPE=Release

cmake -G "Ninja" ^
    %CMAKE_ARGS% ^
    -DCMAKE_BUILD_TYPE="%BUILD_TYPE%" ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DBUILD_SHARED_LIBS=ON ^
    -DBUILD_STATIC_LIBS=OFF ^
    -DBUILD_TESTING=OFF ^
    -DBUILD_CURL_EXE=ON ^
    -DUSE_NGHTTP2=OFF ^
    -DUSE_LIBIDN2=OFF ^
    -DUSE_WIN32_IDN=OFF ^
    -DCURL_WINDOWS_SSPI=ON ^
    -DCURL_USE_SCHANNEL=ON ^
    -DCURL_USE_LIBSSH2=ON ^
    -DCURL_USE_LIBPSL=OFF ^
    -DCURL_DISABLE_LDAP=ON ^
    -DCURL_ZSTD=ON ^
    -DENABLE_UNICODE=ON ^
    %SRC_DIR%
if errorlevel 1 exit 1

cmake --build . --config %BUILD_TYPE% --target install --verbose
if errorlevel 1 exit 1

move %LIBRARY_LIB%\libcurl_imp.lib %LIBRARY_LIB%\libcurl.lib
if errorlevel 1 exit 1

popd
if errorlevel 1 exit 1
