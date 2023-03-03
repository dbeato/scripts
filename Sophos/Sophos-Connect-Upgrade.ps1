mkdir C:\temp
cd \temp
Invoke-WebRequest -Uri "https://tntmaxllc-my.sharepoint.com/:u:/g/personal/dbeato_tntmax_com/Ea6jWX8xuPxMpcBK2M1s8T8BhWKVFSUX2honezMFdjvs-w?e=RJe3rV&download=1"  -OutFile SophosConnect.msi
msiexec.exe /i SophosConnect.msi /QN