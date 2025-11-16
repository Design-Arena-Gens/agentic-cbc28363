@echo off
color 0C
title System Tweaks - Advanced Optimization Tool
mode con: cols=100 lines=35

:MENU
cls
echo.
echo  ================================================================
echo  [91m   SYSTEM TWEAKS - ADVANCED OPTIMIZATION TOOL[0m
echo  ================================================================
echo.
echo  [41m WARNING: Run as Administrator for full functionality [0m
echo.
echo  [1] Clean Temporary Files
echo  [2] Optimize Network Settings
echo  [3] Disable Telemetry Services
echo  [4] Clean DNS Cache
echo  [5] Optimize SSD Performance
echo  [6] Disable Unnecessary Startup Programs
echo  [7] Clean System Memory Cache
echo  [8] Optimize Windows Search
echo  [9] Disable Background Apps
echo  [10] Gaming Performance Mode
echo  [11] Clean Windows Update Cache
echo  [12] System Health Check
echo  [13] Full System Optimization (All Tweaks)
echo  [0] Exit
echo.
echo  ================================================================
echo.
set /p choice="  [91mSelect option (0-13):[0m "

if "%choice%"=="0" goto EXIT
if "%choice%"=="1" goto TEMP_CLEAN
if "%choice%"=="2" goto NETWORK_OPT
if "%choice%"=="3" goto DISABLE_TELEMETRY
if "%choice%"=="4" goto DNS_CLEAN
if "%choice%"=="5" goto SSD_OPT
if "%choice%"=="6" goto STARTUP_OPT
if "%choice%"=="7" goto MEMORY_CLEAN
if "%choice%"=="8" goto SEARCH_OPT
if "%choice%"=="9" goto BACKGROUND_APPS
if "%choice%"=="10" goto GAMING_MODE
if "%choice%"=="11" goto UPDATE_CLEAN
if "%choice%"=="12" goto HEALTH_CHECK
if "%choice%"=="13" goto FULL_OPT

echo  [91mInvalid choice! Please try again.[0m
timeout /t 2 >nul
goto MENU

:TEMP_CLEAN
cls
echo  [91m[*] Cleaning Temporary Files...[0m
echo.
del /q /f /s %TEMP%\* 2>nul
del /q /f /s C:\Windows\Temp\* 2>nul
del /q /f /s C:\Windows\Prefetch\* 2>nul
rd /s /q %TEMP% 2>nul
mkdir %TEMP%
cleanmgr /sagerun:1 2>nul
echo  [92m[+] Temporary files cleaned successfully![0m
timeout /t 3 >nul
goto MENU

:NETWORK_OPT
cls
echo  [91m[*] Optimizing Network Settings...[0m
echo.
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global chimney=enabled
netsh int tcp set global dca=enabled
netsh int tcp set global netdma=enabled
netsh int tcp set global congestionprovider=ctcp
netsh int tcp set global ecncapability=disabled
netsh interface tcp set heuristics disabled
echo  [92m[+] Network settings optimized![0m
timeout /t 3 >nul
goto MENU

:DISABLE_TELEMETRY
cls
echo  [91m[*] Disabling Telemetry Services...[0m
echo.
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start=disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1
sc config dmwappushservice start=disabled >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
echo  [92m[+] Telemetry services disabled![0m
timeout /t 3 >nul
goto MENU

:DNS_CLEAN
cls
echo  [91m[*] Flushing DNS Cache...[0m
echo.
ipconfig /flushdns
echo  [92m[+] DNS cache cleared successfully![0m
timeout /t 3 >nul
goto MENU

:SSD_OPT
cls
echo  [91m[*] Optimizing SSD Performance...[0m
echo.
fsutil behavior set DisableDeleteNotify 0
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f >nul
echo  [92m[+] SSD optimization complete![0m
timeout /t 3 >nul
goto MENU

:STARTUP_OPT
cls
echo  [91m[*] Current Startup Programs:[0m
echo.
wmic startup get caption,command
echo.
echo  [91m[*] Use Task Manager to disable unnecessary startup programs[0m
echo  [91m[*] Press Ctrl+Shift+Esc, go to Startup tab[0m
timeout /t 5 >nul
goto MENU

:MEMORY_CLEAN
cls
echo  [91m[*] Cleaning System Memory Cache...[0m
echo.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1 /f >nul
echo  [92m[+] Memory cache will be cleared at shutdown![0m
timeout /t 3 >nul
goto MENU

:SEARCH_OPT
cls
echo  [91m[*] Optimizing Windows Search...[0m
echo.
sc config WSearch start=demand >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Search" /v SetupCompletedSuccessfully /t REG_DWORD /d 0 /f >nul
echo  [92m[+] Windows Search optimized![0m
timeout /t 3 >nul
goto MENU

:BACKGROUND_APPS
cls
echo  [91m[*] Disabling Background Apps...[0m
echo.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul
echo  [92m[+] Background apps disabled![0m
timeout /t 3 >nul
goto MENU

:GAMING_MODE
cls
echo  [91m[*] Enabling Gaming Performance Mode...[0m
echo.
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul
bcdedit /set useplatformclock true >nul 2>&1
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
echo  [92m[+] Gaming mode activated![0m
timeout /t 3 >nul
goto MENU

:UPDATE_CLEAN
cls
echo  [91m[*] Cleaning Windows Update Cache...[0m
echo.
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /q /f /s C:\Windows\SoftwareDistribution\Download\* 2>nul
rd /s /q C:\Windows\SoftwareDistribution\Download 2>nul
mkdir C:\Windows\SoftwareDistribution\Download
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo  [92m[+] Windows Update cache cleaned![0m
timeout /t 3 >nul
goto MENU

:HEALTH_CHECK
cls
echo  [91m[*] Running System Health Check...[0m
echo.
echo  [91m--- Disk Health ---[0m
wmic diskdrive get status
echo.
echo  [91m--- Memory Info ---[0m
wmic memorychip get capacity,speed
echo.
echo  [91m--- CPU Info ---[0m
wmic cpu get name,maxclockspeed
echo.
echo  [91m--- System Temperature ---[0m
wmic /namespace:\\root\wmi PATH MSAcpi_ThermalZoneTemperature get CurrentTemperature 2>nul
echo.
pause
goto MENU

:FULL_OPT
cls
echo  [91m[*] Running Full System Optimization...[0m
echo  [91m[*] This will apply all tweaks...[0m
echo.
timeout /t 3 >nul

echo  [91m[1/11] Cleaning temporary files...[0m
del /q /f /s %TEMP%\* 2>nul
del /q /f /s C:\Windows\Temp\* 2>nul
rd /s /q %TEMP% 2>nul
mkdir %TEMP%

echo  [91m[2/11] Optimizing network...[0m
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global chimney=enabled >nul 2>&1

echo  [91m[3/11] Disabling telemetry...[0m
sc config DiagTrack start=disabled >nul 2>&1
sc config dmwappushservice start=disabled >nul 2>&1

echo  [91m[4/11] Flushing DNS...[0m
ipconfig /flushdns >nul 2>&1

echo  [91m[5/11] Optimizing SSD...[0m
fsutil behavior set DisableDeleteNotify 0 >nul 2>&1

echo  [91m[6/11] Cleaning memory cache...[0m
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1 /f >nul

echo  [91m[7/11] Optimizing search...[0m
sc config WSearch start=demand >nul 2>&1

echo  [91m[8/11] Disabling background apps...[0m
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul

echo  [91m[9/11] Enabling gaming mode...[0m
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul

echo  [91m[10/11] Cleaning Windows Update cache...[0m
net stop wuauserv >nul 2>&1
del /q /f /s C:\Windows\SoftwareDistribution\Download\* 2>nul
net start wuauserv >nul 2>&1

echo  [91m[11/11] Final optimizations...[0m
cleanmgr /sagerun:1 2>nul

echo.
echo  [92m[+] Full system optimization complete![0m
echo  [92m[+] Consider restarting your system for all changes to take effect.[0m
echo.
pause
goto MENU

:EXIT
cls
echo.
echo  [91m================================================================[0m
echo  [91m              Thank you for using System Tweaks![0m
echo  [91m================================================================[0m
echo.
timeout /t 2 >nul
exit
