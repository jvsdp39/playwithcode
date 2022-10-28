param (        
    [string]$dump_file_name
) 

$DropBoxAccessToken = "sl.BR-Llwqw5q542giNAcfCAHJIXDtm2hjx0NFZm-io63IGK9U1MjmH7EZAo1EhC-C6wlpykmBSr7nM9gIyqy-6XvgYMkGy-T_gxU7FdtJJNs04YCz3QwdWyEWXwK7zh0NEt1EmUby2"
$outputFile = Split-Path $dump_file_name -leaf
$TargetFilePath="/$outputFile"
$arg = '{ "path": "' + $TargetFilePath + '", "mode": "add", "autorename": true, "mute": false }'
$authorization = "Bearer " + $DropBoxAccessToken
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $authorization)
$headers.Add("Dropbox-API-Arg", $arg)
$headers.Add("Content-Type", 'application/octet-stream')
Invoke-RestMethod -Uri https://content.dropboxapi.com/2/files/upload -Method Post -InFile $dump_file_name -Headers $headers