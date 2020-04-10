@echo off
call c:\vagrant\private\keys.bat

echo Accept PsExec Eula
reg.exe ADD "HKCU\Software\Sysinternals\PsExec" /v EulaAccepted /t REG_DWORD /d 1 /f

REM echo Set Network Interfaces to Private
REM powershell -command "Set-NetConnectionProfile -Name 'Network' -NetworkCategory Private"
REM powershell -command "Set-NetConnectionProfile -Name 'Unidentified network' -NetworkCategory Private"

echo Turn on File and Print Sharing
powershell -command "Set-NetFirewallRule -DisplayGroup 'File And Printer Sharing' -Enabled True -Profile Any"

echo Enable Remote Desktop 
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f 

echo Install OpenSSH
powershell -command "Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0"

echo Start OpenSSH
powershell -command "Start-Service sshd"
echo Set Automatic on Start
powershell -command "Set-Service -Name sshd -StartupType 'Automatic'"
echo Confirm the Firewall rule is configured. It should be created automatically by setup.
powershell -command "Get-NetFirewallRule -Name *ssh*"
echo There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled
echo If the firewall does not exist, create one
powershell -command "New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22"

echo Get PSExec
PowerShell Start-Process PowerShell -Verb RunAs; Set-MpPreference -DisableRealtimeMonitoring $true
PowerShell Expand-Archive -Force -Path "C:\vagrant\tools\PSTools.zip" -DestinationPath "C:\Windows\System32"

echo Get Mimikatz
PowerShell Expand-Archive -Force -Path "C:\vagrant\tools\mimikatz.zip" -DestinationPath "C:\Users\Vagrant"
PowerShell cp C:\Users\Vagrant\mimikatz\x64\* C:\Windows\System32

REM echo Enable Remote Script Execution
REM powershell -command "Set-ExecutionPolicy -ExecutionPolicy Unrestricted"

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
