# Set the paths
$basePath = [Environment]::GetFolderPath("UserProfile")
$freelitPath = Join-Path $basePath "Documents\Freelit"
$mzrPath = Join-Path $freelitPath "mzr"
$configPath = Join-Path $mzrPath "config"
$logsPath = Join-Path $mzrPath "logs"
$distributionsPath = Join-Path $mzrPath "distributions"
$tempPath = Join-Path $basePath "Documents\Temp"

# Create the necessary folders
New-Item -ItemType Directory -Force -Path $configPath
New-Item -ItemType Directory -Force -Path $logsPath
New-Item -ItemType Directory -Force -Path $distributionsPath

# Download the ZIP file
$zipUrl = "https://ati-s3-public-dist-prd.s3.ap-southeast-2.amazonaws.com/distributions/mzr/mzr_latest.zip"
$zipPath = Join-Path $tempPath "mzr_latest.zip"
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath

# Extract the contents of the ZIP file
Expand-Archive -Path $zipPath -DestinationPath $distributionsPath -Force

# Clean up the temporary ZIP file
Remove-Item -Path $zipPath -Force
