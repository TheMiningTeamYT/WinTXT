@echo off
set undo=0
set baseline=
set arg1=%1
if "%arg1%"=="%baseline%" goto :beginning
goto :fileopen

:beginning
cls
echo Welcome to WinTXT, A Command Line Editor For Windows!!
echo This program was made by Logan C.
pause

:start
cls
echo What would you like to name your file (and be sure to add a file extension)?
set /p filename="Enter Filename:"
if exist %filename% goto :skip

cls
echo Where would you like to place your file? (Default is (your user directory)\WinTXTDocs)
set /p dir="Enter Directory:"
if not defined dir set dir="%userprofile%\NanoDocs"

cls
if not exist "%dir%" mkdir "%dir%

echo. >> %dir%%filename%

:textadd
set /a undo+=1
cls
if %undo% geq 11 set undo=1
echo =====WinTXT -- A Command Line Editor For Windows=====
echo =====Current Undo State is: %undo%=====
echo =====%dir%%filename%=====
type "%dir%%filename%" 2> nul
echo.
attrib -h "%dir%%filename%%undo%" > nul
copy /y "%dir%%filename%" "%dir%%filename%%undo%" > nul 2>nul
attrib +h "%dir%%filename%%undo%" > nul
set /p text="Type:" 2> nul
(echo %text% | findstr /i /c:"/exit" >nul ) && (goto :undoclear) || (echo %text% >> "%dir%%filename%" 2> nul) 
(echo %text% | findstr /i /c:"/undo" >nul ) && (goto :undo) || (echo. > nul )
(echo %text% | findstr /i /c:"/redo" >nul ) && (goto :redo) || (echo. > nul )
(echo %text% | findstr /i /c:"/del" >nul ) && (goto :del) || (echo. > nul )
(echo %text% | findstr /i /c:"/linebreak" >nul ) && (goto :linebreak) || (echo. > nul )
(echo %text% | findstr /i /c:"/help" >nul ) && (goto :help) || (goto :textadd)

:fileopen
set dir=
set filename=%arg1%
goto :textadd

:skip
set %dir%= 
goto :textadd

:undo
if %undo% equ 1 set undo=11
set /a undo-=1 2> nul
type "%dir%%filename%%undo%" > "%dir%%filename%"
set /a undo-=1 2> nul
goto :textadd

:redo
if %undo% equ 10 set undo=0
set /a undo+=1 2> nul
type "%dir%%filename%%undo%" > "%dir%%filename%"
set /a undo-=1 2> nul
goto :textadd

:del
del %dir%%filename% 
goto :textadd

:linebreak
echo. >> %dir%%filename%
goto :textadd

:undoclear
set undo=11

:undoclear1
if %undo% equ 1 set undo=11
del /a h "%dir%%filename%%undo%" 2> nul
set /a undo-=1
if %undo% leq 1 goto :exit
goto :undoclear1

:help
cls

echo Welcome to the help for WinTXT, A Command Line Editor For Windows!
echo.
echo #1: How to enter commands:
echo At the "Type:" prompt, type the one of the commands shown below:
echo.
echo #2: Commands:
echo.
echo /exit : Exit Nano For Windows.
echo /undo : Undo the previous command.
echo /help : This help screen.
echo.
echo And, if you have any bugs / need help, please email helpmewithstuff@protonmail.com .
pause

cls
echo Thank you for using WinTXT.
pause
goto :textadd

:exit
set undo=1
del /a h "%dir%%filename%%undo%" 2> nul
set undo=1
del /a h "%dir%%filename%%undo%" 2> nul
cls

echo Thank you for using WinTXT!
echo I hope it's not too terrible. hehe
pause
choice /c yn /n /m "Do you want to edit another file? Y/N"
if %errorlevel% equ 1 goto :start
if %errorlevel% equ 2 exit /b