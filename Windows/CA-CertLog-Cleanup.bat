net stop CertSvc
del /Q %windir%\System32\CertLog\*.log
del /Q %windir%\System32\CertLog\edb.chk
net start CertSvc