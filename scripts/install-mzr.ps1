Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
$UserPath = [Environment]::GetFolderPath('MyDocuments')
$FolderPath = Join-Path -Path $UserPath -ChildPath 'Freelit/mzr'

$ConfigPath = Join-Path -Path $FolderPath -ChildPath 'config'
$LogsPath = Join-Path -Path $FolderPath -ChildPath 'logs'
$DistributionsPath = Join-Path -Path $FolderPath -ChildPath 'distributions'
$RestorePath = Join-Path -Path $FolderPath -ChildPath 'restore'

# Create folders
New-Item -ItemType Directory -Path $ConfigPath -Force
New-Item -ItemType Directory -Path $LogsPath -Force
New-Item -ItemType Directory -Path $DistributionsPath -Force
New-Item -ItemType Directory -Path $RestorePath -Force

$TerminalNumber = Read-Host -Prompt 'Enter Terminal number'
$ConfigFilePath = Join-Path -Path $ConfigPath -ChildPath ('{0}.txt' -f $TerminalNumber)
$ConfigContent = 'user id=z1;password=12345678;port=3308;server=192.168.1.2;database=mer1;persistsecurityinfo=True;convertzerodatetime=True'

# Create the config file
$ConfigContent | Out-File -FilePath $ConfigFilePath -Encoding UTF8

$ZipFileUrl = 'https://ati-s3-public-dist-prd.s3.ap-southeast-2.amazonaws.com/distributions/mzr/mzr_latest.zip'
$TempPath = [System.IO.Path]::GetTempPath()
$ZipFilePath = Join-Path -Path $TempPath -ChildPath 'mzr_latest.zip'

# Download the ZIP file
Invoke-WebRequest -Uri $ZipFileUrl -OutFile $ZipFilePath

# Extract contents to the distributions folder
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($ZipFilePath, $DistributionsPath)

# Clean up the temporary ZIP file
Remove-Item -Path $ZipFilePath -Force
