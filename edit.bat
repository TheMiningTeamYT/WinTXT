@echo off
cls
color 17
set arg1=%1
set arg2=%2
set arg3=%3
(echo "%arg1%" | findstr /i /c:"-?" >nul ) && (goto :helparg1) || (echo. > nul)
(echo "%arg2%" | findstr /i /c:"-?" >nul ) && (goto :helparg1) || (echo. > nul)
(echo "%arg3%" | findstr /i /c:"-?" >nul ) && (goto :helparg1) || (echo. > nul)
call wintext %arg1% %arg2% /n Edit
color
cls
exit /b

:helparg1
cls
set arg1=/h edit
color
call wintext "%arg1%"
exit /b