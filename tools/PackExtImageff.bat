@echo off
SET CMD_NAME=
set num_sizes=
set delta=


echo start to pack system.img


if  not exist genext2fs.exe (
set cmd_name=genext2fs
goto error)

if  not exist tune2fs.exe (
set cmd_name=tune2fs
goto error)

if  not exist e2fsck.exe (
set cmd_name=e2fsck
goto error)

if  not exist resize2fs.exe (
set cmd_name=resize2fs
goto error)

if  not exist du.exe (
set cmd_name=du
goto error)


echo start to estimate num of blocks
cd ..\temp
for /f  %%a IN ('..\bin\du -sb system') DO set num_sizes=%%a
cd ..\bin
echo num_sizes = %num_sizes%

set delta=5242880
:loop_1st
set /A num_sizes = %num_sizes%+%delta%

echo start to make ext2 image (num_sizes=%num_sizes%)
make_ext4fs -l %num_sizes% -L system -S ..\temp\recovery\recovery\file_contexts -a system system.img ..\temp\system 
tune2fs -c -1 -i 0 system.img
if %errorlevel% NEQ 0 (goto loop_1st)

e2fsck -fyD system.img

echo Info:Pack system.img success.
goto exit

:error
echo Error:%CMD_NAME% is not existed.
:exit

@echo on