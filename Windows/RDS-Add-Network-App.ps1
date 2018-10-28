<# Appplication name is the applcation name, the file path is the location of the program. The program.exe is the application that will be used #>

New-RDRemoteApp -CollectionName CollectionName  -DisplayName "Application Name"  -FilePath "\\server\share\program.exe" -IconPath "\\server\share\program.exe"

