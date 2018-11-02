#This is for Powershell Version 3 or up

#stops the Windows Module Installer
net stop TrustedInstaller
#Delete all the CBS Logs
Get-ChildItem –Path "C:\Windows\Logs\CBS\" -Recurse -File | Remove-Item
#Delete all the Temporary Windows Files
Get-ChildItem –Path "C:\Windows\Temp\" -Recurse -File | Remove-Item