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
Gui, Add, Text,vTopic1 x5 y5 w50 center, 17-5
Gui, Add, Text,vTopic2 x5 y40 w50 center , 15-6
Gui, Add, Text,vTopic3 x5 y75 w50 center , 13-5
Gui, Add, Text,vTopic4 x5 y110 w50 center, Trans


Gui, Margin ,, 5,5
Gui, Font, s14 cBlack, MS Sans Serif
Gui, Add, Text, vCountdown1 x85 y5 w100 cFFFFFF ,0
Gui, Add, Text, vCountdown2 x85 y40 w100 cFFFFFF ,0
Gui, Add, Text, vCountdown3 x85 y75 w100 cFFFFFF ,0
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

$Numpad3::
   GuiControl, +cF4BD3E, Topic3
   GuiControl, +cFFFFFF, Countdown3
   cnt3 := 29
   SetTimer, Go3, 1000
Return

$Numpad5::
   GuiControl, +cF4BD3E, Topic4
   GuiControl, +cFFFFFF, TransCD
   cnt4 := 19
   SetTimer, Go4, 1000
Return


$NumpadEnter::
   GuiControl, +cFFFFFF, Countdown1
   GuiControl, +cFFFFFF, Countdown2
   GuiControl, +cFFFFFF, Countdown3
   GuiControl, +cFFFFFF, Countdown4
   
   flag = 0

   GuiControl,, Countdown1, 0
   GuiControl,, Countdown2, 0
   GuiControl,, Countdown3, 0
   GuiControl,, Countdown4, 0

   SetTimer, Go1, off
   SetTimer, Go2, off
   SetTimer, Go3, off
   SetTimer, Go4, off
Return

$NumpadMult::
   GuiControl, +cFFFFFF, TransCD

   flag = 0

   GuiControl,, TransCD, 0

   SetTimer, Go4, off
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

Go3:   
   GuiControl,, Countdown3, % cnt3
   if (--cnt3 < 0)
      SetTimer, Go3, off
   else if (cnt3 < 16)
      GuiControl, +cRed, Countdown3
   else if (cnt3 < 26)
      GuiControl, +cF4BD3E, Countdown3
Return

Go4:
   GuiControl,, TransCD, % cnt4
   if (cnt4 == 0) {
       GuiControl, +cF4BD3E, Topic4
       GuiControl, +cFFFFFF, TransCD
       cnt4 := 20
       SetTimer, Go4, 1000
   }

   if (--cnt4 < 5)
      GuiControl, +cRed, TransCD
   else if (cnt4 < 11)
      GuiControl, +cF4BD3E, TransCD
Return