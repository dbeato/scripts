#Script to Fix Volume License office activation issue with office 2016 
cscript "C:\Program Files\Microsoft Office\Office16\OSPP.vbs" /status
#If the Status shows as Retail Expired, run the command below
cscript "C:\Program Files\Microsoft Office\Office16\OSPP.vbs" /unpkey:KHGM9