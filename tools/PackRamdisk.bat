@echo off
SET CMD_NAME=

echo start to pack ramdisk

echo start to mkbootfs
if  not exist mkbootfs.exe (
set cmd_name=mkbootfs
goto error)
if  not exist minigzip.exe (
set cmd_name=minigzip
goto error)
mkbootfs.exe ..\Temp\Boot\ramdisk | minigzip.exe > ..\Temp\Boot\ramdisk.img


echo start to del data
#rmdir /S/Q ..\Temp\Boot\Ramdisk

echo Info:pack ramdisk.img success.

goto exit

:error
echo Error:%CMD_NAME% is not existed.
:exit

@echo on