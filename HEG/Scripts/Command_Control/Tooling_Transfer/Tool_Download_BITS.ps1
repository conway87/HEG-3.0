Start-BitsTransfer -Source https://download.sysinternals.com/files/PSTools.zip -Destination .\Staging\ToolDownload-BITS.zip

Expand-Archive -Path .\Staging\ToolDownload-BITS.zip -DestinationPath .\Staging\ToolDownload-BITS -Force

Remove-Item -Path .\Staging\ToolDownload-BITS.zip -Recurse -Force

Remove-Item -Path .\Staging\ToolDownload-BITS -Recurse -Force