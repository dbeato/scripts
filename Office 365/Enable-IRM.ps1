Install-Module -Name AIPService
Install-Module -Name ExchangeOnlineManagement
Connect-ExchangeOnline
Connect-AipService
Enable-AIPService
$RMSConfig = Get-AipServiceConfiguration
$LicenseUri = $RMSConfig.LicensingIntranetDistributionPointUrl
Set-IRMConfiguration -LicensingLocation $LicenseUri
Set-IRMConfiguration -InternalLicensingEnabled $true

Test-IRMConfiguration -Sender user@domain.com -Recipient external@domain.com