forfiles /p "C:\Program Files\Microsoft\Exchange Server\V15\Logging\MapiHttp" /s /m *.* /c "cmd /c Del @path" /d -15
