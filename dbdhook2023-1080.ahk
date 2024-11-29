#Requires AutoHotkey v2.0
#SingleInstance Force

WindowName := "DeadByDaylight"

FolderPath := "C:\temp"
FileName := "C:\temp\count.ini"
If !DirExist(FolderPath) {
	DirCreate(FolderPath)
}
If FileExist(FileName) {
	FileDelete(FileName)
}
Loop 4 {
    IniWrite(0, FileName, A_Index, A_Index)
}


; Calculate X and Y position for the GUI based on the screen resolution
GuiX := A_ScreenWidth * 0.00005  ; 2.6% of screen width
GuiY := A_ScreenHeight * 0.41  ; 44.4% of screen height

MyGui := Gui()
MyGui.Opt("+LastFound +AlwaysOnTop -Caption +ToolWindow")
MyGui.BackColor := "EEAA99"
MyGui.SetFont("s32 cFFD166", "verdana")

yPos := 0  ; Initialize y-position variable
xPos := 50  ; Set a fixed x-position
Loop 4 {
    MyGui.Add("Text", "x" xPos " y" yPos " vnum" A_Index " BackGroundTrans")
    yPos += 90  ; Increase y-position by 120 for each new line
}

WinSetTransColor(MyGui.BackColor " 255")



SetTimer(UpdateOSD, 200)
UpdateOSD()

; Use calculated position for GUI
Loop {
WinWaitActive(WindowName)
MyGui.Show("x" GuiX " y" GuiY " w120 h450 NoActivate")
WinWaitNotActive(WindowName)
MyGui.Hide()
}
return

#HotIf WinActive(WindowName)
~1::Increment(1)
~2::Increment(2)
~3::Increment(3)
~4::Increment(4)
~+1::Decrement(1)
~+2::Decrement(2)
~+3::Decrement(3)
~+4::Decrement(4)
#HotIf
+ESC::ExitApp
+F12::Reload



; Functions

UpdateOSD() {
    Loop 4 {
        number := IniReadValue(A_Index)
        MyGui["num" A_Index].Text := number
    }
}

Increment(key) {
    UpdateIniFile(key, 1)
}

Decrement(key) {
    UpdateIniFile(key, -1)
}

UpdateIniFile(key, change) {
    number := IniReadValue(key)
    number += change
    number := Mod(number, 4)
    IniWrite(number, FileName, key, key)
}

IniReadValue(key) {
    number := IniRead(FileName, key, key)
    return number
}
