@echo off
:: set folder path
set dump_path=C:\ADNIJSPP\dcm_files

:: set min age of files and folders to delete
set max_days=1095

:: remove files from %dump_path%
forfiles -p %dump_path% -m *.* -d -%max_days% -c "cmd  /c del /q @path"

:: remove sub directories from %dump_path%
forfiles -p %dump_path% -d -%max_days% -c "cmd /c IF @isdir == TRUE rd /S /Q @path"