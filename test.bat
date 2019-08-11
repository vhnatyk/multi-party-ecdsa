set RUST_BACKTRACE=full
set config=release

if /I "%config%"=="release" (set configp=--release) else (set configp=)
cargo build %configp% --bin sm_manager --target=i686-pc-windows-msvc
cargo build %configp% --bin gg18_keygen_client --target=i686-pc-windows-msvc

set "rel_work_dir=target\i686-pc-windows-msvc\%config%"

IF %ERRORLEVEL% NEQ 0 (
    @echo "build command execution failed."
) else (
    @echo "build command execution success."
    REM rd /S /Q target\out\%config%\
    REM mkdir target\out\%config%\
    REM copy target\%target%\%config%\lib%libname%.* target\out\%config%\


    copy /Y params %rel_work_dir%

    copy /Y %userprofile%\.rustup\toolchains\nightly-2019-05-16-x86_64-pc-windows-msvc\lib\rustlib\i686-pc-windows-msvc\lib\gmp*.* %rel_work_dir%

    cd %rel_work_dir%

    start sm_manager

    FOR /L %%p IN (1,1,10) DO start cmd /K gg18_keygen_client http://192.168.43.7:8001 p%%p_keys.store

    cd ..
    cd ..
    cd ..
)