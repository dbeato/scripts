################################################################################################

#

# Copyright (c) Microsoft Corporation.

# Licensed under the MIT License.

#

# THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR

# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,

# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE

# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER

# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,

# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE

# SOFTWARE.

#

################################################################################################

Param (

[Parameter(HelpMessage="Work Directory for patch WinRE")][string]$workDir="",

[Parameter(Mandatory=$true,HelpMessage="Path of target package")][string]$packagePath

)

# ------------------------------------

# Help functions

# ------------------------------------

# Log message

function LogMessage([string]$message)

{

$message = "$([DateTime]::Now) - $message"

Write-Host $message

}

function IsTPMBasedProtector

{

$DriveLetter = $env:SystemDrive

LogMessage("Checking BitLocker status")

$BitLocker = Get-WmiObject -Namespace "Root\cimv2\Security\MicrosoftVolumeEncryption" -Class "Win32_EncryptableVolume" -Filter "DriveLetter = '$DriveLetter'"

if(-not $BitLocker)

{

LogMessage("No BitLocker object")

return $False

}

$protectionEnabled = $False

switch ($BitLocker.GetProtectionStatus().protectionStatus){

("0"){

LogMessage("Unprotected")

break

}

("1"){

LogMessage("Protected")

$protectionEnabled = $True

break

}

("2"){

LogMessage("Uknown")

break

}

default{

LogMessage("NoReturn")

break

}

}

if (!$protectionEnabled)

{

LogMessage("Bitlocker isn’t enabled on the OS")

return $False

}

$ProtectorIds = $BitLocker.GetKeyProtectors("0").volumekeyprotectorID

$return = $False

foreach ($ProtectorID in $ProtectorIds){

$KeyProtectorType = $BitLocker.GetKeyProtectorType($ProtectorID).KeyProtectorType

switch($KeyProtectorType){

"1"{

LogMessage("Trusted Platform Module (TPM)")

$return = $True

break

}

"4"{

LogMessage("TPM And PIN")

$return = $True

break

}

"5"{

LogMessage("TPM And Startup Key")

$return = $True

break

}

"6"{

LogMessage("TPM And PIN And Startup Key")

$return = $True

break

}

default {break}

}#endSwitch

}#EndForeach

if ($return)

{

LogMessage("Has TPM-based protector")

}

else

{

LogMessage("Doesn't have TPM-based protector")

}

return $return

}

function SetRegistrykeyForSuccess

{

reg add HKLM\SOFTWARE\Microsoft\PushButtonReset /v WinREPathScriptSucceed_CVE_2024_20666 /d 1 /f

}

function TargetfileVersionExam([string]$mountDir)

{

# Exam target binary

$targetBinary=$mountDir + "\Windows\System32\winload.efi"

LogMessage("TargetFile: " + $targetBinary)

$realNTVersion = [Diagnostics.FileVersionInfo]::GetVersionInfo($targetBinary).ProductVersion

$versionString = "$($realNTVersion.Split('.')[0]).$($realNTVersion.Split('.')[1])"

$fileVersion = $($realNTVersion.Split('.')[2])

$fileRevision = $($realNTVersion.Split('.')[3])

LogMessage("Target file version: " + $realNTVersion)

if (!($versionString -eq "10.0"))

{

LogMessage("Not Windows 10 or later")

return $False

}

$hasUpdated = $False

#Windows 10, version 1507 10240.20400

#Windows 10, version 1607 14393.6610

#Windows 10, version 1809 17763.5322

#Windows 10, version 2004 1904X.3920

#Windows 11, version 21H2 22000.2710

#Windows 11, version 22H2 22621.3000

switch ($fileVersion) {

"10240" {

LogMessage("Windows 10, version 1507")

if ($fileRevision -ge 20400)

{

LogMessage("Windows 10, version 1507 with revision " + $fileRevision + " >= 20400, updates have been applied")

$hasUpdated = $True

}

break

}

"14393" {

LogMessage("Windows 10, version 1607")

if ($fileRevision -ge 6610)

{

LogMessage("Windows 10, version 1607 with revision " + $fileRevision + " >= 6610, updates have been applied")

$hasUpdated = $True

}

break

}

"17763" {

LogMessage("Windows 10, version 1809")

if ($fileRevision -ge 5322)

{

LogMessage("Windows 10, version 1809 with revision " + $fileRevision + " >= 5322, updates have been applied")

$hasUpdated = $True

}

break

}

"19041" {

LogMessage("Windows 10, version 2004")

if ($fileRevision -ge 3920)

{

LogMessage("Windows 10, version 2004 with revision " + $fileRevision + " >= 3920, updates have been applied")

$hasUpdated = $True

}

break

}

"22000" {

LogMessage("Windows 11, version 21H2")

if ($fileRevision -ge 2710)

{

LogMessage("Windows 11, version 21H2 with revision " + $fileRevision + " >= 2710, updates have been applied")

$hasUpdated = $True

}

break

}

"22621" {

LogMessage("Windows 11, version 22H2")

if ($fileRevision -ge 3000)

{

LogMessage("Windows 11, version 22H2 with revision " + $fileRevision + " >= 3000, updates have been applied")

$hasUpdated = $True

}

break

}

default {

LogMessage("Warning: unsupported OS version")

}

}

return $hasUpdated

}

function PatchPackage([string]$mountDir, [string]$packagePath)

{

# Exam target binary

$hasUpdated =TargetfileVersionExam($mountDir)

if ($hasUpdated)

{

LogMessage("The update has already been added to WinRE")

SetRegistrykeyForSuccess

return $False

}

# Add package

LogMessage("Apply package:" + $packagePath)

Dism /Add-Package /Image:$mountDir /PackagePath:$packagePath

if ($LASTEXITCODE -eq 0)

{

LogMessage("Successfully applied the package")

}

else

{

LogMessage("Applying the package failed with exit code: " + $LASTEXITCODE)

return $False

}

# Cleanup recovery image

LogMessage("Cleanup image")

Dism /image:$mountDir /cleanup-image /StartComponentCleanup /ResetBase

if ($LASTEXITCODE -eq 0)

{

LogMessage("Cleanup image succeed")

}

else

{

LogMessage("Cleanup image failed: " + $LASTEXITCODE)

return $False

}

return $True

}

# ------------------------------------

# Execution starts

# ------------------------------------

# Check breadcrumb

if (Test-Path HKLM:\Software\Microsoft\PushButtonReset)

{

$values = Get-ItemProperty -Path HKLM:\Software\Microsoft\PushButtonReset

if (!(-not $values))

{

if (Get-Member -InputObject $values -Name WinREPathScriptSucceed_CVE_2024_20666)

{

$value = Get-ItemProperty -Path HKLM:\Software\Microsoft\PushButtonReset -Name WinREPathScriptSucceed_CVE_2024_20666

if ($value.WinREPathScriptSucceed_CVE_2024_20666 -eq 1)

{

LogMessage("This script was previously run successfully")

exit 1

}

}

}

}

if ([string]::IsNullorEmpty($workDir))

{

LogMessage("No input for mount directory")

LogMessage("Use default path from temporary directory")

$workDir = [System.IO.Path]::GetTempPath()

}

LogMessage("Working Dir: " + $workDir)

$name = "9f8131ee-878f-4525-bf31-e446aac3016a_Mount"

$mountDir = Join-Path $workDir $name

LogMessage("MountDir: " + $mountdir)

# Delete existing mount directory

if (Test-Path $mountDir)

{

LogMessage("Mount directory: " + $mountDir + " already exists")

LogMessage("Try to unmount it")

Dism /unmount-image /mountDir:$mountDir /discard

if (!($LASTEXITCODE -eq 0))

{

LogMessage("Warning: unmount failed: " + $LASTEXITCODE)

}

LogMessage("Delete existing mount direcotry " + $mountDir)

Remove-Item $mountDir -Recurse

}

# Create mount directory

LogMessage("Create mount directory " + $mountDir)

New-Item -Path $mountDir -ItemType Directory

# Set ACL for mount directory

LogMessage("Set ACL for mount directory")

icacls $mountDir /inheritance:r

icacls $mountDir /grant:r SYSTEM:"(OI)(CI)(F)"

icacls $mountDir /grant:r *S-1-5-32-544:"(OI)(CI)(F)"

# Mount WinRE

LogMessage("Mount WinRE:")

reagentc /mountre /path $mountdir

if ($LASTEXITCODE -eq 0)

{

# Patch WinRE

if (PatchPackage -mountDir $mountDir -packagePath $packagePath)

{

$hasUpdated = TargetfileVersionExam($mountDir)

if ($hasUpdated)

{

LogMessage("After patch, find expected version for target file")

}

else

{

LogMessage("Warning: After applying the patch, unexpected version found for the target file")

}

LogMessage("Patch succeed, unmount to commit change")

Dism /unmount-image /mountDir:$mountDir /commit

if (!($LASTEXITCODE -eq 0))

{

LogMessage("Unmount failed: " + $LASTEXITCODE)

exit 1

}

else

{

if ($hasUpdated)

{

if (IsTPMBasedProtector)

{

# Disable WinRE and re-enable it to let new WinRE be trusted by BitLocker

LogMessage("Disable WinRE")

reagentc /disable

LogMessage("Re-enable WinRE")

reagentc /enable

reagentc /info

}

# Leave a breadcrumb indicates the script has succeed

SetRegistrykeyForSuccess

}

}

}

else

{

LogMessage("Patch failed or is not applicable, discard unmount")

Dism /unmount-image /mountDir:$mountDir /discard

if (!($LASTEXITCODE -eq 0))

{

LogMessage("Unmount failed: " + $LASTEXITCODE)

exit 1

}

}

}

else

{

LogMessage("Mount failed: " + $LASTEXITCODE)

}

# Cleanup Mount directory in the end

LogMessage("Delete mount direcotry")

Remove-Item $mountDir -Recurse