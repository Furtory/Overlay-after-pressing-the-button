/*
黑钨重工出品 免费开源 请勿商用 侵权必究
更多免费教程尽在QQ群 1群763625227 2群643763519
*/

full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
  try
  {
    if A_IsCompiled
      Run *RunAs "%A_ScriptFullPath%" /restart
    else
      Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
  }
  ExitApp
}

Process, Priority, , Realtime
#MenuMaskKey vkE8
#WinActivateForce
#InstallKeybdHook
#InstallMouseHook
#Persistent
#NoEnv
#SingleInstance Force
#MaxHotkeysPerInterval 2000
#KeyHistory 2000
SendMode Input
SetBatchLines -1
CoordMode Pixel Screen
CoordMode ToolTip Screen
SetKeyDelay -1, 20
SetWorkingDir %A_ScriptDir%

~$d::
右移动:
if GetKeyState("a", "P")
{
  Send {a Up}
}
Critical On
loop
{
  if !GetKeyState("d", "P")
  {
    if GetKeyState("a", "P")
    {
      反向:=0
      break
    }
    else
    {
      Critical Off
      return
    }
  }
  else if !GetKeyState("a", "P") and (反向=1)
  {
    反向:=0
  }
  else if GetKeyState("a", "P") and (反向!=1)
  {
    break
  }
}
Send {a Down}
反向:=1
Critical Off
goto 左移动

~$a::
左移动:
if GetKeyState("d", "P")
{
  Send {d Up}
}
loop
{
  Critical On
  if !GetKeyState("a", "P")
  {
    if GetKeyState("d", "P")
    {
      反向:=0
      Critical Off
      break
    }
    else
    {
      return
    }
  }
  else if !GetKeyState("d", "P") and (反向=1)
  {
    反向:=0
  }
  else if GetKeyState("d", "P") and (反向!=1)
  {
    break
  }
}
Send {d Down}
反向:=1
Critical Off
goto 右移动