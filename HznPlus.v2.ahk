/************************************************************************
 * ;Desc ..: Horizon Button ==> A Horizon function library
 * @description ..: This library is a collection of functions and buttons that deal with missing interfaces with Horizon.
 * @file HznPlus.v2.ahk
 * @author OvercastBTC
 * @date 2023.08.15
 * @version 2.0.5
 * @ahkversion v2+
 * @Section .....: Auto-Execution
 ***********************************************************************/
; --------------------------------------------------------------------------------
/************************************************************************
 * ;Description ..: Resource includes for .exe standalone
 * @author OvercastBTC
 * @date 2023.08.15
 * @version 2.0.8
 ***********************************************************************/
;@Ahk2Exe-SetMainIcon HznPlus256.ico
;@Ahk2Exe-AddResource HznPlus256.ico, 160  ; Replaces 'H on blue'
;@Ahk2Exe-AddResource HznPlus256.ico, 206  ; Replaces 'S on green'
;@Ahk2Exe-AddResource HznPlus256.ico, 207  ; Replaces 'H on red'
;@Ahk2Exe-AddResource HznPlus256.ico, 208  ; Replaces 'S on red'
;@include-winapi
; --------------------------------------------------------------------------------
#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
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
; DllCall("SetThreadDpiAwarenessContext", "ptr", -4, "ptr")
DllCall("SetThreadDpiAwarenessContext", "ptr", -1, "ptr")
; --------------------------------------------------------------------------------
#Include <gdi_plus_plus>
#Include <Gdip_All>
#Include <Class_Toolbar.c2v2>
#Include <Tools\Hider>
#Include <Lib.v2\UIA>
; #Include <Lib.v2\UIA_Browser>
; --------------------------------------------------------------------------------

; //TODO: 2023.07.17 ...: Work on the below but consider if needed due to new FreeLibraryAndExitThread
; //TODO: Library_Load(winuser.dll)
; //TODO: Library_Load(processthreadsapi.dll)
; //TODO: Library_Load(memoryapi.dll)

; Startup_Shortcut := A_Startup "\" A_ScriptName ".lnk"
; Startup_Shortcut := A_Startup "\" A_ScriptName
; If !(FileExist(Startup_Shortcut)){
; 	FileCopy(A_ScriptName,Startup_Shortcut)
; 	MsgBox("Shortcut added to your Startup folder at " Startup_Shortcut)
; } 
; Else {
; 	MsgBox("Shortcut Exists")
; }
; --------------------------------------------------------------------------------
/************************************************************************
* ;Description ...: Create Tray Icon
* @description ...: Create the tray icon using the embedded B64 via Create_HznHorizon_ico()
* @author OverastBTC
* @date 2023.08.15
* @version 2.0.1
 ***********************************************************************/
TraySetIcon('HICON:' Create_HznHorizon_ico())
; --------------------------------------------------------------------------------

#HotIf WinActive(A_ScriptName " - Visual Studio Code")
#Include <Abstractions\Script>
~^s::
{
	Script.Reload()
}
#HotIf

; -------------------------------------------------------------------------------------------------
/************************************************************************
* @Title .........: Create Tray Menu
* @Description ...: Create options (//TODO add functions here) for use with the script (e.g., run at startup, open horizon, etc.)
* @file HznPlus.v2.ahk
* @author OverastBTC
* @date 2023.08.09
* @version 0.0.1
* @TODO ;[ ] TODO	.: Convert from v1 to v2
 ***********************************************************************/
; -------------------------------------------------------------------------------------------------

; HznTray := A_TrayMenu
; see at the bottom for the functions
return
; --------------------------------------------------------------------------------------------------
/************************************************************************
;Description: Horizon Hotkeys
;Description: Hotkeys (shortcuts) for normal Windows hotkeys that should exist
@author OvercastBTC
@notes
@function Italics - (CTRL+I)
@function Bold - (CTRL+B)
@function Underline - (CTRL+U) (where applicable)
@function SelectAll - (CTRL+A)
@function Save - (CTRL+S)
 ***********************************************************************/

#HotIf WinActive("ahk_exe hznhorizon.exe")

^i::button()
^b::button()
^u::button()
^a::HznSelectAll()
^s::HznSave()
^F4::HznClose()
#HotIf

; --------------------------------------------------------------------------------

; --------------------------------------------------------------------------------
/************************************************************************
* ;desc ......: Horizon Save Button (Ctrl-S)
* @Desc ......: Use UIAutomation (UIA) to find the element where the save button exists
* @Author OvercastBTC 
* @Credit Descolada and his UIA library and functions
* Function HznSave() (Ctrl-S)
* @param Msg - EM_SETSEL := 177 - the Windows API message for "Set Selection"
* @param wParam - := 0
* @param lParam := -1
***********************************************************************/
; --------------------------------------------------------------------------------

HznSave()
{
	hWnd := WinGetID('A')
	hMenu := DllCall("GetTitleBarInfo", "Ptr", hwnd, "Int")
	OutputDebug(hMenu)
	; --------------------------------------------------------------------------------
	/** @desc This is crazy that I have to set these variables, but it is Horizon though.... */
	global IUIAutomationActivateScreenReader:=0
	global IUIAutomationMaxVersion:=0
	; --------------------------------------------------------------------------------

	idWin := WinGetID("A")
	hznWin := UIA.ElementFromHandle(idWin)
	OutputDebug('WinGetClass: ' WinGetClass(idWin) '`nidWin: ' idWin '`n')
	hznHorizonEl := UIA.ElementFromHandle('A')
	hToolbar := idWin

	; --------------------------------------------------------------------------------
	RECT := hznHorizonEl.ElementFromPath({T:33}, {T:32}, {T:37}).BoundingRectangle
	H := (RECT.b - RECT.t)
	W := (RECT.r - RECT.l)
	X := RECT.l
	Y := RECT.t
	; OutputDebug("X: " X "`nY: " Y "`nW: " W "`nH: " H '`n')
	MouseGetPos(&mX, &mY, &Win, &Ctrl)
	OutputDebug('X:' mX '`n' 'Y: ' mY '`n' WinGetClass(Win) '`n' Ctrl)
	; --------------------------------------------------------------------------------
	/**@desc Still cannot use ControlClick(), dunno what it clicks but it's not that button */
	CoordMode("Mouse", "Screen")
	; --------------------------------------------------------------------------------
	/**@param BlockInput() => prevents the user from doing anything to screw it up */
	BlockInput(1)
	; --------------------------------------------------------------------------------
	DllCall("SetCursorPos", "int", X, "int", Y)  ; The first number is the X-coordinate and the second is the Y (relative to the screen)
	; --------------------------------------------------------------------------------
	/**@param Sleep(100) as the mouse likes to click before it gets to the coordinates => improve reliability */
	Sleep(100)
	; --------------------------------------------------------------------------------
	Click()
	; --------------------------------------------------------------------------------
	/**@param BlockInput() => restore user input */
	BlockInput(0)
	; --------------------------------------------------------------------------------
	/**@param DllCall() move the mouse back to its original position
	 * @param MouseMove() => DOES NOT WORK!!! MOVES IT TO SOME CRAZY LOCATIONS... dumb
	 */
	DllCall("SetCursorPos", "int", mX, "int", mY)  ; The first number is the X-coordinate and the second is the Y (relative to the screen)
	; --------------------------------------------------------------------------------
	/**
	Send('!f') ; <==== This is an alternate method
	Sleep(300) ; <==== Need to change this to a WinWaitActive scenario, but still having trouble getting any data
	Send('S')
	 */
	; --------------------------------------------------------------------------------
	return
}
; --------------------------------------------------------------------------------
/************************************************************************
* ;desc ......: Horizon Close Button (Ctrl-F4) ==> ≠ Alt-F4
* @Desc ......: Use UIAutomation (UIA) to find the element where the close button exists
* @Author OvercastBTC 
* @Credit Descolada and his UIA library and functions
* Function HznClose() (Ctrl-F4)
* @param Msg - EM_SETSEL := 177 - the Windows API message for "Set Selection"
* @param wParam - := 0
* @param lParam := -1
***********************************************************************/
; --------------------------------------------------------------------------------

HznClose()
{
	hWnd := WinGetID('A')
	hMenu := DllCall("GetTitleBarInfo", "Ptr", hwnd, "Int")
	OutputDebug(hMenu)
	; --------------------------------------------------------------------------------
	/** @desc This is crazy that I have to set these variables, but it is Horizon though.... */
	global IUIAutomationActivateScreenReader:=0
	global IUIAutomationMaxVersion:=0
	; --------------------------------------------------------------------------------

	idWin := WinGetID("A")
	hznWin := UIA.ElementFromHandle(idWin)
	OutputDebug('WinGetClass: ' WinGetClass(idWin) '`nidWin: ' idWin '`n')
	hznHorizonEl := UIA.ElementFromHandle('A')
	hToolbar := idWin
	hznHorizonEl.ElementFromPath({T:33}, {T:32}, {T:37}, {T:0, i:-1}).ControlClick()
	; --------------------------------------------------------------------------------
	; RECT := hznHorizonEl.ElementFromPath({T:33}, {T:32}, {T:37}).BoundingRectangle
	; H := (RECT.b - RECT.t)
	; W := (RECT.r - RECT.l)
	; X := RECT.l
	; Y := RECT.t
	; ; OutputDebug("X: " X "`nY: " Y "`nW: " W "`nH: " H '`n')
	MouseGetPos(&mX, &mY, &Win, &Ctrl)
	; OutputDebug('X:' mX '`n' 'Y: ' mY '`n' WinGetClass(Win) '`n' Ctrl)
	; ; --------------------------------------------------------------------------------
	; /**@desc Still cannot use ControlClick(), dunno what it clicks but it's not that button */
	; CoordMode("Mouse", "Screen")
	; ; --------------------------------------------------------------------------------
	; /**@param BlockInput() => prevents the user from doing anything to screw it up */
	; BlockInput(1)
	; ; --------------------------------------------------------------------------------
	; DllCall("SetCursorPos", "int", X, "int", Y)  ; The first number is the X-coordinate and the second is the Y (relative to the screen)
	; ; --------------------------------------------------------------------------------
	; /**@param Sleep(100) as the mouse likes to click before it gets to the coordinates => improve reliability */
	; Sleep(100)
	; ; --------------------------------------------------------------------------------
	; Click()
	; --------------------------------------------------------------------------------
	/**@param BlockInput() => restore user input */
	BlockInput(0)
	; --------------------------------------------------------------------------------
	/**@param DllCall() move the mouse back to its original position
	 * @param MouseMove() => DOES NOT WORK!!! MOVES IT TO SOME CRAZY LOCATIONS... dumb
	 */
	DllCall("SetCursorPos", "int", mX, "int", mY)  ; The first number is the X-coordinate and the second is the Y (relative to the screen)
	; --------------------------------------------------------------------------------
	/**
	Send('!f') ; <==== This is an alternate method
	Sleep(300) ; <==== Need to change this to a WinWaitActive scenario, but still having trouble getting any data
	Send('S')
	 */
	; --------------------------------------------------------------------------------
	return
}

; -------------------------------------------------------------------------------------------------
/************************************************************************
 * Desc ......: Horizon Hotkey - Select-All (Ctrl-A)
 * @author ...: Descolada, OvercastBTC
 * Function ..: Select-All() (Ctrl-A)
 * @param Msg - EM_SETSEL := 177 - the Windows API message for "Set Selection"
 * @param wParam - := 0
 * @param lParam := -1
***********************************************************************/
; -------------------------------------------------------------------------------------------------
HznSelectAll()
{
	Static Msg := EM_SETSEL := 177, wParam := 0, lParam := -1
	fCtl := ControlGetClassNN(ControlGetFocus("A"))
	hCtl := ControlGethWnd(fCtl, "A")
	DllCall('SendMessage', 'Ptr', hCtl, 'UInt', Msg, 'UInt', wParam, 'UIntP', lParam)
}
; -------------------------------------------------------------------------------------------------
/************************************************************************
 * Desc ......:  Call the Horizon msvb_lib_toolbar buttons using the button() function
 * @author ....: Descolada, OvercastBTC
 * @function button()
 * @param A_ThisHotkey - AHK's built in variable.
***********************************************************************/
; -------------------------------------------------------------------------------------------------
button(*) {
	SendLevel(5)
	BlockInput(1) ; 1 = On, 0 = Off
	fCtl := ControlGetClassNN(ControlGetFocus("A"))
	bID := SubStr(fCtl, -1, 1)
	nCtl := "msvb_lib_toolbar" bID
	hTb := ControlGethWnd(nCtl, "A")
	hTx := ControlGethWnd(fCtl, "A")
	hIDx:= A_ThisHotkey = "^i" ? 2 ;.........: italic = 2
		:  A_ThisHotkey = "^b" ? 1 ; .........: bold = 1
		:  A_ThisHotkey = "^u" ? 9 ; 9 = not ASUS monitor, 10 = ASUS monitor........: (AJB - 08/2023) FE Notepad, Comments, and COPE => u = 10; 3 worked somewhere? (???9 and 10???) (else i or b)
		:  A_ThisHotkey = "^x" ? 11 ; ........: cut = 11 and 12
		:  A_ThisHotkey = "^c" ? 13 ; ........: copy
		:  A_ThisHotkey = "^v" ? 16 ; ........: paste
		:  A_ThisHotkey = "^z" ? 17 ; ........: undo = 17 and 18
		:  A_ThisHotkey = "^y" ? 20 : 21 ; ...: redo
	; HznButton(hTb,hIDx,nCtl,fCtl,hTx, bID)
	HznButton(hTb, hIDx, nCtl)
	SendLevel(0)
	BlockInput(0) ; 1 = On, 0 = Off
	return
}
; --------------------------------------------------------------------------------

; -------------------------------------------------------------------------------------------------
/************************************************************************
 * Desc:  Clicks the nth item in a Win32 application toolbar.
 * @author ......: Descolada, OvercastBTC
 * Function .....: HznButton()
 * @param hToolbar - The handle of the toolbar control.
 * @param hTb - The handle of the toolbar control.
 * @param fCtl* - [OPTIONAL] The ClassNN of the "focused" control.
 * @param bID - The ClassNN instance of the "focused" control.
 * @param nCtl - The ClassNN and instance of the toolbar control.
 * @param n - The index (hIDx) of the toolbar item to click (1-based). Note: Separators are considered items as well.
 * @param HznButton(hToolbar, n, nCtl, fCtl:=0, hTx:=0, bID:=0)
 * @param param:=0 => in AHK v2 => optional
 * @example
 * fCtl := ControlGetClassNN(ControlGetFocus("A"))
 * bID := SubStr(fCtl, -1, 1)
 * nCtl := "msvb_lib_toolbar" bID
 * hTb := ControlGethWnd(nCtl, "A")
 * hTx := ControlGethWnd(fCtl, "A")
 * HznButton(hToolbar, 3) ; Clicks the third item
 ***********************************************************************/
; --------------------------------------------------------------------------------

HznButton(hToolbar, n, nCtl, fCtl:=0, hTx:=0, bID:=0) {
	; --------------------------------------------------------------------------------
	; Step: [OPTIONAL] Block all input while the function running
	; --------------------------------------------------------------------------------
	BlockInput(1) ; 1 = On, 0 = Off
	; --------------------------------------------------------------------------------
	static TB_BUTTONCOUNT 		:= 1048
	Static TB_GETBUTTON 		:= 1047
	Static WM_COMMAND			:= 273 ; 0x111
	Static TB_PRESSBUTTON		:= 1027 ; 0x403
	Static TB_BUTTONCOUNT  		:= 1048 ; 0x0418
	Static TB_GETBUTTON    		:= 1047 ; 0x417,
	Static TB_GETITEMRECT  		:= 1053 ; 0x41D,
	Static MEM_COMMIT      		:= 4096 ; 0x1000, ; 0x00001000, ; via MSDN Win32 
	Static MEM_RESERVE     		:= 8192 ; 0x2000, ; 0x00002000, ; via MSDN Win32
	Static MEM_PHYSICAL    		:= 4 ; 0x04    ; 0x00400000, ; via MSDN Win32
	Static MEM_PROTECT     		:= 64 ; 0x40 ;  
	Static MEM_RELEASE     		:= 32768 ; 0x8000 ; 
	Static WM_USER				:= 1024 ; 0x400
	Static TB_Something			:= WM_USER+3 ; (1042)
	Static TB_GETSTATE			:= WM_USER+18 ; (1042)
	Static TB_GETBITMAP			:= WM_USER+44 ; (1068)
	Static TB_GETBUTTONSIZE		:= WM_USER+58 ; 1082
	Static TB_GETBUTTON			:= WM_USER+23 ; 1047
	Static TB_GETBUTTONTEXTA	:= WM_USER+45 ; (1069)
	Static TB_GETBUTTONTEXTW	:= WM_USER+75 ; (1099)
	Static TB_GETITEMRECT		:= WM_USER+29 ; (1053)
	Static TB_BUTTONCOUNT		:= WM_USER+24 ; (1048)
	Static WM_GETDLGCODE		:= 135
	Static WM_NEXTDLGCTL		:= 40
	Static TB_COMMANDTOINDEX	:= 1049
	Static TB_GETBUTTONINFOW	:= 1087
	Static TB_SETSTATE 			:= 1041 ; 0x0411
	Static TBSTATE_PRESSED		:= 2 ; 0x02 
	Static WM_LBUTTONDOWN 		:= 513 ; 0x201
	Static WM_LBUTTONUP 		:= 515 ; 0x202
	Static BM_CLICK				:= 245 ; 0x000000F5
	Static TB_ISBUTTONPRESSED 	:= 1035 ; 0x040B
	; --------------------------------------------------------------------------------
	try ControlGetPos(&ctrlx:=0, &ctrly:=0,&ctrlw,&ctrlh, hToolbar, hToolbar)
	; OutputDebug("&ctrlx: " . ctrlx " &ctrly: " . ctrly " &ctrlw: " . ctrlw " &ctrlh: " . ctrlh . "`n")

	; --------------------------------------------------------------------------------
	; Step: count and load all the msvb_lib_toolbar buttons into memory
	; --------------------------------------------------------------------------------
	buttonCount := SendMessage(TB_BUTTONCOUNT, 0, 0, , Integer(hToolbar))
	; --------------------------------------------------------------------------------
	; Step: Use the @params to press the button
	; --------------------------------------------------------------------------------
	if (n >= 1 && n <= buttonCount)
	{
		; --------------------------------------------------------------------------------
		; Step: Get the toolbar "thread" process ID (PID) 
		DllCall("GetWindowThreadProcessId", "Ptr", hToolbar, "UInt*", &targetProcessID:=0)
		; --------------------------------------------------------------------------------
		; Step: Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
        hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")
		; --------------------------------------------------------------------------------
		; Step: [OPTIONAL] Identify if the process is 32 or 64 bit (efficiency step)
		; --------------------------------------------------------------------------------
		A_Is64bitOS ? DllCall("IsWow64Process", "Ptr", hProcess, "Int*", Is32bit := true) : Is32bit := True
		If (A_Is64bitOS) {
			Try DllCall("IsWow64Process", "Ptr", hProcess, "Int*", Is32bit := true)
		} Else {
			Is32bit := True
		}
		; --------------------------------------------------------------------------------
		; Step: Allocate memory for the TBBUTTON structure in the target process's address space
		; --------------------------------------------------------------------------------
		RPtrSize := Is32bit ? 4 : 8
		TBBUTTON_SIZE := 8 + (RPtrSize * 3) 
		remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", TBBUTTON_SIZE, "UInt", 0x1000, "UInt", MEM_PHYSICAL, "Ptr")
		; --------------------------------------------------------------------------------
		; Step: Get the bounds of each button (Get Item Rectangle)
		; --------------------------------------------------------------------------------
		SendMessage(TB_GETITEMRECT, n-1, remoteMemory,, hToolbar)
		RECT := Buffer(TBBUTTON_SIZE, 0)
		; Note : Winapi TBBUTTON struct(32 bytes on x64, 20 bytes on x86)
		BtnStructSize := Is32bit ? 20 : 32
		BtnStruct := Buffer(BtnStructSize, 0)
		; --------------------------------------------------------------------------------
		; Step: Read the button information stored in the RECT (remoteMemory)
		; --------------------------------------------------------------------------------
        DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", RECT, "UPtr", BtnStructSize, "UInt*", &bytesRead:=0, "Int")
        DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
        DllCall("CloseHandle", "Ptr", hProcess)
		; --------------------------------------------------------------------------------
		; Step: Store previous and set min delay
		; --------------------------------------------------------------------------------
		prevDelay := A_ControlDelay
		prevMDelay := A_MouseDelay
		prevWDelay := A_WinDelay
		SetControlDelay(-1)
		SetMouseDelay(-1)
		SetWinDelay(-1)
		; --------------------------------------------------------------------------------
		Left 	:= NumGet(RECT, 0, 	"Int")
		Top 	:= NumGet(RECT, 4, 	"Int")
		Right 	:= NumGet(RECT, 8, 	"Int")
		Bottom 	:= NumGet(RECT, 12, "Int")
		X 		:= Left
		Y 		:= Top
		W 		:= Right-Left
		H 		:= Bottom-Top
		; --------------------------------------------------------------------------------
		; ControlClick("x" ((X+W)//2) " y" ((Y+H)//2), hToolbar,,,, "NA")
		; if (n = 1)
			; {
		SendLevel(5)
		fCtl := ControlGetClassNN(ControlGetFocus('A'))
		; --------------------------------------------------------------------------------
		hWnd := ControlGetFocus('A')
		flag := MONITOR_DEFAULTTONEAREST := 0x00000002
		monWin := 	DllCall('user32\MonitorFromWindow', 'ptr', hWnd, 'int', flag)
		hMonitor := DllCall('user32\MonitorFromWindow', 'ptr', hwnd, "uint", MONITOR_DEFAULTTONEAREST, 'ptr')
		OutputDebug('monWin: ' monWin)
		DisplayObj(Obj, Depth:=5, IndentLevel:="")
		{
			if Type(Obj) = "Object"
				Obj := Obj.OwnProps()
			for k,v in Obj
			{
				List.= IndentLevel "[" k "]"
				if (IsObject(v) && Depth>1)
					List.="`n" DisplayObj(v, Depth-1, IndentLevel . "    ")
				Else
					List.=" => " v
				List.="`n"
			}
			return RTrim(List)
		}
		mNumber := DisplayObj(GetNearestMonitorInfo(hMonitor))
		test := DllCall("User32\GetDpiForWindow", "Ptr", hwnd, "UInt")
		GetNearestMonitorInfo(hMonitor*) {
			static MONITOR_DEFAULTTONEAREST := 0x00000002
			; hwnd := WinExist(winTitle*)
			; hwnd := winTitle := WinActive('A')
			hMonitor := DllCall("MonitorFromWindow", "ptr", hwnd, "uint", MONITOR_DEFAULTTONEAREST, "ptr")
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
					}
			}
			throw Error("GetMonitorInfo: " A_LastError, -1)
		}

		dpi := DllCall("User32\GetDpiForWindow", "Ptr", hwnd, "UInt")
		mDPI := GetDpiForMonitor(hMonitor)
		fDPI := DisplayObj(mDPI)
		OutputDebug(fDPI)
		GetDpiForMonitor(hMonitor, Monitor_Dpi_Type := 0) {  ; MDT_EFFECTIVE_DPI = 0 (shellscalingapi.h)
			local dpiX := 0, dpiY := 0
			return DllCall("Shcore.dll\GetDpiForMonitor", "Ptr", hMonitor, "Int", Monitor_Dpi_Type, "UIntP", dpiX, "UIntP", dpiY, "UInt") ? 0 : {X:dpiX,Y:dpiY}
		}
		VirtualScreenWidth := SysGet(78)
		VirtualScreenHeight := SysGet(79)
		; --------------------------------------------------------------------------------
		; MsgBox('monitor#: `n' mNumber '`n' 'hDPI?: ' dpi '`n' 'Test: ' test '`n' 'vW?: ' VirtualScreenWidth '`n' 'vH: ' VirtualScreenHeight '`n' monWin '`n' hMonitor '`n' fDPI '`n' (ctrlh) '`n' ctrlw '`n' (ctrlw/ctrlh))
		OutputDebug('monitor#: `n' mNumber '`n' 'hDPI?: ' dpi '`n' 'Test: ' test '`n' 'vW?: ' VirtualScreenWidth '`n' 'vH: ' VirtualScreenHeight '`n' monWin '`n' hMonitor '`n' fDPI '`n' (ctrlh) '`n' ctrlw '`n' (ctrlw/ctrlh))


		; --------------------------------------------------------------------------------
		; Step: Restore previous and set delay
		; --------------------------------------------------------------------------------
        SetControlDelay(prevDelay)
		SetMouseDelay(prevMDelay)
		SetWinDelay(prevWDelay)
		; --------------------------------------------------------------------------------
		OutputDebug("ButtonCount: " buttonCount "`n")
		OutputDebug("pID: " targetProcessID "`n")
		OutputDebug("remoteMemory: " remoteMemory "`n")   
		OutputDebug("hProcess: " hProcess "`nbytesRead: " bytesRead "`n")
		OutputDebug("X: " X " Y: " Y " W: " W " H: " H "`n")
		OutputDebug("x" ((X+W)//2) " y" ((Y+H)//2) "`n")
		; --------------------------------------------------------------------------------
		BlockInput(0) ; 1 = On, 0 = Off
		; --------------------------------------------------------------------------------
    } else
        ; throw ValueError("The specified index " n " is out of range. Please specify a valid index between 1 and " buttonCount ".", -1)
        throw ValueError("The specified toolbar " nCtl " was not found. Please ensure the edit field has been selected and try again.", -1)
    Return 0
}
; --------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe hznhorizon.exe")
; --------------------------------------------------------------------------------------------------
/**
@SubSection .....: Horizon {Enter} ==> Select Option
@Description ....: Hotkeys (shortcuts) sending {Enter} in leu of "Double Click"
@Author OvercastBTC
; [ ] fix: .........: Still doesn't work. Might have to not use the WinActive() function
*/
; --------------------------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe hznhorizonmgr.exe") or WinActive("ahk_exe hznhorizon.exe")
{
	fCtl := ControlGetClassNN(ControlGetFocus("A"))
	hCtl := ControlGethWnd(fCtl, "A")
	; Shift & Enter::DllCall("PostMessage", "Ptr", &hCtl, "UInt", 0x0203, "Ptr", 0, "Ptr", 0)
	Shift & Enter::DllCall("PostMessage", "Str", &hCtl, "UInt", 0x0203, "Ptr", 0, "Ptr", 0)
}
return
#HotIf
; --------------------------------------------------------------------------------
/************************************************************************
 * Desc ......:  Create the .ico file for use in as the Tray Icon
 * @author 2.0.00.00 - 2023-07-31 - iPhilip - converted script to AutoHotkey v2
 * @function Create_HznHorizon_ico()
 * @param B64 - A picture converted to a string and encoded via b64
 * @forum ;-> https://www.autohotkey.com/boards/viewtopic.php?f=83&t=119966
***********************************************************************/
; ##################################################################################
; # This #Include file was generated by Image2Include.ahk, you must not change it! #
; ##################################################################################
Create_HznHorizon_ico(NewHandle := False) {
	Static hBitmap := 0
	If (NewHandle)
		hBitmap := 0
	If (hBitmap)
		Return hBitmap
	B64 := "AAABAAEAICAAAAEAIACoEAAAFgAAACgAAAAgAAAAQAAAAAEAIAAAAAAAgBAAAGAbAABgGwAAAAAAAAAAAAD7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////////////////////////////////////f/////RERE//tcQv/7XEL////////////////////////////////////////////////3/////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL///////////////////////////f/////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC////////////////////////////////90RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC////////////////////////////////////////////////////////////////////////////////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL///////////////////////////////////////////f////3////9/////f///////////////////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//////////////////////////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC////////////////////////////////////////////RERE//tcQv/7XEL/+1xC//tcQv////////////////////////////////////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
	If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", StrPtr(B64), "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", &DecLen := 0, "Ptr", 0, "Ptr", 0)
		Return False
	Dec := Buffer(DecLen, 0)
	If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", StrPtr(B64), "UInt", 0, "UInt", 0x01, "Ptr", Dec, "UIntP", &DecLen, "Ptr", 0, "Ptr", 0)
		Return False
	hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, "UPtr", DecLen, "UPtr")
	pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData, "UPtr")
	DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData, "Ptr", Dec, "UPtr", DecLen)
	DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
	DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "PtrP", pStream := ComValue(13, 0))
	hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll", "UPtr")
	SI := Buffer(8 + 2 * A_PtrSize, 0), NumPut("UInt", 1, SI, 0)
	DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", &pToken := 0, "Ptr", SI, "Ptr", 0)
	DllCall("Gdiplus.dll\GdipCreateBitmapFromStream",  "Ptr", pStream, "PtrP", &pBitmap := 0)
	DllCall("Gdiplus.dll\GdipCreateHICONFromBitmap", "Ptr", pBitmap, "PtrP", &hBitmap := 0)
	DllCall("Gdiplus.dll\GdipDisposeImage", "Ptr", pBitmap)
	DllCall("Gdiplus.dll\GdiplusShutdown", "Ptr", pToken)
	DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
	Return hBitmap
	}
; --------------------------------------------------------------------------------
/*
@resource ...: https://www.autohotkey.com/boards/viewtopic.php?t=73851
@ahkversion .: v1
*/
; CreateTrayMenu()
; addTrayMenuOption(label := "", command := "")
; {
;   Static Tray
;   Tray:= A_TrayMenu
; 	if (label = "" && command = "") {
; 		Tray.Add()
; 	} else {
; 		Tray.Add(label, command)
; 	}
; }
; shortcut(){
;     FileExist(Startup_Shortcut) ? ShortcutExist() : NoShortcut()
; }
; ShortcutExist(){
;     Tray.Check("Run at startup")
; }

; NoShortcut(){
;     Tray.Uncheck(Run at startup)
; }
; CreateTrayMenu()
; {
;     ;Menu, Tray, Icon, % hICON ; this changes the icon into a little Horizon thing.
;     ;Tray.Delete() ; V1toV2: not 100% replacement of NoStandard, Only if NoStandard is used at the beginning
;     addTrayMenuOption("Made with nerd by Adam Bacon and Terry Keatts", "madeBy")
;     addTrayMenuOption()
;     addTrayMenuOption("Run at startup", "runAtStartup")
;     shortcut()
;     ; update the tray menu status on startup
;     addTrayMenuOption()
;     Tray.AddStandard()
; }
; runAtStartup() 
; {
;     FileExist(startup_shortcut) ? rmstartup() : addstartup()
; }

; addstartup(){
;     FileCreateShortcut(A_ScriptName, A_Startup . "\" . A_ScriptName . ".lnk", icostr)
;     Tray.Check(Run at startup) ; update the tray menu status on change
;     trayNotify("Startup shortcut added", "This script will now automatically run when your turn on your computer.")
; }

; rmstartup(){
;     FileDelete(startup_shortcut)
;     Tray.Uncheck(Run at startup) ; update the tray menu status on change
;     trayNotify("Startup shortcut removed", "This script will not run when you turn on your computer.")
; }

; madeBy()
; {
; 	MsgBox("This was made by nerds, for nerds. Regular people are ok too, lol.`nModified by OvercastBTC")
; }
; HideTrayTip()
; {
;     (SubStr(A_OSVersion, 1, 3) = "10.")   ? IconTrayTip()
;                                         : TrayTip
; }

; IconTrayTip()
; {
;     Tray.NoIcon()
;     Sleep(200)
;     Tray.Icon()
; }

; trayNotify(title, message, options := 0)
; {
;     TrayTip(title, message, options)
; }