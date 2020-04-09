@echo off

echo T1136 Create Account

echo Atomic Test #3 - Create a new user in a command prompt
net user /add "T1136_CMD" "T1136_CMD!"

echo Test #3 - Clean Up
net user /del "T1136_CMD"

echo Atomic Test #4 - Create a new user in PowerShell
powershell -command "New-LocalUser -Name 'T1136_PowerShell' -NoPassword"

echo Test # - Clean Up
powershell -command "Remove-LocalUser -Name 'T1136_PowerShell' -ErrorAction Ignore"


