call %BUILD_PREFIX%\Library\bin\run_autotools_clang_conda_build.bat
if errorlevel 1 exit 1

rm -r coincurve.egg-info/SOURCES.txt
rm -r libsecp256k1

rem %PYTHON% -m pip install . --ues-pep517 --no-deps --ignore-installed -vv
rem This fails apparently not setting a correct tempdir:
rem    running build_clib
rem     error: [WinError 193] %1 is not a valid Win32 application
rem     error: subprocess-exited-with-error
rem   full command: 'D:\bld\coincurve_1705706780261\_h_env\python.exe' 'D:\bld\coincurve_1705706780261\_h_env\lib\site-packages\pip\_vendor\pyproject_hooks\_in_process\_in_process.py' build_wheel 'C:\Users\VSSADM~1\AppData\Local\Temp\tmprfx5pfc9'

%PYTHON% setup.py install
exit 0