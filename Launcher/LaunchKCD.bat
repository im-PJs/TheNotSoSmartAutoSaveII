@echo off
setlocal enabledelayedexpansion

REM -----------------------------------------------------
REM LaunchKCD_DebugREM pauses.bat
REM With additional debug REM pauses + a short re-check delay
REM For "The Not-So-Smart AutoSave"
REM -----------------------------------------------------

:: 1) Define path to AutoSaveScript.ahk (avoid double slash issues)
set "AHK_SCRIPT=%~dp0AutoSaveScript.ahk"

REM [Debug] 1) Checking for AutoSaveScript.ahk...
if not exist "%AHK_SCRIPT%" (
    echo [Error] AutoSaveScript.ahk not found in the Launcher directory.
    echo Please ensure AutoSaveScript.ahk exists in:
    echo %~dp0
    REM pause
    exit /B 254
)
REM [Debug] AutoSaveScript.ahk found.
REM pause

:: 2) Read config.ini for Platform
set "configPath=%~dp0..\config.ini"

REM [Debug] 2) Reading Platform from config.ini...
REM pause

for /f "tokens=1,* delims==" %%A in (
    'findstr /r "^Platform=" "%configPath%"'
) do (
    set "Platform=%%B"
)

:: Strip any possible trailing carriage returns or spaces:
set "Platform=%Platform:\r=%"
set "Platform=%Platform: =%"

REM [Debug] Raw platform is: "%Platform%"
REM pause

:: 3) Determine the launch command based on nested if logic:
REM [Debug] 3) Deciding which platform logic to use...
REM pause

set "gameLaunchCommand="

if "%Platform%"=="1" (
    :: Steam
    REM [Debug] => Chosen: Steam
    set "gameLaunchCommand=steam://rungameid/1771300"
    REM pause
) else (
    if "%Platform%"=="2" (
        :: Epic
        REM [Debug] => Chosen: Epic
        set "gameLaunchCommand=[EPIC_SHORTCUT_ONLY]"
        REM pause
    ) else (
        if "%Platform%"=="3" (
            :: Custom
            REM [Debug] => Chosen: Custom
            REM [Debug] Also reading GameLaunchCommand from config.ini...
            REM pause

            for /f "tokens=1,* delims==" %%A in (
                'findstr /r "^GameLaunchCommand=" "%configPath%"'
            ) do (
                set "GameLaunchCommand=%%B"
            )
            set "GameLaunchCommand=%GameLaunchCommand:\r=%"
            set "GameLaunchCommand=%GameLaunchCommand: =%"
            
            echo [Debug] Custom GameLaunchCommand read as: "%GameLaunchCommand%"
            REM pause
        ) else (
            :: Default to Steam if not recognized
            REM [Debug] => Chosen: ^(Unrecognized^) Defaulting to Steam
            set "gameLaunchCommand=steam://rungameid/1771300"
            REM pause
        )
    )
)

REM [Debug] Final gameLaunchCommand: "%gameLaunchCommand%"
REM pause

:: 4) Launch AutoSaveScript.ahk first
REM [Debug] 4) Launching AutoSaveScript.ahk...
start "" "%AHK_SCRIPT%"
REM [Debug] AutoSaveScript started.
REM pause

:: 5) Launch the game based on final gameLaunchCommand
REM [Debug] 5) Launching the game now...
REM pause

REM [Debug] gameLaunchCommand: %gameLaunchCommand%
REM pause

:: Define the .url file you want for Epic
set "ShortcutName=Kingdom Come Deliverance II.url"
REM [DEBUG] ShortcutName is: [%ShortcutName%]
REM pause

:: Nested if (no "else if" on the same line)
if "%gameLaunchCommand%"=="[EPIC_SHORTCUT_ONLY]" (
    :: EPIC-specific approach
    REM [Debug] USERPROFILE is: "%USERPROFILE%"
    REM pause

    REM [DEBUG] ShortcutName WITHIN is: [%ShortcutName%]
    REM [DEBUG] User Profile is: [%USERPROFILE%]
    REM pause

    ::  -- 1) Check OneDrive first --
    set "DesktopShortcutOne=%USERPROFILE%\OneDrive\Desktop\%ShortcutName%"
    REM [Debug] Checking OneDrive path: "!DesktopShortcutOne!"
    REM pause

    if exist "!DesktopShortcutOne!" (
        REM [Debug] Found in OneDrive! Using this path.
        set "DesktopShortcut=!DesktopShortcutOne!"
    ) else (
        ::  -- 2) Fallback to local Desktop --
        set "DesktopShortcut=%USERPROFILE%\Desktop\%ShortcutName%"
        REM [Debug] Checking local Desktop path: "!DesktopShortcut!"
        REM pause
    )

    ::  -- 3) If still not exist, wait 3s and re-check --
    if not exist "!DesktopShortcut!" (
        REM [Debug] Attempt #1: Shortcut not found. Waiting 3s and re-checking...
        timeout /T 3 >nul

        if not exist "!DesktopShortcut!" (
            echo [Error] Even after wait, Epic desktop shortcut not found!
            echo Please create "!ShortcutName!" on your Desktop
            echo or OneDrive\Desktop via the Epic Games Launcher.
            REM pause
            exit /B 1
        )
    )

    :: If we get here, the file exists
    REM [Debug] Found Epic shortcut: "!DesktopShortcut!"
    start "" "!DesktopShortcut!"
    REM [Debug] Epic game launched via desktop shortcut.

) else (
    if "%Platform%"=="3" (
        :: If user typed "Platform=3" we rely on gameLaunchCommand from config
        REM [Debug] Launching Custom command: "%gameLaunchCommand%"
        start "" "%gameLaunchCommand%"
    ) else (
        :: Steam or default
        REM [Debug] Launching Steam command: "%gameLaunchCommand%"
        start "" "%gameLaunchCommand%"
    )
)

REM [Debug] Game launch command executed.
REM pause

:: 6) Wait for the game to close
REM [Debug] 6) Now waiting for KingdomCome.exe to exit...
REM pause

:WaitForGame
REM [Debug] Checking for KingdomCome.exe...
timeout /T 5 /NOBREAK >NUL
tasklist /FI "IMAGENAME eq KingdomCome.exe" | find /I "KingdomCome.exe" >NUL

if "%ERRORLEVEL%"=="0" (
    goto WaitForGame
)

REM [Debug] KingdomCome.exe closed. AHK script should terminate soon.
REM pause

REM [Debug] Exiting batch script...
REM pause
exit /B 0
