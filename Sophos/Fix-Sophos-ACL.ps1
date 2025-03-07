# Source: https://community.sophos.com/intercept-x-endpoint/f/discussions/132809/sophos-network-threat-protection-installation-fails-solved
# Modification the ACLS in the registry 

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -Confirm:$false

$keys_to_fix = "S-1-5-19", 
               "S-1-5-19\Software", 
			   "S-1-5-19\Software\Microsoft", 
			   "S-1-5-19\Software\Microsoft\SystemCertificates"

foreach($key_to_fix in $keys_to_fix)
{
    Write-host "Fixing:" $key_to_fix

    $key = [Microsoft.Win32.Registry]::Users.OpenSubKey($key_to_fix,
           [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,
           [System.Security.AccessControl.RegistryRights]::ChangePermissions)

    $acl = $key.GetAccessControl()

    $rule = New-Object System.Security.AccessControl.RegistryAccessRule ("NT AUTHORITY\LOCALSERVICE","FullControl","ContainerInherit","None","Allow")
    
    $acl.SetAccessRule($rule)
    
    $key.SetAccessControl($acl)
}

$keys_to_fix2 = "S-1-5-19", 
               "S-1-5-19\Software", 
			   "S-1-5-19\Software\Microsoft"			   
			   

foreach($key_to_fix2 in $keys_to_fix2)
{
    Write-host "Fixing:" $key_to_fix2

    $key2 = [Microsoft.Win32.Registry]::Users.OpenSubKey($key_to_fix2,
           [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,
           [System.Security.AccessControl.RegistryRights]::ChangePermissions)

    $acl2 = $key2.GetAccessControl()

    $systemSid = New-Object System.Security.Principal.SecurityIdentifier('S-1-15-2-1')

    $rule2 = New-Object System.Security.AccessControl.RegistryAccessRule ($systemSid,"ReadKey","Allow")
    
    $acl2.SetAccessRule($rule2)
    
    $key2.SetAccessControl($acl2)
}

$keys_to_fix3 = "S-1-5-19", 
               "S-1-5-19\Software", 
			   "S-1-5-19\Software\Microsoft", 
			   "S-1-5-19\Software\Microsoft\SystemCertificates"

foreach($key_to_fix3 in $keys_to_fix3)
{
    Write-host "Fixing:" $key_to_fix3

    $key3 = [Microsoft.Win32.Registry]::Users.OpenSubKey($key_to_fix3,
           [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,
           [System.Security.AccessControl.RegistryRights]::ChangePermissions)

    $acl3 = $key3.GetAccessControl()

    $person = [System.Security.Principal.NTAccount]"restricted"
    $access = [System.Security.AccessControl.RegistryRights]"ReadKey"
    $servicelocal3 = New-Object System.Security.AccessControl.RegistryAccessRule ($person,$access,"ContainerInherit","None","Allow")
    
    $acl3.SetAccessRule($servicelocal3)
    
    $key3.SetAccessControl($acl3)
}
#
#New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS
$key_to_fix =  "S-1-5-19\Software\Microsoft\SystemCertificates\CA"


    Write-host "Fixing:" $key_to_fix

    $key = [Microsoft.Win32.Registry]::Users.OpenSubKey($key_to_fix,
           [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,
           [System.Security.AccessControl.RegistryRights]::ChangePermissions)

    $acl = $key.GetAccessControl()

    $rule = New-Object System.Security.AccessControl.RegistryAccessRule ("NT AUTHORITY\LOCALSERVICE","FullControl","Allow")
    
    $acl.SetAccessRule($rule)
    
    $key.SetAccessControl($acl)
    
    $acl = Get-Acl "HKCU:\S-1-5-19\SOFTWARE\Microsoft\SystemCertificates\CA"
    
    $servicelocal = New-Object System.Security.Principal.NTAccount 'NT AUTHORITY\LOCALSERVICE'
    $acl.SetGroup( $servicelocal)
    $acl | Set-Acl