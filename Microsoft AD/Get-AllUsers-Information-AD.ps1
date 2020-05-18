 $Date = Get-Date -Format "MM/dd/yyyy"
 Get-ADUser -Filter * -Properties * | Select-Object -Property * | Export-Csv C:\$date-users.csv -NoTypeInformation