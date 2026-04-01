Get-Mailbox -ResultSize Unlimited | ForEach-Object {
    Write-Host "Disabling auto calendar processing for:" $_.PrimarySmtpAddress
    Set-CalendarProcessing $_.Identity -AutomateProcessing None
}
