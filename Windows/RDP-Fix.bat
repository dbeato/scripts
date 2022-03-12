cd %systemroot%\system32
copy mstsc.exe mstsc2.exe
cd %systemroot%\system32\en-us\
copy mstsc.exe.mui mstsc2.exe.mui
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /t REG_SZ /v "C:\Windows\System32\mstsc2.exe" /d "~ DPIUNAWARE" /f