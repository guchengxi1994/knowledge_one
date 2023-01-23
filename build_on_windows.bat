@echo off

set input1=%1%
set input2=%2%

:: 参数1接受 run 或者 build

if "%input1%"=="run" (
    flutter  run   -d windows
) else (
    conda activate minum
    cd rpc_python
    :: file_changelog
    :: cd file_changelog
    pyinstaller -w -i  app_icon.ico  server.py -y
    if exist "dist/file_changelog.exe" (
        echo "file exists"
        xcopy dist\server\ ..\..\build\windows\runner\Debug\server\ /E /Y /F
        xcopy dist\server\ ..\..\build\windows\runner\release\server\ /E /Y /F
    ) else (
        echo "file not find"
    )
    cd ..
    cd ..
)