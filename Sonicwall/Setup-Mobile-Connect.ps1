<#
Running this script will Allow you to run the automatic setup & configuration of your Sonicwall Mobile Client through powershell.
   
The $VPNName variable is the name you want your connection to be named as.
The $ServerAddress variable is the address of your SSLVPN.
The $xml variable is the port used by your SSLVPN.

#>


$VPNName="SSLVPN"
$ServerAddress="sslvpn.domain.com"
$xml="<MobileConnect><Port>443</Port></MobileConnect>"
$sourceXml=New-Object System.Xml.XmlDocument
$sourceXml.LoadXml($xml)
Add-VpnConnection -Name $VPNName -ServerAddress $ServerAddress -SplitTunneling $True -PluginApplicationID SonicWALL.MobileConnect_cw5n1h2txyewy -CustomConfiguration $sourceXml