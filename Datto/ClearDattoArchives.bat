@echo off
:: set folder path
set dump_path=C:\Program Files (x86)\CentraStage\archives

:: set min age of files and folders to delete
set max_days=7

:: remove files from %dump_path%
forfiles -p "%dump_path%" -m *.* -d -%max_days% -c "cmd  /c del /q @path"

:: remove sub directories from %dump_path%
forfiles -p "%dump_path%" -d -%max_days% -c "cmd /c IF @isdir == TRUE rd /S /Q @path"