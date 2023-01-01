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
    cd file_changelog
    pyinstaller -w -i  app_icon.ico  file_changelog.py -y
    if exist "dist/file_changelog.exe" (
        echo "file exists"
        xcopy dist\file_changelog\ ..\..\build\windows\runner\Debug\file_changelog\ /E /Y /F
        xcopy dist\file_changelog\ ..\..\build\windows\runner\release\file_changelog\ /E /Y /F
    ) else (
        echo "file not find"
    )
    cd ..
    cd ..
)