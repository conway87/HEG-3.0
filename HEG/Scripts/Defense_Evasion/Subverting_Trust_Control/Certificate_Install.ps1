$rootCert = New-SelfSignedCertificate -CertStoreLocation cert:\LocalMachine\My -DnsName "COMPROMISED_CERTIFICATE" -KeyUsage CertSign,CRLSign -KeyLength 2048 -KeyAlgorithm RSA -HashAlgorithm SHA256 -NotAfter (Get-Date).AddYears(10)
Export-Certificate -Cert $rootCert -FilePath ".\Staging\COMPROMISED_CERTIFICATE.cer" -Type CERT
Import-Certificate -FilePath ".\Staging\COMPROMISED_CERTIFICATE.cer" -CertStoreLocation 'Cert:\LocalMachine\Root'
Get-ChildItem -Path Cert:\LocalMachine\Root | Where-Object {$_.Subject -eq "CN=COMPROMISED_CERTIFICATE"} | Remove-Item -Force
Start-Sleep -Seconds 3
Remove-Item -Path .\Staging\COMPROMISED_CERTIFICATE.cer -Recurse -Force