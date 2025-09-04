@echo off
REM Connect to network share
net use \\LAB\isos

:MENU
cls
echo ==========================================
echo         System Deployment Menu
echo ==========================================
echo [1] Install CMSL and Export BIOS Settings
echo [2] Install Windows 11 24H2
echo [3] Reboot Device
echo [Q] Quit
echo ==========================================
set /p choice="Select an option: "

if "%choice%"=="1" goto CMSL
if "%choice%"=="2" goto WIN11
if "%choice%"=="3" goto REBOOT
if /I "%choice%"=="Q" exit

goto MENU

:CMSL
echo Installing CMSL silently...
\\LAB\isos\CMSL\cmsl.exe /SILENT

echo Exporting BIOS settings using PowerShell script...
powershell -ExecutionPolicy Bypass -File \\LAB\isos\CMSL\ExportBIOSSettings.ps1

goto END

:WIN11
echo Applying registry patch to bypass Windows 11 checks...
regedit /s \\LAB\isos\24h2\BypassWindows11Checks.reg

echo Launching Windows 11 24H2 setup...
\\LAB\isos\24h2\setup.exe

goto END

:REBOOT
echo Rebooting device...
shutdown /r /t 5
goto END

:END
echo.
echo Task completed. Press any key to return to menu.
pause >nul
goto MENU