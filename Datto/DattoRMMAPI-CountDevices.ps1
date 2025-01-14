# Load module
Import-Module DattoRMM -Force

# Provide API Parameters
$params = @{
    Url        =  'https://concord-api.centrastage.net'
    Key        =  'DattoKey'
    SecretKey  =  'DattoSecretKey'
}

# Set API Parameters
Set-DrmmApiParameters @params

# Get Devices Count by Type
$csvFilePath = "C:\Scripts\DattoRMMDevices.csv"
$headers = "Site", "Servers", "Desktops", "Laptops", "Total"
$headers -join "," | Out-File -FilePath $csvFilePath -Encoding UTF8
ForEach ($site in Get-DrmmAccountSites -noDeletedDevices | Where-Object -Property onDemand -Like "False" )
{
        $Servers = Get-DRMMSiteDevices $site.uid | Where-Object -Property deviceType -Like "@{category=Server; type=Main System Chassis}" | Measure-Object | Select-Object -ExpandProperty Count
        $Desktops = Get-DRMMSiteDevices $site.uid | Where-Object -Property deviceType -Like "@{category=Desktop; type=Desktop}" | Measure-Object | Select-Object -ExpandProperty Count
        $Laptops = Get-DRMMSiteDevices $site.uid | Where-Object -Property deviceType -Like "@{category=Laptop; type=Notebook}" | Measure-Object | Select-Object -ExpandProperty Count
        $macOSDesktops = Get-DRMMSiteDevices $site.uid | Where-Object -Property deviceType -Like "@{category=Desktop; type=iMac}"  | Measure-Object | Select-Object -ExpandProperty Count
        $macOSLaptops = Get-DRMMSiteDevices $site.uid | Where-Object -Property deviceType -Like "@{category=Laptop; type=MacBook Pro}" | Measure-Object | Select-Object -ExpandProperty Count
        $Total = Get-DRMMSiteDevices $site.uid | Measure-Object | Select-Object -ExpandProperty Count
    
    $output="""$($site.name)"",""$($Servers)"",""$($Desktops+$macOSDesktops)"",""$($Laptops+$macOSLaptops)"",""$($Total)"""
    Add-Content -Path $csvFilePath -Value $output

    
}