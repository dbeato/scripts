$date = Get-Date -Format "MM-dd-yyyy"
$domains = @(Get-Content C:\scripts\domains.txt)
$domains | resolve-dnsname -Type MX -Server 8.8.8.8 | where {$_.QueryType -eq "MX"} | Select Name,NameExchange | Export-Csv -Path c:\scripts\$date-mxdns.csv -NoTypeInformation
