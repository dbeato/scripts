Local Exchange 
Add-AdPermission -Identity mailbox -User  user -AccessRights ExtendedRight -ExtendedRights "Send-As"
Office 365 
Add-RecipientPermission -Identity "mailbox" -Trustee user -AccessRights SendAs