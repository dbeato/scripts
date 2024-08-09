taskkill /im openvpn* /F
mkdir c:\SophosVPN
copy "c:\Program Files (x86)\Sophos\Sophos SSL VPN Client\config\*.ovpn" c:\SophosVPN\
Start-Process -FilePath "C:\Program Files (x86)\Sophos\Sophos SSL VPN Client\Uninstall.exe" -ArgumentList '/S'
cd \
Remove-Item "c:\Program Files (x86)\Sophos\Sophos SSL VPN Client" -Recurse
mkdir C:\temp
cd \temp
Invoke-WebRequest -Uri "https://download.sophos.com/network/clients/SophosConnect_2.3.1_IPsec_and_SSLVPN.msi"  -OutFile SophosConnect.msi
msiexec.exe /i SophosConnect.msi /QN
Copy-Item -Path "c:\SophosVPN\*" -Destination "C:\Program Files (x86)\Sophos\Connect\Import\"
Start-Process -FilePath "C:\Program Files (x86)\Sophos\Connect\GUI\scgui.exe"