@echo off
SET CMD_NAME=

echo start to pack recovery

echo start to mkbootfs
if  not exist mkbootfs.exe (
set cmd_name=mkbootfs
goto error)
if  not exist minigzip.exe (
set cmd_name=minigzip
goto error)
mkbootfs.exe ..\Temp\recovery\recovery | minigzip.exe > ..\Temp\recovery\recovery_no_crc.img

echo start to mkkrnlimg
if  not exist mkkrnlimg.exe (
set cmd_name=mkkrnlimg
goto error)
mkkrnlimg.exe ..\Temp\recovery\recovery_no_crc.img ..\Temp\recovery\recovery.img

echo start to del data
Del ..\Temp\recovery\recovery_no_crc.img /Q
#rmdir /S/Q ..\Temp\recovery\recovery

echo Info:pack recovery.img success.

goto exit

:error
echo Error:%CMD_NAME% is not existed.
:exit

@echo on