$Mailboxes = Get-Mailbox

ForEach ($mailbox in $Mailboxes) 
#{Write-Output $mailbox}
 {Add-DistributionGroupMember -Identity "distributiongroup@domain.com" -Member $mailbox.alias}

