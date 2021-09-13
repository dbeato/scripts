forfiles /p "C:\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy" /s /m *.log /c "cmd /c Del @path" /d -14

