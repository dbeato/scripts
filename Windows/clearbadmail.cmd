forfiles /p C:\inetpub\mailroot\Badmail /s /m *.* /c "cmd /c del @path" /d -1
