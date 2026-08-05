@echo on
set PKG_NAME=ev
set REMOVE_LIB_PREFIX=no
call %BUILD_PREFIX%\Library\bin\run_autotools_clang_conda_build.bat build.sh
if %ERRORLEVEL% neq 0 exit /b 1
