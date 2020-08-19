@echo off
color 17
set baseline=/?
if "%1"=="%baseline%" (
    color
    echo Syntax: edlin (file) (flags)
    echo Flags:
    echo /t : Typefile : Use the faster typefile mode in edlin (prevents use of line editing)
    echo It's not that hard!
    echo v2.2 (i guess) copyright 2020 Logan C.
    exit /b
)
call wintext %1 %2
color
cl