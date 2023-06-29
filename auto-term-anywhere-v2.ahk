; TO-DO: Network locations create issues


; REMOVED: #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance Force ; if an instance of the script is already running, replace it with this one

GetExplorerPath()
{
  activeTitle := WinGetTitle("A")
  explorerHwnd := WinActive("ahk_class CabinetWClass")
  if (explorerHwnd)
  {
    for window in ComObject("Shell.Application").Windows{
      try
      {
        if (window && window.hwnd && window.hwnd == explorerHwnd && activeTitle == window.LocationName) {
          pathwintmp := window.LocationURL
          pathwin := RegExReplace(pathwintmp, "^file:/{2,}") ; strip the file protocol from the URL
          pathwin := RegExReplace(pathwin, "%20", " ") ; replace %20 strings with spaces

          return pathwin
        }
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
      WinMinimize("`"ahk_id " windowHandleId "`"")
    }
    else
    {
      ; Put the window in focus.
      WinActivate("`"ahk_id " windowHandleId "`"")
      WinShow("`"ahk_id " windowHandleId "`"")
    }
  }
  ; Else it's not already open, so launch it.
  else
  {
    explorerIsOpen := GetExplorerPath()
    if (explorerIsOpen)
    {
      Run("wt -d `"" explorerIsOpen "`"")
    }
    else
    {
      Run("wt")
    }

    ErrorLevel := WinWait("ahk_exe WindowsTerminal.exe", , 3) , ErrorLevel := ErrorLevel = 0 ? 1 : 0
    ErrorLevel := WinWaitNotActive("ahk_exe WindowsTerminal.exe", , 5) , ErrorLevel := ErrorLevel = 0 ? 1 : 0
    if (ErrorLevel = 0)   ; i.e. it's not blank or zero.
        WinActivate()
  }
}

; Hotkey to use Win+C to launch/restore the Windows Terminal.
#!c::SwitchToWindowsTerminal()