$password = ConvertTo-SecureString -String "x^Bu4SV*3e$n" -AsPlainText -Force
New-LocalUser -Name "HEG_Disabled-User" -Password $password -Disabled