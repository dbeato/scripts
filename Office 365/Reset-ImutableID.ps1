$username = user@domainc.com

Get-MSOLUser -UserPrincipalName $username | Select ImmutableID
Set-MSOLUser -UserPrincipalName $username  -ImmutableID "$null"