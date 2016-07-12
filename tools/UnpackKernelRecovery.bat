@echo off
SET CMD_NAME=

echo start to unpack recovery

echo start to gunzip
if  not exist gzip.exe (
set cmd_name=gzip
goto error)

ren ..\Temp\recovery\recovery.img recovery.cpio.gz
gzip -d -f -q ..\Temp\recovery\recovery.cpio.gz

echo start to create recovery directory

if exist ..\Temp\recovery\recovery (
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
echo Info:unpack recovery.img success.
goto exit

:error
echo Error:%CMD_NAME% is not existed.
:exit

@echo on