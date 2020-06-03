write-output "T1016 - System Network Configuration Discovery"

write-output "Atomic Test #1 - System Network Configuration Discovery on Windows"
cmd /c "ipconfig /all && netsh interface show && arp -a && nbtstat -n && net config"

write-output "Atomic Test #2 - List Windows Firewall Rules"
cmd /c "netsh advfirewall firewall show rule name=all"

write-output "Atomic Test #4 - System Network Configuration Discovery (TrickBot Style)"
cmd /c "ipconfig /all && net config workstation && net view /all /domain && nltest /domain_trusts"

write-output "Atomic Test #5 - List Open Egress Ports"

write-output "Get Port File"
New-Item -Type Directory (split-path $env:temp\T1016\src\top-128.txt) -ErrorAction ignore | Out-Null
Invoke-WebRequest "https://github.com/redcanaryco/atomic-red-team/raw/master/atomics/T1016/src/top-128.txt" -OutFile "$env:temp\T1016\src\top-128.txt"

write-output "Verify Port File"
if (Test-Path "$env:temp\T1016\src\top-128.txt") {exit 0} else {exit 1}

write-output "Execute Test #5"
$ports = Get-content %temp%\T1016\src\top-128.txt
$file = "$env:USERPROFILE\Desktop\open-ports.txt"
$totalopen = 0
$totalports = 0
New-Item $file -Force
foreach ($port in $ports) {
    $test = new-object system.Net.Sockets.TcpClient
    $wait = $test.beginConnect("allports.exposed", $port, $null, $null)
    $wait.asyncwaithandle.waitone(250, $false) | Out-Null
    $totalports++ | Out-Null
    if ($test.Connected) {
        $result = "$port open"
        Write-Host -ForegroundColor Green $result
        $result | Out-File -Encoding ASCII -append $file
        $totalopen++ | Out-Null
    }
    else {
        $result = "$port closed"
        Write-Host -ForegroundColor Red $result
        $totalclosed++ | Out-Null
        $result | Out-File -Encoding ASCII -append $file
    }
}
$results = "There were a total of $totalopen open ports out of $totalports ports tested."
$results | Out-File -Encoding ASCII -append $file
Write-Host $results

write-output "Clean Up Test #5"
Remove-Item -ErrorAction ignore "$env:USERPROFILE\Desktop\open-ports.txt"