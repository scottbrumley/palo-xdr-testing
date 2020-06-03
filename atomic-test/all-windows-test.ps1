write-output "Running All Windows Attacks"

write-output "Running Credential Access Attacks"
cmd.exe /c  "C:\vagrant\atomic-test\windows\credential-access\atomic-T1003.bat"

write-output "Running Impact Attacks"
cmd.exe /c  "C:\vagrant\atomic-test\windows\impact\atomic-T1485.bat"
cmd.exe /c  "C:\vagrant\atomic-test\windows\impact\atomic-T1531.bat"

write-output "Running Discovery Attacks"
C:\vagrant\atomic-test\windows\discovery\atomic-T1016.ps1
C:\vagrant\atomic-test\windows\discovery\atomic-T1033.ps1

write-output "Running Lateral Movement Attacks"
cmd.exe /c  "C:\vagrant\atomic-test\windows\lateral-movement\atomic-T1097.bat"
cmd.exe /c  "C:\vagrant\atomic-test\windows\lateral-movement\atomic-T1077.bat"
cmd.exe /c  "C:\vagrant\atomic-test\windows\lateral-movement\atomic-T1088.bat"

write-output "Running Persistence Attacks"
cmd.exe /c  "C:\vagrant\atomic-test\windows\persistence\atomic-T1136.bat"
cmd.exe /c  "C:\vagrant\atomic-test\windows\persistence\atomic-T1197.bat"
C:\vagrant\atomic-test\windows\persistence\atomic-T1158.ps1
C:\vagrant\atomic-test\windows\persistence\atomic-T1060.ps1

write-output "Running Privilege Escalation Attacks"
cmd.exe /c  "C:\vagrant\atomic-test\windows\privilege-escalation\atomic-T1053.bat"
cmd.exe /c  "C:\vagrant\atomic-test\windows\privilege-escalation\atomic-T1103.bat"

write-output "Running Defense Evasion"
C:\vagrant\atomic-test\windows\defense-evasion\atomic-T1027.ps1