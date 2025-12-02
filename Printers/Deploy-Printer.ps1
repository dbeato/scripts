# Creates Printer Folder
###################################
$folderName = "printer"
$Root="C:\"
$Path="C:\"+$folderName 
if (!(Test-Path $Path)) 
{ 
New-Item -itemType Directory -Path $Root -Name $FolderName 
Write-host “Printer Folder created.” 
} 
else 
{ 
write-host "Printer Folder already exists and not created" 
} 

$folderName2 = "Xerox"
$Root2="C:\printer\"
$Path2="C:\printer\"+$folderName2 
if (!(Test-Path $Path)) 
{ 
New-Item -itemType Directory -Path $Root2 -Name $folderName2 
Write-host “Xerox Folder created.” 
} 
else 
{ 
write-host "Xerox Folder already exists and not created" 
} 

###################################
$URL="https://download.support.xerox.com/pub/drivers/EC8036_EC8056/drivers/win10x64/ar/EC8036_EC8056_7.211.16.0_PCL6_x64.zip"
$downloadtargetpath= "C:\printer\Xerox.zip"
$unziptargetpath= "C:\printer\Xerox"

# Download the driver to the C:\printer Directory
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
# Access The folder Target
###########################################

# This script works on Windows 8 or newer since the add-printer cmdlets are't available on Windows 7.
#  Download the HP Univeral Printing PCL 6 driver.

# To find\extract the .inf file, run 7-zip on the print driver .exe and go to the folder in Powershell and run this command: get-childitem *.inf* |copy-item -destination "C:\examplefolder" Otherwise it's hard to find the .inf files.

$driver = "Xerox EC8056 V4 PCL6"
$address = "0.0.0.0"
$name = "Printer"
$sleep = "3"

# The invoke command can be added to specify a remote computer by adding -computername. You would need to copy the .inf file to the remote computer first though. 
# This script has it configured to run on the local computer that needs the printer.
# The pnputil command imports the .inf file into the Windows driverstore. 
# The .inf driver file has to be physically on the local or remote computer that the printer is being installed on.

Invoke-Command {pnputil.exe -a "C:\printer\XEROX\Xerox_EC8036_EC8056_PCL6.inf" }

Add-PrinterDriver -Name $driver

Start-Sleep $sleep

# This creates the TCP\IP printer port. It also will not use the annoying WSD port type that can cause problems. 
# WSD can be used by using a different command syntax though if needed.

Add-PrinterPort -Name $address -PrinterHostAddress $address

start-sleep $sleep

Add-Printer -DriverName $driver -Name $name -PortName $address

Start-Sleep $sleep 

# This prints a list of installed printers on the local computer. This proves the newly added printer works.

get-printer |Out-Printer -Name $name