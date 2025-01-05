/*
< (NOT ARROW KEY, Arrow as in 6<9==true) - Transslot CD Start
RCtrl - Reset Timer to 0
´ as in ´´´ - Close Timer
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
Gui, Add, Text,vTopic1 x5 y5 w50 center, Trans


Gui, Margin ,, 5,5
Gui, Font, s14 cBlack, MS Sans Serif
Gui, Add, Text, vTransCD x85 y5 w100 cFFFFFF ,0

Gui, Show, h15 w115
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

´::
    ExitApp
return

$<::
   GuiControl, +cF4BD3E, Topic1
   GuiControl, +cFFFFFF, TransCD
   cnt1 := 19
   SetTimer, Go1, 1000
Return

F12::KeyHistory

$RCtrl::
   GuiControl, +cFFFFFF, TransCD
   
   flag = 0

   GuiControl,, TransCD, 0

   SetTimer, Go1, off
Return

Go1:   
   GuiControl,, TransCD, % cnt1
   if (cnt1 == 0) {
       GuiControl, +cF4BD3E, Topic1
       GuiControl, +cFFFFFF, TransCD
       cnt1 := 20
       SetTimer, Go1, 1000
   }

   if (--cnt1 < 0)
      SetTimer, Go1, off
   else if (cnt1 < 5)
      GuiControl, +cRed, TransCD
   else if (cnt1 < 11)
      GuiControl, +cF4BD3E, TransCD
Return