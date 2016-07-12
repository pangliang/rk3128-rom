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
mkbootfs.exe ..\Temp\recovery\recovery | minigzip.exe > ..\Temp\recovery\recovery.img


echo start to del data
#rmdir /S/Q ..\Temp\recovery\recovery

echo Info:pack recovery.img success.

goto exit

:error
echo Error:%CMD_NAME% is not existed.
:exit

@echo on