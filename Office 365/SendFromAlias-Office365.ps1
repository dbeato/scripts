Set-OrganizationConfig -SendFromAliasEnabled $true
Get-OrganizationConfig | FL Sendfrom*