mkdir c:\ACL
Invoke-WebRequest -Uri "https://tntmaxllc-my.sharepoint.com/:u:/g/personal/dbeato_tntmax_com/EYZWh0aIMeRPlhixRca4L7ABU7yFuetlVfQPN5aLz-BSYg?e=tvaOho&download=1"  -OutFile C:\ACL\CylanceProtectSetup.exe
Set-Location \ACL
"C:\ACL\CylanceProtectSetup.exe" /uninstall /quiet