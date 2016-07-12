@echo off
SET TOOLS=..\..\tools

echo start to unpack boot
echo start to dd

%TOOLS%\dd if=./boot.img of=./boot.cpio.gz bs=1 skip=8

echo gzip....
%TOOLS%\gzip -d -f -q .\boot.cpio.gz

echo start to create boot directory
if exist .\boot-unpack (
echo del boot directory
rmdir /S/Q .\boot-unpack
)
mkdir .\boot-unpack


echo start to cpio
cd .\boot-unpack
..\%TOOLS%\cpio.exe -idm < ..\boot.cpio
cd ..

echo start to del data
del boot.cpio /Q
del boot.cpio.gz /Q


echo Info:unpack boot.img success.

pause
@echo on