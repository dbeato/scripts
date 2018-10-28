$package = 'AdobeAIR'
$version = '31.0'
 
$params = @{
    PackageName = $package;
    FileType = 'exe';
    SilentArgs = '-silent -eulaAccepted';
    Url = "http://airdownload.adobe.com/air/win/download/$version/AdobeAIRInstaller.exe"
    Checksum = 'DC82421F135627802B21619BDB7E4B9B0EC16D351120485C575AA6C16CD2737E'
    ChecksumType  = 'sha256'
}
 
Install-ChocolateyPackage @params