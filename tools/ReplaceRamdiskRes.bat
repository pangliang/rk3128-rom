@echo off
SET CMD_NAME=

echo start to unpack ramdisk

echo start to gunzip
if  not exist gzip.exe (
set cmd_name=gzip
goto error)

gzip -d -f -q ramdisk.cpio.gz

echo start to create ramdisk directory
if  not exist rm.exe (
set cmd_name=rm
goto error)
if  not exist mkdir.exe (
set cmd_name=mkdir
goto error)
rm -f -r ramdisk
mkdir.exe -p ramdisk

echo start to cpio 
if  not exist cpio.exe (
set cmd_name=cpio
goto error)
cd ramdisk
..\cpio.exe -idm < ../ramdisk.cpio
cd ..

echo start to del data
del ramdisk.cpio /Q
echo unpack ramdisk finish

echo convert initlogo from raw to rle
if  not exist rgb2565.exe (
set cmd_name=rgb2565
goto error)
rgb2565 -rle <initlogo.raw> initlogo.rle
del initlogo.raw /Q
move /Y initlogo.rle ramdisk\

echo start to pack ramdisk

echo start to mkbootfs
if  not exist mkbootfs.exe (
set cmd_name=mkbootfs
goto error)
if  not exist minigzip.exe (
set cmd_name=minigzip
goto error)
mkbootfs.exe ramdisk | minigzip.exe > ramdisk.img


echo start to del data
rm -f -r ramdisk
rm -f ramdisk.cpio.gz
echo pack boot finish

echo Info:Replace logo success.
goto exit

:error
echo Error:%CMD_NAME% is not existed.
:exit

@echo on