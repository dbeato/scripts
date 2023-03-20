
$domains = Import-CSV -Path C:\scripts\09212022Maxmail-domains.csv
$dnsserver = 8.8.8.8
Foreach ($domain in $domains) {

    $MxRecord= Resolve-DnsName -Name $domain.Domain -Type MX -Server $dnsserver | Select Name,NameExchange

    $MxRecord | Export-CSV C:\scripts\Mxrecords-v2.csv -Append

    }

