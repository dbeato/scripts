param ( [Parameter(Mandatory=$true)][string]$instance_name )

$template_path = "C:\Program Files\Microsoft SQL Server\150\LocalDB\Binn\Templates"
$database_path = "C:\Users\ADSync\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\$instance_name"

$service = Get-WmiObject -Class Win32_Service -Filter "NAME = 'ADSync'"

Set-Service ADSync -StartupType Disabled
Stop-Process -Force $service.ProcessId

Copy-Item "$template_path\model.mdf" $database_path
Copy-Item "$template_path\modellog.ldf" $database_path

Set-Service ADSync -StartupType Automatic
Start-Service ADSync