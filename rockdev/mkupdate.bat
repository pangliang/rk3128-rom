SET TOOLS=..\tools

del update.img
%TOOLS%\Afptool -pack .\backupimage backupimage\backup.img
%TOOLS%\Afptool -pack ./ Image\update.img


%TOOLS%\RKImageMaker.exe -RK312A RK312XMiniLoaderAll_V2.19.bin  Image\update.img update.img -os_type:androidos

rem update.img is new format, Image\update.img is old format, so delete older format
del  Image\update.img

pause 
