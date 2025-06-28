/*
Numpad1 - 17-5
Numpad2 - 15-6
Numpad3 - 13-5
Numpad5 - Transslot
NumpadEnter - Reset Timer (Titles + Trans + Rosso)
NumpadMult - Reset Timer (only Trans)
NumpadSub - Close Timer

Numpad7 - Basic Spike Timer
Numpad8 - Overtime (+30s Timer after pattern)
Numpad4 - Freeze
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

Gui, Font, s14 cFF4D4D, MS Sans Serif
Gui, Add, Text,vTopic5 x5 y140 w50 center, Spike
Gui, Add, Text,vTopic6 x5 y170 w50 center , Overtime

Gui, Font, s14 c00CCFF, MS Sans Serif
Gui, Add, Text,vTopic7 x5 y200 w50 center, Freeze


Gui, Margin ,, 5,5
Gui, Font, s14 cBlack, MS Sans Serif
Gui, Add, Text, vCountdown1 x85 y5 w100 cFFFFFF ,0
Gui, Add, Text, vCountdown2 x85 y40 w100 cFFFFFF ,0
Gui, Add, Text, vCountdown3 x85 y75 w100 cFFFFFF ,0
Gui, Add, Text, vTransCD x85 y110 w100 cFFFFFF ,0

Gui, Add, Text, vSpikeCD x85 y140 w100 cFFFFFF ,0
Gui, Add, Text, vOvertimeCD x85 y170 w100 cFFFFFF ,0
Gui, Add, Text, vFreezeCD x85 y200 w100 cFFFFFF ,0

Gui, Show, h210 w120
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
   GuiControl, +cFFFFFF, TransCD
   GuiControl, +cFFFFFF, SpikeCD
   GuiControl, +cFFFFFF, OvertimeCD
   GuiControl, +cFFFFFF, FreezeCD
   
   flag = 0

   GuiControl,, Countdown1, 0
   GuiControl,, Countdown2, 0
   GuiControl,, Countdown3, 0
   GuiControl,, TransCD, 0
   GuiControl,, SpikeCD, 0
   GuiControl,, OvertimeCD, 0
   GuiControl,, FreezeCD, 0

   SetTimer, Go1, off
   SetTimer, Go2, off
   SetTimer, Go3, off
   SetTimer, Go4, off
   SetTimer, Go5, off
   SetTimer, Go6, off
   SetTimer, Go7, off
Return

$NumpadMult::
   GuiControl, +cFFFFFF, TransCD

   flag = 0

   GuiControl,, TransCD, 0

   SetTimer, Go4, off
Return

$Numpad7::
   GuiControl, +cF4BD3E, Topic5
   GuiControl, +cFFFFFF, SpikeCD
   cntSpk := 159
   SetTimer, Go5, 1000
Return

$Numpad8::
   GuiControl, +cF4BD3E, Topic6
   GuiControl, +cFFFFFF, OvertimeCD
   cntOvr := 29
   SetTimer, Go6, 1000
Return

$Numpad4::
   GuiControl, +c21e4ff, Topic7
   GuiControl, +c00a3ba, FreezeCD
   cntFrz := 89
   SetTimer, Go7, 1000
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

   if (--cnt4 < 0)
      SetTimer, Go4, off
   else if (cnt4 < 5)
      GuiControl, +cRed, TransCD
   else if (cnt4 < 11)
      GuiControl, +cF4BD3E, TransCD
Return

Go5:
   GuiControl,, SpikeCD, % cntSpk
   if (--cntSpk < 0)
      SetTimer, Go5, off
   else if (cntSpk < 21)
      GuiControl, +cRed, SpikeCD
   else if (cntSpk < 41)
      GuiControl, +cF4BD3E, SpikeCD
Return

Go6:
   GuiControl,, OvertimeCD, % cntOvr
   if (--cntOvr < 0)
      SetTimer, Go6, off
   else if (cntOvr < 16)
      GuiControl, +cRed, OvertimeCD
   else if (cntOvr < 26)
      GuiControl, +cF4BD3E, OvertimeCD
Return

Go7:
   GuiControl,, FreezeCD, % cntFrz
   if (--cntFrz < 0)
      SetTimer, Go7, off
   else if (cntFrz < 1)
      GuiControl, +c21e4ff, FreezeCD
   else if (cntFrz < 16)
      GuiControl, +cF4BD3E, FreezeCD
Return