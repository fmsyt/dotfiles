@echo off

where wsl >nul 2>nul

if %errorlevel% equ 0 (
    echo WSL is already installed.
    exit
)

for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
if NOT "%LEVEL%"=="High" (
    @powershell -NoProfile -ExecutionPolicy unrestricted -Command "Start-Process %~f0 -Verb runas"
    exit
)

wsl --install
