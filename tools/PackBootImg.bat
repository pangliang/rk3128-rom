@echo off
SET CMD_NAME=

echo start to pack boot

echo start to mkbootfs
if  not exist mkbootfs.exe (
set cmd_name=mkbootfs
goto error)
if  not exist minigzip.exe (
set cmd_name=minigzip
goto error)
mkbootfs.exe ..\Temp\Boot\boot | minigzip.exe > ..\Temp\Boot\boot_no_crc.img

echo start to mkkrnlimg
if  not exist mkkrnlimg.exe (
set cmd_name=mkkrnlimg
goto error)
mkkrnlimg.exe ..\Temp\Boot\boot_no_crc.img ..\Temp\Boot\boot.img

echo start to del data
Del ..\Temp\Boot\boot_no_crc.img /Q
#rmdir /S/Q ..\Temp\Boot\Boot

echo Info:pack boot.img success.

goto exit

:error
echo Error:%CMD_NAME% is not existed.
:exit

@echo on