/*
Numpad7 - Basic Spike Timer
Numpad8 - Overtime (+30s Timer after pattern)
Numpad4 - Freeze

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
Gui, Font, s14 cFF4D4D, MS Sans Serif
Gui, Add, Text,vTopic5 x5 y5 w50 center, Spike
Gui, Add, Text,vTopic6 x5 y40 w50 center , Overtime

Gui, Font, s14 c00CCFF, MS Sans Serif
Gui, Add, Text,vTopic7 x5 y75 w50 center, Freeze


Gui, Margin ,, 5,5
Gui, Font, s14 cBlack, MS Sans Serif
Gui, Add, Text, vSpikeCD x85 y5 w100 cFFFFFF ,0
Gui, Add, Text, vOvertimeCD x85 y40 w100 cFFFFFF ,0
Gui, Add, Text, vFreezeCD x85 y75 w100 cFFFFFF ,0

Gui, Show, h80 w120
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

$NumpadEnter::
   GuiControl, +cFFFFFF, SpikeCD
   GuiControl, +cFFFFFF, OvertimeCD
   GuiControl, +cFFFFFF, FreezeCD
   
   flag = 0

   GuiControl,, SpikeCD, 0
   GuiControl,, OvertimeCD, 0
   GuiControl,, FreezeCD, 0

   SetTimer, Go5, off
   SetTimer, Go6, off
   SetTimer, Go7, off
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
      GuiControl, +cF4BD3E, OvertimeCD+
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