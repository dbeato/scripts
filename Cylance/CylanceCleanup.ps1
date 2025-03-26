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

cd $Path
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "https://tntmaxllc-my.sharepoint.com/:u:/g/personal/dbeato_tntmax_com/EeXPUwqVQMBJptLI8fXajVAB_XLZWZ1yZpBh032gLSlY_Q?e=WqA8HC&download=1" -OutFile ./CylanceUninstallToolx64.exe
Start-Sleep -Seconds 30
.\CylanceUninstallToolx64.exe -f -r