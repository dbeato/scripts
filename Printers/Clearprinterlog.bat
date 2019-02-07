@echo off
echo Stopping print spooler.
echo.
net stop spooler
echo deleting temp files.
echo.
del %windir%\system32\spool\printers\*.* /q
echo Starting print spooler.
echo.
net start spooler