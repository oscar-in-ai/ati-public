# Set the paths
$repoFolder = Join-Path $env:USERPROFILE "repos"
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
