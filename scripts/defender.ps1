Write-Output "Disabling Defender"

#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope MachinePolicy -Force
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope UserPolicy -Force
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process -Force
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine -Force
#Import-Module ServerManager -Force;
Uninstall-WindowsFeature -Name Windows-Defender
#Start-Process PowerShell -Verb RunAs
#Set-MpPreference -DisableRealtimeMonitoring $true
#Set-ItemProperty 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' DisableAntiSpyware 0