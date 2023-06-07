$UserPath = [Environment]::GetFolderPath('MyDocuments')
$FolderPath = Join-Path -Path $UserPath -ChildPath 'Freelit/mzr'

$ConfigPath = Join-Path -Path $FolderPath -ChildPath 'config'
$LogsPath = Join-Path -Path $FolderPath -ChildPath 'logs'
$DistributionsPath = Join-Path -Path $FolderPath -ChildPath 'distributions'

# Create folders
New-Item -ItemType Directory -Path $ConfigPath -Force
New-Item -ItemType Directory -Path $LogsPath -Force
New-Item -ItemType Directory -Path $DistributionsPath -Force

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
