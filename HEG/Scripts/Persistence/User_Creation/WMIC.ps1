$username = 'HEG_WMIC'
$password = 'x^Bu4SV*3e$n'

$securePassword = ConvertTo-SecureString $password -AsPlainText -Force


New-LocalUser -Name $username -Password $securePassword
