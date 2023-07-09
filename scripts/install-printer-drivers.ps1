$driverPath = "$env:userprofile\software\disco_star_BCS10\Windows\Printer Drivers\Star-BSC10-WinPrnDrv\smjb10.inf"
$printerName = "Star BCS10"
$portName = "USB001"
PNPUtil.exe /add-driver $driverPath /install 
# Add printer driver
Add-PrinterDriver -Name "Star BSC10"
# Check if the printer port exists
$portExists = Get-PrinterPort -Name $portName -ErrorAction SilentlyContinue

if ($portExists -eq $null) {
    # Add printer port
    Add-PrinterPort -Name $portName -PrinterHostAddress $portName
    Write-Output "Printer port created."
} else {
    Write-Output "Printer port already exists."
}
# Install printer
Add-Printer -Name $printerName -DriverName "Star BCS10" -PortName $portName
