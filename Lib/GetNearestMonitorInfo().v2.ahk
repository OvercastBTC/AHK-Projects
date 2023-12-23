#Warn All, OutputDebug
#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)
SetTitleMatchMode(2)
; --------------------------------------------------------------------------------
DetectHiddenText(true)
DetectHiddenWindows(true)
; --------------------------------------------------------------------------------
#Requires AutoHotkey v2
; --------------------------------------------------------------------------------
SetControlDelay(-1)
SetMouseDelay(-1)
SetWinDelay(-1)
; --------------------------------------------------------------------------------

GetNearestMonitorInfo(hCtl?, hCtl_title?) {
	static MONITOR_DEFAULTTONEAREST := 0x00000002
	hCtl := ControlGetFocus('A')
	hCtl_title := WinGetTitle(hCtl)
	hMonitor := DllCall("MonitorFromWindow", "ptr", hCtl, "uint", MONITOR_DEFAULTTONEAREST, "ptr")
	DllCall("Shcore\GetDpiForMonitor", "Ptr", hMonitor, "UInt", Monitor_Dpi_Type:=0, "UInt*", &dpiX:=0, "UInt*", &dpiY:=0, "UInt")
	wDPI := DllCall("User32\GetDpiForWindow", "Ptr", hCtl, "UInt")
	NumPut("uint", 104, MONITORINFOEX := Buffer(104))
	if (DllCall("user32\GetMonitorInfo", "ptr", hMonitor, "ptr", MONITORINFOEX)) {
		Return  { Handle   : hMonitor
			, Name     : Name := StrGet(MONITORINFOEX.ptr + 40, 32)
			, Number   : RegExReplace(Name, ".*(\d+)$", "$1")
			, Left     : L  := NumGet(MONITORINFOEX,  4, "int")
			, Top      : T  := NumGet(MONITORINFOEX,  8, "int")
			, Right    : R  := NumGet(MONITORINFOEX, 12, "int")
			, Bottom   : B  := NumGet(MONITORINFOEX, 16, "int")
			, WALeft   : WL := NumGet(MONITORINFOEX, 20, "int")
			, WATop    : WT := NumGet(MONITORINFOEX, 24, "int")
			, WARight  : WR := NumGet(MONITORINFOEX, 28, "int")
			, WABottom : WB := NumGet(MONITORINFOEX, 32, "int")
			, Width    : Width  := R - L
			, Height   : Height := B - T
			, WAWidth  : WR - WL
			, WAHeight : WB - WT
			, Primary  : NumGet(MONITORINFOEX, 36, "uint")
			, x:dpiX
			, y:dpiY
			, WinDPI   : wDPI 
		}
	}
	throw Error("GetMonitorInfo: " A_LastError, -1)
}