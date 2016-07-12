@echo off
SET TOOLS=..\..\tools

echo start to create directory
cd .\resource
..\%TOOLS%\dtc.exe -I dts -O dtb -o rk-kernel.dtb rk-kernel.dts
..\%TOOLS%\ResTool.exe -pack logo.bmp rk-kernel.dtb
move resource.img ..\
del rk-kernel.dtb
cd ..

pause
@echo on