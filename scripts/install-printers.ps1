# Array of URLs
$urls = @(
    "https://www.godexprinters.co.uk/downloads/drivers/Godex_2017.1_M-0.exe",
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

# Function to download and extract the files
function DownloadAndExtractFiles {
    $tempFolderPath = [System.IO.Path]::GetTempPath()
    $softwareFolderPath = Join-Path -Path $env:USERPROFILE -ChildPath 'software'

    foreach ($url in $urls) {
        $fileName = Split-Path -Path $url -Leaf
        $downloadPath = Join-Path -Path $tempFolderPath -ChildPath $fileName

        Write-Host "Downloading $fileName..."
        Invoke-WebRequest -Uri $url -OutFile $downloadPath

        if ($fileName -like '*.zip') {
            Write-Host "Extracting $fileName..."
            Expand-Archive -Path $downloadPath -DestinationPath $softwareFolderPath
        } else {
            Write-Host "Copying $fileName to software folder..."
            Copy-Item -Path $downloadPath -Destination $softwareFolderPath
        }

        # Remove the downloaded file
        Remove-Item -Path $downloadPath -Force
    }
}

CreateSoftwareFolder
DownloadAndExtractFiles

$driverPath1 = "$env:USERPROFILE\software\disco_zebra\Software\ZebraSetupUtilities\Driver\ZBRN\Win64\ZBRN.inf"
PNPUtil.exe /add-driver $driverPath1 /install 

$driverPath2 = "$env:USERPROFILE\software\disco_star_BCS10\Windows\Printer Drivers\Star-BSC10-WinPrnDrv\smjb10.inf"
PNPUtil.exe /add-driver $driverPath2 /install
