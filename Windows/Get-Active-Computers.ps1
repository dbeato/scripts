Import-Module ActiveDirectory

# get today's date
$today = Get-Date

#Get today - 300 days (1 month old)
$cutoffdate = $today.AddDays(-30)

#Get the computer accounts filtered by lastlogondate.
# Select only required properties of the computer account
# and export it to a file
Get-ADComputer  -Properties * -Filter {LastLogonDate -gt $cutoffdate} `
| Select Name,OperatingSystem,OperatingSystemVersion, `
LastLogonDate,CanonicalName | Export-Csv ./ActiveComputers.csv