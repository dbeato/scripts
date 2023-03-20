
$domains = Import-CSV -Path C:\scripts\domains.csv

Foreach ($domain in $domains) {

    $MxRecord= nslookup -type=mx $domain.Domain 

    $MxRecord | Export-CSV C:\scripts\Mxrecords.csv -Append

    }

