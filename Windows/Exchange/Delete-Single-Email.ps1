#For all users

Get-Mailbox -ResultSize unlimited | Search-Mailbox -SearchQuery 'Subject:"Your bank statement"' –DeleteContent
#For Search Results
Get-mailbox | search-mailbox –searchquery “Subject:’Your bank statement’” –Logonly –Targetmailbox administrat