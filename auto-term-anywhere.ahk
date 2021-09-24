﻿; TO-DO: (1) Ignore explorer when non-path locations open (start with ::)


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

GetExplorerPath(hwnd = 0)
{
  if(hwnd == 0)
  {
    explorerHwnd := WinActive("ahk_class CabinetWClass")
  }
  else
  {
    explorerHwnd := WinActive("ahk_class CabinetWClass ahk_id " . hwnd)
  }
  
  if (explorerHwnd)
  {
    for window in ComObjCreate("Shell.Application").Windows{
      try
      {
        if (window && window.hwnd && window.hwnd == explorerHwnd)
          return window.Document.Folder.Self.Path
      }
    }
  }
  return false
}

SwitchToWindowsTerminal()
{
  windowHandleId := WinExist("ahk_exe WindowsTerminal.exe")
  windowExistsAlready := windowHandleId > 0

  ; If the Windows Terminal is already open, determine if we should put it in focus or minimize it.
  if (windowExistsAlready = true)
  {
    activeWindowHandleId := WinExist("A")
    windowIsAlreadyActive := activeWindowHandleId == windowHandleId

    if (windowIsAlreadyActive)
    {
      ; Minimize the window.
      WinMinimize, "ahk_id %windowHandleId%"
    }
    else
    {
      ; Put the window in focus.
      WinActivate, "ahk_id %windowHandleId%"
      WinShow, "ahk_id %windowHandleId%"
    }
  }
  ; Else it's not already open, so launch it.
  else
  {
    explorerIsOpen := GetExplorerPath()
    if (explorerIsOpen)
    {
      Run, wt -d %explorerIsOpen%
    }
    else
    {
      Run, wt
    }
  }
}

; Hotkey to use Win+C to launch/restore the Windows Terminal.
#c::SwitchToWindowsTerminal()


