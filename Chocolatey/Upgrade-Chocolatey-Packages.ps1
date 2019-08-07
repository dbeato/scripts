Import-Module ActiveDirectory

# get today's date
$today = Get-Date

#Get today - 60 days (2 month old)
$cutoffdate = $today.AddDays(-60)

$computers= Get-ADComputer -Properties * -Filter {LastLogonDate -gt $cutoffdate} | Select-Object -ExpandProperty Name
foreach ($comp in $computers)
{
 
Invoke-Command -ComputerName $Comp -ScriptBlock {

    $Packages = choco list -lo -r  | % {($_.split("|"))[0]}

    foreach ($Package in $Packages) {

        choco upgrade $Package -y | Out-File -FilePath "c:\Windows\Temp\choco-$Package.txt"

        if ($LASTEXITCODE -ne '0') {

           $Results = [PSCustomObject]@{

                ComputerName = $Env:COMPUTERNAME

                Package = $Package

            }

            $Results

        }

    }

}  | Select-Object ComputerName,Package | Sort-Object -Property ComputerName
}