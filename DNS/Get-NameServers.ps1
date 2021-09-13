$date = Get-Date -Format "MM-dd-yyyy"
$domains = @(Get-Content domains.txt)
$domains | resolve-dnsname -Type NS -Server 8.8.8.8 | where {$_.QueryType -eq "NS"} | Select Name,NameHost | Export-Csv -Path c:\scripts\$date-dns.csv -NoTypeInformation
