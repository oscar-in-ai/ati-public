# Disable sleep settings
powercfg.exe -change -standby-timeout-ac 0
powercfg.exe -change -standby-timeout-dc 0
powercfg.exe -change -hibernate-timeout-ac 0
powercfg.exe -change -hibernate-timeout-dc 0
powercfg.exe -change -monitor-timeout-ac 0
powercfg.exe -change -monitor-timeout-dc 0

# Disable IPv6 protocol
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
Set-ItemProperty -Path $regPath -Name "DisabledComponents" -Value 0xffffffff

# Disable IPv6 on network interfaces
$netAdapter = Get-NetAdapter | Where-Object {$_.InterfaceType -ne "Loopback"}
$netAdapter | ForEach-Object {
    Disable-NetAdapterBinding -Name $_.Name -ComponentID ms_tcpip6
}

# Enable file extensions in Windows
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
