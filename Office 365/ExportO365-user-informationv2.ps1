$outFile = "$home\desktop\UserListToImport.csv" 
$mailboxes = Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails UserMailbox 

foreach ($mailbox in $mailboxes)
{
    Get-Mailbox $mailbox.alias | Format-List alias,displayname,ExchagneGuid,userprincipalname,WindowsLiveId,MicrosoftOnlineServicesID,ArchiveGUid,EmailAddresse,PrimarySMTPAddress,RecipientType,RecipientTypeDetails,WindowsEmailAddress,ID,LEgacyExchangeDN,ExchangeGUId 
}
| Export-CSV $outfile -notypeinformation