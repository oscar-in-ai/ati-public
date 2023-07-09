$driverPath = "$env:userprofile\software\disco_star_BCS10\Windows\Printer Drivers\Star-BSC10-WinPrnDrv\smjb10.inf"
$printerName = "StarBCS10"
$portName = "USB001"

# Add printer driver
Add-PrinterDriver -Name "StarBCS10" -InfPath $driverPath

# Add printer port
Add-PrinterPort -Name $portName -PrinterHostAddress $portName

# Install printer
Add-Printer -Name $printerName -DriverName "StarBCS10" -PortName $portName
