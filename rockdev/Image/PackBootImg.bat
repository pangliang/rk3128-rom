@echo off
SET TOOLS=..\..\tools

echo start to pack boot
%TOOLS%\mkbootfs.exe .\boot | %TOOLS%\minigzip.exe > .\boot_no_crc.img

echo start to mkkrnlimg
%TOOLS%\mkkrnlimg.exe .\boot_no_crc.img .\boot.img

echo start to del data
Del .\boot_no_crc.img /Q

echo Info:pack boot.img success.

pause
@echo on