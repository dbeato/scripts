#Import AD  and  Exchange Module (The Server Must have AD PowerShell Exchange PowerSHell  Modules)
Import-Module ActiveDirectory
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn
#OU INformation (if needed)
$OU="dc=domain,dc=com"
#Get Today's Date
$today = Get-Date
#Date Format for File Name
$date = Get-Date -Format "MMddyyyy"
#Define a work folder for the report
$WorkFolder="C:\Scripts"
#Define # of days to search for users that have not logged in
$Days=$today.AddDays(-90)
#Search for users
Get-ADUser -Filter {LastLogonDate -lt $Days} | Select SAMAccountname | ConvertTo-Csv -NoTypeInformation | % { $_ -replace '"', ""}  | out-file "$WorkFolder\$date-Users.csv" -fo -en ascii
#Get all the Users from AD
$users= @(Get-Content $WorkFolder\$date-Users.csv)
#Loop for all the users to Report of All Mailboxes That are Inactive
foreach ($user in $users) {
Get-Mailbox -Identity $user | Select DisplayName,Database,WindowsEmailAddress,@{n="Size(MB)";e={[int]$(Get-MailboxStatistics $_.Alias).TotalItemSize.Value.ToMB()}} | Sort-Object "Size(MB)" -Descending | Export-Csv -Path $WorkFolder\MailboxStatistics-$date.csv -NoTypeInformation -Append
}

