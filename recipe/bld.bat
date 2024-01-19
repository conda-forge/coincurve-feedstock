call %BUILD_PREFIX%\Library\bin\run_autotools_clang_conda_build.bat
if errorlevel 1 exit 1

%PYTHON% -m pip install . --no-deps --ignore-installed -vv
exit 0