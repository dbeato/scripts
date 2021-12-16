Import-Module ActiveDirectory
$ImportUserList = import-csv "C:\Users\usadministrator\Desktop\Attribute-Import.csv"
foreach ($user in $ImportUserList) {
#Declaring the Managers
$Managerid = $user.LineManagerID
$manager=get-aduser -filter {employeeid -eq $managerid} -Properties DistinguishedName | Select -ExpandProperty  distinguishedName
#Importing data including managers
Set-ADUser -identity $user.sAMAccountName -replace @{employeeID = $user.EmployeeID;entityName = $user.EntityName;startDate = $user.startDate;workLocationName = $user.WorkLocation;division = $user.Division;department=$user.Department;title = $user.Title;lineManagerID = $user.LineManagerID;region = $user.region;l = $user.l;co = $user.co;manager = $manager} 
#Write-Output $user.sAMAccountName
#Write-Output $manager
}