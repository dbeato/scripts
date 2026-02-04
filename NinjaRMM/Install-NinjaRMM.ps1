# Define variables
$msiUrl = "https://xx.ninjarmm.com/agent/installer/NinjaOne-Agent.msi"  # Replace with your MSI URL
$msiFileName = "NinjaOne-Agent.msi"                 # Replace with the MSI file name
$tempFolder = [System.IO.Path]::GetTempPath()
$msiFilePath = Join-Path -Path $tempFolder -ChildPath $msiFileName
$programName = "NinjaRMMAgent"

# Function to check if the program is installed
function Is-ProgramInstalled {
    param (
        [string]$programName
    )

    $uninstallKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
    $uninstallKeyWow6432 = "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
    
    $installedPrograms = Get-ChildItem -Path $uninstallKey, $uninstallKeyWow6432 | 
                         Get-ItemProperty | 
                         Where-Object { $_.DisplayName -like "*$programName*" }

    return $installedPrograms -ne $null
}

# Step 1: Check if the program is already installed
if (Is-ProgramInstalled -programName $programName) {
    Write-Host "The program '$programName' is already installed. Exiting script."
} else {
    # Step 2: If not installed, download the MSI file if not already in the temp folder
    if (-Not (Test-Path -Path $msiFilePath)) {
        Write-Host "Downloading the MSI file..."
        
        $headers = @{
            "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
        }
        
        Invoke-WebRequest -Uri $msiUrl -OutFile $msiFilePath -Headers $headers
        Write-Host "Download complete."
    } else {
        Write-Host "MSI file already exists in the Temp folder."
    }

    # Step 3: Install the MSI if the program is not installed
    Write-Host "Installing the program '$programName'..."
    Start-Process msiexec.exe -ArgumentList "/i `"$msiFilePath`" /quiet /norestart" -Wait
    Write-Host "Installation complete."
}