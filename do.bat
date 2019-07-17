call setenv
REM set "AZURE_SDK_PATH=C:\Program Files (x86)\Microsoft Azure Sphere SDK"
REM call "%AZURE_SDK_PATH%\InitializeCommandPrompt.cmd"
echo %deb_ug%
REM set "LLVM32=C:\Progra~2\LLVM"
REM set "LLVM_BIN=%LLVM32%\bin"
REM set "PATH=%PATH%;%LLVM_BIN%""

REM set "CC=%LLVM_BIN%\clang.exe"
REM set "CXX=%LLVM_BIN%\clang++.exe"
REM set "AR=%LLVM_BIN%\llvm-ar.exe"

REM set cc=clang
REM set cxx=clang++
REM set ar=llvm-ar

REM set CC=cl
REM set CXX=clang++
REM set AR=llvm-ar

set cc=gcc
set cxx=g++
REM REM set ar=ar

REM arch_lib_dir="/usr/lib/$trgt/$api_num$compil_type"

REM set SYSROOT="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$host_var/sysroot$arch_lib_dir"
REM set AARCH64_LINUX_ANDROID_OPENSSL_LIB_DIR=$SYSROOT
REM set OPENSSL_DIR="/usr/" #depends on your OS and OpenSSL setup

REM ## setting some additional vars may be required
REM # set PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig"
REM # set PATH="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$host_var/bin":$PATH
REM set LIBRARY_PATH=$LIBRARY_PATH:"/usr/lib/x86_64-linux-gnu:/usr/local/lib:$SYSROOT"

rem set verb_lev="" 
rem verbosity level default
set "verb_lev=--verbose --verbose --verbose" 

rem show trace if crashes
set RUST_BACKTRACE=1 

REM set action=test
REM set action=bench
set action=build

REM cargo %action% --target wasm32-unknown-unknown %verb_lev% 

rem command itself
REM xargo build --target armv7-linux-eabi %verb_lev%
xargo build --release --target arm-v7-none-eabi %verb_lev%


REM "gcc" "-O3" "-ffunction-sections" "-fdata-sections" "-fPIC" "-fno-builtin" "-fvisibility=hidden" "-ffreestanding" "-DVISIBILITY_HIDDEN" "-o" "C:\\Users\\utech\\AppData\\Local\\Temp\\xargo.DZBFWVwpGbCY\\target\\arm-v7-none-eabi\\release\\build\\compiler_builtins-4e136e1759a8ac54\\out\\.\\compiler-rt\\lib\\builtins\\absvdi2.o" "-c" ".\\compiler-rt\\lib\\builtins\\absvdi2.c"

rem "gcc" "-O3" "-ffunction-sections" "-fdata-sections" "-fPIC" "-fno-builtin" "-fvisibility=hidden" "-ffreestanding" "-fomit-frame-pointer" "-DVISIBILITY_HIDDEN" "-o" "C:\\Users\\utech\\AppData\\Local\\Temp\\xargo.Bt4Wk4BvNAb9\\target\\arm-v7-none-eabi\\release\\build\\compiler_builtins-4e136e1759a8ac54\\out\\.\\compiler-rt/lib/builtins\\arm\\aeabi_cdcmp.o" "-c" ".\\compiler-rt/lib/builtins\\arm/aeabi_cdcmp.S"

REM C:\Users\utech\AppData\Local\Temp\xargo.Bt4Wk4BvNAb9\target\arm-v7-none-eabi\release\build\compiler_builtins-4e136e1759a8ac54\out\

rem C:\WINDOWS\system32\cmd.exe /k "C:\Program Files\Emscripten\emsdk_env.bat"