' Version 1.1
Set WshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Get the directory path of the current script
scriptPath = fso.GetParentFolderName(WScript.ScriptFullName) & "\"

' Path to LaunchKCD.bat
batchFilePath = scriptPath & "Launcher\LaunchKCD.bat"

' Check if LaunchKCD.bat exists
If fso.FileExists(batchFilePath) Then
    ' Run the batch file hidden (0) without waiting (False)
    ExitCode = WshShell.Run(Chr(34) & batchFilePath & Chr(34), 0, False)
Else
    MsgBox "LaunchKCD.bat not found. Please ensure it exists in the Launcher directory.", vbCritical, "The Not-So-Smart AutoSave"
End If

Set WshShell = Nothing
Set fso = Nothing
