write-output "T1027 - Ovfuscated files or Information"

write-output "Atomic Test #2 - Execute base64-encoded PowerShell"

$OriginalCommand = 'Write-Host "Hey, Atomic!"'
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($OriginalCommand)
$EncodedCommand =[Convert]::ToBase64String($Bytes)
$EncodedCommand
powershell.exe -EncodedCommand $EncodedCommand

write-output "Atomic Test #3 - Execute base64-encoded PowerShell from Windows Registry"
$OriginalCommand = 'Write-Host "Hey, Atomic!"'
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($OriginalCommand)
$EncodedCommand =[Convert]::ToBase64String($Bytes)
$EncodedCommand

Set-ItemProperty -Force -Path HKCU:Software\Microsoft\Windows\CurrentVersion -Name Debug -Value $EncodedCommand
powershell.exe -Command "IEX ([Text.Encoding]::UNICODE.GetString([Convert]::FromBase64String((gp HKCU:Software\Microsoft\Windows\CurrentVersion Debug).Debug)))"

write-output "Clean up Test #3"
Remove-ItemProperty -Force -ErrorAction Ignore -Path HKCU:Software\Microsoft\Windows\CurrentVersion -Name Debug

write-output "Atomic Test #4 - Execution from Compressed File"
$url = "https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1027/bin/T1027.zip"
$start_time = Get-Date

write-output "Retrieving File $url to $env:temp\T1027.zip"
Invoke-WebRequest $url -OutFile "$env:temp\T1027.zip"
Expand-Archive -Force -path "$env:temp\T1027.zip" -DestinationPath "$env:temp\temp_T1027.zip\"
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"



write-output "Execute Test"
if (Test-Path "%temp%\temp_T1027.zip\T1027.exe") {exit 0} else {exit 1}
"%temp%\temp_T1027.zip\T1027.exe" | cmd

write-output "Clean up Test #4"
"taskkill /f /im calculator.exe >nul 2>nul" | cmd
"rmdir /S /Q %temp%\temp_T1027.zip >nul 2>nul" | cmd
"del /Q %temp%\T1027.zip >nul 2>nul" | cmd

