[String]$Hostname = 'controller.domain.com'
[String]$Port = '8443' # Change this to match the listening port
# Recommended to have a username that is "View Only"
[String]$UnifiUsername = 'username'
[String]$UnifiPassword = 'password'

[String]$Controller = "https://$($hostname):$($port)"

# Enables TLS1.2 -- this is a universal method that works for any dot net version
[Net.ServicePointManager]::SecurityProtocol = [Enum]::ToObject([Net.SecurityProtocolType], 3072)

# Ignore self-signed certificates 
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }

# Create a secure credential object
[securestring]$SecPassword=ConvertTo-SecureString $UnifiPassword -AsPlainText -Force
[pscredential]$Credentials=New-Object System.Management.Automation.PSCredential ($UnifiUsername, $SecPassword)

import-module Unifi

# If connecting to a UDMPro, add '-UDMPro' to the following line.
Connect-UnifiController -ControllerURL $Controller -credentials $Credentials


# Get Devices Count by Type
$csvFilePath = "C:\Scripts\ManagedWireless-TotalDevices.csv"
$headers = "Site", "Access Points", "Switches", "Routers", "Total"
$headers -join "," | Out-File -FilePath $csvFilePath -Encoding UTF8
$Sites=Get-UnifiSite
ForEach ($Site in $Sites)
{
    
    $AccessPoints=Get-UnifiSiteDevice -name $site.name| Where-Object -Property type -Like "uap"  | Measure-Object | Select-Object -ExpandProperty Count
    $Switches=Get-UnifiSiteDevice -name $site.name | Where-Object -Property type -Like "usw" | Measure-Object | Select-Object -ExpandProperty Count
    $Routers=Get-UnifiSiteDevice -name $site.name | Where-Object -Property type -Like "ugw" | Measure-Object | Select-Object -ExpandProperty Count
    $Routers2=Get-UnifiSiteDevice -name $site.name | Where-Object -Property type -Like "uxg" | Measure-Object | Select-Object -ExpandProperty Count
    $Routers3=Get-UnifiSiteDevice -name $site.name | Where-Object -Property type -Like "udm" | Measure-Object | Select-Object -ExpandProperty Count
    $Total=Get-UnifiSiteDevice -name $site.name | Measure-Object | Select-Object -ExpandProperty Count
       
    $output="""$($site.desc)"",""$($AccessPoints)"",""$($Switches)"",""$($Routers+$Routers2+$Routers3)"",""$($Total)"""
    Add-Content -Path $csvFilePath -Value $output
    
}

Copy-Item $csvFilePath -Destination "C:\Reports\Location\"