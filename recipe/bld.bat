call %BUILD_PREFIX%\Library\bin\run_autotools_clang_conda_build.bat
if errorlevel 1 exit 1

rm -r coincurve.egg-info/SOURCES.txt
rm -r libsecp256k1

%PYTHON% -m pip install . --ues-pep517 --no-deps --ignore-installed -vv
exit 0