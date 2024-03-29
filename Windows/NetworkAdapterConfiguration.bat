:: Configuration Variables ::
set connectionName="Wireless Network Connection"
set ipAddress=x.x.x.x
set subnetMask=x.x.x.x
set defaultGateway=x.x.x.x
set primaryDNS=x.x.x.x
set alternateDNS=x.x.x.x
netsh interface ipv4 set address name=%connectionName% source=static addr=%ipAddress% mask=%subnetMask% gateway=%defaultGateway%
netsh interface ipv4 set dns %connectionName% static %primaryDNS%
netsh interface ipv4 add dns %connectionName% %alternateDNS% index=2