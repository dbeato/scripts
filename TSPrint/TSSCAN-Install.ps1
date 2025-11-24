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
Invoke-WebRequest -Uri https://www.terminalworks.com/downloads/tsscan/msi/TSScanMSI.msi -OutFile ./TSScanMSI.msi
Start-Sleep -Seconds 90

msiexec /i TSScanMSI.msi /qn

Start-Sleep -Seconds 240
Remove-Item 'TSScanMSI.msi'



