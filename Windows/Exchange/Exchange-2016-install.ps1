#Install Pre-requisites
Install-WindowsFeature RSAT-ADDS
#Install Server Roles
Install-WindowsFeature NET-Framework-45-Features, RPC-over-HTTP-proxy, RSAT-Clustering, RSAT-Clustering-CmdInterface, RSAT-Clustering-Mgmt, RSAT-Clustering-PowerShell, Web-Mgmt-Console, WAS-Process-Model, Web-Asp-Net45, Web-Basic-Auth, Web-Client-Auth, Web-Digest-Auth, Web-Dir-Browsing, Web-Dyn-Compression, Web-Http-Errors, Web-Http-Logging, Web-Http-Redirect, Web-Http-Tracing, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Lgcy-Mgmt-Console, Web-Metabase, Web-Mgmt-Console, Web-Mgmt-Service, Web-Net-Ext45, Web-Request-Monitor, Web-Server, Web-Stat-Compression, Web-Static-Content, Web-Windows-Auth, Web-WMI, Windows-Identity-Foundation, RSAT-ADDS, Server-Media-Foundation
# Install the Unified Communications Managed API 4.0 Runtime
# From URL: https://www.microsoft.com/en-us/download/details.aspx?id=34992
# Install Net 4.7.1 on the Server
# From URL: https://www.microsoft.com/en-us/download/details.aspx?id=56116
# Install Visual C++ Redistributable Packages for Visual Studio 2013
# From URL: https://www.microsoft.com/en-us/download/details.aspx?id=40784
# Download the latest Exchange 2016 Install from here: https://docs.microsoft.com/en-us/Exchange/new-features/build-numbers-and-release-dates?view=exchserver-2019#exchange-server-2016
# Run the install of the Exchange by running the Setup.exe of the mounted image.
# Also make sure the Exchange Server is on the same Site as the Schema Master FSMO holder in the domain. 
# Follow the prompts on the Exchange installer.