@echo off
setlocal ENABLEDELAYEDEXPANSION
set undo=0
set deleted=0
set newline=0
set typefile=0
set typefileonce=0
set splitfile=0
set splitfileonce=0
set dir=
set filename=
set wintext=wintext
set WinTXT=WinTXT
set input=0
set arg1="%1"
set arg2="%2"
set arg3="%3"
set arg4="%4"
(echo "%arg1%" | findstr /i /c:"-?" >nul ) && (goto :helparg1) || (echo. > nul)
(echo "%arg2%" | findstr /i /c:"-?" >nul ) && (goto :helparg2) || (echo. > nul)
(echo "%arg3%" | findstr /i /c:"-?" >nul ) && (goto :helparg3) || (echo. > nul)
(echo "%arg1%" | findstr /i /c:"/h" >nul ) && (goto :help2arg1) || (echo. > nul)
(echo "%arg1%" | findstr /i /c:"/n" >nul ) && (goto :namearg1) || (echo. > nul)
(echo "%arg2%" | findstr /i /c:"/n" >nul ) && (goto :namearg2) || (echo. > nul)
(echo "%arg3%" | findstr /i /c:"/n" >nul ) && (goto :namearg3) || (echo. > nul)
(echo "%arg1%" | findstr /i /c:"-t" >nul ) && (goto :targ1) || (echo. > nul )
(echo "%arg2%" | findstr /i /c:"-t" >nul ) && (goto :targ2) || (echo. > nul )

set baseline=""
if "%arg1%"=="%baseline%" goto :beginning
set input=1
goto :fileopen

:targ1
set typefile=1
if "%arg2%"=="%baseline%" goto :beginning
set input=2
goto :fileopen

:2targ1
set typefile=1
goto :beginning

:3targ1
set typefile=1
set input=2
goto :fileopen

:3targ2
set typefile=1
set input=1
goto :fileopen

:2targ1
set typefile=1
goto :beginning

:targ2
set typefile=1
set input=1
goto :fileopen

:helparg1
goto :commandlinehelp

:helparg2
set arg1=%arg2%
goto :commandlinehelp

:helparg3
set arg1=%arg3%
goto :commandlinehelp

:help2arg1
set wintext=%arg1:/h =%
for /f "useback tokens=*" %%a in ('!wintext!') do set wintext=%%~a
for /f "useback tokens=*" %%a in ('!wintext!') do set wintext=%%~a
for /f "useback tokens=*" %%a in ('!wintext!') do set wintext=%%~a
for /f "useback tokens=*" %%a in ('!wintext!') do set wintext=%%~a
goto :commandlinehelp

:namearg1
set WinTXT=!arg2!
for /f "useback tokens=*" %%a in ('!wintxt!') do set WinTXT=%%~a
for /f "useback tokens=*" %%a in ('!wintxt!') do set WinTXT=%%~a
title %WinTXT%
goto :beginning

:namearg2
set WinTXT=!arg3!
for /f "useback tokens=*" %%a in ('!wintxt!') do set WinTXT=%%~a
for /f "useback tokens=*" %%a in ('!wintxt!') do set WinTXT=%%~a
title %WinTXT%
(echo "%arg1%" | findstr /i /c:"-t" >nul ) && (goto :2targ1) || (echo. > nul )
set baseline=""
if "%arg1%"=="%baseline%" goto :beginning
set input=1
goto :fileopen

:namearg3
set WinTXT=!arg4!
for /f "useback tokens=*" %%a in ('!wintxt!') do set WinTXT=%%~a
for /f "useback tokens=*" %%a in ('!wintxt!') do set WinTXT=%%~a
title %WinTXT% 
(echo "%arg1%" | findstr /i /c:"-t" >nul ) && (goto :3targ1) || (echo. > nul )
(echo "%arg2%" | findstr /i /c:"-t" >nul ) && (goto :3targ2) || (echo. > nul )
set baseline=""
if "%arg1%"=="%baseline%" goto :beginning
if "%arg2%"=="%baseline%" goto :beginning
set input=1
goto :fileopen

:beginning
cls
echo Welcome to !wintxt!, A Command Line Editor For Windows!!
echo This program was made by Logan C.
pause

:start
cls
echo What would you like to name your file (and be sure to add a file extension)?
set /p filename="Enter Filename: "
if exist %filename% goto :skip

cls
echo Where would you like to place your file? (Default is (your user directory)\!wintxt!Docs)
set /p dir="Enter Directory: "
if not defined dir set dir=%userprofile%\!wintxt!Docs\
set dirend=%dir:~-1%
if not "%dirend%"=="\" set dir=%dir%\

cls
if not exist "%dir%" mkdir "%dir%

if exist "%dir%%filename%" (
    if not exist C:\DocTemp\ mkdir C:\DocTemp\
    copy "%dir%%filename%" C:\DocTemp\doctemp.txt
)
echo. >> "C:\DocTemp\doctemp.txt"
goto :textadd

:SPLIT
SETLOCAL DISABLEDELAYEDEXPANSION
if not exist C:\DocTemp\ mkdir C:\DocTemp\
copy "C:\DocTemp\doctemp.txt" C:\DocTemp\temp.txt > nul
SET /a fcount=1999999999
SET /a llimit=1
SET /a lcount=%llimit%
FOR /f "usebackqdelims=" %%a IN (C:\DocTemp\temp.txt) DO (
 CALL :select
 >>"C:\DocTemp\temp.txt$$" ECHO(%%a
)
SET /a lcount=%llimit%
:select
SET /a lcount+=1
IF %lcount% lss %llimit% GOTO :EOF >NUL 2>nul
SET /a lcount=0
SET /a fcount+=1
MOVE /y "C:\DocTemp\temp.txt$$" "C:\DocTemp\doctemp.txtline%fcount:~-9%" >NUL 2>nul
attrib +h "C:\DocTemp\doctemp.txtline%fcount:~-9%" >NUL 2>nul
echo %fcount:~-9% > "C:\DocTemp\doctemp.txtfcount"

GOTO :EOF

:textadd
set newline=0
set /a undo+=1
cls
if %undo% geq 11 set undo=1
echo =====!wintxt! -- A Command Line Editor For Windows=====
echo =====Current Undo State is: %undo%=====
set display=%dir%%filename%
for /f "useback tokens=*" %%a in ('%display%') do set display=%%~a
for /f "useback tokens=*" %%a in ('%display%') do set display=%%~a
for /f "useback tokens=*" %%a in ('%display%') do set display=%%~a
for /f "useback tokens=*" %%a in ('%display%') do set display=%%~a
echo =====%display%=====
echo.
if %deleted% equ 1 (
    set deleted=0
    goto :edit
)
if %splitfile% equ 1 (
    set textadd=0
)
if %typefile% equ 1 (
    type "C:\DocTemp\doctemp.txt"
    goto :edit
)
if %typefileonce% equ 1 (
    type "C:\DocTemp\doctemp.txt"
    set %typefileonce% equ 0
    goto :edit
)
if %splitfileonce% equ 1 (
    call :split
    setlocal ENABLEDELAYEDEXPANSION
    del C:\DocTemp\temp.txt
    set /p fcount2= < "C:\DocTemp\doctemp.txtfcount"
    del "C:\DocTemp\doctemp.txtfcount"
    set lcount=2000000000
    echo.
    set typefile=1
    set splitfileonce=0
    goto :linebyline
    )
call :split
setlocal ENABLEDELAYEDEXPANSION
del C:\DocTemp\temp.txt
set /p fcount2= < "C:\DocTemp\doctemp.txtfcount"
del "C:\DocTemp\doctemp.txtfcount"

set lcount=2000000000

:linebyline
set /a lcount+=1
set /p line=<"C:\DocTemp\doctemp.txtline%lcount:~-9%"
set /a lcount1=%lcount%-2000000000
echo Line: %lcount1% : !line!
if %lcount:~-9% geq %fcount2% goto :edit
goto :linebyline

:edit
echo.
set text= 
attrib -h "C:\DocTemp\doctemp.txt%undo%" > nul
copy /y "C:\DocTemp\doctemp.txt" "C:\DocTemp\doctemp.txt%undo%" > nul 2>nul
attrib +h "C:\DocTemp\doctemp.txt%undo%" > nul
set /p text="Type: " 2> nul
set baseline= 
if "!text!"=="%baseline%" set text=/linebreak
set baseline=/?
if "!text!"=="%baseline%" set text=/help
set baseline=on
if "!text!"=="%baseline%" set text="on"
set baseline=off
if "!text!"=="%baseline%" set text="off"
(echo "!text!" | findstr /i /c:"/undo" >nul ) && (goto :undo) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/save" >nul ) && (call :save1) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/redo" >nul ) && (goto :redo) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/delfile" >nul ) && (goto :del) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/editline" >nul ) && (goto :line) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/newline" >nul ) && (goto :newline) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/delline" >nul ) && (goto :delline) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/linebreak" >nul ) && (goto :linebreak) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/typefile" >nul ) && (goto :typefile) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/typefileonce" >nul ) && (goto :typefile) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/splitfileonce" >nul ) && (goto :splitfileonce) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/splitfile" >nul ) && (goto :splitfile) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/exit" >nul ) && (goto :undoclear) || (echo. > nul ) 
(echo "!text!" | findstr /i /c:"/help" >nul ) && (goto :help) || (goto :addtext)

:addtext
echo !text! >> "C:\DocTemp\doctemp.txt" 2> nul
goto :textadd

:newline
set newline=1
goto :line

:delline
set text=%text:/delline =%
set lcount=2000000000
set /a lcount+=!text!
del /a h "C:\DocTemp\doctemp.txtline%lcount:~-9%"
goto :rebuild

:typefile
(echo "!text!" | findstr /i /c:"/typefileonce" >nul ) && (set typefileonce=1) || (echo. > nul )
if %typefileonce% equ 1 goto :textadd
set typefile=1
set splitfile=0
goto :textadd

:fileopen
set dir=
if %input% equ 0 (
    set filename=%arg1%
)
if %input% equ 1 (
    set filename=%arg1%
)
if %input% equ 2 (
    set filename=%arg2%
)
if not exist C:\DocTemp\ mkdir C:\DocTemp\
copy "%dir%%filename%" C:\DocTemp\doctemp.txt
echo. >> "C:\DocTemp\doctemp.txt"
goto :textadd

:save1
call :save
goto :textadd

:skip
set %dir%=
if not exist C:\DocTemp\ mkdir C:\DocTemp\
copy "%dir%%filename%" C:\DocTemp\doctemp.txt
echo. >> "C:\DocTemp\doctemp.txt"
goto :textadd

:commandlinehelp
echo Syntax: !wintext! (file) (flags)
echo Flags:
echo -t : Typefile : Use the faster typefile mode in !wintext! (prevents use of line editing)
echo -? : This help screen.
echo It's not that hard!
echo v2.86 (i guess) copyright 2020 Logan C.
exit /b

:splitfile
set typefile=0
set splitfile=1
goto :textadd

:splitfileonce
set splitfileonce=1
set typefile=0
goto :textadd

:save
cls
choice /c yn /n /m "Are you sure you want to save your file Y/N?"
if %errorlevel% equ 1 (
    type C:\DocTemp\doctemp.txt > "%dir%%filename%"
    echo File Saved.
    pause
    exit /b
)
if %errorlevel% equ 2 (
    exit /b
)

:undo
if %undo% equ 1 set undo=11
set /a undo-=1 2> nul
type "C:\DocTemp\doctemp.txt%undo%" > "C:\DocTemp\doctemp.txt"
set /a undo-=1 2> nul
goto :textadd

:redo
if %undo% equ 10 set undo=0
set /a undo+=1 2> nul
type "C:\DocTemp\doctemp.txt%undo%" > "C:\DocTemp\doctemp.txt"
set /a undo-=1 2> nul
goto :textadd

:del
choice /c yn /n /m "Are you sure you want to delete your file Y/N?"
if %errorlevel% equ 1 (
    del "%dir%%filename%"
    del C:\DocTemp\doctemp.txt
    set deleted=1
    goto :textadd
)
if %errorlevel% equ 2 (
    goto :textadd
)
goto :textadd

:linebreak
echo. >> "C:\DocTemp\doctemp.txt"
goto :textadd

:line
if %newline% equ 1 (
    set text=%text:/newline =%
    goto :linepart2
)
set text=%text:/editline =%

:linepart2
set lcount=2000000000
set /a lcount+=!text!
set /a lcount1=%lcount%-2000000000
set /a undo+=1
cls
if %undo% geq 11 set undo=1
echo =====!wintxt! -- A Command Line Editor For Windows=====
echo =====Current Undo State is: %undo%=====
set display=%dir%%filename%
for /f "useback tokens=*" %%a in ('%display%') do set display=%%~a
for /f "useback tokens=*" %%a in ('%display%') do set display=%%~a
for /f "useback tokens=*" %%a in ('%display%') do set display=%%~a
for /f "useback tokens=*" %%a in ('%display%') do set display=%%~a
echo =====%dir%%filename%=====
echo =====Current Line Is: %lcount1%=====
if %newline% equ 1 goto :editline
set /p Line= <"C:\DocTemp\doctemp.txtline%lcount:~-9%"
echo.
echo Line: %lcount1% : !line!
echo.

:editline
set text= 
attrib -h "C:\DocTemp\doctemp.txt%undo%" > nul
copy /y "C:\DocTemp\doctemp.txt" "C:\DocTemp\doctemp.txt%undo%" > nul 2>nul
attrib +h "C:\DocTemp\doctemp.txt%undo%" > nul
set /p text="Type: " 2> nul
set baseline= 
if "!text!"=="%baseline%" set text=/linebreak
set baseline=/?
if "!text!"=="%baseline%" set text=/help
set baseline=on
if "!text!"=="%baseline%" set text="on"
set baseline=off
if "!text!"=="%baseline%" set text="off"
(echo "!text!" | findstr /i /c:"/undo" >nul ) && (goto :undo) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/redo" >nul ) && (goto :redo) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/del" >nul ) && (goto :del) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/linebreak" >nul ) && (goto :linelinebreak) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/typefile" >nul ) && (goto :typefile) || (echo. > nul )
(echo "!text!" | findstr /i /c:"/exit" >nul ) && (goto :undoclear) || (echo. > nul ) 
(echo "!text!" | findstr /i /c:"/help" >nul ) && (goto :help) || (echo. > nul)
(echo "!text!" | findstr /i /c:"/save" >nul ) && (call :save1) || (echo. > nul )
if %newline% equ 1 (
     goto :addnewtextline
)
goto :addtextline

:addtextline
attrib -h "C:\DocTemp\doctemp.txtline%lcount:~-9%"
echo !text! > "C:\DocTemp\doctemp.txtline%lcount:~-9%"
attrib +h "C:\DocTemp\doctemp.txtline%lcount:~-9%"
goto :rebuild

:addnewtextline
attrib -h "C:\DocTemp\doctemp.txtline%lcount:~-9%"
copy "C:\DocTemp\doctemp.txtline%lcount:~-9%" "C:\DocTemp\doctemp.txtline%lcount:~-9%temp" > nul
echo !text! > "C:\DocTemp\doctemp.txtline%lcount:~-9%"
type "C:\DocTemp\doctemp.txtline%lcount:~-9%temp" >> "C:\DocTemp\doctemp.txtline%lcount:~-9%"
del "C:\DocTemp\doctemp.txtline%lcount:~-9%temp"
attrib +h "C:\DocTemp\doctemp.txtline%lcount:~-9%"
goto :rebuild

:linelinebreak
attrib -h "C:\DocTemp\doctemp.txtline%lcount:~-9%"
if %newline% equ 1 (
    copy "C:\DocTemp\doctemp.txtline%lcount:~-9%" "C:\DocTemp\doctemp.txtline%lcount:~-9%temp" > nul
    echo. > "C:\DocTemp\doctemp.txtline%lcount:~-9%"
    type "C:\DocTemp\doctemp.txtline%lcount:~-9%temp" >> "C:\DocTemp\doctemp.txtline%lcount:~-9%"
    del "C:\DocTemp\doctemp.txtline%lcount:~-9%temp"
    goto :rebuild
)
echo. > "C:\DocTemp\doctemp.txtline%lcount:~-9%"
goto :rebuild

:rebuild
echo We can defeat COVID!
set lcount=2000000000

set /a lcount+=1
type "C:\DocTemp\doctemp.txtline%lcount:~-9%" > "C:\DocTemp\doctemp.txt"

:rebuildlinebyline
set /a lcount+=1
type "C:\DocTemp\doctemp.txtline%lcount:~-9%" >> "C:\DocTemp\doctemp.txt"
if %lcount:~-9% geq %fcount2% goto :textadd
goto :rebuildlinebyline



:undoclear
set undo=11

:undoclear1
if %undo% equ 1 set undo=11
del /a h "C:\DocTemp\doctemp.txt%undo%" 2> nul
set /a undo-=1
if %undo% leq 1 goto :exit
goto :undoclear1

:help
cls

echo Welcome to the help for !wintxt!, A Command Line Editor For Windows!
echo.
echo #1: How to enter commands:
echo At the "Type:" prompt, type the one of the commands shown below:
echo.
echo #2: Commands:
echo.
echo /exit : Exit !wintxt!.
echo /undo : Undo the previous command.
echo /help : This help screen.
echo /redo : Redo the previous undone command.
echo /delfile : Delete the current file. (can be undone with /undo.)
echo /linebreak : Insert a line break.
echo /typefile : Type the file normally instead of having the line markings. (can be enabled with the -t flag on startup)
echo /typefileonce : Type the file normally once.
echo /splitfile : Split the file (required for line editing) (enabled by default) (high performance impact)
echo /splitfileonce : Split the file once.
echo /editline (line number) : Edit that line
echo /newline (line number) : Add that line
echo.
echo And, if you have any bugs / need help, please email helpmewithstuff@protonmail.com .
pause

cls
echo Thank you for using !wintxt!.
pause
goto :textadd

:exit

set undo=1
del /a h "C:\DocTemp\doctemp.txt%undo%" 2> nul

set undo=1
del /a h "C:\DocTemp\doctemp.txt%undo%" 2> nul
cls

set lcount=2000000000

set /a fcount2+=1000
set /a fcount2+=2000000000
set fcount=%fcount:~-9%

:deltemp
set /a lcount+=1
if exist "C:\DocTemp\doctemp.txtline%lcount:~-9%" (
attrib -h "C:\DocTemp\doctemp.txtline%lcount:~-9%" > nul 2> nul
del "C:\DocTemp\doctemp.txtline%lcount:~-9%" > nul 2> nul
)
if %lcount:~-9% geq %fcount2:~-9% goto :exit2
goto :deltemp

:exit2
set /a lcount+=1
attrib -h "C:\DocTemp\doctemp.txtline%lcount:~-9%" > nul 2> nul
del "C:\DocTemp\doctemp.txtline%lcount:~-9%" > nul 2> nul

set /a lcount+=1
attrib -h "C:\DocTemp\doctemp.txtline%lcount:~-9%" > nul 2> nul
del "C:\DocTemp\doctemp.txtline%lcount:~-9%" > nul 2> nul

call :save
cls

echo Thank you for using !wintxt!!
echo I hope it's not too terrible. hehe
pause
choice /c yn /n /m "Do you want to edit another file? Y/N"
if %errorlevel% equ 1 (
    set undo=0
    set deleted=0
    set newline=0
    set typefileonce=0
    set splitfileonce=0
    set dir=
    set filename=
    goto :start
)
if %errorlevel% equ 2 (
    title cmd
    del C:\DocTemp\doctemp.txt
    rmdir C:\DocTemp\
    cls
    exit /b
)
