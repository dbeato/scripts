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
Invoke-Command -ComputerName $Comp -ScriptBlock {

    choco upgrade firefox googlechrome 7zip.install jre8 powershell -y | Out-File -FilePath C:\Windows\Temp\choco-upgrade.txt

    if ($?) {

        Write-Output "$Env:COMPUTERNAME Successful"

    }

    else {

        Write-Output "$Env:COMPUTERNAME Failed"

    }

}
}
