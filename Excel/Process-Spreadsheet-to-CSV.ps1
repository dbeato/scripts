
# Variables for The processing of the CSV Files
# You will be required to create an Archive & Output Folders on the Folder where the Excel Spreadsheet is in.
# Date format and Date variable (Can be changed based on this article - https://learn.microsoft.com/en-us/system-center/orchestrator/standard-activities/format-date-time?view=sc-orch-2022)
$dateFormat = "MM-dd-yyyy"
$date = (Get-Date).ToString($dateFormat)
#Location of the File that will be Worked on
$file_location = "D:\OneDrive\OneDrive - TNTMAX, LLC\Test Script\Test.xlsx"
#File Name to be renamed
$file_name = "Test.xlsx"
#Archive Folder & Archived File Location
$archive_dir = "D:\OneDrive\OneDrive - TNTMAX, LLC\Test Script\Archive\"
$archived_filename = "D:\OneDrive\OneDrive - TNTMAX, LLC\Test Script\Archive\Test.xlsx"
#Sheet Name to be Processed (Each Sheet Name needs to be )
$sheet_lists = "Sept-2023","August-2023"
#$password: optional - to be used if file is password protected

#Opens Excel and Saves the specified Sheet/Sheets into one ore more CSV Files.
ForEach ($sheet_list in $sheet_lists)
{
$objExcel = New-Object -ComObject Excel.Application
$objExcel.Visible = $False
$objExcel.DisplayAlerts = $False
$WorkBook = $objExcel.Workbooks.Open($file_location)
#Save Location
$output_file_location = "D:\OneDrive\OneDrive - TNTMAX, LLC\Test Script\Output\Test-$sheet_list.csv"
$WorkSheet = $WorkBook.sheets.item("$sheet_list")
$xlCSV = 6
$WorkSheet.SaveAs($output_file_location,$xlCSV)
$objExcel.quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($objExcel)
}
#Archiving of the Excel File and Rename of the file to the Date-FileName
Move-Item $file_location -Destination $archive_dir
Rename-Item -Path $archived_filename -NewName "$date-$file_name"
