param($result)

set-alias ps64 "$env:C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe"

ps64 -args $result -command {

   $result = $args[0]
   $RDCB = "server.domain.com"
   $pfxpath = $result.ManagedItem.CertificatePath
  

   Import-Module RemoteDesktop
   Import-Module RemoteDesktopServices

   Set-RDCertificate -Role RDPublishing -ImportPath $pfxpath -ConnectionBroker $RDCB -Force

   Set-RDCertificate -Role RDWebAcces -ImportPath $pfxpath -ConnectionBroker $RDCB -Force

   Set-RDCertificate -Role RDGateway -ImportPath $pfxpath -ConnectionBroker $RDCB -Force

   Set-RDCertificate -Role RDRedirector -ImportPath $pfxpath  -ConnectionBroker $RDCB -Force

   Restart-Service TSGateway -Force -ErrorAction Stop
}