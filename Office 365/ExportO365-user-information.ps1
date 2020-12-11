$outFile = "C:\PST\UserSListToImport-New.csv" 
Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails UserMailbox | Select-Object SamAccountName,alias,displayname,Name,LastName,FirstName,ExchangeGuid,userprincipalname,WindowsLiveId,MicrosoftOnlineServicesID,ArchiveGUid,EmailAddresse,PrimarySMTPAddress,RecipientType,RecipientTypeDetails,WindowsEmailAddress,ID,LEgacyExchangeDN| Sort-Object PrimarySmtpAddress | Export-CSV -Path $outfile -notypeinformation

