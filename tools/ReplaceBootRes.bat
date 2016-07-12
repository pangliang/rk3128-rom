@echo off
SET CMD_NAME=

echo start to unpack boot

echo start to dd
if  not exist dd.exe (
set cmd_name=dd
goto error)

dd if=boot.img of=boot.cpio.gz bs=1 skip=8

echo start to gunzip
if  not exist gzip.exe (
set cmd_name=gzip
goto error)

gzip -d -f -q boot.cpio.gz

echo start to create boot directory
if  not exist rm.exe (
set cmd_name=rm
goto error)
if  not exist mkdir.exe (
set cmd_name=mkdir
goto error)
rm -f -r boot
mkdir.exe -p boot

echo start to cpio 
if  not exist cpio.exe (
set cmd_name=cpio
goto error)
cd boot
..\cpio.exe -idm < ../boot.cpio
cd ..

echo start to del data
del boot.cpio /Q
echo unpack boot finish

echo convert initlogo from raw to rle
if  not exist rgb2565.exe (
set cmd_name=rgb2565
goto error)
rgb2565 -rle <initlogo.raw> initlogo.rle
del initlogo.raw /Q
move /Y initlogo.rle boot\

echo start to pack boot

echo start to mkbootfs
if  not exist mkbootfs.exe (
set cmd_name=mkbootfs
goto error)
if  not exist minigzip.exe (
set cmd_name=minigzip
goto error)
mkbootfs.exe boot | minigzip.exe > boot_no_crc.img

echo start to mkkrnlimg
if  not exist mkkrnlimg.exe (
set cmd_name=mkkrnlimg
goto error)
mkkrnlimg.exe boot_no_crc.img boot_new.img

echo start to del data
rm -f boot_no_crc.img
rm -f -r boot
rm -f boot.img
move /Y boot_new.img boot.img
echo pack boot finish

echo Info:Replace logo success.
goto exit

:error
echo Error:%CMD_NAME% is not existed.
:exit

@echo on