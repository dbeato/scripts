    mkdir C:\scripts
    cd \scripts
    Invoke-WebRequest -Uri "https://tntmaxllc-my.sharepoint.com/:u:/g/personal/dbeato_tntmax_com/ERah9KR7oDtDulMJ4O2zGYgBea5jci2LITNfU3Gm7iEQKA?e=fVGcG9&download=1" -OutFile "PatchWinREScript_2004plus.ps1"
    Invoke-WebRequest -Uri "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/crup/2024/01/windows10.0-kb5034235-x64_56366bb71884fc21c948c37ed3341f74aaf6b296.cab" -OutFile "windows10.0-kb5034235-x64_56366bb71884fc21c948c37ed3341f74aaf6b296.cab"
    Set-ExecutionPolicy -ExecutionPolicy Bypass
    .\PatchWinREScript_2004plus.ps1 -packagePath "windows10.0-kb5034235-x64_56366bb71884fc21c948c37ed3341f74aaf6b296.cab"