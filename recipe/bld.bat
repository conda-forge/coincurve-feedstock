copy "%RECIPE_DIR%\build_windows.sh" .
set PREFIX=%PREFIX:\=/%
set SRC_DIR=%SRC_DIR:\=/%
set MSYSTEM=MINGW%ARCH%
set MSYS2_PATH_TYPE=inherit
set CHERE_INVOKING=1
set BUILD_PLATFORM=win_amd64

makedirs \tmp

bash -lc "./build_windows.sh"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

rem %PYTHON% setup.py bdist_wheel --plat-name=win_amd64
rem if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

%PYTHON% setup.py install --single-version-externally-managed --record=record.txt
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

rem CLANG try, fails with unknown -EXPORT
rem call %BUILD_PREFIX%\Library\bin\run_autotools_clang_conda_build.bat
rem if errorlevel 1 exit 1

rem rm -r coincurve.egg-info/SOURCES.txt
rem rm -r libsecp256k1

rem rem %PYTHON% -m pip install . --ues-pep517 --no-deps --ignore-installed -vv
rem rem This fails apparently not setting a correct tempdir:
rem rem    running build_clib
rem rem     error: [WinError 193] %1 is not a valid Win32 application
rem rem     error: subprocess-exited-with-error
rem rem   full command: 'D:\bld\coincurve_1705706780261\_h_env\python.exe' 'D:\bld\coincurve_1705706780261\_h_env\lib\site-packages\pip\_vendor\pyproject_hooks\_in_process\_in_process.py' build_wheel 'C:\Users\VSSADM~1\AppData\Local\Temp\tmprfx5pfc9'

rem %PYTHON% setup.py install
rem if errorlevel 1 exit 1

rem exit 0