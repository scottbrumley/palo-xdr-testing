Write-Output "Configure AutoLogin"

$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$DefaultUsername = "vagrant"
$DefaultPassword = "vagrant"
Set-ItemProperty $RegPath "AutoAdminLogon" -Value "1" -type String
Set-ItemProperty $RegPath "DefaultUsername" -Value "$DefaultUsername" -type String
Set-ItemProperty $RegPath "DefaultPassword" -Value "$DefaultPassword" -type String
Restart-Computer -F
exit 0
