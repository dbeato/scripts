Remove-MailboxPermission -Identity user@domain.com -User user2@domain.com -AccessRights FullAccess
Add-MailboxPermission -Identity user@domain.com -User user2@domain.com -AccessRights FullAccess -AutoMapping $false
Remove-MailboxPermission -Identity user@domain.com -User user2@domain.com -AccessRights FullAccess