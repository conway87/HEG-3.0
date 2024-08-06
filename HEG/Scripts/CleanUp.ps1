cmd /c 'REG DELETE HKEY_CURRENT_USER\Console\HEG\COMPROMISED\RegistryKey\ /f'

cmd /c 'SCHTASKS /DELETE /TN "Microsoft\HEG\COMPROMISED\ScheduledTask" /f'

cmd /c 'sc.exe delete HEG-COMPROMISED-Service'



$usersToDelete = Get-LocalUser | Where-Object {$_.Name -like 'HEG_*'}

foreach ($user in $usersToDelete) {
        Remove-LocalUser -Name $user.Name
        
}


# Staging Directory Cleanup
$directoryPath = ".\Staging"

# Get all items in the directory
$items = Get-ChildItem -Path $directoryPath

# Loop through each item and delete it
foreach ($item in $items) {
    try {
        Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction Stop
    } catch {
        # Handle errors silently
    }
}
