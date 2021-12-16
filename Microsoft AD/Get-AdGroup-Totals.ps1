Import-Module ActiveDirectory
$groups = Get-ADGroup -Filter * -Properties *

Foreach ($group in $groups) {

$groupname = $group.Name
#$groupdescription = $group.Description
$membercount = $group.Member.Count 
#Write-Output $group.Name,$membercount.Count

$countgrp = New-Object -TypeName PScustomObject -Property @{"Group Name" = $groupname 
Total = $membercount
} 

$countgrp | Select-Object "Group Name", Total | Export-Csv C:\users\usadministrator\Desktop\ADGroupCount.csv -NoTypeInformation -Delimiter ';' -Append


}   