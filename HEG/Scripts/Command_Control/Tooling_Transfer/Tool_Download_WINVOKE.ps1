$url = "https://download.sysinternals.com/files/PSTools.zip"
$downloadPath = ".\Staging\ToolDownload-WINVOKE.zip"
$destinationPath = ".\Staging\ToolDownload-WINVOKE"


# Download the file
Invoke-WebRequest -Uri $url -OutFile $downloadPath

# Wait for download to finish
while (-not (Test-Path $downloadPath)) {
    Start-Sleep -Seconds 1
}


# Uncompress the downloaded file
Expand-Archive -Path $downloadPath -DestinationPath $destinationPath -Force



Remove-Item -Path $downloadPath -Recurse -Force
Remove-Item -Path $destinationPath -Recurse -Force





