import-module ActiveDirectory
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn; 
#Add-PSSnapin Quest.ActiveRoles.ADManagement
$ImportUserList = import-csv "C:\Users\usadministrator\Desktop\Remote-Accounts.csv"
foreach ($user in $ImportUserList) {
Enable-RemoteMailbox $user.User -Shared -RemoteRoutingAddress $user.RemoteMailbox}