Connect-ExchangeOnline
$Mailboxes = Get-Mailbox -ResultSize Unlimited

Foreach ($Mailbox in $Mailboxes) {
Set-UserBriefingConfig -Identity $Mailbox.userprincipalname-Enabled $false}