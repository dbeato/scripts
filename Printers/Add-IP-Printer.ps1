<#
Modified from @Sorvani
PrinterName = is the 
$PrinterName = "Name of the Printer"
$PrinterPort = "Printer Port"
$PortHost = "IP address of the printer"
$DriverLocation = "Driver Share"
$DriverName = "Driver Name"
setup the variables to throughout. These will become parameters.#>
$PrinterName = "HP 500 Color"
$PrinterPort = "10.202.20.23C"
$PortHost = "10.202.20.23"
$DriverLocation = "\\someshare\Software\Drivers\Printers\HP_LJPM570\hpcm570u.inf"
$DriverName = "HP LaserJet 500 color MFP M570 PCL 6"


# Import Print Management Module
Import-Module PrintManagement

# Remove any existing printer port
# you will see an error is it does not exist, just ignore
# todo wrap in if statement
Remove-PrinterPort -name $PrinterPort

# Add the printer port
Add-PrinterPort -Name $PrinterPort -PrinterHostAddress $PortHost

# Add the driver to the driver store
# using this because had failures with -InfPath in Add-PrinterDriver
Invoke-Command {pnputil.exe -a $DriverLocation }

# Add the print driver 
 Add-PrinterDriver -name $DriverName

# Add the printer
Add-Printer -name $PrinterName -PortName $PrinterPort -DriverName $DriverName

# Set printer to print mono or color
Set-PrintConfiguration -PrinterName $PrinterName -Color $true

###Set this printer as the default printer
$Printers = Get-WmiObject -Class Win32_Printer
$Printer = $Printers | Where{$_.Name -eq "$PrinterName"} 
$Printer.SetDefaultPrinter() | Out-Null