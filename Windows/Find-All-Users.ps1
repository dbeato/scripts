$DaysInactive = 120

$OU = ""

$time = (Get-Date).Adddays(-($DaysInactive))

#Get-ADUser -Filter {LastLogonTimeStamp -lt $time} -SearchBase $OU -ResultPageSize 2000 -resultSetSize $null | Select-Object -Property Name, OperatingSystem, SamAccountName, DistinguishedName, @{n="LastLogonTimeStamp";e={[DateTime]::FromFileTime($_.LastLogontimestamp)}}

Get-ADUser -Filter {LastLogonTimeStamp -lt $time} -SearchBase $OU -ResultPageSize 2000 -resultSetSize $null -Properties Name, OperatingSystem, SamAccountName, DistinguishedName, LastLogonTimeStamp | Select-Object -Property Name,OperatingSystem, SamAccountName, DistinguishedName, @{n="LastLogonTimeStamp";e={[DateTime]::FromFileTime($_.LastLogontimestamp)}}