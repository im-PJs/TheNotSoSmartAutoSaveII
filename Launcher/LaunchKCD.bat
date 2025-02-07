@echo off
setlocal enabledelayedexpansion

REM ----------------------------------------------------------------
REM LaunchKCD.bat - Version 1.1
REM Fully updated version with watchdog for AutoSaveScript.ahk.
REM This batch file:
REM   1) Launches AutoSaveScript.ahk.
REM   2) Launches the game (KingdomCome.exe) via Steam, Epic, or custom settings.
REM   3) Monitors that AutoSaveScript.ahk is running while the game is active.
REM      If the AHK script stops unexpectedly, it is restarted. 
REM ----------------------------------------------------------------

:: 1) Define the path to AutoSaveScript.ahk (avoid double slash issues)
set "AHK_SCRIPT=%~dp0AutoSaveScript.ahk"

if not exist "%AHK_SCRIPT%" (
    echo [Error] AutoSaveScript.ahk not found in the Launcher directory.
    echo Please ensure AutoSaveScript.ahk exists in:
    echo %~dp0
    exit /B 254
)

:: 2) Read config.ini to determine the Platform setting
set "configPath=%~dp0..\config.ini"
for /f "tokens=1,* delims==" %%A in (
    'findstr /r "^Platform=" "%configPath%"'
) do (
    set "Platform=%%B"
)
:: Remove any carriage returns or spaces
set "Platform=%Platform:\r=%"
set "Platform=%Platform: =%"

:: 3) Determine the game launch command based on the Platform value
set "gameLaunchCommand="
if "%Platform%"=="1" (
    :: Steam
    set "gameLaunchCommand=steam://rungameid/1771300"
) else (
    if "%Platform%"=="2" (
        :: Epic
        set "gameLaunchCommand=[EPIC_SHORTCUT_ONLY]"
    ) else (
        if "%Platform%"=="3" (
            :: Custom command – read from config.ini
            for /f "tokens=1,* delims==" %%A in (
                'findstr /r "^GameLaunchCommand=" "%configPath%"'
            ) do (
                set "GameLaunchCommand=%%B"
            )
            set "GameLaunchCommand=%GameLaunchCommand:\r=%"
            set "GameLaunchCommand=%GameLaunchCommand: =%"
            echo [Debug] Custom GameLaunchCommand read as: "%GameLaunchCommand%"
        ) else (
            :: Default to Steam if Platform is unrecognized
            set "gameLaunchCommand=steam://rungameid/1771300"
        )
    )
)

:: 4) Launch AutoSaveScript.ahk first
echo Launching AutoSaveScript.ahk...
start "" "%AHK_SCRIPT%"

:: 5) Launch the game based on the platform
if "%gameLaunchCommand%"=="[EPIC_SHORTCUT_ONLY]" (
    :: Epic-specific approach using a desktop shortcut
    set "ShortcutName=Kingdom Come Deliverance II.url"
    set "DesktopShortcutOne=%USERPROFILE%\OneDrive\Desktop\%ShortcutName%"
    if exist "!DesktopShortcutOne!" (
        set "DesktopShortcut=!DesktopShortcutOne!"
    ) else (
        set "DesktopShortcut=%USERPROFILE%\Desktop\%ShortcutName%"
    )
    if not exist "!DesktopShortcut!" (
        REM Wait a few seconds to see if the shortcut appears
        timeout /T 3 >nul
        if not exist "!DesktopShortcut!" (
            echo [Error] Epic desktop shortcut not found!
            echo Please create "!ShortcutName!" on your Desktop or OneDrive\Desktop.
            exit /B 1
        )
    )
    echo Launching Epic game via desktop shortcut...
    start "" "!DesktopShortcut!"
) else (
    if "%Platform%"=="3" (
        echo Launching custom game command: "%GameLaunchCommand%"
        start "" "%GameLaunchCommand%"
    ) else (
        echo Launching game via Steam command: "%gameLaunchCommand%"
        start "" "%gameLaunchCommand%"
    )
)

:: 6) Monitor the game and check for the AutoSaveScript.ahk process.
:WaitForGame
    timeout /T 2 /NOBREAK >nul

    :: Check if the game (KingdomCome.exe) is still running.
    tasklist /FI "IMAGENAME eq KingdomCome.exe" | find /I "KingdomCome.exe" >nul
    if "%ERRORLEVEL%"=="0" (
        
        set "ahkRunning="

        echo Debug: Starting tasklist query for AutoSaveScript.ahk...

        :: Check the verbose tasklist output for known AutoHotkey processes.
        for %%p in (AutoHotkeyU64.exe AutoHotkeyUX.exe AutoHotkey.exe) do (
            for /f "skip=3 tokens=*" %%a in ('tasklist /V /FI "IMAGENAME eq %%p"') do (
                echo %%a | findstr /I "AutoSaveScript.ahk" >nul
                if "%ERRORLEVEL%"=="0" (
                    set "ahkRunning=1"
                )
            )
        )

        echo Debug: tasklist query complete. ahkRunning is: %ahkRunning%

        if not defined ahkRunning (
            echo [Debug] AutoSaveScript.ahk is NOT running. Restarting...
            start "" "%AHK_SCRIPT%"
        ) else (
            echo [Debug] AutoSaveScript.ahk is running.
        )

        goto WaitForGame
    ) else (
        echo Game process closed. Exiting batch script.
        exit /B 0
    )
