write-output "T1106 - Execution through API"

write-output "Atomic Test #1 - Execution through API - CreateProcess"

cmd.exe /c "C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe /out:`"%temp%\T1106.exe`" /target:exe `"c:\Vagrant\tools\CreateProcess.cs`""
cmd.exe /c "%temp%\T1106.exe"

