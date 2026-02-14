@echo off
REM Run-Debloat-Menu.bat
REM Launcher for the Win11 Debloat Menu
REM Double-click this file to start the menu

echo.
echo ================================================================
echo          Windows 11 Debloat Scripts - Menu Launcher
echo ================================================================
echo.
echo Checking for administrator privileges...
echo.

REM Check for administrator privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Administrator privileges confirmed.
    echo Starting menu...
    echo.
    timeout /t 2 /nobreak >nul
    
    REM Set execution policy and run the menu script
    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0Run-Debloat-Menu.ps1'"
    
    goto :end
) else (
    echo.
    echo ERROR: This script requires administrator privileges!
    echo.
    echo Please right-click this file and select "Run as administrator"
    echo.
    pause
    goto :end
)

:end
exit /b
