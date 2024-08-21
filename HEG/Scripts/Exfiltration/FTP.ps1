# Default creds supplied on dlptest.com for testing. 
# dlptest.com could rotate these in future, in which case please check for new ones and update script.

$ftpUrl = "ftp://ftp.dlptest.com/"
$username = "dlpuser"
$password = "rNrKYTX9g7z3RgJRmxWuGHbeu"

# Create WebClient object and set credentials
$client = New-Object System.Net.WebClient
$client.Credentials = New-Object System.Net.NetworkCredential($username, $password)



# Upload a test file to the FTP server
$remoteFile = "test.txt"
$SourceFile = '.\Tools\Random_Data.txt'
$localContent = Get-Content $SourceFile -Raw
$localFile = "C:\test.txt"
$localContent | Out-File -FilePath $localFile


# Upload the test file to FTP server
$client.UploadFile("$ftpUrl/$remoteFile", $localFile)

# Check if the uploaded file exists on the FTP server
$ftpResponse = $client.DownloadString("$ftpUrl/$remoteFile")

if ($ftpResponse -ne $null) {
    Write-Host "            * File upload was successful."
} else {
    Write-Host "            * File upload failed."
}


Remove-Item $localFile
