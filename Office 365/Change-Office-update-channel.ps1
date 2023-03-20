<#
##########################################################
#Script Description: it is used to change office 365 update channel
#Author: Selcuk ERGUL
#Date Created: 30/09/2021
#Version: V1.0 - First relase.
#>	
$UpdateChannel = "http://officecdn.microsoft.com/pr/492350f6-3a01-4f97-b9c0-c7c6ddf67d60"
$CTRPath = "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration"
$CDNBaseUrl = Get-ItemProperty -Path $CTRPath -Name "CDNBaseUrl" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty "CDNBaseUrl"
if ($CDNBaseUrl -ne $null) {
    if ($CDNBaseUrl -notmatch $UpdateChannel) {
        # Set new update channel
        Set-ItemProperty -Path $CTRPath -Name "CDNBaseUrl" -Value $UpdateChannel -Force
		if($?){write-output "CDNBaseUrl has been changed as Current Channel"}
		else {write-output "CDNBaseUrl has not been changed as Current Channel"}
        # Trigger hardware inventory
        Invoke-WmiMethod -Namespace "root\ccm" -Class "SMS_Client" -Name "TriggerSchedule" -ArgumentList "{00000000-0000-0000-0000-000000000001}"
    }
	else
	{write-host "update channel is already as Current Channel and CDNBaseUrl is $CDNBaseUrl"}
}
else
{write-host "CND Base Url registery key does not exsist."}