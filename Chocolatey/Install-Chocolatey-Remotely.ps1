Import-Module ActiveDirectory 
$Computers = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

ForEach ($computer in $Computers) {
Invoke-Command -ComputerName $Computer -ScriptBlock {

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

}
}