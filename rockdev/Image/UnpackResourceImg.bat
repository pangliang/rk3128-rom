@echo off
SET TOOLS=..\..\tools

echo start to create directory
mkdir .\resource

echo start to cpio
cd .\resource
..\%TOOLS%\ResTool.exe -unpack ..\resource.img
..\%TOOLS%\dtc.exe -I dtb -o rk-kernel-unpack.dts rk-kernel.dtb
del rk-kernel.dtb
cd ..

pause
@echo on