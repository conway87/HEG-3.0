@echo off
set COMPUTER=%COMPUTERNAME%
.\Tools\psexec \\%COMPUTER% -s winrm.cmd quickconfig -q
timeout /t 2 > nul
sc stop winrm
sc config winrm start= disabled