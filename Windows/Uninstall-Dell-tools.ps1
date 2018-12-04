Function un-install
{
 $apps = "Dell Digital Delivery","Dell Foundation Services","Dell Protected Workspace","Dell Backup and Recovery","Dell Command Update", "SuperAntiSpyware"
 Foreach ($app in $apps) 
 {
  $uninstall32 = Get-ChildItem "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { Get-ItemProperty $_.PSPath } | Where { $_ -match "$app" } | select UninstallString
  $uninstall64 = Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { Get-ItemProperty $_.PSPath } | Where { $_ -match "$app" } | select UninstallString
  If ($uninstall64) 
    {
     $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
     $uninstall64 = $uninstall64.Trim()
     Write-Host "Uninstalling..."
     start-process "msiexec.exe" -arg "/X $uninstall64 /quiet" -Wait -NoNewWindow -ErrorAction Stop
    }
  If ($uninstall32)
    {
     $uninstall32 = $uninstall32.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
     $uninstall32 = $uninstall32.Trim()
     Write-Host "Uninstalling..."
     start-process "msiexec.exe" -arg "/X $uninstall32 /quiet" -Wait -NoNewWindow -ErrorAction stop
    }
 }   
}

un-install