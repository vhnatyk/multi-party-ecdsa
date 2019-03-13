#cd <your GMP sources>
make clean
make mostlyclean

platform_trgt="aarch64-linux-android"
ndk_ver="19b"
host_trgt="linux-x86_64"
api="24"
export ANDROID_NDK_HOME="$HOME/android-ndk-r$ndk_ver"
toolchain_dir="/toolchains/llvm/prebuilt/$host_trgt"
toolchain_bin_dir=$ANDROID_NDK_HOME$toolchain_dir/bin/
export CC="$toolchain_bin_dir$platform_trgt$api-clang"
export CXX="$toolchain_bin_dir$platform_trgt$api-clang++"
export AR="$toolchain_bin_dir$platform_trgt-ar"
export SYSROOT="$ANDROID_NDK_HOME$toolchain_dir/sysroot"
#export AARCH64_LINUX_ANDROID_OPENSSL_LIB_DIR="/usr/lib/x86_64-linux-gnu" #
export PATH=$toolchain_bin_dir:$PATH

./configure --enable-static --disable-shared --host=$platform_trgt
make
make install