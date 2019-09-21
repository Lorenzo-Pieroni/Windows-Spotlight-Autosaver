@echo off
call :isAdmin
if %errorlevel%==0 (
if not exist "%USERPROFILE%\Pictures\spotlight" mkdir "%USERPROFILE%\Pictures\spotlight"
cd "%USERPROFILE%\Pictures\spotlight"
forfiles /M *.jpg /C "cmd /c rename @file @fname"
robocopy "%LocalAppData%\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets" "%USERPROFILE%\Pictures\spotlight" /s /min:300000
ren *. *.jpg
) else (
call :getAdmin
)

:isAdmin
    fsutil dirty query %systemdrive% >nul
exit /b

:getAdmin
   echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
   echo UAC.ShellExecute "cmd.exe", "/c %~s0 %~1", "", "runas", 1 >> "%temp%\getadmin.vbs"

   "%temp%\getadmin.vbs"
   del "%temp%\getadmin.vbs"
   goto 0
