$supportassist = Get-WMIObject -Class Win32_Product  | Where-Object { $_.Name -ceq "Dell SupportAssist OS Recovery Plugin for Dell Update" } | Select-Object -ExpandProperty IdentifyingNumber
if ($supportassist)
{
   
    Write-Output "Uninstalling Dell SupportAssist OS Recovery Plugin for Dell Update"
    MsiExec.exe /X "$supportassist" /qn REBOOT=REALLYSUPRESS
}

$supportassist2 = Get-WMIObject -Class Win32_Product  | Where-Object { $_.Name -ceq "Dell SupportAssist Remediation" } | Select-Object -ExpandProperty IdentifyingNumber
if ($supportassist2)
{
   
    Write-Output "Uninstalling Dell SupportAssist Remediation"
    MsiExec.exe /X "$supportassist2" /qn REBOOT=REALLYSUPRESS
}

$supportassist3 = Get-WMIObject -Class Win32_Product  | Where-Object { $_.Name -ceq "Dell SupportAssist" } | Select-Object -ExpandProperty IdentifyingNumber
if ($supportassist3)
{
   
    Write-Output "Uninstalling Dell SupportAssist"
    MsiExec.exe /X "$supportassist3" /qn REBOOT=REALLYSUPRESS
}

$supportassist4 = Get-WMIObject -Class Win32_Product  | Where-Object { $_.Name -ceq "Dell Digital Delivery" } | Select-Object -ExpandProperty IdentifyingNumber
if ($supportassist4)
{
   
    Write-Output "Uninstalling Dell Digital Delivery"
    MsiExec.exe /X "$supportassist4" /qn REBOOT=REALLYSUPRESS
}

