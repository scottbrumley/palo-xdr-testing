@echo off
call c:\vagrant\private\keys.bat

echo Install The Cortex XDR Agent
"c:\vagrant\private\cortexxdr.msi" /qn TS_ENABLED=1

echo Checkin Cortex XDR Agent
"c:\Program Files\Palo Alto Neworks\Traps\cytool" checkin

echo Set Windows License Key on %ComputerName% if Provided

powershell c:\vagrant\scripts\licenseme.ps1

echo Set Time
for /F "tokens=2" %%i in ('date /t') do set mydate=%%i
set mytime=%time%
echo Current time is %mydate%:%mytime%
