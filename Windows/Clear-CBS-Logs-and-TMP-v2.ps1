#this is for 
#stops the Windows Module Installer
net stop TrustedInstaller
#Delete all the CBS Logs
Remove-Item –path C:\Windows\Logs\CBS\* -Recurse
#Delete all the Temporary Windows Files
Remove-Item –path C:\Windows\Temp\* -Recurse