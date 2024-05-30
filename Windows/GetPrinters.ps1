$printers = get-printer * 

foreach ($printer in $printers){get-printerproperty -printerName $printer.name}