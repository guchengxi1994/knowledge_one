@echo off

set input1=%1%
set input2=%2%

:: 参数1接受 run 或者 build

if "%input1%"=="run" (
    flutter  run   -d windows
) else (
    conda activate minum
    cd rpc
    :: file_changelog
    cd file_changelog
    pyinstaller -i app_icon.ico -F file_changelog.py
    if exist "dist/file_changelog.exe" (
        echo "file exists"
        copy dist\file_changelog.exe ..\..\build\windows\runner\Debug\file_changelog.exe /y 
    ) else (
        echo "file not find"
    )
    cd ..
    cd ..
)