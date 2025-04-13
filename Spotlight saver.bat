@if (@X)==(@Y) @end /* JScript comment
  @echo off
  set "PathTemp=%~dp0"
  set "PathTemp=%PathTemp:"=%"
  if %PathTemp:~-1%==\ set "PathTemp=%PathTemp:~0,-1%"
  setx Spotlight "%PathTemp%"
  set "spot=%Spotlight:"=%"

  if not "%1"=="am_admin" (
  powershell start -verb runas '%0' am_admin & exit /b
  ) else (
      if not exist "%spot%\Spotlight" mkdir "%spot%\Spotlight"
      cd /D "%spot%\Spotlight"
      forfiles /M *.jpg /C "cmd /c rename @file @fname"
      robocopy "%LocalAppData%\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets" "%spot%\Spotlight" /s /min:300000 /NFL /NDL /NJH /NJS /nc /ns /np
      ren * *.jpg
      echo PROCESS IN PROGRESS WAIT UNTIL THE WINDOW CLOSES...
      for /R "%spot%\Spotlight" %%G in (*.jpg) do call :checkDimension "%%G"
    )

:checkDimension

rem :: the first argument is the script name as it will be used for proper help message
cscript //E:JScript //nologo "%~f0" %*

exit /b %errorlevel%

@if (@X)==(@Y) @end JScript comment */
var ARGS = WScript.Arguments;
var wshShell = new ActiveXObject("WScript.Shell");

var filename=ARGS.Item(0);

var img=new ActiveXObject("WIA.ImageFile");
try {
    img.LoadFile(filename);
    if (img.Width < 1400) {
        var cmd = "cmd.exe /c del \"" + filename + "\"";
        wshShell.Run(cmd);
    }
} catch (e) {
    WScript.Echo("Errore nel caricamento dell'immagine: " + e.message);
}
