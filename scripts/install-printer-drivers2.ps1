$driverPath = "$env:userprofile\software\disco_zebra\Software\ZebraSetupUtilities\Driver\ZBRN\Win64\ZBRN.inf"
$printerName = "ZDesigner TLP 2844"
$portName = "USB002"
PNPUtil.exe /add-driver $driverPath /install 
# Add printer driver
Add-PrinterDriver -Name "ZDesigner TLP 2844"
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
Add-Printer -Name $printerName -DriverName "ZDesigner TLP 2844" -PortName $portName
