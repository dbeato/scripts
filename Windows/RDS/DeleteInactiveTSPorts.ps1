#Get RDSH Servers
$servers = Get-ADComputer -Filter * -SearchBase "OU=Terminal Servers,OU=Servers,DC=domain,DC=com"  

#Delete inactive TS Ports (https://archive.codeplex.com/?p=inactivetsport)
foreach ($server in $servers) {
    $RemoteComputer =$server.name 
    if (Test-Connection -ComputerName $RemoteComputer -Count 1 -ErrorAction SilentlyContinue) { 
        Invoke-Command -ComputerName $RemoteComputer -ScriptBlock {
            $Gegevens = Get-ChildItem -path 'HKLM:SYSTEM\CurrentControlSet\Control\DeviceClasses\{28d78fad-5a12-11d1-ae5b-0000f803a8c2}\##?#ROOT#RDPBUS#0000#{28d78fad-5a12-11d1-ae5b-0000f803a8c2}' -Recurse
            ($gegevens.Name ) -replace "\\Device parameters" | Select-Object -Unique | ForEach-Object { 
                $subkey = ($_ -replace "HKEY_LOCAL_MACHINE\\" , "HKLM:\") + "\Device Parameters"         
                $PortDescription = (Get-itemproperty -path $subkey)."Port Description"
                if ($PortDescription -eq "Inactive TS Port") {
                    $subkeydelete = ($_ -replace "HKEY_LOCAL_MACHINE\\" , "HKLM:\")
                    write-host "delete subkey from $env:COMPUTERNAME => $subkeydelete"
                    Remove-Item -Path $subkeydelete -Recurse                   
                }
            }
        } 
    }
}