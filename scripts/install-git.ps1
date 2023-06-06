# Check if Chocolatey is installed
$chocoInstalled = Get-Command choco -ErrorAction SilentlyContinue
if (!$chocoInstalled) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install Git using Chocolatey
Write-Host "Installing Git..."
choco install git -y

# Set the paths
$repoFolder = Join-Path $env:USERPROFILE "repos\ati-public"
$repoUrl = "https://github.com/oscar-in-ai/ati-public.git"

# Create the repository folder
Write-Host "Creating repository folder..."
New-Item -ItemType Directory -Path $repoFolder -Force

# Change to the repository folder
Set-Location -Path $repoFolder

# Clone the repository
Write-Host "Cloning the repository..."
git clone $repoUrl

Write-Host "Repository cloned successfully!"
