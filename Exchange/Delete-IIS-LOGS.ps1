forfiles /p "C:\inetpub\logs\LogFiles" /s /m *.* /c "cmd /c Del @path" /d -15
forfiles /p "C:\Program Files\Microsoft\Exchange Server\V15\Logging" /s /m *.* /c "cmd /c Del @path" /d -15
