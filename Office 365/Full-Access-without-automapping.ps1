Connect to Office 365
$mailbox=user1@domain.com
$User=user2@domain.com
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking

Add-MailboxPermission -Identity $mailbox -User $user -AccessRights FullAccess -InheritanceType All -Automapping $false

