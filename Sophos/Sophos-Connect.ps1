mkdir C:\temp
cd \temp
Invoke-WebRequest -Uri "https://tntmaxllc-my.sharepoint.com/:u:/g/personal/dbeato_tntmax_com/ESHXRBYhbAJOoX-78q89DFUBz9ucpmf_qHEVuoq6ovAxjw?e=kgNoa1&download=1"  -OutFile SophosConnect.msi
msiexec.exe /i SophosConnect.msi /QN