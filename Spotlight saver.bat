@echo off
if not "%1"=="am_admin" (
if not "%Spotlight%"=="%cd%" setx Spotlight %cd%
powershell start -verb runas '%0' am_admin & exit /b
) else (
    if not exist "%Spotlight%\Spotlight" mkdir "%Spotlight%\Spotlight"
    cd /D "%Spotlight%\Spotlight"
    forfiles /M *.jpg /C "cmd /c rename @file @fname"
    robocopy "%LocalAppData%\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets" "%Spotlight%\Spotlight" /s /min:300000 /NFL /NDL /NJH /NJS /nc /ns /np
    ren * *.jpg
)