
REG DELETE HKEY_CURRENT_USER\Console\HEG\COMPROMISED\RegistryKey\ /f

SCHTASKS /DELETE /TN "Microsoft\HEG\COMPROMISED\ScheduledTask" /f

sc.exe delete HEG-COMPROMISED-Service



del /Q .\Staging\*