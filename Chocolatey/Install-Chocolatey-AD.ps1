Import-Module ActiveDirectory

# get today's date
$today = Get-Date

#Get today - 60 days (2 month old)
$cutoffdate = $today.AddDays(-60)
#Working Query
#$computers=Get-ADComputer -Filter * | Select-Object -ExpandProperty Name
$computers= Get-ADComputer -Properties * -Filter {LastLogonDate -gt $cutoffdate} | Select-Object -ExpandProperty Name


foreach ($comp in $computers)
{
   Invoke-Command -computername $comp {Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))}
}
