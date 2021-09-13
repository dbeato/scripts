$users = Get-Mailbox -Resultsize Unlimited
$domain = "@tntmax.com"
foreach ($user in $users) {
    Set-UserBriefingConfig -Identity "$($user.alias)$domain" -Enabled $false

}