SCHTASKS /CREATE /SC DAILY /TN "Microsoft\HEG\COMPROMISED\ScheduledTask" /TR "%windir%\system32\win32calc.exe"