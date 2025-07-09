/*
Numpad1 - 17-5
Numpad2 - 15-6
Numpad3 - 13-5
Numpad5 - Transslot
NumpadEnter - Reset Timer (Titles + Trans)
NumpadMult - Reset Timer (only Trans)
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
Gui, Add, Text,vTopic175 x5 y5 w50 center, 17-5
Gui, Add, Text,vTopic156 x5 y40 w50 center , 15-6
Gui, Add, Text,vTopic135 x5 y75 w50 center , 13-5
Gui, Add, Text,vTopicTrans x5 y110 w50 center, Trans


Gui, Margin ,, 5,5
Gui, Font, s14 cBlack, MS Sans Serif
Gui, Add, Text, vCountdown175 x85 y5 w100 cFFFFFF ,0
Gui, Add, Text, vCountdown156 x85 y40 w100 cFFFFFF ,0
Gui, Add, Text, vCountdown135 x85 y75 w100 cFFFFFF ,0
Gui, Add, Text, vTransCD x85 y110 w100 cFFFFFF ,0

Gui, Show, h120 w120
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
   GuiControl, +cF4BD3E, Topic175
   GuiControl, +cFFFFFF, Countdown175
   cnt175 := 59
   SetTimer, Go175, 1000
Return

$Numpad2::
   GuiControl, +cF4BD3E, Topic156
   GuiControl, +cFFFFFF, Countdown156
   cnt156 := 29
   SetTimer, Go156, 1000
Return

$Numpad3::
   GuiControl, +cF4BD3E, Topic135
   GuiControl, +cFFFFFF, Countdown135
   cnt135 := 29
   SetTimer, Go135, 1000
Return

$Numpad5::
   GuiControl, +cF4BD3E, TopicTrans
   GuiControl, +cFFFFFF, TransCD
   cntTrans := 19
   SetTimer, GoTrans, 1000
Return


$NumpadEnter::
   GuiControl, +cFFFFFF, Countdown175
   GuiControl, +cFFFFFF, Countdown156
   GuiControl, +cFFFFFF, Countdown135
   GuiControl, +cFFFFFF, TransCD
   
   flag = 0

   GuiControl,, Countdown175, 0
   GuiControl,, Countdown156, 0
   GuiControl,, Countdown135, 0
   GuiControl,, TransCD, 0

   SetTimer, Go175, off
   SetTimer, Go156, off
   SetTimer, Go135, off
   SetTimer, GoTrans, off
Return

$NumpadMult::
   GuiControl, +cFFFFFF, TransCD

   flag = 0

   GuiControl,, TransCD, 0

   SetTimer, GoTrans, off
Return

Go175:
   GuiControl,, Countdown175, % cnt175
   if (--cnt175 < 0)
      SetTimer, Go175, off
   else if (cnt175 < 11)
      GuiControl, +cRed, Countdown175
   else if (cnt175 < 31)
      GuiControl, +cF4BD3E, Countdown175
Return

Go156:
   GuiControl,, Countdown156, % cnt156
   if (--cnt156 < 0)
      SetTimer, Go156, off
   else if (cnt156 < 11)
      GuiControl, +cRed, Countdown156
   else if (cnt156 < 21)
      GuiControl, +cF4BD3E, Countdown156
Return

Go135:
   GuiControl,, Countdown135, % cnt135
   if (--cnt135 < 0)
      SetTimer, Go135, off
   else if (cnt135 < 16)
      GuiControl, +cRed, Countdown135
   else if (cnt135 < 26)
      GuiControl, +cF4BD3E, Countdown135
Return

GoTrans:
   GuiControl,, TransCD, % cntTrans
   if (cntTrans == 0) {
       GuiControl, +cF4BD3E, TopicTrans
       GuiControl, +cFFFFFF, TransCD
       cntTrans := 20
       SetTimer, GoTrans, 1000
   }

   if (--cntTrans < 5)
      GuiControl, +cRed, TransCD
   else if (cntTrans < 11)
      GuiControl, +cF4BD3E, TransCD
Return