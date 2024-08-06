$groups = "Administrators", "Remote Desktop Users"
$username = "HEG_User"

foreach ($group in $groups) {
    Add-LocalGroupMember -Group $group -Member $username
}