# Creates Temp Folder
###################################
mkdir C:\temp  Setup Key Values
###################################
$URL="https://domain.com\FortiSIEAM.zip"
$downloadtargetpath= "C:\temp\FortiSIEM.zip"
$unziptargetpath= "C:\temp"

# Force TLS 1.2
###################################[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Download the script to C:\temp Directory
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
cd $unziptargetpath

#Install the FortiSIEM Agent
###########################################
.\FSMLogAgent.exe SUPERNAME="siemhostname.com" SUPERPORT="443" ORGNAME="ORGName" ORGID="IDNUMBER" AGENTUSER="USER" AGENTPASSWORD="PASSWORD" HOSTNAME="" /quiet
