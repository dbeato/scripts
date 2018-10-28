$urlpath = Read-Host "https://mail.domain.com"

Set-ClientAccessServer –Identity * –AutodiscoverServiceInternalUri “$urlpath/autodiscover/autodiscover.xml” 
Set-webservicesvirtualdirectory –Identity * –internalurl “$urlpath/ews/exchange.asmx” 
Set-oabvirtualdirectory –Identity * –internalurl “$urlpath/oab” 
Set-owavirtualdirectory –Identity * –internalurl “$urlpath/owa” 
Set-ecpvirtualdirectory –Identity * –internalurl “$urlpath/ecp” 
Set-ActiveSyncVirtualDirectory -Identity * -InternalUrl "$urlpath/Microsoft-Server-ActiveSync" 