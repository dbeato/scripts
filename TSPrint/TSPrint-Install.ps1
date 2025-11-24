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
Invoke-WebRequest -Uri https://www.terminalworks.com/downloads/tsprint/msi/TSPrintMSI.msi -OutFile ./TSPrintMSI.msi
Start-Sleep -Seconds 90

msiexec /i TSPrintMSI.msi /qn

Start-Sleep -Seconds 240
Remove-Item 'TSPrintMSI.msi'



