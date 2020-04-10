Write-Output "Disabling Defender"

#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope MachinePolicy -Force
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope UserPolicy -Force
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process -Force
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine -Force

Start-Process PowerShell -Verb RunAs
Set-MpPreference -DisableRealtimeMonitoring $true
