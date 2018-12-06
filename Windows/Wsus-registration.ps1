net stop bits
net stop wuauserv
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientIDValidation /f
rd /s /q "C:\WINDOWS\SoftwareDistribution"
net start bits
net start wuauserv
wuauclt /resetauthorization /detectnow
PowerShell.exe (New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow()