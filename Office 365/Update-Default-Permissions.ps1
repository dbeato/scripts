$users = Get-Mailbox -Resultsize Unlimited
foreach ($user in $users) {
Write-Host -ForegroundColor green "Setting permission for $($user.alias)..."
Set-MailboxFolderPermission -Identity "$($user.alias):\calendar" -User Default -AccessRights Reviewer
}