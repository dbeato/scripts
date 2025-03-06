$folderName = "scripts"
$Root="C:\"
$Path="C:\"+$folderName 
if (!(Test-Path $Path)) 
{ 
New-Item -itemType Directory -Path $Root -Name $FolderName 
Write-host “Scripts Folder created.” 
} 
else 
{ 
write-host "Scripts Folder already exists and not created" 
} 

Set-Location $Path
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri https://agents.static.liongard.com/LiongardAgent-lts.msi -OutFile ./LiongardAgent-lts.msi
Start-Sleep -Seconds 90

msiexec /i LiongardAgent-lts.msi LIONGARDURL=server.app.liongard.com LIONGARDACCESSKEY="AccessKey" LIONGARDACCESSSECRET="Secret" LIONGARDENVIRONMENT="Environment" /qn

Start-Sleep -Seconds 240
Remove-Item 'LiongardAgent-lts.msi'



