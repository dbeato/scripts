#For the Search Base of a Group 
$group=username
Get-ADGroup -Identity $group| FL DistinguishedName
#For the BindDN of the user

$user=username
Get-ADUser $user | FL DistinguishedName
