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

$folderName2 = "temp"
$Root="C:\"
$Path="C:\"+$folderName2 
if (!(Test-Path $Path)) 
{ 
New-Item -itemType Directory -Path $Root -Name $FolderName2 
Write-host “Temp Folder created.” 
} 
else 
{ 
write-host "Temp Folder already exists and not created" 
} 

$folderName3 = "wiztree"
$Root="C:\scripts\"
$Path="C:\scripts\"+$folderName3 
if (!(Test-Path $Path)) 
{ 
New-Item -itemType Directory -Path $Root -Name $folderName3 
Write-host “wiztree Folder created.” 
} 
else 
{ 
write-host "Wiztree Folder already exists and not created" 
} 

Set-Location $Path
###################################
$URL="https://diskanalyzer.com/files/wiztree_4_28_portable.zip"
$downloadtargetpath= "C:\scripts\wiztree.zip"
$unziptargetpath= "C:\scripts\wiztree\"

# Download WizTree to the C:\scripts Directory
###########################################
write-host " "
write-host "Download the zip file from: $URL" -ForegroundColor Yellow
write-host " "

Invoke-WebRequest -UseBasicParsing $URL -OutFile $downloadtargetpath -ErrorAction Stop

# Unzip the file
###########################################
write-host " "
write-host "unzipping $downloadtargetpath" -ForegroundColor Yellow
write-host " "

Expand-Archive -LiteralPath $downloadtargetpath -DestinationPath $unziptargetpath -Force

###################################
$URL2="https://raw.githubusercontent.com/dbeato/scripts/refs/heads/master/Wiztree-Report.ps1"
$downloadtargetpath2= "C:\scripts\wiztree\Wiztree-Report.ps1"

# Download WizTreeReport PS1 file to the C:\scripts Directory
###########################################
write-host " "
write-host "Download the file from: $URL2" -ForegroundColor Yellow
write-host " "

Invoke-WebRequest -UseBasicParsing $URL2 -OutFile $downloadtargetpath2 -ErrorAction Stop

cd C:\scripts\wiztree\
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
& $unziptargetpath\Wiztree-Report.ps1








