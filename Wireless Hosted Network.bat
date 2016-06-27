@echo off
title Adhoc Network Hoster 1.03 by William Nichols
:top
rem Cheap dirty way to check if we're admin
reg add HKLM\software\netsh /v amIAdmin /f >nul 2>nul
if %ERRORLEVEL% == 1 goto notAdmin
reg delete HKLM\software\netsh /v amIAdmin /f >nul 2>nul
if "%1" == "-?" goto Help
if "%1" == "/?" goto Help
if "%1" == "-start" goto Start
if "%1" == "/start" goto Start
if "%1" == "-show" goto Show
if "%1" == "/show" goto Show
if "%1" == "-temp" goto Temp
if "%1" == "/temp" goto Temp
if "%1" == "-edit" goto Edit
if "%1" == "/edit" goto Edit
if "%1" == "-stop" goto Stop
if "%1" == "/stop" goto Stop
:Menu
cls
echo No Command line options were givin. Choose a option.
echo Adhoc Network Hosting by William Nichols
echo [S]tart Hosting
echo S[h]ow set SSID and Passphrase
echo S[t]art Temporary
echo [E]dit the SSID and Passphrase
echo St[o]p Hosting
echo E[x]it
choice /C SHTEOX
if %ERRORLEVEL% == 1 goto Start
if %ERRORLEVEL% == 2 goto Show
if %ERRORLEVEL% == 3 goto Temp
if %ERRORLEVEL% == 4 goto Edit
if %ERRORLEVEL% == 5 goto Stop
if %ERRORLEVEL% == 6 goto Exit

:Start
cls
netsh wlan start hostednetwork

pause
goto Menu

:Show
cls
netsh wlan show hostednetwork
netsh wlan show hostednetwork setting=security

pause
goto Menu

:Temp
cls
echo What's the SSID?
set /p SSID=
set SSID="%SSID%"
echo What's the Passphrase?
set /p key=
set key="%key%"
netsh wlan set hostednetwork ssid=%SSID% key=%key% keyUsage=temporary
netsh wlan start hostednetwork

pause
goto Menu

:Edit
cls
echo What's the SSID?
set /p SSID=
set SSID="%SSID%"
echo What's the Passphrase?
set /p key=
set key="%key%"
netsh wlan set hostednetwork ssid=%SSID% key=%key%

pause
goto Menu

:Stop
cls
netsh wlan stop hostednetwork

pause
goto Menu

:Exit
exit

:notAdmin
set "batchPath=%~0"
setlocal EnableDelayedExpansion
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "!batchPath!", "ELEV", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%temp%\OEgetPrivileges.vbs"
exit /B
goto Menu
