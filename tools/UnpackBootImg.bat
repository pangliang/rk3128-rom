@echo off
SET CMD_NAME=

echo start to unpack boot
echo start to dd
if  not exist dd.exe (
set cmd_name=dd
goto error)

dd if=..\Temp\Boot\boot.img of=..\Temp\Boot\boot.cpio.gz bs=1 skip=8

echo start to gunzip
if  not exist gzip.exe (
set cmd_name=gzip
goto error)

gzip -d -f -q ..\Temp\Boot\boot.cpio.gz

echo start to create boot directory
if exist ..\Temp\Boot\Boot (
echo del boot directory
rmdir /S/Q ..\Temp\Boot\Boot)
mkdir ..\Temp\Boot\Boot


echo start to cpio 
if  not exist cpio.exe (
set cmd_name=cpio
goto error)
cd ..\Temp\Boot\Boot
..\..\..\bin\cpio.exe -idm < ..\boot.cpio
cd ..

echo start to del data
del boot.cpio /Q
del boot.img /Q
echo Info:unpack boot.img success.
goto exit

:error
echo Error:%CMD_NAME% is not existed.
:exit

@echo on