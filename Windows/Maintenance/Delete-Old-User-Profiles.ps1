$Daysolder=720
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
Invoke-WebRequest -Uri "https://tntmaxllc-my.sharepoint.com/:u:/g/personal/dbeato_tntmax_com/EUKJA_uwkqhFutdCpYlbHxUB6d_JW1VJZ5BlY_CBS9Egzw?e=V9XqHD&download=1" -OutFile ./ADProfileCleanup.exe

Start-Sleep -Seconds 60

.\ADProfileCleanup.exe $Daysolder ExcludeLocal=Yes Administrator appinstall dbeato