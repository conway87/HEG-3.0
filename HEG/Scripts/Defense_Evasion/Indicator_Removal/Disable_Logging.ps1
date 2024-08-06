$ErrorActionPreference = "SilentlyContinue"

wevtutil sl Microsoft-Windows-Bits-Client/Operational /e:false
wevtutil sl Microsoft-Windows-HelloForBusiness/Operational /e:false

Start-Sleep -Seconds 3

wevtutil sl Microsoft-Windows-Bits-Client/Operational /e:true
wevtutil sl Microsoft-Windows-HelloForBusiness/Operational /e:true