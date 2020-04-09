@echo off

echo T1077 - Windows Admin Shares

echo Atomic Test #1 - Map admin share
cmd.exe /c "net use \\Host02\C$ P@ssw0rd1 /u:DOMAIN\Administrator"

echo Atomic Test #2 - Map Admin Share PowerShell
powershell -command "New-PSDrive -name g -psprovider filesystem -root \\Host02\C$"

echo Atomic Test #3 - Copy and Execute File with PsExec
psexec.exe \\localhost -c "C:\Windows\System32\fc.exe /?"

echo Atomic Test #4 - Execute command writing output to local Admin Share
cmd.exe /Q /c hostname 1> \\127.0.0.1\ADMIN$\output.txt 2>&1
