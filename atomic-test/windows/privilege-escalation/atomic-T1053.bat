@echo off

echo T1053 - Scheduled Task

echo Atomic Test #2 - Scheduled task Local
SCHTASKS /Create /SC ONCE /TN spawn /TR C:\windows\system32\cmd.exe /ST 72600 

echo Test #2 - Clean Up
SCHTASKS /Delete /TN spawn /F

echo Atomic Test #3 - Scheduled task Remote
SCHTASKS /Create /S localhost /RU DOMAIN\user /RP At0micStrong /TN "Atomic task" /TR "C:\windows\system32\cmd.exe" /SC daily /ST 72600 

echo Test #3 - Clean Up
SCHTASKS /Delete /TN "Atomic task" /F

echo Atomic Test #4 - Powershell Cmdlet Scheduled Task
powershell -command "$Action = New-ScheduledTaskAction -Execute 'calc.exe';$Trigger = New-ScheduledTaskTrigger -AtLogon;$User = New-ScheduledTaskPrincipal -GroupId 'BUILTIN\Administrators' -RunLevel Highest;$Set = New-ScheduledTaskSettingsSet;$object = New-ScheduledTask -Action $Action -Principal $User -Trigger $Trigger -Settings $Set;Register-ScheduledTask AtomicTask -InputObject $object" 

echo Test #4 - Clean Up
powershell -command "Unregister-ScheduledTask -TaskName 'AtomicTask' -confirm:$false > $null 2>&1"
