$folderName = "scripts"
$Path="C:\"+$folderName 
if (!(Test-Path $Path)) 
{ 
New-Item -itemType Directory -Path enter_path -Name $FolderName 
Write-host “Scripts Folder created.” 
} 
else 
{ 
write-host "Scripts Folder already exists!" 
} 

cd $Path
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri https://app.ringcentral.com/download/RingCentral-x64.msi -OutFile ./RingCentral-x64.msi
Start-Sleep -Seconds 90

msiexec.exe /i RingCentral-x64.msi /qn
Start-Sleep -Seconds 240
Remove-Item 'C:\scripts\RingCentral-x64.msi'