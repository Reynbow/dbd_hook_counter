#Persistent
#SingleInstance Force
#NoEnv

FolderPath := "C:\temp"
IfNotExist, %FolderPath%
{
    FileCreateDir, %FolderPath%
}

FileDelete, C:\temp\hook.ini
Loop, 4 {
    IniWrite, 0, C:\temp\hook.ini, %A_Index%, %A_Index%
}

; Retrieve primary monitor's screen resolution
SysGet, ScreenWidth, 0  ; Retrieves the width of the primary monitor
SysGet, ScreenHeight, 1  ; Retrieves the height of the primary monitor

; Calculate X and Y position for the GUI based on the screen resolution
GuiX := ScreenWidth * 0.00005  ; 2.6% of screen width
GuiY := ScreenHeight * 0.41  ; 44.4% of screen height

CustomColor = EEAA99
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui, Color, %CustomColor%
Gui, Font, s32, verdana

yPos := 0  ; Initialize y-position variable
xPos := 50  ; Set a fixed x-position
Loop, 4 {
    Gui, Add, Text, x%xPos% y%yPos% vnum%A_Index% cFFD166 BackGroundTrans
    yPos += 90  ; Increase y-position by 120 for each new line
}

WinSet, TransColor, %CustomColor% 255
SetTimer, UpdateOSD, 200
Gosub, UpdateOSD

; Use calculated position for GUI
Gui, Show, x%GuiX% y%GuiY% w120 h450 NoActivate
return

UpdateOSD:
Loop, 4 {
    number := IniReadValue(A_Index)
    GuiControl,, num%A_Index%, %number%
}
return

~1::Increment(1)
~2::Increment(2)
~3::Increment(3)
~4::Increment(4)
~+1::Decrement(1)
~+2::Decrement(2)
~+3::Decrement(3)
~+4::Decrement(4)

F12::Reload
+ESC::ExitApp

; Functions
Increment(key) {
    UpdateIniFile(key, 1)
}

Decrement(key) {
    UpdateIniFile(key, -1)
}

UpdateIniFile(key, change) {
    number := IniReadValue(key)
    number += change
    if (number > 3) {
        number := 0
    } else if (number < 0) {
        number := 3
    }
    IniWrite, %number%, C:\temp\hook.ini, %key%, %key%
}

IniReadValue(key) {
    IniRead, number, C:\temp\hook.ini, %key%, %key%
    return number
}
