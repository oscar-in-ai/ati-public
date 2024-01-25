Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
$UserPath = [Environment]::GetFolderPath('MyDocuments')
$FolderPath = Join-Path -Path $UserPath -ChildPath 'Freelit/mzr'

$ConfigPath = Join-Path -Path $FolderPath -ChildPath 'config'
$LogsPath = Join-Path -Path $FolderPath -ChildPath 'logs'
$DistributionsPath = Join-Path -Path $FolderPath -ChildPath 'distributions'
$RestorePath = Join-Path -Path $FolderPath -ChildPath 'restore'


$ZipFileUrl = 'https://ati-s3-public-dist-prd.s3.ap-southeast-2.amazonaws.com/distributions/mzr/mzr_latest.zip'
$TempPath = [System.IO.Path]::GetTempPath()
$ZipFilePath = Join-Path -Path $TempPath -ChildPath 'mzr_latest.zip'

# Download the ZIP file
Invoke-WebRequest -Uri $ZipFileUrl -OutFile $ZipFilePath


# Extract the zip file to the destination directory and overwrite existing files
Expand-Archive -Path $ZipFilePath -DestinationPath $DistributionsPath -Force

# Clean up the temporary ZIP file
Remove-Item -Path $ZipFilePath -Force
Invoke-Item $DistributionsPath
