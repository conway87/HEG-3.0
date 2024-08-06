@echo off
setlocal

set password=password
set command=calc.exe



for /l %%i in (1, 1, 25) do (
    .\Tools\psexec -u Administrator -p %password%_%%i %command%
)