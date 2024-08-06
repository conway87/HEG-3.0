Start-Process -FilePath "vssadmin.exe" -ArgumentList "create shadow /for=C:" -Wait
Start-Process -FilePath "vssadmin.exe" -ArgumentList "delete shadows /all /quiet"