@echo off
SET TOOLS=..\..\tools
set num_sizes=
set delta=


echo start to pack system.img

echo start to estimate num of blocks
for /f  %%a IN ('%TOOLS%\du -sb system') DO set num_sizes=%%a

echo num_sizes = %num_sizes%

set delta=5242880
:loop_1st
set /A num_sizes = %num_sizes%+%delta%

echo start to make ext2 image (num_sizes=%num_sizes%)
%TOOLS%\make_ext4fs -l %num_sizes% -L system -S recovery\file_contexts -a system system.img .\system 
%TOOLS%\tune2fs -c -1 -i 0 system.img
if %errorlevel% NEQ 0 (goto loop_1st)

%TOOLS%\e2fsck -fyD system.img

echo Info:Pack system.img success.

pause
@echo on