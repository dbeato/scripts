dism /Get-WimInfo /WimFile:d:\sources\install.wim
dism /online /cleanup-image /restorehealth /source:wim:d:\sources\install.wim:2 /limitaccess