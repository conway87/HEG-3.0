Copy-Item -Path ".\Tools\PsExec.exe" -Destination "C:\Windows\System32"
PsExec.exe -i -s cmd /c ping google.ie
Remove-Item "C:\Windows\System32\PsExec.exe"