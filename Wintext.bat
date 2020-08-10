@echo off
set undo=0
set baseline=
set arg1="%1"
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

echo. >> "%dir%%filename%"
goto :textadd

:SPLIT
SETLOCAL
SET /a fcount=1999999999
SET /a llimit=1
SET /a lcount=%llimit%
FOR /f "usebackqdelims=" %%a IN (%dir%%filename%) DO (
 CALL :select
 >>"%dir%%filename%$$" ECHO(%%a
)
SET /a lcount=%llimit%
:select
SET /a lcount+=1
IF %lcount% lss %llimit% GOTO :EOF >NUL 2>nul
SET /a lcount=0
SET /a fcount+=1
MOVE /y "%dir%%filename%$$" "%dir%%filename%line%fcount:~-9%" >NUL 2>nul
attrib +h "%dir%%filename%line%fcount:~-9%" >NUL 2>nul
echo %fcount:~-9% > "%dir%%filename%fcount"
GOTO :EOF

:textadd
set /a undo+=1
cls
if %undo% geq 11 set undo=1
echo =====WinTXT -- A Command Line Editor For Windows=====
echo =====Current Undo State is: %undo%=====
echo =====%dir%%filename%=====

call :split
set /p fcount2= < "%dir%%filename%fcount"
del "%dir%%filename%fcount"

set lcount=2000000000

:linebyline
set /a lcount+=1
set /p Line= <"%dir%%filename%line%lcount:~-9%"
set lcount1=%lcount:~-9%
set /a lcount1+=1
set /a lcount1-=1
echo Line: %lcount1% : %Line%
if %lcount:~-9% equ %fcount2% goto :edit
goto :linebyline

:edit
echo.
attrib -h "%dir%%filename%%undo%" > nul
copy /y "%dir%%filename%" "%dir%%filename%%undo%" > nul 2>nul
attrib +h "%dir%%filename%%undo%" > nul
set /p text="Type:" 2> nul
(echo %text% | findstr /i /c:"/undo" >nul ) && (goto :undo) || (echo. > nul )
(echo %text% | findstr /i /c:"/redo" >nul ) && (goto :redo) || (echo. > nul )
(echo %text% | findstr /i /c:"/del" >nul ) && (goto :del) || (echo. > nul )
(echo %text% | findstr /i /c:"/line" >nul ) && (goto :line) || (echo. > nul )
(echo %text% | findstr /i /c:"/linebreak" >nul ) && (goto :linebreak) || (echo. > nul )
(echo %text% | findstr /i /c:"/exit" >nul ) && (goto :undoclear) || (echo. > nul ) 
(echo %text% | findstr /i /c:"/help" >nul ) && (goto :help) || (goto :addtext)

:addtext
echo %text% >> "%dir%%filename%" 2> nul
goto :textadd

:fileopen
set dir=
set filename=%arg1%
echo. >> "%dir%%filename%"
goto :textadd

:skip
set %dir%=
echo. >> "%dir%%filename%"
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
del "%dir%%filename%"
goto :textadd

:linebreak
echo. >> "%dir%%filename%"
goto :textadd

:line
set text=%text:/line =%
echo 1
echo %text%
pause
set lcount=2000000000
echo 2
pause
set /a lcount+=%text%
echo 3
echo %lcount%
pause
set lcount1=%lcount:~-9%
echo 4
echo %lcount1%
pause
set /a lcount1+=1
echo 5
echo %lcount1%
pause
set /a lcount1+=1
echo 6
echo %lcount1%
set /a undo+=1
cls
if %undo% geq 11 set undo=1
echo =====WinTXT -- A Command Line Editor For Windows=====
echo =====Current Undo State is: %undo%=====
echo =====%dir%%filename%=====
echo =====Current Line Is: %lcount1%=====
echo.
set /p Line= <"%dir%%filename%line%lcount:~-9%"
echo Line: %lcount1% : %Line%
echo %lcount:~-9%%
echo %line%
echo.
attrib -h "%dir%%filename%%undo%" > nul
copy /y "%dir%%filename%" "%dir%%filename%%undo%" > nul 2>nul
attrib +h "%dir%%filename%%undo%" > nul
set /p text="Type:" 2> nul
(echo %text% | findstr /i /c:"/undo" >nul ) && (goto :undo) || (echo. > nul )
(echo %text% | findstr /i /c:"/redo" >nul ) && (goto :redo) || (echo. > nul )
(echo %text% | findstr /i /c:"/del" >nul ) && (goto :del) || (echo. > nul )
(echo %text% | findstr /i /c:"/line" >nul ) && (goto :line) || (echo. > nul )
(echo %text% | findstr /i /c:"/linebreak" >nul ) && (goto :linebreak) || (echo. > nul )
(echo %text% | findstr /i /c:"/exit" >nul ) && (goto :undoclear) || (echo. > nul ) 
(echo %text% | findstr /i /c:"/help" >nul ) && (goto :help) || (goto :addtextline)

:addtextline
echo %text% >> "%dir%%filename%line%lcount:~-9%" 2> nul
goto :rebuild

:rebuild
echo We can defeat COVID!
set lcount=2000000000

set /a lcount+=1
set /p Line= <"%dir%%filename%line%lcount:~-9%"
set lcount1=%lcount:~-9%
set /a lcount1+=1
set /a lcount1-=1
echo %Line% > "%dir%%filename%"

:rebuildlinebyline
set /a lcount+=1
set /p Line= <"%dir%%filename%line%lcount:~-9%"
set lcount1=%lcount:~-9%
set /a lcount1+=1
set /a lcount1-=1
echo %Line% >> "%dir%%filename%"
if %lcount:~-9% equ %fcount2% goto :textadd
goto :rebuildlinebyline



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
echo /redo : Redo the previous undone command.
echo /del : Delete the current file. (can be undone with /undo.)
echo /linebreak : Insert a line break.
echo /line (line number) : Coming...
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