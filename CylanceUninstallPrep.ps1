mkdir c:\ACL
Invoke-WebRequest -Uri "https://tntmaxllc-my.sharepoint.com/:u:/g/personal/dbeato_tntmax_com/EYEsykFpK5xDhCIlkRLbNPkB0BBTNn16cjQPYvMBBL2mOg?e=euxUSP&download=1"  -OutFile C:\ACL\SetACL.exe
cd \ACL
C:\ACL\SetACL.exe -on "hklm\software\cylance\desktop" -ot reg -actn setowner -ownr "n:administrators"
C:\ACL\SetACL.exe -on "hklm\software\cylance\desktop" -ot reg -actn ace -ace "n:administrators;p:full"
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Cylance\Desktop /v LastStateRestorePoint /f
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Cylance\Desktop /v SelfProtectionLevel /t REG_DWORD /d 1 /f
