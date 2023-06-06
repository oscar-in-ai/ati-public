# Run PowerShell as administrator

# Disable sleep settings
powercfg.exe -change -standby-timeout-ac 0
powercfg.exe -change -standby-timeout-dc 0
powercfg.exe -change -hibernate-timeout-ac 0
powercfg.exe -change -hibernate-timeout-dc 0
powercfg.exe -change -monitor-timeout-ac 0
powercfg.exe -change -monitor-timeout-dc 0

# Disable hybrid sleep
powercfg.exe -change -hibernate-type 0

# Set power plan to High Performance
$powerPlan = Get-WmiObject -Namespace "root\cimv2\power" -Class Win32_PowerPlan | Where-Object {$_.ElementName -like "*High performance*"}
powercfg.exe /s $powerPlan.InstanceID
