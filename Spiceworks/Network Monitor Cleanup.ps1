$regKey = "hklm:\software\spiceworks\network monitor"

$dir = (Get-ItemProperty $regKey).Path

if (!$p) {
 $dir = "C:\Program Files\Spiceworks\Network Monitor"
}

Stop-Process -Force -ProcessName MonitorService
Stop-Process -Force -ProcessName redis-server
Stop-Process -Force -ProcessName RedisService
Stop-Process -Force -ProcessName TrayNotifier
Stop-Process -Force -ProcessName SpiceworksAppServer
Stop-Process -Force -ProcessName SpiceworksEventProcessor
Stop-Process -Force -ProcessName SpiceworksEventStore

sc.exe config SpiceworksAppServer start= disabled
sc.exe config SpiceworksEventProcessor start= disabled
sc.exe config SpiceworksEventStore start= disabled
sc.exe config SpiceworksMonitor start= disabled
sc.exe config SpiceworksRedis start= disabled
sc.exe config spiceworkswsp start= disabled

sc.exe delete SpiceworksMonitor
sc.exe delete SpiceworksRedis
sc.exe delete SpiceworksAppServer
sc.exe delete SpiceworksEventProcessor
sc.exe delete spiceworkswsp
sc.exe delete SpiceworksEventStore

netsh http delete urlacl url=http://+:4094/v1
netsh http delete urlacl url=https://+:4094/v1
netsh http delete sslcert ipport=0.0.0.0:4094

Get-ChildItem -rec Cert:\LocalMachine | where {$_.Issuer -eq 'CN=Spiceworks Certificate Authority'} | Remove-Item 

Remove-Item -rec -force $dir
Remove-Item -Path $regKey
Write-Host "You should reboot now if you haven't since the uninstall"