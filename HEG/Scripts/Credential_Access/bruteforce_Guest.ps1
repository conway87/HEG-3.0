$TimeZone = (Get-TimeZone).Id
$ResetTimeZone = [System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now, $TimeZone)




function Set-OriginalDateTime {

Set-Date $ResetTimeZone > $null

}



function Set-RandomDateTime {
# Generate a random date and time
$randomDate = Get-Date -Year (Get-Random -Minimum 2025 -Maximum 2055) -Month (Get-Random -Minimum 1 -Maximum 13) -Day (Get-Random -Minimum 1 -Maximum 29) -Hour (Get-Random -Minimum 0 -Maximum 24) -Minute (Get-Random -Minimum 0 -Maximum 60) -Second (Get-Random -Minimum 0 -Maximum 60)

Set-Date $randomDate

}







$username = "Guest"
for ($i = 1; $i -le 25; $i++) {
    $password = "Password_$i"
    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)
    Start-Process -FilePath "C:\Windows\System32\calc.exe" -Credential $credential
    Set-RandomDateTime > $null
}


Set-OriginalDateTime


Start-Sleep -Seconds 5
