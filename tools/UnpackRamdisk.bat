@echo off
SET CMD_NAME=

echo start to unpack ramdisk

echo start to gunzip
if  not exist gzip.exe (
set cmd_name=gzip
goto error)

ren ..\Temp\Boot\ramdisk.img ramdisk.cpio.gz
gzip -d -f -q ..\Temp\Boot\ramdisk.cpio.gz

echo start to create ramdisk directory

if exist ..\Temp\Boot\ramdisk (
echo del ramdisk directory
rmdir /S/Q ..\Temp\Boot\ramdisk)
mkdir ..\Temp\Boot\ramdisk

echo start to cpio 
if  not exist cpio.exe (
set cmd_name=cpio
goto error)
cd ..\Temp\Boot\ramdisk
..\..\..\bin\cpio.exe -idm < ..\ramdisk.cpio
cd ..

echo start to del data
del ramdisk.cpio /Q
echo Info:unpack ramdisk.img success.
goto exit

:error
echo Error:%CMD_NAME% is not existed.
:exit

@echo on