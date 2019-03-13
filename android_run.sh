cargo dinghy all-devices
read -p "pls enter device id: " dev_id
host_var="linux-x86_64"

#example how RUSTFLAGS env var may be used to pass aditional params to rustc/cargo/clang
# export RUSTFLAGS='-C no-integrated-as -C link-args=-lclang_rt.builtins-aarch64-android'
ndk_ver="19b"
export ANDROID_NDK_HOME="$HOME/android-ndk-r$ndk_ver"
trgt="aarch64-linux-android"
#export compil_type="_static" # copy content of your $SYSROOT to the folder with appended '_static, then 
#                               remove all dynamic .so.* files, except liblog.so
#                               LLVM will always ignore .a files if .so.* present
#                               You may want to leave as much .so files
api_num="24"

## environment vars for additional tools
# export CC="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$host_var/bin/$trgt$api_num-clang"
# export CXX="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$host_var/bin/$trgt$api_num-clang++"
# export AR="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$host_var/bin/$trgt-ar"

arch_lib_dir="/usr/lib/$trgt/$api_num$compil_type"

export SYSROOT="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$host_var/sysroot$arch_lib_dir"
export AARCH64_LINUX_ANDROID_OPENSSL_LIB_DIR=$SYSROOT
export OPENSSL_DIR="/usr/" #depends on your OS and OpenSSL setup

## setting some additional vars may be required
# export PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig"
# export PATH="$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/$host_var/bin":$PATH
export LIBRARY_PATH=$LIBRARY_PATH:"/usr/lib/x86_64-linux-gnu:/usr/local/lib:$SYSROOT"

verb_lev="" ##verbosity level default
# verb_lev="-vvv" #unless fails

# export RUST_BACKTRACE=1 #show trace if crashes

# action="test"
action="bench"

cargo dinghy -d $dev_id --platform auto-android-aarch64-api$api_num $verb_lev $action

## some extra info on helpful stuff for things like connect to device etc
# sudo apt-get update
# sudo apt-get install pkg-config
# sudo apt-get install go-mtpfs
# sudo apt-get install libmtp
# sudo apt-get install mtpfs mtp-tools