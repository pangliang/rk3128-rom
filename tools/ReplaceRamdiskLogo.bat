@echo off
SET CMD_NAME=


echo convert initlogo from raw to rle
if  not exist rgb2565.exe (
set cmd_name=rgb2565
goto error)
rgb2565 -rle <..\Temp\Boot\initlogo.raw> ..\Temp\Boot\Ramdisk\initlogo.rle
del ..\Temp\Boot\initlogo.raw /Q


echo Info:Replace logo success.
goto exit

:error
echo Error:%CMD_NAME% is not existed.
:exit

@echo on