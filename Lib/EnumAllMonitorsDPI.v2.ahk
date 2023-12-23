#Requires AutoHotkey v2+
#Include <Directives\__AE.v2>
; --------------------------------------------------------------------------------
/**
 * @author Descolada (main v2 author)
 * @author OvercastBTC (mod)
 * @author justme (original v1 author)
 * @author iPhilip (v1 mod)
 * @param EnumMonitors 
 */
#HotIf WinExist(A_ScriptName)
#^e::
{
hwnd := WinExist("A"), List := "", hMonitor := ''
for hMonitor in EnumMonitors() {
	dpi := GetDpiForMonitor(hMonitor)
	List .= 'Index: [' A_Index ']`n' 'mhWnd: ' hMonitor '`n' 'dpi.x: ' dpi.x  '`n' 'dpi.y: ' dpi.y '`n' 'dpi.Window: ' GetDpiForWindow(hwnd)
}

Info(List, 30000)
return
}

^#i::
{
	hwnd := WinExist('A')
	dpi := GetDpiForWindow(hwnd)
	Info(hwnd '`n' dpi,30000)
	; reload()
	return
}

#HotIf

EnumMonitors() {
	static EnumProc := CallbackCreate(MonitorEnumProc)
	Monitors := []
	return DllCall("User32\EnumDisplayMonitors", "Ptr", 0, "Ptr", 0, "Ptr", EnumProc, "Ptr", ObjPtr(Monitors), "Int") ? Monitors : false
}

MonitorEnumProc(hMonitor, hDC, pRECT, ObjectAddr) {
	Monitors := ObjFromPtrAddRef(ObjectAddr)
	Monitors.Push(hMonitor)
	return true
}

GetDpiForMonitor(hMonitor, Monitor_Dpi_Type := 0) {  ; MDT_EFFECTIVE_DPI = 0 (shellscalingapi.h)
	if !DllCall("Shcore\GetDpiForMonitor", "Ptr", hMonitor, "UInt", Monitor_Dpi_Type, "UInt*", &dpiX:=0, "UInt*", &dpiY:=0, "UInt")
		return {x:dpiX, y:dpiY}
}

GetDpiForWindow(hwnd) {
	return DllCall("User32\GetDpiForWindow", "Ptr", hwnd, "UInt")
}
