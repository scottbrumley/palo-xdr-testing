@echo off

echo T1531 Account Access Removal
echo Atomic Test #1 - Change User Password - Windows

echo Check User Exists
net user AtomicAdministrator | findstr /C:"AtomicAdministrator">nul && (
    echo User Exists
) || (
    echo Add User
    net user AtomicAdministrator User2ChangePW! /add
)

echo Change User Password
net.exe user AtomicAdministrator HuHuHUHoHo283283@dJD

echo Clean Up Atomic Test #1
net.exe user AtomicAdministrator /delete


echo Atomic Test #2 - Delete User - Windows

echo Check User Exists
net user AtomicUser | findstr /C:"AtomicUser">nul && (
    echo User Exists
) || (
    echo Add User
    net user AtomicUser User2DeletePW! /add
)

echo Delete User
net.exe user AtomicUser /delete