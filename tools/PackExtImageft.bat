@echo off
SET CMD_NAME=
set num_blocks=
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
for /f  %%a IN ('..\bin\du -sk system') DO set num_blocks=%%a
cd ..\bin
echo num_blocks = %num_blocks%

set delta=5120
:loop_1st
set /A num_blocks = %num_blocks%+%delta%

echo start to make ext2 image (num_blocks=%num_blocks%)
genext2fs -a -d ..\temp\system -b %num_blocks% -m 0 system.img
if %errorlevel% NEQ 0 (goto loop_1st)


echo start to convert ext2 to ext3
tune2fs -j -L system -c -1 -i 0 system.img
if %errorlevel% NEQ 0 (goto loop_1st)

echo start to check ext3 image
e2fsck -fy system.img


echo start to resize image
for /f "tokens=2 delims=:"  %%a IN ('resize2fs -P system.img') DO set num_blocks=%%a
echo num_blocks=%num_blocks%

echo start to delete system.img
del system.img /Q

set delta=1024
:loop_2nd
set /A num_blocks = %num_blocks%+%delta%

echo start to make ext2 image again(num_blocks=%num_blocks%)
genext2fs -a -d ..\temp\system -b %num_blocks% -m 0 system.img
if %errorlevel% NEQ 0 (goto loop_2nd)

echo start to convert ext2 to ext3 again
tune2fs -O dir_index,filetype,sparse_super -j -L system -c -1 -i 0 system.img
if %errorlevel% NEQ 0 (goto loop_2nd)

echo start to check ext3 image again
e2fsck -fyD system.img

echo Info:Pack system.img success.
goto exit

:error
echo Error:%CMD_NAME% is not existed.
:exit

@echo on