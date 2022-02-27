New-Item -Path 'C:\temp\updates\KB5005613' -ItemType Directory
Invoke-WebRequest "http://download.windowsupdate.com/c/msdownload/update/software/secu/2021/09/windows8.1-kb5005613-x64_52d05012aa71c9d14f218559dba1baa82e4515c9.msu" -outfile "C:\temp\updates\KB5005613\windows8.1-kb5005613-x64_52d05012aa71c9d14f218559dba1baa82e4515c9.msu"
#$WebClient = New-Object System.Net.WebClient
#$WebClient.DownloadFile("http://download.windowsupdate.com/c/msdownload/update/software/secu/2021/09/windows8.1-kb5005613-x64_52d05012aa71c9d14f218559dba1baa82e4515c9.msu","C:\temp\updates\KB5005613")
expand C:\temp\updates\KB5005613\windows8.1-kb5005613-x64_52d05012aa71c9d14f218559dba1baa82e4515c9.msu /f:* C:\temp\updates\KB5005613
dism /online /remove-package:C:\Temp\Updates\kb5005613\Windows8.1-KB5005613-x64.cab
dism /online /add-package /packagepath:C:\Temp\updates\kb5005613\Windows8.1-KB5005613-x64.cab