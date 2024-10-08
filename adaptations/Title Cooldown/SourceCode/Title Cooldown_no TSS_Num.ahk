﻿/*
Numpad1 - 17-5
Numpad2 - 15-6
NumpadEnter - Reset Timer
NumpadSub - Close Timer
*/

#SingleInstance Force
if not A_IsAdmin
   {
      Run *RunAs "%A_ScriptFullPath%"
      ExitApp 
   }

Gui, Show, x1550 y700
Gui, Color, c404040
Gui, Font, s14 cF4BD3E, MS Sans Serif
Gui, Add, Text,vTopic1 x5 y5 w50 center, 17-5
Gui, Add, Text,vTopic2 x5 y40 w50 center , 15-6


Gui, Margin ,, 5,5
Gui, Font, s14 cBlack, MS Sans Serif
Gui, Add, Text, vCountdown1 x85 y5 w100 cFFFFFF ,0
Gui, Add, Text, vCountdown2 x85 y40 w100 cFFFFFF ,0

Gui, Show, h45 w120
Gui, +AlwaysOnTop -Caption -Border


Gui, +LastFound
hwnd := WinExist()
DllCall("SetWindowLong", "UInt", hwnd, "Int", -20, "UInt", 0x20)


OnMessage(0x201, "WM_LBUTTONDOWN")
WM_LBUTTONDOWN() {
    PostMessage, 0xA1, 2,,, A
}

flag = 0
return

NumpadSub::
    ExitApp
return

$Numpad1::
   GuiControl, +cF4BD3E, Topic1
   GuiControl, +cFFFFFF, Countdown1
   cnt1 := 59
   SetTimer, Go1, 1000
Return

$Numpad2::
   GuiControl, +cF4BD3E, Topic2
   GuiControl, +cFFFFFF, Countdown2
   cnt2 := 29
   SetTimer, Go2, 1000
Return


$NumpadEnter::
   GuiControl, +cFFFFFF, Countdown1
   GuiControl, +cFFFFFF, Countdown2
   
   flag = 0

   GuiControl,, Countdown1, 0
   GuiControl,, Countdown2, 0

   SetTimer, Go1, off
   SetTimer, Go2, off
Return

Go1:   
   GuiControl,, Countdown1, % cnt1
   if (--cnt1 < 0)
      SetTimer, Go1, off
   else if (cnt1 < 11)
      GuiControl, +cRed, Countdown1
   else if (cnt1 < 31)
      GuiControl, +cF4BD3E, Countdown1
Return

Go2:   
   GuiControl,, Countdown2, % cnt2
   if (--cnt2 < 0)
      SetTimer, Go2, off
   else if (cnt2 < 11)
      GuiControl, +cRed, Countdown2
   else if (cnt2 < 21)
      GuiControl, +cF4BD3E, Countdown2
Return