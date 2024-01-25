# Array of hardcoded zip URLs
$zipUrls = @(
    "https://ati-s3-public-dist-prd.s3.ap-southeast-2.amazonaws.com/software/disco_star_BCS10.zip",
    "https://ati-s3-public-dist-prd.s3.ap-southeast-2.amazonaws.com/software/disco_zebra.zip"
)

# Function to create the 'software' folder if it doesn't exist
function CreateSoftwareFolder {
    $softwareFolderPath = Join-Path -Path $env:USERPROFILE -ChildPath 'software'
    if (-not (Test-Path -Path $softwareFolderPath)) {
        New-Item -ItemType Directory -Path $softwareFolderPath | Out-Null
    }
}

# Function to download and extract the zip files
function DownloadAndExtractZipFiles {
    $tempFolderPath = [System.IO.Path]::GetTempPath()
    $softwareFolderPath = Join-Path -Path $env:USERPROFILE -ChildPath 'software'

    foreach ($url in $zipUrls) {
        $zipFileName = [System.IO.Path]::GetFileName($url)
        $downloadPath = Join-Path -Path $tempFolderPath -ChildPath $zipFileName

        Write-Host "Downloading $zipFileName..."
        Invoke-WebRequest -Uri $url -OutFile $downloadPath

        Write-Host "Extracting $zipFileName..."
        Expand-Archive -Path $downloadPath -DestinationPath $softwareFolderPath

        # Remove the downloaded zip file
        Remove-Item -Path $downloadPath -Force
    }
}

CreateSoftwareFolder
DownloadAndExtractZipFiles

$driverPath1 = "$env:userprofile\software\disco_zebra\Software\ZebraSetupUtilities\Driver\ZBRN\Win64\ZBRN.inf"
PNPUtil.exe /add-driver $driverPath1 /install 

$driverPath2 = "$env:userprofile\software\disco_star_BCS10\Windows\Printer Drivers\Star-BSC10-WinPrnDrv\smjb10.inf"
PNPUtil.exe /add-driver $driverPath2 /install 