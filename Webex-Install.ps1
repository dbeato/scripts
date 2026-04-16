$folderName = "scripts"
$Path="C:\"+$folderName 
if (!(Test-Path $Path)) 
{ 
New-Item -itemType Directory -Path $Path -Name $FolderName 
Write-host “Scripts Folder created.” 
} 
else 
{ 
write-host "Scripts Folder already exists and not created" 
} 

cd $Path
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri 	https://binaries.webex.com/WebexTeamsDesktop-Windows-Gold/Webex_en.msi -OutFile ./Webex_en.msi
Start-Sleep -Seconds 60

msiexec /i Webex_en.msi ACCEPT_EULA=TRUE ALLUSERS=1 AUTOSTART_WITH_WINDOWS=true ALLUSERS=1 /qn
