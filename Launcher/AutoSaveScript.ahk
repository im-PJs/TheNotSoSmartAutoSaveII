#SingleInstance Force
#Persistent
Menu, Tray, NoStandard  ; Remove the default menu items
Menu, Tray, Add, Exit, ExitApp  ; Add an Exit option

; Set default values (1 minute = 60000 ms)
defaultSaveInterval := 300000  ; 5 minutes = 300000 ms
defaultDelay := 300000         ; 5 minutes before the first autosave
logFilePath := A_ScriptDir . "\autosave.log"

; Read settings from config.ini
configFilePath := A_ScriptDir . "\..\config.ini"
saveInterval := defaultSaveInterval
initialDelay := defaultDelay
enableLogging := false
Log("Starting AutoSaveScript.ahk... Enjoy the madness!")

if FileExist(configFilePath)
{
    IniRead, userInterval, %configFilePath%, Settings, SaveInterval, 0
    if (userInterval > 0)
    {
        saveInterval := userInterval * 1000  ; Convert seconds to milliseconds
    }

    IniRead, userDelay, %configFilePath%, Settings, InitialDelay, 0
    if (userDelay > 0)
    {
        initialDelay := userDelay * 1000  ; Convert seconds to milliseconds
    }

    IniRead, loggingSetting, %configFilePath%, Settings, EnableLogging, false
    if (loggingSetting = "true")
    {
        enableLogging := true
    }
}
else
{
    MsgBox, 48, The Not-So-Smart AutoSave, config.ini not found. Using default settings.
}

; Function to log messages if logging is enabled
Log(message) {
    global enableLogging, logFilePath
    if enableLogging {
        FormatTime, timestamp,, yyyy-MM-dd HH:mm:ss
        FileAppend, [%timestamp%] %message%`n, %logFilePath%
    }
}

; Initialize countdown timer and autosave
autosaveStarted := false
countdown := initialDelay // 1000  ; Countdown starts with InitialDelay in seconds
Menu, Tray, Tip, Preparing to autosave... initial delay ends in %countdown% seconds  ; Set initial tray tip
SetTimer, CountdownTick, 1000  ; Update tray icon every second
SetTimer, InitialAutosave, %initialDelay%  ; Initial delay before first autosave
SetTimer, CheckKCD, 6000  ; Check if the game is still running every 6 seconds

; Tray countdown update
CountdownTick:
    if countdown > 0
    {
        if autosaveStarted
        {
            Menu, Tray, Tip, Next autosave in %countdown% seconds
        }
        else
        {
            Menu, Tray, Tip, Preparing to autosave... initial delay ends in %countdown% seconds
        }
        countdown--
    }
    else
    {
        if autosaveStarted
        {
            Menu, Tray, Tip, Autosaving now...
        }
        else
        {
            Menu, Tray, Tip, Initial autosave starting...
        }
    }
return

; Function to send F5 to the game window and reset interval timer (Initial autosave)
InitialAutosave:
    ; Check if the Kingdom Come window is open
    IfWinExist, ahk_exe KingdomCome.exe
    {
        ; Activate the game window before sending the F5 key
        WinActivate
        ; Send F5 key to the active game window
        Send {F5}
        ; Reset the interval and countdown
        autosaveStarted := true
        countdown := saveInterval // 1000
        SetTimer, Autosave, %saveInterval%  ; Set up repeating timer for subsequent autosaves
        Menu, Tray, Tip, Autosave completed! Next autosave in %countdown% seconds
        Log("Initial autosave triggered.")
    }
    else
    {
        Menu, Tray, Tip, Kingdom Come not found! Initial autosave skipped.
        Log("Initial autosave failed. Game window not found.")
    }
return

; Function to send F5 to the game window for subsequent autosaves
Autosave:
    ; Check if the Kingdom Come window is open
    IfWinExist, ahk_exe KingdomCome.exe
    {
        ; Activate the game window before sending the F5 key
        WinActivate
        ; Send F5 key to the active game window
        Send {F5}
        ; Reset the interval and countdown
        countdown := saveInterval // 1000
        Menu, Tray, Tip, Autosave completed! Next autosave in %countdown% seconds
        Log("Autosave triggered.")
    }
    else
    {
        Menu, Tray, Tip, Kingdom Come not found! Autosave skipped.
        Log("Autosave failed. Game window not found.")
    }
return

; Timer to check if KCD is still running
CheckKCD:
    Process, Exist, KingdomCome.exe
    if (ErrorLevel = 0)  ; If the process is not running
    {
        Menu, Tray, Tip, Kingdom Come closed. Exiting AutoSave Mod.
        Log("KingdomCome.exe not running. Exiting AutoSaveScript.")
        ExitApp
    }
return

; Exit routine
ExitApp:
    Menu, Tray, Tip, Exiting The Not-So-Smart AutoSave.
    Log("Script exited.")
    ExitApp
return
