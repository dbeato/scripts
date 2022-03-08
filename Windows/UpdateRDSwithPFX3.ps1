$pfxpath = "C:\Certs\SSL.pfx"
$RDCB = "server.domain.com"
Import-Module RemoteDesktop
Set-RDCertificate -Role RDPublishing -ImportPath $pfxpath -ConnectionBroker $RDCB -Force
Set-RDCertificate -Role RDWebAcces -ImportPath $pfxpath -ConnectionBroker $RDCB -Force
Set-RDCertificate -Role RDGateway -ImportPath $pfxpath -ConnectionBroker $RDCB -Force
Set-RDCertificate -Role RDRedirector -ImportPath $pfxpath  -ConnectionBroker $RDCB -Force
Restart-Service TSGateway -Force -ErrorAction Stop