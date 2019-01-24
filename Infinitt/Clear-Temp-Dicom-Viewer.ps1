$HowOld = -45
#Path to the Root Folder
$Path = "C:\INFINITT_WVI\VIEWER\Temp"
get-childitem $Path -recurse | where {$_.lastwritetime -lt (get-date).adddays($HowOld) -and -not $_.psiscontainer} |% {remove-item $_.fullname -force}