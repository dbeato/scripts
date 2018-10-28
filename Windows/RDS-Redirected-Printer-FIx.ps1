$key = 'HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows\SessionDefaultDevices'
$keyproperty = Get-ChildItem -path $key | Select-Object Name
$keyenv = $keyproperty.Name
Copy-ItemProperty -path Registry::$keyenv -destination 'HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows\' -Name Device