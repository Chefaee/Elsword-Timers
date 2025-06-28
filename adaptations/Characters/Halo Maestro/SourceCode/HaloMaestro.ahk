/*
F2 - Combo Done/Undo
F3 - Awakening Done/Undo
F4 - Halo is active/running
F9 - Reset Timer
F12 - Close Timer
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
Gui, Add, Text,vTopic1 x5 y5 w50 center, Combo
Gui, Add, Text,vTopic2 x5 y40 w50 center , Awaken
Gui, Add, Text,vTopic3 x5 y75 w50 center , Halo


Gui, Margin ,, 5,5
Gui, Font, s14 cBlack, MS Sans Serif
Gui, Add, Text, vFunction1 x85 y5 w100 cFFFFFF ,0
Gui, Add, Text, vFunction2 x85 y40 w100 cFFFFFF ,0
Gui, Add, Text, vCountdown1 x85 y75 w100 cFFFFFF ,0

Gui, Show, h75 w120 
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

F12::
    ExitApp
return


$F4::
   GuiControl, +cF4BD3E, Topic3
   GuiControl, +cFFFFFF, Countdown1
   cnt3 := 119
   SetTimer, Go3, 1000
Return


$F9::
   GuiControl, +cFFFFFF, Function1
   GuiControl, +cFFFFFF, Function2
   GuiControl, +cFFFFFF, Countdown1
   
   flag = 0

   GuiControl,, Function1, 0
   GuiControl,, Function2, 0
   GuiControl,, Countdown1, 0

   SetTimer, Go1, off
   SetTimer, Go2, off
   SetTimer, Go3, off
Return

$F2::
   check1 := !check1
   if (check1) {
      GuiControl, +cF4BD3E, Topic1
      GuiControl, +cFFFFFF, Function1
      SetTimer, Go1, 1000
   } else {
      SetTimer, Go1, Off
      GuiControl, , Function1, 0
      GuiControl, +cFFFFFF, Function1
   }

   if (check1 && check2) {
      check1 := 0
      check2 := 0
      GoSub, Go4
   }
Return

$F3::
   check2 := !check2
   if (check2) {
      GuiControl, +cF4BD3E, Topic2
      GuiControl, +cFFFFFF, Function2
      SetTimer, Go2, 1000
   } else {
      SetTimer, Go2, Off
      GuiControl, , Function2, 0
      GuiControl, +cFFFFFF, Function2
   }

   if (check1 && check2)
      GoSub, Go4
Return

Go1:
   GuiControl,, Function1, %check1%
   if (check1 == 0)
      SetTimer, Go1, Off
   else if (check1 == 1)
      GuiControl, +cGreen, Function1
Return

Go2:
   GuiControl,, Function2, %check2%
   if (check2 == 0)
      SetTimer, Go2, Off
   else if (check2 == 1)
      GuiControl, +cGreen, Function2
Return

Go4:
    GuiControl, +cF4BD3E, Topic3
    GuiControl, +cFFFFFF, Countdown1

    SetTimer, Go1, Off
    GuiControl, , Function1, 0
    GuiControl, +cGreen, Function1
    check1 := 0

    SetTimer, Go2, Off
    GuiControl, , Function2, 0
    GuiControl, +cGreen, Function2
    check2 := 0

    cnt3 := 119
    SetTimer, Go3, 1000
Return


Go3:
   GuiControl,, Countdown1, % cnt3
   if (cn3 := !0) {
       SetTimer, Go1, Off
       GuiControl, , Function1, 0
       GuiControl, +cGreen, Function1
       check1 := 0

       SetTimer, Go2, Off
       GuiControl, , Function2, 0
       GuiControl, +cGreen, Function2
       check2 := 0

       if (--cnt3 < 0) {
                 SetTimer, Go3, off
                 GuiControl, +cRed, Function1
                 GuiControl, +cRed, Function2
              } else if (cnt3 < 16) {
                 GuiControl, +cRed, Countdown1
              }
   } else {
       if (--cnt3 < 0) {
          SetTimer, Go3, off
          GuiControl, +cRed, Function1
          GuiControl, +cRed, Function2
       }
   }
Return