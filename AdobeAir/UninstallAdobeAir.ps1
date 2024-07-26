mkdir C:\scripts
cd \scripts
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri https://airsdk.harman.com/assets/downloads/AdobeAIR.exe -OutFile ./AdobeAIR.exe
C:\scripts\AdobeAIR.exe -uninstall