Import-Module ActiveDirectory
 
$list = Get-ADComputer -LDAPFilter '(objectClass=Computer)' | Select -Expand Name
 
 
 
foreach ($computer in $list) {
 
  Write-Host "working on  $computer"
 
  Invoke-Command -ComputerName $computer -ScriptBlock { w32tm /resync }
 
  }