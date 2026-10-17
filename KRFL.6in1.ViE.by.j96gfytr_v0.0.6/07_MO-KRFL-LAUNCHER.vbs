Option Explicit
Dim fso, shell, root, game, record, launcher
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")
root = fso.GetParentFolderName(WScript.ScriptFullName)
game = root
record = root & "\GAME_DIRECTORY.txt"
If fso.FileExists(record) Then
    Dim stream
    Set stream = fso.OpenTextFile(record, 1, False)
    game = Trim(stream.ReadAll)
    stream.Close
End If
launcher = game & "\07_KRFL-LAUNCHER.exe"
If Not fso.FileExists(launcher) Then launcher = root & "\COPY_INTO_GAME\07_KRFL-LAUNCHER.exe"
If Not fso.FileExists(launcher) Then
    MsgBox "Khong tim thay launcher. Giai nen toan bo patch va chay 01_CAI-PATCH.bat truoc.", 48, "KRFL Launcher"
    WScript.Quit 1
End If
shell.Run Chr(34) & launcher & Chr(34), 1, False
