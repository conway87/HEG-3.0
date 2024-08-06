

$Sensitive_Data = Get-Content -Path '.\Tools\Random_Data.txt'

$EncodedText = [System.Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($Sensitive_Data))




Write-Output $EncodedText

$EncodedText | Out-File -FilePath .\Staging\Encoded.txt
