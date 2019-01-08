$HowOld = -45
#Path to the Root Folder
$Path = "C:\Program Files\SimplexGrinnell LP\PayClock\Backup"
get-childitem $Path -recurse | where {$_.lastwritetime -lt (get-date).adddays($HowOld) -and -not $_.psiscontainer} |% {remove-item $_.fullname -force}