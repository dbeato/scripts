echo off
set X=1
set "source=C:\<Source Folder Path>"
set "destination=D:\<Destination Folder Path>"
robocopy "%source%" "%destination%" /mov /minage:%X%
exit /b