write-output "T1082 - System Information Discovery"

write-output "Atomic Test #1 -  System Information Discovery"

cmd.exe /c "systeminfo"
cmd.exe /c "reg query HKLM\SYSTEM\CurrentControlSet\Services\Disk\Enum"

write-output "Atomic Test #6 - Hostname Discovery (Windows)"
cmd.exe /c "hostname"

write-output "Atomic Test #8 - Windows MachineGUID Discovery"
cmd.exe /c "REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography /v MachineGuid"

