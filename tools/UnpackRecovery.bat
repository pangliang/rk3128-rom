@echo off
SET CMD_NAME=

echo start to unpack recovery
echo start to dd
if  not exist dd.exe (
set cmd_name=dd
goto error)

dd if=..\Temp\Recovery\recovery.img of=..\Temp\Recovery\recovery.cpio.gz bs=1 skip=8

echo start to gunzip
if  not exist gzip.exe (
set cmd_name=gzip
goto error)

gzip -d -f -q ..\Temp\Recovery\recovery.cpio.gz

echo start to create recovery directory
if exist ..\Temp\Recovery\recovery (
echo del recovery directory
rmdir /S/Q ..\Temp\recovery\recovery)
mkdir ..\Temp\recovery\recovery


echo start to cpio 
if  not exist cpio.exe (
set cmd_name=cpio
goto error)
cd ..\Temp\recovery\recovery
..\..\..\bin\cpio.exe -idm < ..\recovery.cpio
cd ..

echo start to del data
del recovery.cpio /Q
del recovery.img /Q
echo Info:unpack recovery.img success.
goto exit

:error
echo Error:%CMD_NAME% is not existed.
:exit

@echo on