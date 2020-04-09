write-output "Atomic Test #9 - Create ADS PowerShell"
cmd.exe /c  "echo 'test' > test.txt" | set-content -path test.txt -stream adstest.txt -value 'test'
set-content -path test.txt -stream adstest.txt -value 'test2'
set-content -path . -stream adstest.txt -value 'test3'
ls -Recurse | %{ gi $_.Fullname -stream *} | where stream -ne ':$Data' | Select-Object pschildname

write-output "Clean Up #9"
Remove-Item -Path test.txt -ErrorAction Ignore

