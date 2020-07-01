@echo off
call c:\vagrant\private\keys.bat

if EXIST c:\vagrant\private\cortexxdr.msi (
    echo Install The Cortex XDR Agent
    "c:\vagrant\private\cortexxdr.msi" /qn TS_ENABLED=1

    echo Checkin Cortex XDR Agent
    "c:\Program Files\Palo Alto Neworks\Traps\cytool" checkin
) ELSE (
    echo Cortex Agent Not Found c:\vagrant\private\cortexxdr.msi
)

if defined %ComputerName% (
    echo Set Windows License Key on %ComputerName% if Provided
    powershell c:\vagrant\scripts\licenseme.ps1
) ELSE (
    echo %ComputerName%=windows-key must be set in c:\vagrant\private\keys.bat
)

echo Set Time
for /F "tokens=2" %%i in ('date /t') do set mydate=%%i
set mytime=%time%
echo Current time is %mydate%:%mytime%

echo Check if Cymulate agent is present
if defined CYMULATE (

   if EXIST c:\vagrant\private\Cymulate.msi (
    echo Install The Cymulate Testing Agent
    "c:\vagrant\private\Cymulate.msi" /q KEY=%CYMULATE%

    powershell c:\vagrant\scripts\autologin.ps1
    ) ELSE (
      echo Missing Cymulate Agent c:\vagrant\private\Cymulate.msi
    )
)