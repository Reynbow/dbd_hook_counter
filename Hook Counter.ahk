;I use these three lines for every single script.
#Persistent                 ;This keeps the script running even if it finishes running all its code (afaik)
#SingleInstance Force       ;This makes it so if you run the script a second time, it'll close the old version and open the new instance
#NoEnv                      ;Just makes the script not check empty variables, I dunno, I just always use it

FileDelete, C:\temp\hook.ini ; Resets the ini file each time the script launchers or you press F12 to reload the script

IniWrite, 0, C:\temp\hook.ini, 1, 1 ; writes a 0 value at the start of the script for each line
IniWrite, 0, C:\temp\hook.ini, 2, 2
IniWrite, 0, C:\temp\hook.ini, 3, 3
IniWrite, 0, C:\temp\hook.ini, 4, 4

CustomColor = EEAA99 ; the chroma colour
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow ; hiding all the various GUI elements and keeping it on top
Gui, Color, %CustomColor% ; chroma colour
Gui, Font, s32, verdana ; Set a large font size (32-point).

Gui, Add, Text, x00 y0 vnum1 cFFD166 BackGroundTrans, ; survivor 1
Gui, Add, Text, x110 y0 vnum2 cFFD166 BackGroundTrans, ; survivor 2
Gui, Add, Text, x220 y0 vnum3 cFFD166 BackGroundTrans, ; survivor 3
Gui, Add, Text, x330 y0 vnum4 cFFD166 BackGroundTrans, ; survivor 4

WinSet, TransColor, %CustomColor% 255 ; I was working with making the font transparent a little, but I prefer it opaque. Adjust this from 0 - 255 for transparancy
SetTimer, UpdateOSD, 200 ; how frequently the On Screen Display updates - it's set to 200 miliseconds at the moment. Set it to 1000 for 1 second updates
Gosub, UpdateOSD
Gui, Show, x122 y945 w450 h60 NoActivate
return

UpdateOSD:
IniRead, number1, C:\temp\hook.ini, 1, 1
GuiControl,, num1, %number1%
IniRead, number2, C:\temp\hook.ini, 2, 2
GuiControl,, num2, %number2%
IniRead, number3, C:\temp\hook.ini, 3, 3
GuiControl,, num3, %number3%
IniRead, number4, C:\temp\hook.ini, 4, 4
GuiControl,, num4, %number4%
return

1::
IniRead, number1, C:\temp\hook.ini, 1, 1
number1 := number1 + 1
IniWrite, %number1%, C:\temp\hook.ini, 1, 1
Return

2::
IniRead, number2, C:\temp\hook.ini, 2, 2
number2 := number2 + 1
IniWrite, %number2%, C:\temp\hook.ini, 2, 2
Return

3::
IniRead, number3, C:\temp\hook.ini, 3, 3
number3 := number3 + 1
IniWrite, %number3%, C:\temp\hook.ini, 3, 3
Return

4::
IniRead, number4, C:\temp\hook.ini, 4, 4
number4 := number4 + 1
IniWrite, %number4%, C:\temp\hook.ini, 4, 4
Return

+1::
IniRead, number1, C:\temp\hook.ini, 1, 1
number1 := number1 - 1
IniWrite, %number1%, C:\temp\hook.ini, 1, 1
Return

+2::
IniRead, number2, C:\temp\hook.ini, 2, 2
number2 := number2 - 1
IniWrite, %number2%, C:\temp\hook.ini, 2, 2
Return

+3::
IniRead, number3, C:\temp\hook.ini, 3, 3
number3 := number3 - 1
IniWrite, %number3%, C:\temp\hook.ini, 3, 3
Return

+4::
IniRead, number4, C:\temp\hook.ini, 4, 4
number4 := number4 - 1
IniWrite, %number4%, C:\temp\hook.ini, 4, 4
Return

F12::
Reload
Return

+ESC::
ExitApp