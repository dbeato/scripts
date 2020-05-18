#$DaysInactive = 90

#$time = (Get-Date).Adddays(-($DaysInactive))
$ProcessName=CommitCRM
$computers=Get-ADComputer -Filter * | Select-Object -ExpandProperty Name


foreach ($comp in $computers)
{
   Invoke-Command -computername $comp {{Stop-Process $ProcessName -Force}}
}
