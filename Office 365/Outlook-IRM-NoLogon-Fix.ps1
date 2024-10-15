# Set variables to indicate value and key to set
$RegistryPath = 'HKCU:\Software\Microsoft\Office\16.0\Common\Identity'
$Name         = 'NoDomainUser'
$Value        = '1'
# Create the key if it does not exist
If (-NOT (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
  } 
New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force 