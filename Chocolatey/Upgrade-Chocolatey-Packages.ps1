
$computers=Get-ADComputer -Filter * | Select-Object -ExpandProperty Name
 
foreach ($comp in $computers)
{
Invoke-Command -ComputerName $Comp -ScriptBlock {

    choco upgrade firefox chrome 7zip.install jre8  -y | Out-File -FilePath C:\Windows\Temp\choco-upgrade.txt

    if ($?) {

        Write-Output "$Env:COMPUTERNAME Successful"

    }

    else {

        Write-Output "$Env:COMPUTERNAME Failed"

    }

}