/************************************************************************
 * Description ..: Horizon Button ==> A Horizon function library
 * @Description ..: This library is a collection of functions and buttons that deal with missing interfaces with Horizon.
 * @file HznPlus.v2.ahk
 * @author OvercastBTC
 * @date 2023/07/31
 * @version 1.0.0
 ***********************************************************************/

; Section .....: Auto-Execution
SetWinDelay(-1)
SetControlDelay(-1)
SetMouseDelay(-1)
; //#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
#Warn All, OutputDebug
#SingleInstance Force
SendMode("Input") ;* Superior speed and reliability.
SetWorkingDir(A_ScriptDir) ; A consistent starting directory.
SetTitleMatchMode(2) ; Match = "containing" instead of "exact"
DetectHiddenText(true)
DetectHiddenWindows(true)
; CoordMode("Mouse", "Client")
#Requires Autohotkey v2
#Include <gdi_plus_plus>
#Include <Class_Toolbar.c2v2>
#Include <Tools\Hider>
; #Include <GetProcessHandles>
TraySetIcon("HznHorizon.ico")
; //TODO: 2023.07.17 ...: Work on the below but consider if needed due to new FreeLibraryAndExitThread
; //TODO: Library_Load(winuser.dll)
; //TODO: Library_Load(processthreadsapi.dll)
; //TODO: Library_Load(memoryapi.dll)

; ------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;?						... End of Auto-Execution ...
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; ------------------------------------------------------------------------

; --------------------------------------------------------------------------------------------------
; Section .....: Script Name, Startup Path, and icon
; --------------------------------------------------------------------------------------------------

; --------------------------------------------------------------------------------------------------
; Reference .......: https://www.autohotkey.com/boards/viewtopic.php?f=76&t=101960&p=527471#p527471
; Credit ..........: Hellbent
; Sub-Section .....: Create Icon File
; Description .....: Base64 icon string
; Variable ........: icostr
; Function ........: MyIcon_B64()
; --------------------------------------------------------------------------------------------------

Startup_Shortcut := A_Startup "\" A_ScriptName ".lnk"


; -------------------------------------------------------------------------------------------------
; - Sub-Section .....: Create Tray Menu
; -------------------------------------------------------------------------------------------------

; CreateTrayMenu()

; <<<<< ... First Return ... <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Return
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; -------------------------------------------------------------------------------------------------
#HotIf WinActive(A_ScriptName " - Visual Studio Code") ;&& WinActive("Code.exe")
~^s::
{
	Reload()
}
#HotIf
; Sub-Section .....: Create Tray Menu Functions
; Description .....: addTrayMenuOption() ; madeBy() ; runAtStartup() ; trayNotify()
; -------------------------------------------------------------------------------------------------
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

#HotIf WinActive("ahk_exe hznhorizon.exe", )
; --------------------------------------------------------------------------------------------------
/**
@SubSection .....: Horizon {Enter} ==> Select Option
@description Hotkeys (shortcuts) sending {Enter} in leu of "Double Click"
@author OvercastBTC
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

; --------------------------------------------------------------------------------------------------
/**
;Description: Horizon Hotkeys
;Description: Hotkeys (shortcuts) for normal Windows hotkeys that should exist
@author OvercastBTC
@notes
@function Italics - (CTRL+I)
@function Bold - (CTRL+B)
@function Underline - (CTRL+U) (where applicable)
@function SelectAll - (CTRL+A)
@function Save - (CTRL+S)
*/
; Notes: The below indexes, or n from the HznButton(hWndToolbar, n) function, depend on what screen you are on
; Notes Continued ..: 1=Bold, 2=Italics, (everything after this changes depending on what screen you are on)
; Notes Continued ..: where underline is an option is index 9 or 10, else it reverts to CTRL+B or CTRL+I
; --------------------------------------------------------------------------------
; Notes Continued ..: >>>>>>>>> THIS NEEDS TO BE FULLY VALIDATED FOR EACH SCREEN <<<<<<<<<<
; Notes: (AJB - 06/2023) as of this timestamp, none of this below is fully validated and changes
; Notes Continued ..: 10=Cut, 11=Copy, 12=Paste, 14=Undo, 15=Redo, 17=Bulleted List, 18=Spell Check
; Notes Continued ..: ===== Human Element Section =====
; Notes Continued ..: 20=Super/Sub Script, 21=Find/Replace
; Notes Continued ..: Mystery or Spacers: 3-9, 13, 16, 19=?Bold?
; Notes Continued ..: ===== Equipment Section =====
; Notes Continued ..: Nothing?=21,20,18,17,
; -------------------------------------------------------------------------------------------------

; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Horizon Button Function <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; -------------------------------------------------------------------------------------------------
; Sub-Section .....: Horizon Hotkeys - Italic, Bold, and Underline (***where applicable***)
; ..............: 06/05/2023 - CTRL+I and CTRL+B validated for all screens
; . Continued ..: CTRL+U only valid for screens which have it listed as a button
; . Continued ..: else it reverts to CTRL+B or CTRL+I
; -------------------------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe hznhorizon.exe")

^i::button()
^b::button()
^u::button()
^a::HznSelectAll()

; --------------------------------------------------------------------------------------------------
; Function .....: Horizon Hotkeys - Cut, Copy, Paste, Undo, Redo
; ChangeLog ....: 06/05/2023 - Validated for the Human Element Screen only. Commented out due to irratic behavior.
; --------------------------------------------------------------------------------------------------

/*
^x::b()
^c::b()
^v::b()
^z::b()
^y::b()
ControlGetFocus, focus, A
bID:= SubStr(focus, 0, 1)
hIDx := A_ThisHotkey = "^x" ? 11 ; ........: cut = 11 and 12
		 :  A_ThisHotkey = "^c" ? 13 ; ........: copy
		 :  A_ThisHotkey = "^v" ? 16 ; ........: paste
		 :  A_ThisHotkey = "^z" ? 17 ; ........: undo = 17 and 18
		 :  A_ThisHotkey = "^y" ? 20 : 20 ; ...: redo
ControlGet, hToolbar, hWnd,,% "msvb_lib_toolbar" bID, A
HznButton(hToolbar,hIDx)
return
*/
; -------------------------------------------------------------------------------------------------
/**
 * Desc ......: Horizon Hotkey - Select-All (Ctrl-A)
 * @author ...: Descolada, OvercastBTC
 * Function ..: Select-All() (Ctrl-A
 * @param Msg - EM_SETSEL := 177 - the Windows API message for "Set Selection"
 * @param wParam - := 0
 * @param lParam := -1
 */
; -------------------------------------------------------------------------------------------------
HznSelectAll()
{
	Static Msg := EM_SETSEL := 177, wParam := 0, lParam := -1
	fCtl := ControlGetClassNN(ControlGetFocus("A"))
	hCtl := ControlGethWnd(fCtl, "A")
	DllCall('SendMessage', 'Ptr', hCtl, 'UInt', Msg, 'UInt', wParam, 'UIntP', lParam)
}


; .................................................................................................
;</s if (ErrorLevel != 1) {
;</s ToolTip % "SendMessge Error: " ErrorLevel "`n" hCtl "`n" Ctl
;</s }
;</s WinGetClass, vCtl, % "ahk_id " Ctl
;</s DllCall("SendMessage","Ptr",Ctl,"UInt",EM_SETSEL := 0xB1, "Ptr", 0, "Ptr", -1))
;</s ((vCtl = "TX11") ? DllCall("SendMessage","Ptr",Ctl,"UInt",EM_SETSEL := 177, "PtrP", 0, "PtrP", -1) : DllCall("SendMessage","Ptr",Ctl,"UInt",EM_SETSEL := 0xB1, "Ptr", 0, "Ptr", -1))
;</s ((vCtl = "TX11") ? SendMessage,0xB1,"","",,ahk_id %Ctl% : SendMessage,0xB1,0,-1,,ahk_id %Ctl%) ; doesn't work

;</s ToolTip % "1: " hCtl "`n2: " vCtl, 0,0,1

;</s MsgBox % "xCtl: " xCtl  "`nyCtl: " yCtl
;</s hWndChild := DllCall("RealChildWindowFromPoint","Ptr",Ctl,"UInt",4,"Ptr")
;</s Ctl := DllCall("RealChildWindowFromPoint","Ptr",hCtl,"UInt",4,"Ptr")
;</s VarSetCapacity(cClass, 261*2, 0)
;</s DllCall("GetClassName","Ptr",Ctl,"Str",cClass,"Int",261)
;</s VarSetCapacity(cClass, 64*2, 0)
;</s DllCall("GetClassName","Ptr",Ctl,"Str",cClass,"Int",64)
;</s WinGetClass, vCtl, % "ahk_id " hWndChild

;</s ((cClass = "TX11") ? DllCall("SendMessage","Ptr",Ctl,"UInt",0x00B1) : DllCall("SendMessage","Ptr",Ctl,"UInt",0xB1, "Ptr", 0, "Ptr", -1))
;</s DllCall("SendMessage","Ptr",Ctl,"UInt",0xB1, "Ptr", 0, "Ptr", -1)
;</s return
; -------------------------------------------------------------------------------------------------
/**
 * Desc ......:  Call the Horizon msvb_lib_toolbar buttons using the button() function
 * @author ....: Descolada, OvercastBTC
 * @function button()
 * @param A_ThisHotkey - AHK's built in variabl.
 */
; -------------------------------------------------------------------------------------------------
button() {
	SendLevel(5)
	fCtl := ControlGetClassNN(ControlGetFocus("A"))
	bID := SubStr(fCtl, -1, 1)
	nCtl := "msvb_lib_toolbar" bID
	hTb := ControlGethWnd(nCtl, "A")
	hTx := ControlGethWnd(fCtl, "A")
	hIDx:= A_ThisHotkey = "^i" ? 2 ; .........: italic = 2
		:  A_ThisHotkey = "^b" ? 1 ; .........: bold = 1
		:  A_ThisHotkey = "^u" ? 9 ; .........: u = 3? trying 4 (???9 and 10???) (else i or b)
		:  A_ThisHotkey = "^x" ? 11 ; ........: cut = 11 and 12
		:  A_ThisHotkey = "^c" ? 13 ; ........: copy
		:  A_ThisHotkey = "^v" ? 16 ; ........: paste
		:  A_ThisHotkey = "^z" ? 17 ; ........: undo = 17 and 18
		:  A_ThisHotkey = "^y" ? 20 : 21 ; ...: redo
	HznButton(hTb,hIDx,nCtl,fCtl,hTx, bID)
	; HznButtonTest(hTb,hIDx,nCtl,fCtl)
	; ClickToolbarButton(hToolbar,hIDx)
	; --------------------------------------------------------------------------------
	OutputDebug("fCtl: " fCtl "`n")
	OutputDebug("bID: " bID "`n")
	OutputDebug("hIDx: " hIDx "`n")	
	OutputDebug("hTb: " hTb "`n")
	OutputDebug("hTX11: " hTx "`n")
	; --------------------------------------------------------------------------------
}    
return
; -------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------
/**
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
 */
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
	; --------------------------------------------------------------------------------
	; try ControlGetPos(&ctrlx:=0, &ctrly:=0,&ctrlw,&ctrlh, hToolbar, hToolbar)
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
		; Note: Winapi TBBUTTON struct(32 bytes on x64, 20 bytes on x86)
		BtnStructSize := Is32bit ? 20 : 32
		BtnStruct := Buffer(BtnStructSize, 0)
		; --------------------------------------------------------------------------------
		; Step: Read the button information stored in the RECT (remoteMemory)
		; --------------------------------------------------------------------------------
        DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", RECT, "UPtr", 16, "UInt*", &bytesRead:=0, "Int")
        DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
        DllCall("CloseHandle", "Ptr", hProcess)
		; --------------------------------------------------------------------------------
		; Step: Store previous and set min delay
		; --------------------------------------------------------------------------------
		prevDelay := A_ControlDelay
		prevMDelay := A_MouseDelay
		SetControlDelay(-1)
		SetMouseDelay(-1)
		; --------------------------------------------------------------------------------
		Left 	:= NumGet(RECT, 0, "int")
		Top 	:= NumGet(RECT, 4, "int")
		Right 	:= NumGet(RECT, 8, "int")
		Bottom 	:= NumGet(RECT, 12, "int")
		X 		:= Left
		Y 		:= Top
		W 		:= Right-Left
		H 		:= Bottom-Top
		; --------------------------------------------------------------------------------
		ControlClick("x" ((X+W)//2) " y" ((Y+H)//2), hToolbar,,,, "NA")
		; --------------------------------------------------------------------------------
        prevDelay := SetControlDelay(-1)
		; --------------------------------------------------------------------------------
		; Step: Restore previous and set delay
		; --------------------------------------------------------------------------------
        SetControlDelay(prevDelay)
		SetMouseDelay(prevMDelay)
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
    return
}
HznButtonWStateCheck(hTb, n, nCtl, fCtl:=0, hTx:=0, bID:=0) {
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
	; --------------------------------------------------------------------------------
	arbtn := Array([])
	try ControlGetPos(&ctrlx:=0, &ctrly:=0,&ctrlw,&ctrlh, hTb, hTb)
	; OutputDebug("&ctrlx: " . ctrlx " &ctrly: " . ctrly " &ctrlw: " . ctrlw " &ctrlh: " . ctrlh . "`n")
	; --------------------------------------------------------------------------------
	; Step: count and load all the msvb_lib_toolbar buttons into memory
	; --------------------------------------------------------------------------------
	buttonCount := SendMessage(TB_BUTTONCOUNT, 0, 0, , Integer(hTb))
	; --------------------------------------------------------------------------------
	; Step: Use the @params to press the button
	; --------------------------------------------------------------------------------
	if (n >= 1 && n <= buttonCount)
	{
		; --------------------------------------------------------------------------------
		; Step: Get the toolbar "thread" process ID (PID) 
		DllCall("GetWindowThreadProcessId", "Ptr", hTb, "UInt*", &targetProcessID:=0)
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
		SendMessage(TB_GETITEMRECT, n-1, remoteMemory,, hTb)
		RECT := Buffer(TBBUTTON_SIZE, 0)	
		; Note: Winapi TBBUTTON struct(32 bytes on x64, 20 bytes on x86)
		BtnStructSize := Is32bit ? 20 : 32
		BtnStruct := Buffer(BtnStructSize, 0)
		Static ctrlhwnd := hTb
		Static gbCtl := ctrlhwnd
		Static tbHwnd := ctrlhwnd
		Static gbCtl := Integer(ctrlhwnd)
		Static remote_buffer := remoteMemory
		Static hpRemote := hProcess

		GETBUTTON := SendMessage(TB_GETBUTTON, A_Index-1, remote_buffer,gbCtl, ctrlhwnd) ; Integer(ctrlhwnd))
		ReadRemoteBuffer(hpRemote, remote_buffer, &BtnStruct, 32)
		OutputDebug("GETBUTTON: " GETBUTTON "`n")
		idButton := NumGet(BtnStruct, 4, "IntP")
		OutputDebug("idButton: " . idButton . "`n")
		
		COMMANDTOINDEX := SendMessage(TB_COMMANDTOINDEX, idButton, 0,gbCtl ,ctrlhwnd) ; hope that 4KB is enough ; just a test
		btnvar1 := COMMANDTOINDEX
		OutputDebug("Cmd2Indx: " . btnvar1 . "`n")
		
		; CtrlID := DllCall("GetDlgCtrlID", "Ptr", CtrlHwnd, "Int")
		CtrlID := idButton
		hWndCtrl := DllCall("GetDlgItem", "Ptr", ctrlhwnd , "Int", CtrlID, "UPtr")
		OutputDebug('CtrlID: ' CtrlID "`nhWndCtrl: " hWndCtrl "`n")

		GETBUTTONINFOW := SendMessage(TB_GETBUTTONINFOW, btnvar1, remote_buffer,gbCtl , ctrlhwnd) ; hope that 4KB is enough ; just a test
		btnvar2 := GETBUTTONINFOW
		OutputDebug("BtnInfoW: " . btnvar2 . "`n")

		GETSTATE := SendMessage(TB_GETSTATE, idButton, 0,gbCtl ,ctrlhwnd) ; hope that 4KB is enough ; just a test
		btnstate := SubStr(GETSTATE,1,1)
		OutputDebug("btnstate: " . btnstate . "`n")
		; --------------------------------------------------------------------------------
		; Step: Read the button information stored in the RECT (remoteMemory)
		; --------------------------------------------------------------------------------
        DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", RECT, "UPtr", 16, "UInt*", &bytesRead:=0, "Int")
        DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
        DllCall("CloseHandle", "Ptr", hProcess)
		; --------------------------------------------------------------------------------
		; Step: Store previous and set min delay
		; --------------------------------------------------------------------------------
		prevDelay := A_ControlDelay
		prevMDelay := A_MouseDelay
		SetControlDelay(-1)
		SetMouseDelay(-1)
		; --------------------------------------------------------------------------------
		Left 	:= NumGet(RECT, 0, "int")
		Top 	:= NumGet(RECT, 4, "int")
		Right 	:= NumGet(RECT, 8, "int")
		Bottom 	:= NumGet(RECT, 12, "int")
		X 		:= Left
		Y 		:= Top
		W 		:= Right-Left
		H 		:= Bottom-Top
		; --------------------------------------------------------------------------------
		ControlClick("x" ((X+W)//2) " y" ((Y+H)//2), hTb,,,, "NA")
		; --------------------------------------------------------------------------------
        prevDelay := SetControlDelay(-1)
		; --------------------------------------------------------------------------------
		; Step: Restore previous and set delay
		; --------------------------------------------------------------------------------
        SetControlDelay(prevDelay)
		SetMouseDelay(prevMDelay)
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
    return
}
; --------------------------------------------------------------------------------

; --------------------------------------------------------------------------------
ClickToolbarItem(hWndToolbar, n) {
	static TB_BUTTONCOUNT := 1048 ; 0x418,
	static TB_GETBUTTON := 1047 ; 0x417, 
	static TB_GETITEMRECT := 1053 ; 0x41D
	static BM_SETCHECK:=0xF1
    buttonCount := SendMessage(TB_BUTTONCOUNT, 0, 0, , hWndToolbar)
	OutputDebug("ButtonCount: " buttonCount "`n")
    if (n >= 1 && n <= buttonCount) {
        DllCall("GetWindowThreadProcessId", "Ptr", hWndToolbar, "UInt*", &targetProcessID:=0)
		OutputDebug("targetProcessID: " targetProcessID "`n")
        ; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
        hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")
		OutputDebug("hProcess: " hProcess "`n")
        ; Allocate memory for the TBBUTTON structure in the target process's address space
        remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", 16, "UInt", 0x1000, "UInt", 0x04, "Ptr")
		OutputDebug("remoteMemory: " remoteMemory "`n")
        SendMessage(TB_GETITEMRECT, n-1, remoteMemory, , hWndToolbar)
        RECT := Buffer(16, 0)
        DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", RECT, "UPtr", 16, "UInt*", &bytesRead:=0, "Int")
		OutputDebug("hProcess: " hProcess "`n bytesRead: " bytesRead "`n")
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
		Left 	:= NumGet(RECT, 0, "int")
		Top 	:= NumGet(RECT, 4, "int")
		Right 	:= NumGet(RECT, 8, "int")
		Bottom 	:= NumGet(RECT, 12, "int")
		X 		:= Left
		Y 		:= Top
		W 		:= Right-Left
		H 		:= Bottom-Top
		; --------------------------------------------------------------------------------
		ControlClick("x" ((X+W)//2) " y" ((Y+H)//2), hwndToolbar,,,, "NA")
		; --------------------------------------------------------------------------------
		; Step: Restore previous and set delay
		; --------------------------------------------------------------------------------
        SetControlDelay(prevDelay)
		SetMouseDelay(prevMDelay)
		SetWinDelay(prevWDelay)
    } else
        throw ValueError("The specified index " n " is out of range. Please specify a valid index between 1 and " buttonCount ".", -1)
    return
}
; /**
;  * Clicks the nth item in a Win32 application toolbar.
;  * @param hWndToolbar - The handle of the toolbar control.
;  * @param n - The index of the toolbar item to click (1-based). Note: Separators are considered items as well.
;  * @example
;  * ControlGet, hToolbar, hWnd,, ToolbarWindow321, Test ; Replace with the actual ClassNN and WinTitle
;  * ClickToolbarItem(hToolbar, 3) ; Clicks the third item
;  */

ClickToolbarButton(hWndToolbar, n) {
    static TB_BUTTONCOUNT 		:= 1048
	Static TB_GETBUTTON 		:= 1047
	Static WM_COMMAND			:= 273 ; 0x111
	Static TB_BUTTONCOUNT  		:= 1048 ; 0x0418
	Static TB_GETBUTTON    		:= 1047 ; 0x417,
	Static TB_GETITEMRECT  		:= 1053 ; 0x41D,
	Static MEM_COMMIT      		:= 4096 ; 0x1000, ; 0x00001000, ; via MSDN Win32 
	Static MEM_RESERVE     		:= 8192 ; 0x2000, ; 0x00002000, ; via MSDN Win32
	Static MEM_PHYSICAL    		:= 4 ; 0x04    ; 0x00400000, ; via MSDN Win32
	Static MEM_PROTECT     		:= 64 ; 0x40 ;  
	Static MEM_RELEASE     		:= 32768 ; 0x8000 ; 

	static BM_SETCHECK			:= 241 ; 0xF1
	static BM_SETSTATE 			:=0xF3
	static BM_GETSTATE			:=0xF2
	static BST_CHECKED 			:= 1 ; 0x1,
	static BST_UNCHECKED 		:= 0 ; 0x0
	static BST_FOCUS			:=0x8
	static BST_HOT				:=0x0200
	static BST_INDETERMINATE 	:= 2 ; 0x2,
	static BST_PUSHED			:=0x4
	Static WM_USER				:= 1024 ; 0x400
	Static WM_IDUNNO			:= WM_USER+3
	Static TB_GETSTATE			:= WM_USER+18 ; (1042		
    buttonCount := SendMessage(TB_BUTTONCOUNT, 0, 0, , hWndToolbar)
	OutputDebug("ButtonCount: " buttonCount "`n")
    if (n >= 1 && n <= buttonCount) {
        DllCall("GetWindowThreadProcessId", "Ptr", hWndToolbar, "UInt*", &targetProcessID:=0)
		OutputDebug("targetProcessID: " targetProcessID "`n")
        ; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
        hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")
		OutputDebug("hProcess: " hProcess "`n")
        ; Allocate memory for the TBBUTTON structure in the target process's address space
		If (A_Is64bitOS) {
			Try DllCall("IsWow64Process", "Ptr", hProcess, "Int*", Is32bit := false)
		} Else {
			Is32bit := True
		}
	
		RPtrSize := Is32bit ? 4 : 8
		TBBUTTON_SIZE := 8 + (RPtrSize * 3) 
        ; remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", 32, "UInt", 0x1000, "UInt", 0x04, "Ptr")
        remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", TBBUTTON_SIZE, "UInt", 0x1000, "UInt", 0x04, "Ptr")
		OutputDebug("remoteMemory: " remoteMemory "`n")
        ; button := SendMessage(TB_GETBUTTON, n-1, remoteMemory, , hWndToolbar)
        button := SendMessage(TB_GETBUTTON, n, remoteMemory, , hWndToolbar)
		OutputDebug("Button: " button "`n")
        DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory+4, "Int*", &idCommand:=0, "UPtr", RPtrSize, "UInt*", &bytesRead:=0, "Int")
		OutputDebug("idCommand: " idCommand "`n")
		OutputDebug("hProcess: " hProcess "`n" "bytesRead: " bytesRead "`n")
        DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
        DllCall("CloseHandle", "Ptr", hProcess)
		GETSTATE := SendMessage(TB_GETSTATE, idCommand, 0,hWndToolbar ,hWndToolbar)
		btnstate := SubStr(GETSTATE,1,1)
		OutputDebug("btnstate: " . btnstate . "`n")
        pClick := SendMessage(BM_SETSTATE, 0x04,0,, hwndToolbar)
		OutputDebug("Programmatic Click: " pClick)
    } else
        throw ValueError("The specified index " n " is out of range. Please specify a valid index between 1 and " buttonCount ".", -1)
    return
}
; --------------------------------------------------------------------------------

; --------------------------------------------------------------------------------
HznButtonTest(hToolbar, n, nCtl, fCtl*) {
	; BlockInput(1) ; 1 = On, 0 = Off
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
	try ControlGetPos(&ctrlx:=0, &ctrly:=0,&ctrlw,&ctrlh, hToolbar, hToolbar)
	OutputDebug("&ctrlx: " . ctrlx " &ctrly: " . ctrly " &ctrlw: " . ctrlw " &ctrlh: " . ctrlh . "`n")
	; Step: count and load all the msvb_lib_toolbar buttons into memory
	buttonCount := SendMessage(TB_BUTTONCOUNT, 0, 0, , Integer(hToolbar))
	; Step: result of TB_BUTTONCOUNT (num of buttons)
	OutputDebug("ButtonCount: " buttonCount "`n")
	if (n >= 1 && n <= buttonCount)
	{
		DllCall("GetWindowThreadProcessId", "Ptr", hToolbar, "UInt*", &targetProcessID:=0)
		OutputDebug("pID: " targetProcessID "`n")
		; --------------------------------------------------------------------------------
		;- Step Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
        hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")
		OutputDebug("hProcess: " hProcess "`n")
		; --------------------------------------------------------------------------------
		; Step: Allocate memory for the TBBUTTON structure in the target process's address space
			; --------------------------------------------------------------------------------    
		; Allocate memory for the TBBUTTON structure in the target process's address space
		A_Is64bitOS ? DllCall("IsWow64Process", "Ptr", hProcess, "Int*", Is32bit := true) : Is32bit := True

		; If (A_Is64bitOS) {
		; 	Try DllCall("IsWow64Process", "Ptr", hProcess, "Int*", Is32bit := true)
		; } Else {
		; 	Is32bit := True
		; }
		; --------------------------------------------------------------------------------
		RPtrSize := Is32bit ? 4 : 8
		TBBUTTON_SIZE := 8 + (RPtrSize * 3) 
		; remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", 32, "UInt", 0x1000, "UInt", 0x04, "Ptr")
		remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", TBBUTTON_SIZE, "UInt", 0x1000, "UInt", MEM_PHYSICAL, "Ptr")
		OutputDebug("remoteMemory: " remoteMemory "`n")   
		; --------------------------------------------------------------------------------
		;/*
		; button := SendMessage(TB_GETBUTTON, n-1, remoteMemory,, hToolbar)
		; OutputDebug("Button: " button "`n")
        ; DllCall("ReadProcessMemory",
		; 		"Ptr", hProcess,
		; 		"Ptr", remoteMemory+4,
		; 		"Int*", &idCommand:=0,
		; 		"UPtr", 4,
		; 		"UInt*", &bytesRead:=0,
		; 		"Int")
		; OutputDebug("idCommand: " idCommand "`n")
		; OutputDebug("hProcess: " hProcess "`n" "bytesRead: " bytesRead "`n")
        ; DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
        ; DllCall("CloseHandle", "Ptr", hProcess)
		; WM_NOTIFY := 0x004e
		; WM_NOTIFY	Int32	78	0x0000004E
		WM_NOTIFY := 78 ; 0x0000004E
		; BM_CLICK	Int32	245	0x000000F5
		BM_CLICK	:= 245 ; 0x000000F5
		; NM_LDOWN	Int32	-20	0xFFFFFFEC
		; NM_CLICK	Int32	-2	0xFFFFFFFE
		; NM_RELEASEDCAPTURE	Int32	-16	0xFFFFFFF0
        ; pClick := SendMessage(WM_COMMAND, 1 | idCommand,,, hToolbar)
        ; pClick := SendMessage(BM_CLICK, 0,0,htoolbar,, hToolbar)
		; OutputDebug("Programmatic Click: " pClick)
		;*/
		; --------------------------------------------------------------------------------
		;? Get the bounds of each button
        ;/* 
		SendMessage(TB_GETITEMRECT, n-1, remoteMemory,, hToolbar)
        ; RECT := Buffer(16, 0)
		RECT := Buffer(TBBUTTON_SIZE, 0)
		BtnStructSize := 32 ;Is32bit ? 20 : 32
		BtnStruct := Buffer(BtnStructSize, 0) ; Winapi TBBUTTON struct(32 bytes on x64, 20 bytes on x86)
        DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", RECT, "UPtr", 16, "UInt*", &bytesRead:=0, "Int")
		OutputDebug("hProcess: " hProcess "`n bytesRead: " bytesRead "`n")
        DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
        DllCall("CloseHandle", "Ptr", hProcess)
		X := NumGet(RECT, 0, "int"),
		Y := NumGet(RECT, 4, "int"),
		W := NumGet(RECT, 8, "int")-X,
		H := NumGet(RECT, 12, "int")-Y
		OutputDebug("X: " X " Y: " Y " W: " W " H: " H "`n")
        ControlClick("x" ((X+W)//2) " y" ((Y+H)//2), hToolbar,,,, "NA")
        prevDelay := SetControlDelay(-1)
		OutputDebug("x" ((X+W)//2) " y" ((Y+H)//2) "`n")
		; --------------------------------------------------------------------------------
		prevDelay := A_ControlDelay
		prevMDelay := A_MouseDelay
		SetControlDelay(-1)
		SetMouseDelay(-1)
		; CaretGetPos(&cX, &cY)
		; MouseGetPos(&mX, &mY,&mWin,&mCtl,3)
		; --------------------------------------------------------------------------------
        ; ControlClick("x" X " y" Y, hToolbar,,,, "NA")
		; ControlClick(hToolbar,,,,,"X" X " " "Y" Y)
		WM_MOUSEHOVER 	:= 673 ; 0x02A1
		MK_LBUTTON 		:= 1 ; 0x0001
		; Static TB_PRESSBUTTON		:= 1027 ; 0x403
		; pClick := SendMessage(WM_MOUSEHOVER, ,X|Y,htoolbar,hToolbar)
		; pClick := SendMessage(TB_PRESSBUTTON,64,0,, hToolbar)
		; PostMessage(WM_LBUTTONDOWN,,x | y,nCtl,hToolbar)
		; PostMessage(WM_LBUTTONUP,,x | y,nCtl,hToolbar)
		; MouseClick(,X,Y,,-1)
		; ControlClick("x" X " " "y" Y,hToolbar,,,,"NA")

		; --------------------------------------------------------------------------------
		; MouseMove(mX,mY,0)
		; MouseMove(cX,cY,-1)
		; MouseMove(ctrlx + Ceil(x2+x1//2), ctrly + Ceil(y2+y1//2))
		; MouseMove(Ceil(X+W//2),Ceil(Y+H//2))
		; OutputDebug("x: " Ceil(X+W//2) " y: " Ceil(Y+H//2) "`n")
        SetControlDelay(prevDelay)
		SetMouseDelay(prevMDelay)
		;*/
		; --------------------------------------------------------------------------------
		;BlockInput(0) ; 1 = On, 0 = Off
    } else
        throw ValueError("The specified index " n " is out of range. Please specify a valid index between 1 and " buttonCount ".", -1)
    return
}
; Access := Map(
; 	; "PROCESS_ALL_ACCESS", 0x1F0FFF,
; 	; https://www.magnumdb.com/search?q=PROCESS_ALL_ACCESS (review and add)
; 	"PROCESS_DUP_HANDLE"                    , 0x0040,
; 	"PROCESS_QUERY_INFORMATION"             , 0x0400,
; 	"PROCESS_QUERY_LIMITED_INFORMATION"     , 0x1000,
; 	"PROCESS_SET_INFORMATION"               , 0x0200,
; 	"PROCESS_SET_QUOTA"                     , 0x0100,
; 	"PROCESS_SUSPEND_RESUME"                , 0x0800,
; 	"PROCESS_TERMINATE"                     , 0x0001,
; 	"PROCESS_VM_OPERATION"                  , 0x0008,
; 	"PROCESS_VM_READ"                       , 0x0010,
; 	"PROCESS_VM_WRITE"                      , 0x0020,
; 	"SYNCHRONIZE"                           , 0x100000,
; 	"MEM_PHYSICAL"              			, 4,
; 	"MEM_PROTECT"               			, 64 ; 0x40,                     
; 	"MEM_RELEASE"               			, 32768, ; 0x8000
; 	"MEM_COMMIT"                			, 4096,
; 	"MEM_RESERVE"               			, 8192
; )
; Msg := Map(
; 	"TB_GETBUTTON"              , 1047,
; 	"TB_BUTTONCOUNT"            , 1048,
; 	"TB_GETITEMRECT"            , 1053,                     
; )
; 	; static  TB_BUTTONCOUNT          := 0x418,
; 	; 		TB_GETBUTTON            := 0x417,
; 	; 		TB_GETITEMRECT          := 0x41D,
; 	; 		MEM_COMMIT              := 0x1000, ; 0x00001000, ; via MSDN Win32 
; 	; 		MEM_RESERVE             := 0x2000, ; 0x00002000, ; via MSDN Win32
; 	; 		MEM_PHYSICAL            := 0x04    ; 0x00400000, ; via MSDN Win32
; ------------------------------------------
; Function .....: Horizon Button - Test function to gather data about the toolbar
; ------------------------------------------
^+9::
{ ; V1toV2: Added bracket
	SendLevel(5)
	fCtl := ControlGetClassNN(ControlGetFocus('A'))
	; --------------------------------------------------------------------------------
	; ; #5::
	; ; WinGet, hWnd, ID, A
	; ; WinGet, vCtlList, ControlList, % "ahk_id " hWnd
	; ; vOutput := 0
	; Loop fCtl ;, Parse, vCtlList, `n
	; {
	; 	vCtlClassNN := A_LoopField
	; 	ControlGetHwnd(vCtlClassNN)
	; 	; ControlGet, hCtl, Hwnd,, % vCtlClassNN, % "ahk_id " hWnd
	; 	hWndParent := DllCall("user32\GetAncestor","Ptr",hCtl, "UInt",1, "Ptr") ;GA_PARENT := 1
	; 	hWndRoot := DllCall("user32\GetAncestor","Ptr", hCtl, "UInt",2, "Ptr") ;GA_ROOT := 2
	; 	hWndOwner := DllCall("user32\GetAncestor","Ptr", hCtl, "UInt",4, "Ptr") ;GA_ROOT := 2
	; 	;hWndOwner := DllCall("user32\GetWindow", Ptr,hCtl, UInt,4, Ptr) ;GW_OWNER = 4
	; 	hWndChild := DllCall("RealChildWindowFromPoint","Ptr",hCtl, "UInt",4, "Ptr") ;GW_OWNER = 4
	; 	CursorHwnd := DllCall("WindowFromPoint", "int64", &CursorX:=0 | (&CursorY:=0 << 32), "Ptr")
	; 	vWinClass1 := WinGetClass(hWndParent)
	; 	; WinGetClass, vWinClass1, % "ahk_id " hWndParent
	; 	vWinClass2 := WinGetClass(hWndRoot)
	; 	; WinGetClass, vWinClass2, % "ahk_id " hWndRoot
	; 	vWinClass3 := WinGetClass(hWndOwner)
	; 	; WinGetClass, vWinClass3, % "ahk_id " hWndOwner
	; 	vWinClass4 := WinGetClass(hWndChild)
	; 	; WinGetClass, vWinClass4, % "ahk_id " hWndChild
	; 	vOutput := "Index: " A_Index " | ClassNN: " vCtlClassNN " | hWndChild: " vWinClass4 " | hWndChild: " hWndChild " | hWndParent: " hWndParent " | hWndRoot: " hWndRoot " | hWndOwner: " hWndOwner " | CursorHwnd: " CursorHwnd "`n" ;"|" vWinClass1 "|" vWinClass2 "|" vWinClass3 "|" vWinClass4 "`r`n" ;"|" vWinClass4 "`r`n"
	; }
	; A_Clipboard := vOutput[] 
	; ;ToolTip, % vCtlClassNN,x+1,0
	; ; ToolTip, % vOutput, xm,0
	; MsgBox(vOutput)
	; return
	; MsgBox(fCtl)
	; --------------------------------------------------------------------------------
	bID := SubStr(fCtl, -1, 1)
	nCtl := "msvb_lib_toolbar" bID
	hTb := ControlGethWnd(nCtl, "A")
	hTx := ControlGethWnd(fCtl, "A")
	hIDx:= A_ThisHotkey = "^i" ? 2 ; .........: italic = 2
	:  A_ThisHotkey = "^b" ? 1 ; .........: bold = 1
	:  A_ThisHotkey = "^u" ? 9 ; .........: u = 3 (???9 and 10???) (else i or b)
	:  A_ThisHotkey = "^x" ? 11 ; ........: cut = 11 and 12
	:  A_ThisHotkey = "^c" ? 13 ; ........: copy
	:  A_ThisHotkey = "^v" ? 16 ; ........: paste
	:  A_ThisHotkey = "^z" ? 17 ; ........: undo = 17 and 18
	:  A_ThisHotkey = "^y" ? 20 : 21 ; ...: redo
	EnumToolbarButtons(hTb,hIDx,nCtl,fCtl)

} ; Added bracket before function
; -------------------------------------------------------------------------------------------------
/**
 * Clicks the nth item in a Win32 application toolbar.
 * @param ctrlhwnd - The handle of the toolbar control.
 * @param hTb - The handle of the toolbar control.
 * @param fCtl* - [OPTIONAL] The ClassNN of the "focused" control.
 * @param bID - The ClassNN instance of the "focused" control.
 * @param nCtl - The ClassNN and instance of the toolbar control.
 * @param n - The index (hIDx) of the toolbar item to click (1-based). Note: Separators are considered items as well.
 * @param hIDx - The index (n) of the toolbar item to click (1-based). Note: Separators are considered items as well.
 * @param HznButton(hToolbar, n, nCtl, fCtl:=0, hTx:=0, bID:=0)
 * @param param:=0 => in AHK v2 => optional
 * @example
 * fCtl := ControlGetClassNN(ControlGetFocus("A"))
 * bID := SubStr(fCtl, -1, 1)
 * nCtl := "msvb_lib_toolbar" bID
 * hTb := ControlGethWnd(nCtl, "A")
 * hTx := ControlGethWnd(fCtl, "A")
 * HznButton(hToolbar, 3) ; Clicks the third item
 */

EnumToolbarButtons(ctrlhwnd, n:=0, nCtl:=0, fCtl:=0, hTx:=0, bID:=0) ;, is_apply_scale:=false) {
{
	Static 	WM_COMMAND				:= 273 ; 0x111
	Static 	TB_PRESSBUTTON			:= 1027 ; 0x403
	Static 	TB_BUTTONCOUNT  		:= 1048 ; 0x0418, WM_USER+24
	Static 	TB_GETBUTTON    		:= 1047 ; 0x417,
	Static 	TB_GETITEMRECT  		:= 1053 ; 0x41D, WM_USER+29
	Static 	MEM_COMMIT      		:= 4096 ; 0x1000, ; 0x00001000, ; via MSDN Win32 
	Static 	MEM_RESERVE     		:= 8192 ; 0x2000, ; 0x00002000, ; via MSDN Win32
	Static 	MEM_PHYSICAL    		:= 4 ; 0x04    ; 0x00400000, ; via MSDN Win32
	Static 	MEM_PROTECT     		:= 64 ; 0x40 ;  
	Static 	MEM_RELEASE     		:= 32768 ; 0x8000 ; 
	Static 	WM_USER					:= 1024 ; 0x400
	Static 	TB_GETSTATE				:= 1042 ; WM_USER+18
	Static 	TB_GETBITMAP			:= 1068 ; WM_USER+44
	Static 	TB_GETBUTTONSIZE		:= 1082 ; WM_USER+58
	Static 	TB_GETBUTTON			:= 1047 ; WM_USER+23
	Static 	TB_GETBUTTONTEXTA		:= 1069 ; WM_USER+45
	Static 	TB_GETBUTTONTEXTW		:= 1099 ; WM_USER+75
	Static 	WM_GETDLGCODE			:= 135
	Static 	WM_NEXTDLGCTL			:= 40
	Static 	TB_COMMANDTOINDEX		:= 1049
	Static 	TB_GETBUTTONINFOW		:= 1087
	Static 	TB_SETSTATE 			:= 1041 ; 0x0411
	Static 	TBSTATE_PRESSED			:= 2 ; 0x02 
	Static 	WM_LBUTTONDOWN 			:= 513 ; 0x201
	Static 	WM_LBUTTONUP 			:= 515 ; 0x202

	x1 :=0, x2 :=0, y1 :=0, y2 :=0
	
	; Thanks to LabelControl code from 
	; https://www.donationcoder.com/Software/Skrommel/
	;
	; ctrlhwnd is the toolbar hwnd.
	; Return an array of objects, with element:
	; * .x .y .w .h (button position relative to the toolbar)
	; * .cmd  (command id of the button)
	; * .text  (text displayed on the button)
	;
	; is_apply_scale should keep false; true is only for testing purpose

	; get the bounding rectangle for the specified button
	arbtn := Array([])
	
	ControlGetPos(&ctrlx:=0, &ctrly:=0, &ctrlw:=0, &ctrlh:=0,ctrlhwnd, "ahk_id " ctrlhwnd)
	
	;MsgBox % "X: "ctrlx " Y: "ctrly " W: " ctrlw " H: " ctrlh ; 06.25.2023 .. THIS WORKS!!!
	;MouseMove, ctrlx, ctrly ; 06.25.2023 .. THIS WORKS!!! It actually moves the mouse to the right location!!!
	;pid_target := ""
	/*
	pid_target := DllCall( "GetWindowThreadProcessId"
										, "Ptr", ctrlhwnd)
	;                  , "UIntP") ;, pid_target)
	OutputDebug, % "pid_target: " . pid_target

*/
	; --------------------------------------------------------------------------------
	; Step: Get the toolbar "thread" process ID (PID) 
	DllCall("GetWindowThreadProcessId", "Ptr", ctrlhwnd, "UInt*", &targetProcessID:=0)
	pid_target := WinGetPID(ctrlhwnd) ; ==> replaced with above DllCall()
	OutputDebug("pid_targetW: " . pid_target . "`n" "targetProcessID: " targetProcessID "`n")
	; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
	; --------------------------------------------------------------------------------
	; Step: Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
	hpRemote := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", pid_target, "Ptr")
	; hpRemote: Remote process handle
	if(!hpRemote) {
		ToolTip("Autohotkey: Cannot OpenProcess(pid=" . pid_target . ")")
		return
	}
	; --------------------------------------------------------------------------------
	; Step: [OPTIONAL] Identify if the process is 32 or 64 bit (efficiency step)
	; --------------------------------------------------------------------------------
	A_Is64bitOS ? DllCall("IsWow64Process", "Ptr", hpRemote, "Int*", Is32bit := true) : Is32bit := True
	If (A_Is64bitOS) {
		Try DllCall("IsWow64Process", "Ptr", hpRemote, "Int*", Is32bit := true)
	} Else {
		Is32bit := True
	}
	; --------------------------------------------------------------------------------
	; Step: Allocate memory for the TBBUTTON structure in the target process's address space
	; --------------------------------------------------------------------------------
	RPtrSize := Is32bit ? 4 : 8
	TBBUTTON_SIZE := 8 + (RPtrSize * 3) 
	remote_buffer := DllCall("VirtualAllocEx", "Ptr", hpRemote, "Ptr", 0, "UPtr", TBBUTTON_SIZE, "UInt", 0x1000, "UInt", MEM_PHYSICAL, "Ptr")
	; --------------------------------------------------------------------------------
	Static Msg := TB_BUTTONCOUNT, wParam := 0, lParam := 0, control := ctrlhwnd
	; --------------------------------------------------------------------------------
	; Step: count and load all the msvb_lib_toolbar buttons into memory
	; --------------------------------------------------------------------------------
	; BUTTONCOUNT := SendMessage(TB_BUTTONCOUNT, wParam, lParam, control, "ahk_id " ctrlhwnd)
	buttons := SendMessage(TB_BUTTONCOUNT, wParam, lParam, control, "ahk_id " ctrlhwnd)
	; buttons := BUTTONCOUNT
	OutputDebug("buttons: " . buttons . "`n") 
	rect := Buffer(16,0)
	BtnStruct := Buffer(32,0)
	/*
typedef struct _TBBUTTON {
	int       iBitmap; 
	int       idCommand; 
	BYTE      fsState; 
	BYTE      fsStyle; 
	#ifdef _WIN64
	BYTE      bReserved[6]     // padding for alignment
	#elif defined(_WIN32)
	BYTE      bReserved[2]     // padding for alignment
	#endif
	DWORD_PTR dwData; 
	INT_PTR   iString; 
} TBBUTTON, NEAR* PTBBUTTON, FAR* LPTBBUTTON; 
	*/
	
	Loop buttons
	{
		; Try to get button text. Two Notes: 
		; 1. get command-id from button-index,
		; 2. get button text from command-id
		; Static gbCtl := 
		Static gbCtl := ctrlhwnd
		Static tbHwnd := ctrlhwnd
		Static gbCtl := Integer(ctrlhwnd)

		GETBUTTON := SendMessage(TB_GETBUTTON, A_Index-1, remote_buffer,gbCtl, ctrlhwnd) ; Integer(ctrlhwnd))
		ReadRemoteBuffer(hpRemote, remote_buffer, &BtnStruct, 32)
		OutputDebug("GETBUTTON: " GETBUTTON "`n")
		idButton := NumGet(BtnStruct, 4, "IntP")
		OutputDebug("idButton: " . idButton . "`n")
		
		COMMANDTOINDEX := SendMessage(TB_COMMANDTOINDEX, idButton, 0,gbCtl ,ctrlhwnd) ; hope that 4KB is enough ; just a test
		btnvar1 := COMMANDTOINDEX
		OutputDebug("Cmd2Indx: " . btnvar1 . "`n")
		
		; CtrlID := DllCall("GetDlgCtrlID", "Ptr", CtrlHwnd, "Int")
		CtrlID := idButton
		hWndCtrl := DllCall("GetDlgItem", "Ptr", ctrlhwnd , "Int", CtrlID, "UPtr")
		OutputDebug('CtrlID: ' CtrlID "`nhWndCtrl: " hWndCtrl "`n")

		GETBUTTONINFOW := SendMessage(TB_GETBUTTONINFOW, btnvar1, remote_buffer,gbCtl , ctrlhwnd) ; hope that 4KB is enough ; just a test
		btnvar2 := GETBUTTONINFOW
		OutputDebug("BtnInfoW: " . btnvar2 . "`n")

		GETSTATE := SendMessage(TB_GETSTATE, idButton, 0,gbCtl ,ctrlhwnd) ; hope that 4KB is enough ; just a test
		btnstate := SubStr(GETSTATE,1,1)
		OutputDebug("btnstate: " . btnstate . "`n")

		GETBUTTONTEXTW := SendMessage(TB_GETBUTTONTEXTW, idButton, remote_buffer,gbCtl,ctrlhwnd) ; hope that 4KB is enough
		btntextcharsW := GETBUTTONTEXTW
		OutputDebug("btntextcharsW: " . btntextcharsW . "`n")
		
		if(btntextcharsW>0){
			btntextbytes := 1 ? btntextcharsW*2 : btntextcharsW
			
			BtnTextBuf := Buffer(btntextbytes+2, 0) ; +2 is for trailing-NUL ; V1toV2: if 'BtnTextBuf' is a UTF-16 string, use 'VarSetStrCapacity(&BtnTextBuf, btntextbytes+2)'
			ReadRemoteBuffer(hpRemote, remote_buffer, &BtnTextBuf, btntextbytes)
			BtnTextW := StrGet(BtnTextBuf,,"UTF-16")
		} else {
			BtnTextW := ""
		}
		OutputDebug("BtnTextW: " . BtnTextW . "`n")
		
		/*

		SendMessage, % TB_GETBUTTONTEXTA, % idButton, remote_buffer, , % "ahk_id " ctrlhwnd ; hope that 4KB is enough
		btntextcharsA := ErrorLevel
		OutputDebug, % "btntextcharsA: " . btntextcharsA . "`n"
		
		if(btntextcharsA>0){
			btntextbytes := A_IsUnicode ? btntextcharsA*2 : btntextcharsA
			VarSetCapacity(BtnTextBuf, btntextbytes+2, 0) ; +2 is for trailing-NUL
			ReadRemoteBuffer(hpRemote, remote_buffer, BtnTextBuf, btntextbytes)
			BtnTextA := StrGet(&BtnTextBuf,99,0)
		} else {
			BtnTextA := ""
		}
		OutputDebug, % "BtnTextA: " . BtnTextA . "`n"
		*/
		
		;FileAppend, % A_Index . ":" . idButton . "(" . btntextchars . ")" . BtnText . "`n", _emeditor_toolbar_buttons.txt ; debug
		
		BTNRECT := SendMessage(TB_GETITEMRECT, A_Index-1, remote_buffer, , "ahk_id " ctrlhwnd)
		
		ReadRemoteBuffer(hpRemote, remote_buffer, &rect, 32)
		oldx1:=x1
		oldx2:=x2
		oldy1:=y1
		x1 := NumGet(rect, 0, "Int") 
		x2 := NumGet(rect, 8, "Int") 
		y1 := NumGet(rect, 4, "Int") 
		y2 := NumGet(rect, 12, "Int")
		
		FileAppend(A_Index . ":" . idButton . " " . "(text: " . btntextcharsW . ")" . "(" . "hWndCtrl: " . hWndCtrl . ")" . " BtnTextW: " . BtnTextW . " State: " btnstate . " " . "Cmd2Indx: " . btnvar1 . " " . "BtnInfoW: " . btnvar2 . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . " BTNRECT: " BTNRECT . "`n", "_emeditor_toolbar_buttons.txt")  ; debug
		; output := A_Index . ":" . idButton . " " . "(" . "hWndCtrl: " . hWndCtrl . ")" . " State: " btnstate . " " . "Cmd2Indx: " . btnvar1 . " " . "BtnInfoW: " . btnvar2 . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . " BTNRECT: " BTNRECT . "`n"
		; output := A_Index . ":" . idButton . " " . "(text: " . btntextcharsW . ")" . "(" . "hWndCtrl: " . hWndCtrl . ")" . " BtnTextW: " . BtnTextW . " State: " btnstate . " " . "Cmd2Indx: " . btnvar1 . " " . "BtnInfoW: " . btnvar2 . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . " BTNRECT: " BTNRECT . "`n"
		; FileAppend(output, "_emeditor_toolbar_buttons.txt")  ; debug
		; OutputDebug(A_Index . ":" . idButton . " " . "(text: " . btntextcharsW . ")" . "(" . "hWndCtrl: " . hWndCtrl . ")" . " BtnTextW: " . BtnTextW . " State: " btnstate . " " . "Cmd2Indx: " . btnvar1 . " " . "BtnInfoW: " . btnvar2 . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . " BTNRECT: " BTNRECT . "`n")                                 ; debug
		OutputDebug(A_Index . ":" . idButton . " " . "(text: " . btntextcharsW . ")" . "(" . "hWndCtrl: " . hWndCtrl . ")" . " BtnTextW: " . BtnTextW . " State: " btnstate . " " . "Cmd2Indx: " . btnvar1 . " " . "BtnInfoW: " . btnvar2 . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . " BTNRECT: " BTNRECT . "`n")                                 ; debug
		; --------------------------------------------------------------------------------
		;MouseMove % ctrlx + (x2+x1//2), ctrly + (y2+y1//2)
		;if(is_apply_scale) {
		;scale := Get_DPIScale()
		;x1 /= scale
		;y1 /= scale
		;x2 /= scale
		;y2 /= scale
		;}
		
		; If (x1=oldx1 And y1=oldy1 And x2=oldx2)
		; 	Continue
		; If (x2-x1<10)
		; 	Continue
		; If (x1>ctrlw Or y1>ctrlh)
		; 	Continue
		


		arbtn.Push(A_Index,{x:x1, y:y1, w:x2-x1, h:y2-y1, cmd:idButton}) ; , text:BtnTextW})
		;arbtn.Insert( {"x":x1, "y":y1, "w":x2-x1, "h":y2-y1, "cmd":idButton, "text":BtnText} )
		;line:=100000000+Floor((ctrly+y1)/same)*10000+(ctrlx+x1)
		;lines=%lines%%line%%A_Tab%%ctrlid%%A_Tab%%class%`n
		; arbtn := ({x:x1, y:y1, w:x2-x1, h:y2-y1, cmd:idButton, text:BtnTextW})
		; For key, value in arbtn{
		; 	FileAppend("Key:" . key . " = " . value . "`n", "_arbtn.txt")
		; }
	}
	
	DllCall("VirtualFreeEx", "UInt", hpRemote, "UInt", remote_buffer, "UInt", 0, "UInt", 0x8000)
	DllCall("CloseHandle", "UInt", hpRemote)
	return arbtn
}

ReadRemoteBuffer(hpRemote, RemoteBuffer, &LocalVar, bytes) {
	DllCall("ReadProcessMemory", "Ptr", hpRemote, "Ptr", RemoteBuffer, "Ptr", LocalVar, "UInt", bytes, "UInt", 0) 
}

#HotIf

; ^+5::
; { ; V1toV2: Added bracket
; SendLevel(1)
; fCtl := ControlGetClassNN(ControlGetFocus("A"))
; bID:= SubStr(fCtl, -1, 1)
; ctrlhwnd := ControlGethWnd("msvb_lib_toolbar" bID, "A")
; cTb := New Toolbar(ctrlhwnd)
; OutputDebug("ahk_id " . ctrlhwnd . "`n")
; OutputDebug("1:__" . cTb.Base . "__:1`n")
; ; for k, v in cTb
; ;     OutputDebug % k . " = " . v . "`n"
; ; ahk_id 0x20d72
; ; DefaultBtnInfo = 
; ; Presets = 
; ; tbHwnd = 0x20d72
; }
return

; -------------------------------------------------------------------------------------------------
; Function .....: Horizon Hotkeys - Save
; ChangeLog ....: 06/08/2023 - v1 - With #IfWinActive ahk_exe hznhorizon.exe, added CTRL+S
; . Continued ..: Added FindText() function to bottom of script using the-automator.com script
; . Continued ..: Added the "specific text", which is really a picture convereted to base64 (to text) of the Save icon
; -------------------------------------------------------------------------------------------------
;/*
#HotIf WinActive("ahk_exe Hznhorizon.exe")
#Include <Lib.v2\UIA>
#Include <Lib.v2\UIA_Browser>
^s::HznSave()

HznSave()
{
	global IUIAutomationActivateScreenReader:=0
	global IUIAutomationMaxVersion:=0
	idWin := WinGetID("[Main] ahk_exe hznHorizon.exe")
	idControl := ControlGetHwnd("msvb_lib_toolbar1")
	hznWin := UIA.ElementFromHandle(WinGetID('[Main] ahk_exe hznHorizon.exe'))
	hznMenuBar := HznWin.FindElement({
		LocalizedType: "menu bar",
		Name: "System"})
	hznSave := hznMenuBar.Highlight().ControlClick()
	; hznClickSave := hznSave.ControlClick()
	; hznMenuItem :=	hznMenuBar.FindElement({
	; 		LocalizedType: 'menu item',
	; 		Value: 'Main'}).FindElement({
	; 			LocalizedType: 'menu bar',
	; 			Name: 'Document Window'
	; 		})
	; hznSaveHiLgt :=	hznMenuItem.Highlight()
	; hznHorizonEl.ElementFromPath({Name: "Document Window"}).ControlClick()
	; hznHorizonEl.ElementFromPath("YXcAB").ControlClick()
	; Send("!f")
	; Sleep(300)
	; Send("s")
	return
}
#HotIf

;===== Copy The Following Functions To Your Own Code Just once =====


; Note: parameters of the X,Y is the center of the coordinates,
; and the W,H is the offset distance to the center,
; So the search range is (X-W, Y-H)-->(X+W, Y+H).
; err1 is the character "0" fault-tolerant in percentage.
; err0 is the character "_" fault-tolerant in percentage.
; Text can be a lot of text to find, separated by "|".
; ruturn is a array, contains the X,Y,W,H,Comment results of Each Find.
/*
} ; Added bracket before function


FindText(x,y,w,h,err1,err0,text)
{
	xywh2xywh(x-w,y-h,2*w+1,2*h+1,x,y,w,h)
	if (w<1 or h<1)
		return, 0
	bch:=A_BatchLines
	SetBatchLines, -1
	;--------------------------------------
	GetBitsFromScreen(x,y,w,h,Scan0,Stride,bits)
	;--------------------------------------
	sx:=0, sy:=0, sw:=w, sh:=h, arr:=[]
	Loop, 2 {
	Loop, Parse, text, |
	{
		v:=A_LoopField
		IfNotInString, v, $, Continue
		Comment:="", e1:=err1, e0:=err0
		; You Can Add Comment Text within The <>
		if RegExMatch(v,"<([^>]*)>",r)
			v:=StrReplace(v,r), Comment:=Trim(r1)
		; You can Add two fault-tolerant in the [], separated by commas
		if RegExMatch(v,"\[([^\]]*)]",r)
		{
			v:=StrReplace(v,r), r1.=","
			StringSplit, r, r1, `,
			e1:=r1, e0:=r2
		}
		StringSplit, r, v, $
		color:=r1, v:=r2
		StringSplit, r, v, .
		w1:=r1, v:=base64tobit(r2), h1:=StrLen(v)//w1
		if (r0<2 or h1<1 or w1>sw or h1>sh or StrLen(v)!=w1*h1)
			Continue
		;--------------------------------------------
		if InStr(color,"-")
		{
			r:=e1, e1:=e0, e0:=r, v:=StrReplace(v,"1","_")
			v:=StrReplace(StrReplace(v,"0","1"),"_","0")
		}
		mode:=InStr(color,"*") ? 1:0
		color:=RegExReplace(color,"[*\-]") . "@"
		StringSplit, r, color, @
		color:=Round(r1), n:=Round(r2,2)+(!r2)
		n:=Floor(255*3*(1-n)), k:=StrLen(v)*4
		VarSetCapacity(ss, sw*sh, Asc("0"))
		VarSetCapacity(s1, k, 0), VarSetCapacity(s0, k, 0)
		VarSetCapacity(rx, 8, 0), VarSetCapacity(ry, 8, 0)
		len1:=len0:=0, j:=sw-w1+1, i:=-j
		ListLines, Off
		Loop, Parse, v
		{
			i:=Mod(A_Index,w1)=1 ? i+j : i+1
			if A_LoopField
				NumPut(i, s1, 4*len1++, "Int")
			else
				NumPut(i, s0, 4*len0++, "Int")
		}
		ListLines, On
		e1:=Round(len1*e1), e0:=Round(len0*e0)
		;--------------------------------------------
		if PicFind(mode,color,n,Scan0,Stride,sx,sy,sw,sh
			,ss,s1,s0,len1,len0,e1,e0,w1,h1,rx,ry)
		{
			rx+=x, ry+=y
			arr.Push(rx,ry,w1,h1,Comment)
		}
	}
	if (arr.MaxIndex())
		Break
	if (A_Index=1 and err1=0 and err0=0)
		err1:=0.05, err0:=0.05
	else Break
	}
	SetBatchLines, %bch%
	return, arr.MaxIndex() ? arr:0
}

PicFind(mode, color, n, Scan0, Stride
	, sx, sy, sw, sh, ByRef ss, ByRef s1, ByRef s0
	, len1, len0, err1, err0, w, h, ByRef rx, ByRef ry)
{
	static MyFunc
	if !MyFunc
	{
		x32:="5589E583EC408B45200FAF45188B551CC1E20201D08945F"
		. "48B5524B80000000029D0C1E00289C28B451801D08945D8C74"
		. "5F000000000837D08000F85F00000008B450CC1E81025FF000"
		. "0008945D48B450CC1E80825FF0000008945D08B450C25FF000"
		. "0008945CCC745F800000000E9AC000000C745FC00000000E98"
		. "A0000008B45F483C00289C28B451401D00FB6000FB6C02B45D"
		. "48945EC8B45F483C00189C28B451401D00FB6000FB6C02B45D"
		. "08945E88B55F48B451401D00FB6000FB6C02B45CC8945E4837"
		. "DEC007903F75DEC837DE8007903F75DE8837DE4007903F75DE"
		. "48B55EC8B45E801C28B45E401D03B45107F0B8B55F08B452C0"
		. "1D0C600318345FC018345F4048345F0018B45FC3B45240F8C6"
		. "AFFFFFF8345F8018B45D80145F48B45F83B45280F8C48FFFFF"
		. "FE9A30000008B450C83C00169C0E803000089450CC745F8000"
		. "00000EB7FC745FC00000000EB648B45F483C00289C28B45140"
		. "1D00FB6000FB6C069D02B0100008B45F483C00189C18B45140"
		. "1C80FB6000FB6C069C04B0200008D0C028B55F48B451401D00"
		. "FB6000FB6C06BC07201C83B450C730B8B55F08B452C01D0C60"
		. "0318345FC018345F4048345F0018B45FC3B45247C948345F80"
		. "18B45D80145F48B45F83B45280F8C75FFFFFF8B45242B45488"
		. "3C0018945488B45282B454C83C00189454C8B453839453C0F4"
		. "D453C8945D8C745F800000000E9E3000000C745FC00000000E"
		. "9C70000008B45F80FAF452489C28B45FC01D08945F48B45408"
		. "945E08B45448945DCC745F000000000EB708B45F03B45387D2"
		. "E8B45F08D1485000000008B453001D08B108B45F401D089C28"
		. "B452C01D00FB6003C31740A836DE001837DE00078638B45F03"
		. "B453C7D2E8B45F08D1485000000008B453401D08B108B45F40"
		. "1D089C28B452C01D00FB6003C30740A836DDC01837DDC00783"
		. "08345F0018B45F03B45D87C888B551C8B45FC01C28B4550891"
		. "08B55208B45F801C28B45548910B801000000EB2990EB01908"
		. "345FC018B45FC3B45480F8C2DFFFFFF8345F8018B45F83B454"
		. "C0F8C11FFFFFFB800000000C9C25000"
		x64:="554889E54883EC40894D10895518448945204C894D288B4"
		. "5400FAF45308B5538C1E20201D08945F48B5548B8000000002"
		. "9D0C1E00289C28B453001D08945D8C745F000000000837D100"
		. "00F85000100008B4518C1E81025FF0000008945D48B4518C1E"
		. "80825FF0000008945D08B451825FF0000008945CCC745F8000"
		. "00000E9BC000000C745FC00000000E99A0000008B45F483C00"
		. "24863D0488B45284801D00FB6000FB6C02B45D48945EC8B45F"
		. "483C0014863D0488B45284801D00FB6000FB6C02B45D08945E"
		. "88B45F44863D0488B45284801D00FB6000FB6C02B45CC8945E"
		. "4837DEC007903F75DEC837DE8007903F75DE8837DE4007903F"
		. "75DE48B55EC8B45E801C28B45E401D03B45207F108B45F0486"
		. "3D0488B45584801D0C600318345FC018345F4048345F0018B4"
		. "5FC3B45480F8C5AFFFFFF8345F8018B45D80145F48B45F83B4"
		. "5500F8C38FFFFFFE9B60000008B451883C00169C0E80300008"
		. "94518C745F800000000E98F000000C745FC00000000EB748B4"
		. "5F483C0024863D0488B45284801D00FB6000FB6C069D02B010"
		. "0008B45F483C0014863C8488B45284801C80FB6000FB6C069C"
		. "04B0200008D0C028B45F44863D0488B45284801D00FB6000FB"
		. "6C06BC07201C83B451873108B45F04863D0488B45584801D0C"
		. "600318345FC018345F4048345F0018B45FC3B45487C848345F"
		. "8018B45D80145F48B45F83B45500F8C65FFFFFF8B45482B859"
		. "000000083C0018985900000008B45502B859800000083C0018"
		. "985980000008B45703945780F4D45788945D8C745F80000000"
		. "0E90B010000C745FC00000000E9EC0000008B45F80FAF45488"
		. "9C28B45FC01D08945F48B85800000008945E08B85880000008"
		. "945DCC745F000000000E9800000008B45F03B45707D368B45F"
		. "04898488D148500000000488B45604801D08B108B45F401D04"
		. "863D0488B45584801D00FB6003C31740A836DE001837DE0007"
		. "8778B45F03B45787D368B45F04898488D148500000000488B4"
		. "5684801D08B108B45F401D04863D0488B45584801D00FB6003"
		. "C30740A836DDC01837DDC00783C8345F0018B45F03B45D80F8"
		. "C74FFFFFF8B55388B45FC01C2488B85A000000089108B55408"
		. "B45F801C2488B85A80000008910B801000000EB2F90EB01908"
		. "345FC018B45FC3B85900000000F8C05FFFFFF8345F8018B45F"
		. "83B85980000000F8CE6FEFFFFB8000000004883C4405DC390"
		MCode(MyFunc, A_PtrSize=8 ? x64:x32)
	}
	return, DllCall(&MyFunc, "Int",mode
		, "UInt",color, "Int",n, "ptr",Scan0, "Int",Stride
		, "Int",sx, "Int",sy, "Int",sw, "Int",sh
		, "ptr",&ss, "ptr",&s1, "ptr",&s0
		, "Int",len1, "Int",len0, "Int",err1, "Int",err0
		, "Int",w, "Int",h, "int*",rx, "int*",ry)
}

xywh2xywh(x1,y1,w1,h1,ByRef x,ByRef y,ByRef w,ByRef h)
{
	SysGet, zx, 76
	SysGet, zy, 77
	SysGet, zw, 78
	SysGet, zh, 79
	left:=x1, right:=x1+w1-1, up:=y1, down:=y1+h1-1
	left:=left<zx ? zx:left, right:=right>zx+zw-1 ? zx+zw-1:right
	up:=up<zy ? zy:up, down:=down>zy+zh-1 ? zy+zh-1:down
	x:=left, y:=up, w:=right-left+1, h:=down-up+1
}

GetBitsFromScreen(x,y,w,h,ByRef Scan0,ByRef Stride,ByRef bits)
{
	VarSetCapacity(bits,w*h*4,0), bpp:=32
	Scan0:=&bits, Stride:=((w*bpp+31)//32)*4
	Ptr:=A_PtrSize ? "UPtr" : "UInt", PtrP:=Ptr . "*"
	win:=DllCall("GetDesktopWindow", Ptr)
	hDC:=DllCall("GetWindowDC", Ptr,win, Ptr)
	mDC:=DllCall("CreateCompatibleDC", Ptr,hDC, Ptr)
	;-------------------------
	VarSetCapacity(bi, 40, 0), NumPut(40, bi, 0, "Int")
	NumPut(w, bi, 4, "Int"), NumPut(-h, bi, 8, "Int")
	NumPut(1, bi, 12, "short"), NumPut(bpp, bi, 14, "short")
	;-------------------------
	if hBM:=DllCall("CreateDIBSection", Ptr,mDC, Ptr,&bi
		, "Int",0, PtrP,ppvBits, Ptr,0, "Int",0, Ptr)
	{
		oBM:=DllCall("SelectObject", Ptr,mDC, Ptr,hBM, Ptr)
		DllCall("BitBlt", Ptr,mDC, "Int",0, "Int",0, "Int",w, "Int",h
			, Ptr,hDC, "Int",x, "Int",y, "UInt",0x00CC0020|0x40000000)
		DllCall("RtlMoveMemory","ptr",Scan0,"ptr",ppvBits,"ptr",Stride*h)
		DllCall("SelectObject", Ptr,mDC, Ptr,oBM)
		DllCall("DeleteObject", Ptr,hBM)
	}
	DllCall("DeleteDC", Ptr,mDC)
	DllCall("ReleaseDC", Ptr,win, Ptr,hDC)
}

base64tobit(s)
{
	ListLines, Off
	Chars:="0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		. "abcdefghijklmnopqrstuvwxyz"
	SetFormat, IntegerFast, d
	StringCaseSense, On
	Loop, Parse, Chars
	{
		i:=A_Index-1, v:=(i>>5&1) . (i>>4&1)
			. (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1)
		s:=StrReplace(s,A_LoopField,v)
	}
	StringCaseSense, Off
	s:=SubStr(s,1,InStr(s,"1",0,0)-1)
	s:=RegExReplace(s,"[^01]+")
	ListLines, On
	return, s
}

bit2base64(s)
{
	ListLines, Off
	s:=RegExReplace(s,"[^01]+")
	s.=SubStr("100000",1,6-Mod(StrLen(s),6))
	s:=RegExReplace(s,".{6}","|$0")
	Chars:="0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		. "abcdefghijklmnopqrstuvwxyz"
	SetFormat, IntegerFast, d
	Loop, Parse, Chars
	{
		i:=A_Index-1, v:="|" . (i>>5&1) . (i>>4&1)
			. (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1)
		s:=StrReplace(s,v,A_LoopField)
	}
	ListLines, On
	return, s
}

ASCII(s){
	if RegExMatch(s,"(\d+)\.([\w+/]{3,})",r)
	{
		s:=RegExReplace(base64tobit(r2),".{" r1 "}","$0`n")
		s:=StrReplace(StrReplace(s,"0","_"),"1","0")
	}
	else s=
	return, s
}

MCode(ByRef code, hex){
	ListLines, Off
	bch:=A_BatchLines
	SetBatchLines, -1
	VarSetCapacity(code, StrLen(hex)//2)
	Loop, % StrLen(hex)//2
		NumPut("0x" . SubStr(hex,2*A_Index-1,2), code, A_Index-1, "char")
	Ptr:=A_PtrSize ? "UPtr" : "UInt"
	DllCall("VirtualProtect", Ptr,&code, Ptr
		,VarSetCapacity(code), "UInt",0x40, Ptr . "*",0)
	SetBatchLines, %bch%
	ListLines, On
}

; You can put the text library at the beginning of the script, and Use Pic(Text,1) to add the text library to Pic()'s Lib,
; Use Pic("comment1|comment2|...") to get text images from Lib
Pic(comments, add_to_Lib=0) {
	static Lib:=[]
	if (add_to_Lib)
	{
		re:="<([^>]*)>[^$]+\$\d+\.[\w+/]{3,}"
		Loop, Parse, comments, |
			if RegExMatch(A_LoopField,re,r)
				Lib[Trim(r1)]:=r
	}
	else
	{
		text:=""
		Loop, Parse, comments, |
			text.="|" . Lib[Trim(A_LoopField)]
		return, text
	}
}
return

Specify_Area:
run FindText_get_coordinates.ahk
return
*/

;Convert a Base 64 string into a pBitmap
B64ToPBitmap( Input ){
	; local Ptr , UPtr , pBitmap , pStream , hData , pData , Dec , DecLen , B64
	Static UPtr , pBitmap , pStream , hData , pData , Dec , DecLen , B64
	;B64 := Buffer(strlen( Input ) << !!A_IsUnicode)
	VarSetStrCapacity(&B64, 5120000) ; V1toV2: if 'B64' is NOT a UTF-16 string, use 'B64 := Buffer(strlen( Input ) << !!A_IsUnicode)'
	VarSetStrCapacity(&DecLen, 5120000) ; V1toV2: if 'B64' is NOT a UTF-16 string, use 'B64 := Buffer(strlen( Input ) << !!A_IsUnicode)'
	B64 := Input
	If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", &DecLen, "Ptr", 0, "Ptr", 0)
		Return False
	; Dec := Buffer(DecLen, 0) ; V1toV2: if 'Dec' is a UTF-16 string, use 'VarSetStrCapacity(&Dec, DecLen)'
	VarSetStrCapacity(&Dec, DecLen) ; V1toV2: if 'Dec' is a UTF-16 string, use 'VarSetStrCapacity(&Dec, DecLen)'
	If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", B64, "UInt", 0, "UInt", 0x01, "Ptr", Dec, "UIntP", &DecLen, "Ptr", 0, "Ptr", 0)
		Return False
	DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData := DllCall("Kernel32.dll\GlobalLock", "Ptr", hData := DllCall("Kernel32.dll\GlobalAlloc", "UInt", 2, UPtr := A_PtrSize ? "UPtr" : "UInt", DecLen, "UPtr"), "UPtr"), "Ptr", Dec, "UPtr", DecLen)
	DllCall("Kernel32.dll\GlobalUnlock", "Ptr", hData)
	DllCall("Ole32.dll\CreateStreamOnHGlobal", "Ptr", hData, "Int", True, "Ptr", &pStream)
	DllCall("Gdiplus.dll\GdipCreateBitmapFromStream", "Ptr", pStream, "Ptr", &pBitmap)
	return pBitmap
}

Library_Load(filename)
{
	static ref := {}
	if (!(ptr := p := DllCall("LoadLibrary", "str", filename, "ptr")))
	return 0
	ref[ptr,"count"] := (ref[ptr]) ? ref[ptr,"count"]+1 : 1
	p += NumGet(p+0, 0x3c, "Int")+24
	o := {_ptr:ptr, __delete: &FreeLibrary, _ref:ref[ptr]}
	if (NumGet(p+0, (A_PtrSize=4) ? 92 : 108, "UInt")<1 || (ts := NumGet(p+0, (A_PtrSize=4) ? 96 : 112, "UInt")+ptr)=ptr || (te := NumGet(p+0, (A_PtrSize=4) ? 100 : 116, "UInt")+ts)=ts)
	return o
	n := ptr+NumGet(ts+0, 32, "UInt")
	Loop NumGet(ts+0, 24, "UInt")
	{
	if (p := NumGet(n+0, (A_Index-1)*4, "UInt"))
	{
		o[f := StrGet(ptr+p, "cp0")] := DllCall("GetProcAddress", "ptr", "ptr", "astr", f, "ptr")
		if (SubStr(f, -1)==((1) ? "W" : "A"))
		o[SubStr(f, 1, -1)] := o[f]
	}
	}
	return o
}

Library_Free(lib)
{
	if (lib._ref.count>=1)
		lib._ref.count -= 1
	if (lib._ref.count<1)
		DllCall("FreeLibrary", "ptr", lib._ptr)
}
; ; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; ; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013
; ; Supports: Basic, _L ANSi, _L Unicode x86 and _L Unicode x64
; ;
; ; Updated 2/20/2014 - fixed Gdip_CreateRegion() and Gdip_GetClipRegion() on AHK Unicode x86
; ; Updated 5/13/2013 - fixed Gdip_SetBitmapToClipboard() on AHK Unicode x64
; ;
; ;#####################################################################################
; ;#####################################################################################
; ; STATUS ENUMERATION
; ; Return values for functions specified to have status enumerated return type
; ;#####################################################################################
; ;
; ; Ok =						= 0
; ; GenericError				= 1
; ; InvalidParameter			= 2
; ; OutOfMemory				= 3
; ; ObjectBusy				= 4
; ; InsufficientBuffer		= 5
; ; NotImplemented			= 6
; ; Win32Error				= 7
; ; WrongState				= 8
; ; Aborted					= 9
; ; FileNotFound				= 10
; ; ValueOverflow				= 11
; ; AccessDenied				= 12
; ; UnknownImageFormat		= 13
; ; FontFamilyNotFound		= 14
; ; FontStyleNotFound			= 15
; ; NotTrueTypeFont			= 16
; ; UnsupportedGdiplusVersion	= 17
; ; GdiplusNotInitialized		= 18
; ; PropertyNotFound			= 19
; ; PropertyNotSupported		= 20
; ; ProfileNotFound			= 21
; ;
; ;#####################################################################################
; ;#####################################################################################
; ; FUNCTIONS
; ;#####################################################################################
; ;
; ; UpdateLayeredWindow(hwnd, hdc, x="", y="", w="", h="", Alpha=255)
; ; BitBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, Raster="")
; ; StretchBlt(dDC, dx, dy, dw, dh, sDC, sx, sy, sw, sh, Raster="")
; ; SetImage(hwnd, hBitmap)
; ; Gdip_BitmapFromScreen(Screen=0, Raster="")
; ; CreateRectF(ByRef RectF, x, y, w, h)
; ; CreateSizeF(ByRef SizeF, w, h)
; ; CreateDIBSection
; ;
; ;#####################################################################################

; ; Function:     			UpdateLayeredWindow
; ; Description:  			Updates a layered window with the handle to the DC of a gdi bitmap
; ; 
; ; hwnd        				Handle of the layered window to update
; ; hdc           			Handle to the DC of the GDI bitmap to update the window with
; ; Layeredx      			x position to place the window
; ; Layeredy      			y position to place the window
; ; Layeredw      			Width of the window
; ; Layeredh      			Height of the window
; ; Alpha         			Default = 255 : The transparency (0-255) to set the window transparency
; ;
; ; return      				If the function succeeds, the return value is nonzero
; ;
; ; notes						If x or y omitted, then layered window will use its current coordinates
; ;							If w or h omitted then current width and height will be used

; UpdateLayeredWindow(hwnd, hdc, x:="", y:="", w:="", h:="", Alpha:=255)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	if ((x != "") && (y != ""))
; 		VarSetStrCapacity(&pt, 8), NumPut("UInt", x, pt, 0), NumPut("UInt", y, pt, 4) ; V1toV2: if 'pt' is NOT a UTF-16 string, use 'pt := Buffer(8)'

; 	if (w = "") ||(h = "")
; 		WinGetPos(, , &w, &h, "ahk_id " hwnd)
	 
; 	return DllCall("UpdateLayeredWindow"					, Ptr, hwnd					, Ptr, 0					, Ptr, ((x = "") && (y = "")) ? 0 : &pt					, "int64*", w|h<<32					, Ptr, hdc					, "int64*", 0					, "UInt", 0					, "UInt*", Alpha<<16|1<<24					, "UInt", 2)
; }

; ;#####################################################################################

; ; Function				BitBlt
; ; Description			The BitBlt function performs a bit-block transfer of the color data corresponding to a rectangle 
; ;						of pixels from the specified source device context into a destination device context.
; ;
; ; dDC					handle to destination DC
; ; dx					x-coord of destination upper-left corner
; ; dy					y-coord of destination upper-left corner
; ; dw					width of the area to copy
; ; dh					height of the area to copy
; ; sDC					handle to source DC
; ; sx					x-coordinate of source upper-left corner
; ; sy					y-coordinate of source upper-left corner
; ; Raster				raster operation code
; ;
; ; return				If the function succeeds, the return value is nonzero
; ;
; ; notes					If no raster operation is specified, then SRCCOPY is used, which copies the source directly to the destination rectangle
; ;
; ; BLACKNESS				= 0x00000042
; ; NOTSRCERASE			= 0x001100A6
; ; NOTSRCCOPY			= 0x00330008
; ; SRCERASE				= 0x00440328
; ; DSTINVERT				= 0x00550009
; ; PATINVERT				= 0x005A0049
; ; SRCINVERT				= 0x00660046
; ; SRCAND				= 0x008800C6
; ; MERGEPAINT			= 0x00BB0226
; ; MERGECOPY				= 0x00C000CA
; ; SRCCOPY				= 0x00CC0020
; ; SRCPAINT				= 0x00EE0086
; ; PATCOPY				= 0x00F00021
; ; PATPAINT				= 0x00FB0A09
; ; WHITENESS				= 0x00FF0062
; ; CAPTUREBLT			= 0x40000000
; ; NOMIRRORBITMAP		= 0x80000000

; BitBlt(dDC, dx, dy, dw, dh, sDC, sx, sy, Raster:="")
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdi32\BitBlt"					, Ptr, dDC					, "Int", dx					, "Int", dy					, "Int", dw					, "Int", dh					, Ptr, sDC					, "Int", sx					, "Int", sy					, "UInt", Raster ? Raster : 0x00CC0020)
; }

; ;#####################################################################################

; ; Function				StretchBlt
; ; Description			The StretchBlt function copies a bitmap from a source rectangle into a destination rectangle, 
; ;						stretching or compressing the bitmap to fit the dimensions of the destination rectangle, if necessary.
; ;						The system stretches or compresses the bitmap according to the stretching mode currently set in the destination device context.
; ;
; ; ddc					handle to destination DC
; ; dx					x-coord of destination upper-left corner
; ; dy					y-coord of destination upper-left corner
; ; dw					width of destination rectangle
; ; dh					height of destination rectangle
; ; sdc					handle to source DC
; ; sx					x-coordinate of source upper-left corner
; ; sy					y-coordinate of source upper-left corner
; ; sw					width of source rectangle
; ; sh					height of source rectangle
; ; Raster				raster operation code
; ;
; ; return				If the function succeeds, the return value is nonzero
; ;
; ; notes					If no raster operation is specified, then SRCCOPY is used. It uses the same raster operations as BitBlt		

; StretchBlt(ddc, dx, dy, dw, dh, sdc, sx, sy, sw, sh, Raster:="")
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdi32\StretchBlt"					, Ptr, ddc					, "Int", dx					, "Int", dy					, "Int", dw					, "Int", dh					, Ptr, sdc					, "Int", sx					, "Int", sy					, "Int", sw					, "Int", sh					, "UInt", Raster ? Raster : 0x00CC0020)
; }

; ;#####################################################################################

; ; Function				SetStretchBltMode
; ; Description			The SetStretchBltMode function sets the bitmap stretching mode in the specified device context
; ;
; ; hdc					handle to the DC
; ; iStretchMode			The stretching mode, describing how the target will be stretched
; ;
; ; return				If the function succeeds, the return value is the previous stretching mode. If it fails it will return 0
; ;
; ; STRETCH_ANDSCANS 		= 0x01
; ; STRETCH_ORSCANS 		= 0x02
; ; STRETCH_DELETESCANS 	= 0x03
; ; STRETCH_HALFTONE 		= 0x04

; SetStretchBltMode(hdc, iStretchMode:=4)
; {
; 	return DllCall("gdi32\SetStretchBltMode"					, A_PtrSize ? "UPtr" : "UInt", hdc					, "Int", iStretchMode)
; }

; ;#####################################################################################

; ; Function				SetImage
; ; Description			Associates a new image with a static control
; ;
; ; hwnd					handle of the control to update
; ; hBitmap				a gdi bitmap to associate the static control with
; ;
; ; return				If the function succeeds, the return value is nonzero

; SetImage(hwnd, hBitmap)
; {
; 	ErrorLevel := SendMessage(0x172, 0x0, hBitmap, , "ahk_id " hwnd)
; 	E := ErrorLevel
; 	DeleteObject(E)
; 	return E
; }

; ;#####################################################################################

; ; Function				SetSysColorToControl
; ; Description			Sets a solid colour to a control
; ;
; ; hwnd					handle of the control to update
; ; SysColor				A system colour to set to the control
; ;
; ; return				If the function succeeds, the return value is zero
; ;
; ; notes					A control must have the 0xE style set to it so it is recognised as a bitmap
; ;						By default SysColor=15 is used which is COLOR_3DFACE. This is the standard background for a control
; ;
; ; COLOR_3DDKSHADOW				= 21
; ; COLOR_3DFACE					= 15
; ; COLOR_3DHIGHLIGHT				= 20
; ; COLOR_3DHILIGHT				= 20
; ; COLOR_3DLIGHT					= 22
; ; COLOR_3DSHADOW				= 16
; ; COLOR_ACTIVEBORDER			= 10
; ; COLOR_ACTIVECAPTION			= 2
; ; COLOR_APPWORKSPACE			= 12
; ; COLOR_BACKGROUND				= 1
; ; COLOR_BTNFACE					= 15
; ; COLOR_BTNHIGHLIGHT			= 20
; ; COLOR_BTNHILIGHT				= 20
; ; COLOR_BTNSHADOW				= 16
; ; COLOR_BTNTEXT					= 18
; ; COLOR_CAPTIONTEXT				= 9
; ; COLOR_DESKTOP					= 1
; ; COLOR_GRADIENTACTIVECAPTION	= 27
; ; COLOR_GRADIENTINACTIVECAPTION	= 28
; ; COLOR_GRAYTEXT				= 17
; ; COLOR_HIGHLIGHT				= 13
; ; COLOR_HIGHLIGHTTEXT			= 14
; ; COLOR_HOTLIGHT				= 26
; ; COLOR_INACTIVEBORDER			= 11
; ; COLOR_INACTIVECAPTION			= 3
; ; COLOR_INACTIVECAPTIONTEXT		= 19
; ; COLOR_INFOBK					= 24
; ; COLOR_INFOTEXT				= 23
; ; COLOR_MENU					= 4
; ; COLOR_MENUHILIGHT				= 29
; ; COLOR_MENUBAR					= 30
; ; COLOR_MENUTEXT				= 7
; ; COLOR_SCROLLBAR				= 0
; ; COLOR_WINDOW					= 5
; ; COLOR_WINDOWFRAME				= 6
; ; COLOR_WINDOWTEXT				= 8

; SetSysColorToControl(hwnd, SysColor:=15)
; {
;    WinGetPos(, , &w, &h, "ahk_id " hwnd)
;    bc := DllCall("GetSysColor", "Int", SysColor, "UInt")
;    pBrushClear := Gdip_BrushCreateSolid(0xff000000 | (bc >> 16 | bc & 0xff00 | (bc & 0xff) << 16))
;    pBitmap := Gdip_CreateBitmap(w, h), G := Gdip_GraphicsFromImage(pBitmap)
;    Gdip_FillRectangle(G, pBrushClear, 0, 0, w, h)
;    hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
;    SetImage(hwnd, hBitmap)
;    Gdip_DeleteBrush(pBrushClear)
;    Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmap), DeleteObject(hBitmap)
;    return 0
; }

; ;#####################################################################################

; ; Function				Gdip_BitmapFromScreen
; ; Description			Gets a gdi+ bitmap from the screen
; ;
; ; Screen				0 = All screens
; ;						Any numerical value = Just that screen
; ;						x|y|w|h = Take specific coordinates with a width and height
; ; Raster				raster operation code
; ;
; ; return      			If the function succeeds, the return value is a pointer to a gdi+ bitmap
; ;						-1:		one or more of x,y,w,h not passed properly
; ;
; ; notes					If no raster operation is specified, then SRCCOPY is used to the returned bitmap

; Gdip_BitmapFromScreen(Screen:=0, Raster:="")
; {
; 	if (Screen = 0)
; 	{
; 		x := SysGet(76)
; 		y := SysGet(77)
; 		w := SysGet(78)
; 		h := SysGet(79)
; 	}
; 	else if (SubStr(Screen, 1, 5) = "hwnd:")
; 	{
; 		Screen := SubStr(Screen, 6)
; 		if !WinExist( "ahk_id " Screen)
; 			return -2
; 		WinGetPos(, , &w, &h, "ahk_id " Screen)
; 		x := y := 0
; 		hhdc := GetDCEx(Screen, 3)
; 	}
; 	else if (Screen&1 != "")
; 	{
; 		MonitorGet(Screen, &MLeft, &MTop, &MRight, &MBottom)
; 		x := MLeft, y := MTop, w := MRight-MLeft, h := MBottom-MTop
; 	}
; 	else
; 	{
; 		; StringSplit, S, Screen, |
; 		S := StrSplit(Screen, |)
; 		x := S1, y := S2, w := S3, h := S4
; 	}

; 	if (x = "") || (y = "") || (w = "") || (h = "")
; 		return -1

; 	chdc := CreateCompatibleDC(), hbm := CreateDIBSection(w, h, chdc), obm := SelectObject(chdc, hbm), hhdc := hhdc ? hhdc : GetDC()
; 	BitBlt(chdc, 0, 0, w, h, hhdc, x, y, Raster)
; 	ReleaseDC(hhdc)
	
; 	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
; 	SelectObject(chdc, obm), DeleteObject(hbm), DeleteDC(hhdc), DeleteDC(chdc)
; 	return pBitmap
; }

; ;#####################################################################################

; ; Function				Gdip_BitmapFromHWND
; ; Description			Uses PrintWindow to get a handle to the specified window and return a bitmap from it
; ;
; ; hwnd					handle to the window to get a bitmap from
; ;
; ; return				If the function succeeds, the return value is a pointer to a gdi+ bitmap
; ;
; ; notes					Window must not be not minimised in order to get a handle to it's client area

; Gdip_BitmapFromHWND(hwnd)
; {
; 	WinGetPos(, , &Width, &Height, "ahk_id " hwnd)
; 	hbm := CreateDIBSection(Width, Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
; 	PrintWindow(hwnd, hdc)
; 	pBitmap := Gdip_CreateBitmapFromHBITMAP(hbm)
; 	SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
; 	return pBitmap
; }

; ;#####################################################################################

; ; Function    			CreateRectF
; ; Description			Creates a RectF object, containing a the coordinates and dimensions of a rectangle
; ;
; ; RectF       			Name to call the RectF object
; ; x            			x-coordinate of the upper left corner of the rectangle
; ; y            			y-coordinate of the upper left corner of the rectangle
; ; w            			Width of the rectangle
; ; h            			Height of the rectangle
; ;
; ; return      			No return value

; CreateRectF(&RectF, x, y, w, h)
; {
;    VarSetStrCapacity(&RectF, 16) ; V1toV2: if 'RectF' is NOT a UTF-16 string, use 'RectF := Buffer(16)'
;    NumPut("float", x, RectF, 0), NumPut("float", y, RectF, 4), NumPut("float", w, RectF, 8), NumPut("float", h, RectF, 12)
; }

; ;#####################################################################################

; ; Function    			CreateRect
; ; Description			Creates a Rect object, containing a the coordinates and dimensions of a rectangle
; ;
; ; RectF       			Name to call the RectF object
; ; x            			x-coordinate of the upper left corner of the rectangle
; ; y            			y-coordinate of the upper left corner of the rectangle
; ; w            			Width of the rectangle
; ; h            			Height of the rectangle
; ;
; ; return      			No return value

; CreateRect(&Rect, x, y, w, h)
; {
; 	VarSetStrCapacity(&Rect, 16) ; V1toV2: if 'Rect' is NOT a UTF-16 string, use 'Rect := Buffer(16)'
; 	NumPut("UInt", x, Rect, 0), NumPut("UInt", y, Rect, 4), NumPut("UInt", w, Rect, 8), NumPut("UInt", h, Rect, 12)
; }
; ;#####################################################################################

; ; Function		    	CreateSizeF
; ; Description			Creates a SizeF object, containing an 2 values
; ;
; ; SizeF         		Name to call the SizeF object
; ; w            			w-value for the SizeF object
; ; h            			h-value for the SizeF object
; ;
; ; return      			No Return value

; CreateSizeF(&SizeF, w, h)
; {
;    VarSetStrCapacity(&SizeF, 8) ; V1toV2: if 'SizeF' is NOT a UTF-16 string, use 'SizeF := Buffer(8)'
;    NumPut("float", w, SizeF, 0), NumPut("float", h, SizeF, 4)     
; }
; ;#####################################################################################

; ; Function		    	CreatePointF
; ; Description			Creates a SizeF object, containing an 2 values
; ;
; ; SizeF         		Name to call the SizeF object
; ; w            			w-value for the SizeF object
; ; h            			h-value for the SizeF object
; ;
; ; return      			No Return value

; CreatePointF(&PointF, x, y)
; {
;    VarSetStrCapacity(&PointF, 8) ; V1toV2: if 'PointF' is NOT a UTF-16 string, use 'PointF := Buffer(8)'
;    NumPut("float", x, PointF, 0), NumPut("float", y, PointF, 4)     
; }
; ;{#####################################################################################

; ; Function				CreateDIBSection
; ; Description			The CreateDIBSection function creates a DIB (Device Independent Bitmap) that applications can write to directly
; ;
; ; w						width of the bitmap to create
; ; h						height of the bitmap to create
; ; hdc					a handle to the device context to use the palette from
; ; bpp					bits per pixel (32 = ARGB)
; ; ppvBits				A pointer to a variable that receives a pointer to the location of the DIB bit values
; ;
; ; return				returns a DIB. A gdi bitmap
; ;
; ; notes					ppvBits will receive the location of the pixels in the DIB
; ;}
; CreateDIBSection(w, h, hdc:="", bpp:=32, &ppvBits:=0)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	hdc2 := hdc ? hdc : GetDC()
; 	bi := Buffer(40, 0) ; V1toV2: if 'bi' is a UTF-16 string, use 'VarSetStrCapacity(&bi, 40)'
	
; 	NumPut("UInt", w, bi, 4)	, NumPut("UInt", h, bi, 8)	, NumPut("UInt", 40, bi, 0)	, NumPut("ushort", 1, bi, 12)	, NumPut("UInt", 0, bi, 16)	, NumPut("ushort", bpp, bi, 14)
	
; 	hbm := DllCall("CreateDIBSection"					, Ptr, hdc2					, Ptr, &bi					, "UInt", 0					, A_PtrSize ? "UPtr*" : "uint*", ppvBits					, Ptr, 0					, "UInt", 0, Ptr)

; 	if !hdc
; 		ReleaseDC(hdc2)
; 	return hbm
; }

; ;{#####################################################################################

; ; Function				PrintWindow
; ; Description			The PrintWindow function copies a visual window into the specified device context (DC), typically a printer DC
; ;
; ; hwnd					A handle to the window that will be copied
; ; hdc					A handle to the device context
; ; Flags					Drawing options
; ;
; ; return				If the function succeeds, it returns a nonzero value
; ;
; ; PW_CLIENTONLY			= 1
; ;}
; PrintWindow(hwnd, hdc, Flags:=0)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("PrintWindow", "Ptr", hwnd, "Ptr", hdc, "UInt", Flags)
; }

; ;{#####################################################################################

; ; Function				DestroyIcon
; ; Description			Destroys an icon and frees any memory the icon occupied
; ;
; ; hIcon					Handle to the icon to be destroyed. The icon must not be in use
; ;
; ; return				If the function succeeds, the return value is nonzero
; ;}
; DestroyIcon(hIcon)
; {
; 	return DllCall("DestroyIcon", A_PtrSize ? "UPtr" : "UInt", hIcon)
; }

; ;#####################################################################################

; PaintDesktop(hdc)
; {
; 	return DllCall("PaintDesktop", A_PtrSize ? "UPtr" : "UInt", hdc)
; }

; ;#####################################################################################

; CreateCompatibleBitmap(hdc, w, h)
; {
; 	return DllCall("gdi32\CreateCompatibleBitmap", A_PtrSize ? "UPtr" : "UInt", hdc, "Int", w, "Int", h)
; }

; ;{#####################################################################################

; ; Function				CreateCompatibleDC
; ; Description			This function creates a memory device context (DC) compatible with the specified device
; ;
; ; hdc					Handle to an existing device context					
; ;
; ; return				returns the handle to a device context or 0 on failure
; ;
; ; notes					If this handle is 0 (by default), the function creates a memory device context compatible with the application's current screen
; ;}
; CreateCompatibleDC(hdc:=0)
; {
;    return DllCall("CreateCompatibleDC", A_PtrSize ? "UPtr" : "UInt", hdc)
; }

; ;{#####################################################################################

; ; Function				SelectObject
; ; Description			The SelectObject function selects an object into the specified device context (DC). The new object replaces the previous object of the same type
; ;
; ; hdc					Handle to a DC
; ; hgdiobj				A handle to the object to be selected into the DC
; ;
; ; return				If the selected object is not a region and the function succeeds, the return value is a handle to the object being replaced
; ;
; ; notes					The specified object must have been created by using one of the following functions
; ;						Bitmap - CreateBitmap, CreateBitmapIndirect, CreateCompatibleBitmap, CreateDIBitmap, CreateDIBSection (A single bitmap cannot be selected into more than one DC at the same time)
; ;						Brush - CreateBrushIndirect, CreateDIBPatternBrush, CreateDIBPatternBrushPt, CreateHatchBrush, CreatePatternBrush, CreateSolidBrush
; ;						Font - CreateFont, CreateFontIndirect
; ;						Pen - CreatePen, CreatePenIndirect
; ;						Region - CombineRgn, CreateEllipticRgn, CreateEllipticRgnIndirect, CreatePolygonRgn, CreateRectRgn, CreateRectRgnIndirect
; ;
; ; notes					If the selected object is a region and the function succeeds, the return value is one of the following value
; ;
; ; SIMPLEREGION			= 2 Region consists of a single rectangle
; ; COMPLEXREGION			= 3 Region consists of more than one rectangle
; ; NULLREGION			= 1 Region is empty
; ;}
; SelectObject(hdc, hgdiobj)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("SelectObject", "Ptr", hdc, "Ptr", hgdiobj)
; }

; ;{#####################################################################################

; ; Function				DeleteObject
; ; Description			This function deletes a logical pen, brush, font, bitmap, region, or palette, freeing all system resources associated with the object
; ;						After the object is deleted, the specified handle is no longer valid
; ;
; ; hObject				Handle to a logical pen, brush, font, bitmap, region, or palette to delete
; ;
; ; return				Nonzero indicates success. Zero indicates that the specified handle is not valid or that the handle is currently selected into a device context
; ;}
; DeleteObject(hObject)
; {
;    return DllCall("DeleteObject", A_PtrSize ? "UPtr" : "UInt", hObject)
; }

; ;{#####################################################################################

; ; Function				GetDC
; ; Description			This function retrieves a handle to a display device context (DC) for the client area of the specified window.
; ;						The display device context can be used in subsequent graphics display interface (GDI) functions to draw in the client area of the window. 
; ;
; ; hwnd					Handle to the window whose device context is to be retrieved. If this value is NULL, GetDC retrieves the device context for the entire screen					
; ;
; ; return				The handle the device context for the specified window's client area indicates success. NULL indicates failure
; ;}
; GetDC(hwnd:=0)
; {
; 	return DllCall("GetDC", A_PtrSize ? "UPtr" : "UInt", hwnd)
; }

; ;{#####################################################################################

; ; DCX_CACHE = 0x2
; ; DCX_CLIPCHILDREN = 0x8
; ; DCX_CLIPSIBLINGS = 0x10
; ; DCX_EXCLUDERGN = 0x40
; ; DCX_EXCLUDEUPDATE = 0x100
; ; DCX_INTERSECTRGN = 0x80
; ; DCX_INTERSECTUPDATE = 0x200
; ; DCX_LOCKWINDOWUPDATE = 0x400
; ; DCX_NORECOMPUTE = 0x100000
; ; DCX_NORESETATTRS = 0x4
; ; DCX_PARENTCLIP = 0x20
; ; DCX_VALIDATE = 0x200000
; ; DCX_WINDOW = 0x1
; ;}
; GetDCEx(hwnd, flags:=0, hrgnClip:=0)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
;     return DllCall("GetDCEx", "Ptr", hwnd, "Ptr", hrgnClip, "Int", flags)
; }

; ;{#####################################################################################

; ; Function				ReleaseDC
; ; Description			This function releases a device context (DC), freeing it for use by other applications. The effect of ReleaseDC depends on the type of device context
; ;
; ; hdc					Handle to the device context to be released
; ; hwnd					Handle to the window whose device context is to be released
; ;
; ; return				1 = released
; ;						0 = not released
; ;
; ; notes					The application must call the ReleaseDC function for each call to the GetWindowDC function and for each call to the GetDC function that retrieves a common device context
; ;						An application cannot use the ReleaseDC function to release a device context that was created by calling the CreateDC function; instead, it must use the DeleteDC function. 
; ;}
; ReleaseDC(hdc, hwnd:=0)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("ReleaseDC", "Ptr", hwnd, "Ptr", hdc)
; }

; ;{#####################################################################################

; ; Function				DeleteDC
; ; Description			The DeleteDC function deletes the specified device context (DC)
; ;
; ; hdc					A handle to the device context
; ;
; ; return				If the function succeeds, the return value is nonzero
; ;
; ; notes					An application must not delete a DC whose handle was obtained by calling the GetDC function. Instead, it must call the ReleaseDC function to free the DC
; ;}
; DeleteDC(hdc)
; {
;    return DllCall("DeleteDC", A_PtrSize ? "UPtr" : "UInt", hdc)
; }
; ;{#####################################################################################

; ; Function				Gdip_LibraryVersion
; ; Description			Get the current library version
; ;
; ; return				the library version
; ;
; ; notes					This is useful for non compiled programs to ensure that a person doesn't run an old version when testing your scripts
; ;}
; Gdip_LibraryVersion()
; {
; 	return 1.45
; }

; ;{#####################################################################################

; ; Function				Gdip_LibrarySubVersion
; ; Description			Get the current library sub version
; ;
; ; return				the library sub version
; ;
; ; notes					This is the sub-version currently maintained by Rseding91
; ;}
; Gdip_LibrarySubVersion()
; {
; 	return 1.47
; }

; ;{#####################################################################################

; ; Function:    			Gdip_BitmapFromBRA
; ; Description: 			Gets a pointer to a gdi+ bitmap from a BRA file
; ;
; ; BRAFromMemIn			The variable for a BRA file read to memory
; ; File					The name of the file, or its number that you would like (This depends on alternate parameter)
; ; Alternate				Changes whether the File parameter is the file name or its number
; ;
; ; return      			If the function succeeds, the return value is a pointer to a gdi+ bitmap
; ;						-1 = The BRA variable is empty
; ;						-2 = The BRA has an incorrect header
; ;						-3 = The BRA has information missing
; ;						-4 = Could not find file inside the BRA
; ;}
; Gdip_BitmapFromBRA(&BRAFromMemIn, File, Alternate:=0)
; {
; 	Static FName := "ObjRelease"
	
; 	if !BRAFromMemIn
; 		return -1
; 	Loop Parse, BRAFromMemIn, "`n"
; 	{
; 		if (A_Index = 1)
; 		{
; 			;StringSplit, Header, A_LoopField, |
; 			Header := StrSplit( A_LoopField, "|" )
; 			if (Header0 != 4 || Header2 != "BRA!")
; 				return -2
; 		}
; 		else if (A_Index = 2)
; 		{
; 			Info := StrSplit( A_LoopField, "|" )
; 			if (Info0 != 3)
; 				return -3
; 		}
; 		else
; 			break
; 	}
; 	if !Alternate
; 		StrReplace(File, File, "\", , &"\\", All)
; 	RegExMatch(BRAFromMemIn, "mi`n)^" (Alternate ? File "\|.+?\|(\d+)\|(\d+)" : "\d+\|" File "\|(\d+)\|(\d+)") "$", &FileInfo)
; 	if !FileInfo[0]
; 		return -4
	
; 	hData := DllCall("GlobalAlloc", "UInt", 2, "Ptr", FileInfo[2], "Ptr")
; 	pData := DllCall("GlobalLock", "Ptr", hData, "Ptr")
; 	DllCall("RtlMoveMemory", "Ptr", pData, "Ptr", BRAFromMemIn+Info2+FileInfo[1], "Ptr", FileInfo[2])
; 	DllCall("GlobalUnlock", "Ptr", hData)
; 	DllCall("ole32\CreateStreamOnHGlobal", "Ptr", hData, "Int", 1, A_PtrSize ? "UPtr*" : "UInt*", &pStream)
; 	DllCall("gdiplus\GdipCreateBitmapFromStream", "Ptr", pStream, A_PtrSize ? "UPtr*" : "UInt*", &pBitmap)
; 	If (A_PtrSize)
; 		%FName%(pStream)
; 	Else
; 		DllCall(NumGet(NumGet(pStream*1, "UPtr")+8, "UPtr"), "UInt", pStream)
; 	return pBitmap
; }

; ;{#####################################################################################

; ; Function				Gdip_DrawRectangle
; ; Description			This function uses a pen to draw the outline of a rectangle into the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pPen					Pointer to a pen
; ; x						x-coordinate of the top left of the rectangle
; ; y						y-coordinate of the top left of the rectangle
; ; w						width of the rectanlge
; ; h						height of the rectangle
; ;
; ; return				status enumeration. 0 = success
; ;
; ; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width
; ;}
; Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdiplus\GdipDrawRectangle", "Ptr", pGraphics, "Ptr", pPen, "float", x, "float", y, "float", w, "float", h)
; }

; ;{#####################################################################################

; ; Function				Gdip_DrawRoundedRectangle
; ; Description			This function uses a pen to draw the outline of a rounded rectangle into the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pPen					Pointer to a pen
; ; x						x-coordinate of the top left of the rounded rectangle
; ; y						y-coordinate of the top left of the rounded rectangle
; ; w						width of the rectanlge
; ; h						height of the rectangle
; ; r						radius of the rounded corners
; ;
; ; return				status enumeration. 0 = success
; ;
; ; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width
; ;}
; Gdip_DrawRoundedRectangle(pGraphics, pPen, x, y, w, h, r)
; {
; 	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
; 	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
; 	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
; 	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
; 	E := Gdip_DrawRectangle(pGraphics, pPen, x, y, w, h)
; 	Gdip_ResetClip(pGraphics)
; 	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
; 	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
; 	Gdip_DrawEllipse(pGraphics, pPen, x, y, 2*r, 2*r)
; 	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y, 2*r, 2*r)
; 	Gdip_DrawEllipse(pGraphics, pPen, x, y+h-(2*r), 2*r, 2*r)
; 	Gdip_DrawEllipse(pGraphics, pPen, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
; 	Gdip_ResetClip(pGraphics)
; 	return E
; }

; ;{#####################################################################################

; ; Function				Gdip_DrawEllipse
; ; Description			This function uses a pen to draw the outline of an ellipse into the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pPen					Pointer to a pen
; ; x						x-coordinate of the top left of the rectangle the ellipse will be drawn into
; ; y						y-coordinate of the top left of the rectangle the ellipse will be drawn into
; ; w						width of the ellipse
; ; h						height of the ellipse
; ;
; ; return				status enumeration. 0 = success
; ;
; ; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width
; ;}
; Gdip_DrawEllipse(pGraphics, pPen, x, y, w, h)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdiplus\GdipDrawEllipse", "Ptr", pGraphics, "Ptr", pPen, "float", x, "float", y, "float", w, "float", h)
; }

; ;{#####################################################################################

; ; Function				Gdip_DrawBezier
; ; Description			This function uses a pen to draw the outline of a bezier (a weighted curve) into the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pPen					Pointer to a pen
; ; x1					x-coordinate of the start of the bezier
; ; y1					y-coordinate of the start of the bezier
; ; x2					x-coordinate of the first arc of the bezier
; ; y2					y-coordinate of the first arc of the bezier
; ; x3					x-coordinate of the second arc of the bezier
; ; y3					y-coordinate of the second arc of the bezier
; ; x4					x-coordinate of the end of the bezier
; ; y4					y-coordinate of the end of the bezier
; ;
; ; return				status enumeration. 0 = success
; ;
; ; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width
; ;}
; Gdip_DrawBezier(pGraphics, pPen, x1, y1, x2, y2, x3, y3, x4, y4)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdiplus\GdipDrawBezier"					, Ptr, pGraphics					, Ptr, pPen					, "float", x1					, "float", y1					, "float", x2					, "float", y2					, "float", x3					, "float", y3					, "float", x4					, "float", y4)
; }

; ;{#####################################################################################

; ; Function				Gdip_DrawArc
; ; Description			This function uses a pen to draw the outline of an arc into the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pPen					Pointer to a pen
; ; x						x-coordinate of the start of the arc
; ; y						y-coordinate of the start of the arc
; ; w						width of the arc
; ; h						height of the arc
; ; StartAngle			specifies the angle between the x-axis and the starting point of the arc
; ; SweepAngle			specifies the angle between the starting and ending points of the arc
; ;
; ; return				status enumeration. 0 = success
; ;
; ; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width
; ;}
; Gdip_DrawArc(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdiplus\GdipDrawArc"					, Ptr, pGraphics					, Ptr, pPen					, "float", x					, "float", y					, "float", w					, "float", h					, "float", StartAngle					, "float", SweepAngle)
; }

; ;{#####################################################################################

; ; Function				Gdip_DrawPie
; ; Description			This function uses a pen to draw the outline of a pie into the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pPen					Pointer to a pen
; ; x						x-coordinate of the start of the pie
; ; y						y-coordinate of the start of the pie
; ; w						width of the pie
; ; h						height of the pie
; ; StartAngle			specifies the angle between the x-axis and the starting point of the pie
; ; SweepAngle			specifies the angle between the starting and ending points of the pie
; ;
; ; return				status enumeration. 0 = success
; ;
; ; notes					as all coordinates are taken from the top left of each pixel, then the entire width/height should be specified as subtracting the pen width
; ;}
; Gdip_DrawPie(pGraphics, pPen, x, y, w, h, StartAngle, SweepAngle)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdiplus\GdipDrawPie", "Ptr", pGraphics, "Ptr", pPen, "float", x, "float", y, "float", w, "float", h, "float", StartAngle, "float", SweepAngle)
; }

; ;{#####################################################################################

; ; Function				Gdip_DrawLine
; ; Description			This function uses a pen to draw a line into the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pPen					Pointer to a pen
; ; x1					x-coordinate of the start of the line
; ; y1					y-coordinate of the start of the line
; ; x2					x-coordinate of the end of the line
; ; y2					y-coordinate of the end of the line
; ;
; ; return				status enumeration. 0 = success		
; ;}
; Gdip_DrawLine(pGraphics, pPen, x1, y1, x2, y2)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdiplus\GdipDrawLine"					, Ptr, pGraphics					, Ptr, pPen					, "float", x1					, "float", y1					, "float", x2					, "float", y2)
; }

; ;{#####################################################################################

; ; Function				Gdip_DrawLines
; ; Description			This function uses a pen to draw a series of joined lines into the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pPen					Pointer to a pen
; ; Points				the coordinates of all the points passed as x1,y1|x2,y2|x3,y3.....
; ;
; ; return				status enumeration. 0 = success				
; ;}
; Gdip_DrawLines(pGraphics, pPen, Points)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
; 	Points := StrSplit(Points, "|" )
; 	VarSetStrCapacity(&PointF, 8*Points0)    ; V1toV2: if 'PointF' is NOT a UTF-16 string, use 'PointF := Buffer(8*Points0)'
; 	Loop Points0
; 	{
; 		Coord := StrSplit( Points%A_Index%, `)
; 		NumPut("float", Coord1, PointF, 8*(A_Index-1)), NumPut("float", Coord2, PointF, (8*(A_Index-1))+4)
; 	}
; 	return DllCall("gdiplus\GdipDrawLines", "Ptr", pGraphics, "Ptr", pPen, "Ptr", PointF, "Int", Points0)
; }

; ;{#####################################################################################

; ; Function				Gdip_FillRectangle
; ; Description			This function uses a brush to fill a rectangle in the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pBrush				Pointer to a brush
; ; x						x-coordinate of the top left of the rectangle
; ; y						y-coordinate of the top left of the rectangle
; ; w						width of the rectanlge
; ; h						height of the rectangle
; ;
; ; return				status enumeration. 0 = success
; ;}
; Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdiplus\GdipFillRectangle"					, Ptr, pGraphics					, Ptr, pBrush					, "float", x					, "float", y					, "float", w					, "float", h)
; }

; ;{#####################################################################################

; ; Function				Gdip_FillRoundedRectangle
; ; Description			This function uses a brush to fill a rounded rectangle in the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pBrush				Pointer to a brush
; ; x						x-coordinate of the top left of the rounded rectangle
; ; y						y-coordinate of the top left of the rounded rectangle
; ; w						width of the rectanlge
; ; h						height of the rectangle
; ; r						radius of the rounded corners
; ;
; ; return				status enumeration. 0 = success
; ;}
; Gdip_FillRoundedRectangle(pGraphics, pBrush, x, y, w, h, r)
; {
; 	Region := Gdip_GetClipRegion(pGraphics)
; 	Gdip_SetClipRect(pGraphics, x-r, y-r, 2*r, 2*r, 4)
; 	Gdip_SetClipRect(pGraphics, x+w-r, y-r, 2*r, 2*r, 4)
; 	Gdip_SetClipRect(pGraphics, x-r, y+h-r, 2*r, 2*r, 4)
; 	Gdip_SetClipRect(pGraphics, x+w-r, y+h-r, 2*r, 2*r, 4)
; 	E := Gdip_FillRectangle(pGraphics, pBrush, x, y, w, h)
; 	Gdip_SetClipRegion(pGraphics, Region, 0)
; 	Gdip_SetClipRegion(pGraphics, Region, 0)
; 	Gdip_SetClipRect(pGraphics, x-(2*r), y+r, w+(4*r), h-(2*r), 4)
; 	Gdip_SetClipRect(pGraphics, x+r, y-(2*r), w-(2*r), h+(4*r), 4)
; 	Gdip_FillEllipse(pGraphics, pBrush, x, y, 2*r, 2*r)
; 	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y, 2*r, 2*r)
; 	Gdip_FillEllipse(pGraphics, pBrush, x, y+h-(2*r), 2*r, 2*r)
; 	Gdip_FillEllipse(pGraphics, pBrush, x+w-(2*r), y+h-(2*r), 2*r, 2*r)
; 	Gdip_SetClipRegion(pGraphics, Region, 0)
; 	Gdip_DeleteRegion(Region)
; 	return E
; }

; ;{#####################################################################################

; ; Function				Gdip_FillPolygon
; ; Description			This function uses a brush to fill a polygon in the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pBrush				Pointer to a brush
; ; Points				the coordinates of all the points passed as x1,y1|x2,y2|x3,y3.....
; ;
; ; return				status enumeration. 0 = success
; ;
; ; notes					Alternate will fill the polygon as a whole, wheras winding will fill each new "segment"
; ; Alternate 			= 0
; ; Winding 				= 1
; ;}
; Gdip_FillPolygon(pGraphics, pBrush, Points, FillMode:=0)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	Points := StrSplit(Points, "|" )
; 	VarSetStrCapacity(&PointF, 8*Points0)    ; V1toV2: if 'PointF' is NOT a UTF-16 string, use 'PointF := Buffer(8*Points0)'
; 	Loop Points0
; 	{
; 		Coord := StrSplit( Points%A_Index%, `)
; 		NumPut("float", Coord1, PointF, 8*(A_Index-1)), NumPut("float", Coord2, PointF, (8*(A_Index-1))+4)
; 	}   
; 	return DllCall("gdiplus\GdipFillPolygon", "Ptr", pGraphics, "Ptr", pBrush, "Ptr", PointF, "Int", Points0, "Int", FillMode)
; }

; ;{#####################################################################################

; ; Function				Gdip_FillPie
; ; Description			This function uses a brush to fill a pie in the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pBrush				Pointer to a brush
; ; x						x-coordinate of the top left of the pie
; ; y						y-coordinate of the top left of the pie
; ; w						width of the pie
; ; h						height of the pie
; ; StartAngle			specifies the angle between the x-axis and the starting point of the pie
; ; SweepAngle			specifies the angle between the starting and ending points of the pie
; ;
; ; return				status enumeration. 0 = success
; ;}
; Gdip_FillPie(pGraphics, pBrush, x, y, w, h, StartAngle, SweepAngle)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdiplus\GdipFillPie"					, Ptr, pGraphics					, Ptr, pBrush					, "float", x					, "float", y					, "float", w					, "float", h					, "float", StartAngle					, "float", SweepAngle)
; }

; ;{#####################################################################################

; ; Function				Gdip_FillEllipse
; ; Description			This function uses a brush to fill an ellipse in the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pBrush				Pointer to a brush
; ; x						x-coordinate of the top left of the ellipse
; ; y						y-coordinate of the top left of the ellipse
; ; w						width of the ellipse
; ; h						height of the ellipse
; ;
; ; return				status enumeration. 0 = success
; ;}
; Gdip_FillEllipse(pGraphics, pBrush, x, y, w, h)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdiplus\GdipFillEllipse", "Ptr", pGraphics, "Ptr", pBrush, "float", x, "float", y, "float", w, "float", h)
; }

; ;{#####################################################################################

; ; Function				Gdip_FillRegion
; ; Description			This function uses a brush to fill a region in the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pBrush				Pointer to a brush
; ; Region				Pointer to a Region
; ;
; ; return				status enumeration. 0 = success
; ;
; ; notes					You can create a region Gdip_CreateRegion() and then add to this
; ;}
; Gdip_FillRegion(pGraphics, pBrush, Region)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdiplus\GdipFillRegion", "Ptr", pGraphics, "Ptr", pBrush, "Ptr", Region)
; }

; ;{#####################################################################################

; ; Function				Gdip_FillPath
; ; Description			This function uses a brush to fill a path in the Graphics of a bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pBrush				Pointer to a brush
; ; Region				Pointer to a Path
; ;
; ; return				status enumeration. 0 = success
; ;}
; Gdip_FillPath(pGraphics, pBrush, Path)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdiplus\GdipFillPath", "Ptr", pGraphics, "Ptr", pBrush, "Ptr", Path)
; }

; ;{#####################################################################################

; ; Function				Gdip_DrawImagePointsRect
; ; Description			This function draws a bitmap into the Graphics of another bitmap and skews it
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pBitmap				Pointer to a bitmap to be drawn
; ; Points				Points passed as x1,y1|x2,y2|x3,y3 (3 points: top left, top right, bottom left) describing the drawing of the bitmap
; ; sx					x-coordinate of source upper-left corner
; ; sy					y-coordinate of source upper-left corner
; ; sw					width of source rectangle
; ; sh					height of source rectangle
; ; Matrix				a matrix used to alter image attributes when drawing
; ;
; ; return				status enumeration. 0 = success
; ;
; ; notes					if sx,sy,sw,sh are missed then the entire source bitmap will be used
; ;						Matrix can be omitted to just draw with no alteration to ARGB
; ;						Matrix may be passed as a digit from 0 - 1 to change just transparency
; ;						Matrix can be passed as a matrix with any delimiter
; ;}
; Gdip_DrawImagePointsRect(pGraphics, pBitmap, Points, sx:="", sy:="", sw:="", sh:="", Matrix:=1)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	Points := StrSplit(Points, "|" )
; 	VarSetStrCapacity(&PointF, 8*Points0)    ; V1toV2: if 'PointF' is NOT a UTF-16 string, use 'PointF := Buffer(8*Points0)'
; 	Loop Points0
; 	{
; 		Coord := StrSplit( Points%A_Index%, `)
; 		NumPut("float", Coord1, PointF, 8*(A_Index-1)), NumPut("float", Coord2, PointF, (8*(A_Index-1))+4)
; 	}

; 	if (Matrix&1 = "")
; 		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
; 	else if (Matrix != 1)
; 		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")
		
; 	if (sx = "" && sy = "" && sw = "" && sh = "")
; 	{
; 		sx := 0, sy := 0
; 		sw := Gdip_GetImageWidth(pBitmap)
; 		sh := Gdip_GetImageHeight(pBitmap)
; 	}

; 	E := DllCall("gdiplus\GdipDrawImagePointsRect"				, Ptr, pGraphics				, Ptr, pBitmap				, Ptr, &PointF				, "Int", Points0				, "float", sx				, "float", sy				, "float", sw				, "float", sh				, "Int", 2				, Ptr, ImageAttr				, Ptr, 0				, Ptr, 0)
; 	if ImageAttr
; 		Gdip_DisposeImageAttributes(ImageAttr)
; 	return E
; }

; ;{#####################################################################################

; ; Function				Gdip_DrawImage
; ; Description			This function draws a bitmap into the Graphics of another bitmap
; ;
; ; pGraphics				Pointer to the Graphics of a bitmap
; ; pBitmap				Pointer to a bitmap to be drawn
; ; dx					x-coord of destination upper-left corner
; ; dy					y-coord of destination upper-left corner
; ; dw					width of destination image
; ; dh					height of destination image
; ; sx					x-coordinate of source upper-left corner
; ; sy					y-coordinate of source upper-left corner
; ; sw					width of source image
; ; sh					height of source image
; ; Matrix				a matrix used to alter image attributes when drawing
; ;
; ; return				status enumeration. 0 = success
; ;
; ; notes					if sx,sy,sw,sh are missed then the entire source bitmap will be used
; ;						Gdip_DrawImage performs faster
; ;						Matrix can be omitted to just draw with no alteration to ARGB
; ;						Matrix may be passed as a digit from 0 - 1 to change just transparency
; ;						Matrix can be passed as a matrix with any delimiter. For example:
; ;						MatrixBright=
; ;						(
; ;						1.5		|0		|0		|0		|0
; ;						0		|1.5	|0		|0		|0
; ;						0		|0		|1.5	|0		|0
; ;						0		|0		|0		|1		|0
; ;						0.05	|0.05	|0.05	|0		|1
; ;						)
; ;
; ; notes					MatrixBright = 1.5|0|0|0|0|0|1.5|0|0|0|0|0|1.5|0|0|0|0|0|1|0|0.05|0.05|0.05|0|1
; ;						MatrixGreyScale = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
; ;						MatrixNegative = -1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|0|0|0|0|1
; ;}
; Gdip_DrawImage(pGraphics, pBitmap, dx:="", dy:="", dw:="", dh:="", sx:="", sy:="", sw:="", sh:="", Matrix:=1)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	if (Matrix&1 = "")
; 		ImageAttr := Gdip_SetImageAttributesColorMatrix(Matrix)
; 	else if (Matrix != 1)
; 		ImageAttr := Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")

; 	if (sx = "" && sy = "" && sw = "" && sh = "")
; 	{
; 		if (dx = "" && dy = "" && dw = "" && dh = "")
; 		{
; 			sx := dx := 0, sy := dy := 0
; 			sw := dw := Gdip_GetImageWidth(pBitmap)
; 			sh := dh := Gdip_GetImageHeight(pBitmap)
; 		}
; 		else
; 		{
; 			sx := sy := 0
; 			sw := Gdip_GetImageWidth(pBitmap)
; 			sh := Gdip_GetImageHeight(pBitmap)
; 		}
; 	}

; 	E := DllCall("gdiplus\GdipDrawImageRectRect"				, Ptr, pGraphics				, Ptr, pBitmap				, "float", dx				, "float", dy				, "float", dw				, "float", dh				, "float", sx				, "float", sy				, "float", sw				, "float", sh				, "Int", 2				, Ptr, ImageAttr				, Ptr, 0				, Ptr, 0)
; 	if ImageAttr
; 		Gdip_DisposeImageAttributes(ImageAttr)
; 	return E
; }

; ;{#####################################################################################

; ; Function				Gdip_SetImageAttributesColorMatrix
; ; Description			This function creates an image matrix ready for drawing
; ;
; ; Matrix				a matrix used to alter image attributes when drawing
; ;						passed with any delimeter
; ;
; ; return				returns an image matrix on sucess or 0 if it fails
; ;
; ; notes					MatrixBright = 1.5|0|0|0|0|0|1.5|0|0|0|0|0|1.5|0|0|0|0|0|1|0|0.05|0.05|0.05|0|1
; ;						MatrixGreyScale = 0.299|0.299|0.299|0|0|0.587|0.587|0.587|0|0|0.114|0.114|0.114|0|0|0|0|0|1|0|0|0|0|0|1
; ;						MatrixNegative = -1|0|0|0|0|0|-1|0|0|0|0|0|-1|0|0|0|0|0|1|0|0|0|0|0|1
; ;}
; Gdip_SetImageAttributesColorMatrix(Matrix)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	ColourMatrix := Buffer(100, 0) ; V1toV2: if 'ColourMatrix' is a UTF-16 string, use 'VarSetStrCapacity(&ColourMatrix, 100)'
; 	Matrix := RegExReplace(RegExReplace(Matrix, "^[^\d-\.]+([\d\.])", "$1", &"", 1), "[^\d-\.]+", "|")
; 	Matrix := StrSplit(Matrix, "|" )
; 	Loop 25
; 	{
; 		Matrix := (Matrix%A_Index% != "") ? Matrix%A_Index% : Mod(A_Index-1, 6) ? 0 : 1
; 		NumPut("float", Matrix, ColourMatrix, (A_Index-1)*4)
; 	}
; 	DllCall("gdiplus\GdipCreateImageAttributes", A_PtrSize ? "UPtr*" : "uint*", &ImageAttr)
; 	DllCall("gdiplus\GdipSetImageAttributesColorMatrix", "Ptr", ImageAttr, "Int", 1, "Int", 1, "Ptr", ColourMatrix, "Ptr", 0, "Int", 0)
; 	return ImageAttr
; }

; ;{#####################################################################################

; ; Function				Gdip_GraphicsFromImage
; ; Description			This function gets the graphics for a bitmap used for drawing functions
; ;
; ; pBitmap				Pointer to a bitmap to get the pointer to its graphics
; ;
; ; return				returns a pointer to the graphics of a bitmap
; ;
; ; notes					a bitmap can be drawn into the graphics of another bitmap
; ;}
; Gdip_GraphicsFromImage(pBitmap)
; {
; 	DllCall("gdiplus\GdipGetImageGraphicsContext", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", &pGraphics)
; 	return pGraphics
; }

; ;{#####################################################################################

; ; Function				Gdip_GraphicsFromHDC
; ; Description			This function gets the graphics from the handle to a device context
; ;
; ; hdc					This is the handle to the device context
; ;
; ; return				returns a pointer to the graphics of a bitmap
; ;
; ; notes					You can draw a bitmap into the graphics of another bitmap
; ;}
; Gdip_GraphicsFromHDC(hdc)
; {
;     DllCall("gdiplus\GdipCreateFromHDC", A_PtrSize ? "UPtr" : "UInt", hdc, A_PtrSize ? "UPtr*" : "UInt*", &pGraphics)
;     return pGraphics
; }

; ;{#####################################################################################

; ; Function				Gdip_GetDC
; ; Description			This function gets the device context of the passed Graphics
; ;
; ; hdc					This is the handle to the device context
; ;
; ; return				returns the device context for the graphics of a bitmap
; ;}
; Gdip_GetDC(pGraphics)
; {
; 	DllCall("gdiplus\GdipGetDC", A_PtrSize ? "UPtr" : "UInt", pGraphics, A_PtrSize ? "UPtr*" : "UInt*", &hdc)
; 	return hdc
; }

; ;{#####################################################################################

; ; Function				Gdip_ReleaseDC
; ; Description			This function releases a device context from use for further use
; ;
; ; pGraphics				Pointer to the graphics of a bitmap
; ; hdc					This is the handle to the device context
; ;
; ; return				status enumeration. 0 = success
; ;}
; Gdip_ReleaseDC(pGraphics, hdc)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdiplus\GdipReleaseDC", "Ptr", pGraphics, "Ptr", hdc)
; }

; ;{#####################################################################################

; ; Function				Gdip_GraphicsClear
; ; Description			Clears the graphics of a bitmap ready for further drawing
; ;
; ; pGraphics				Pointer to the graphics of a bitmap
; ; ARGB					The colour to clear the graphics to
; ;
; ; return				status enumeration. 0 = success
; ;
; ; notes					By default this will make the background invisible
; ;						Using clipping regions you can clear a particular area on the graphics rather than clearing the entire graphics
; ;}
; Gdip_GraphicsClear(pGraphics, ARGB:=0x00ffffff)
; {
;     return DllCall("gdiplus\GdipGraphicsClear", A_PtrSize ? "UPtr" : "UInt", pGraphics, "Int", ARGB)
; }

; ;{#####################################################################################

; ; Function				Gdip_BlurBitmap
; ; Description			Gives a pointer to a blurred bitmap from a pointer to a bitmap
; ;
; ; pBitmap				Pointer to a bitmap to be blurred
; ; Blur					The Amount to blur a bitmap by from 1 (least blur) to 100 (most blur)
; ;
; ; return				If the function succeeds, the return value is a pointer to the new blurred bitmap
; ;						-1 = The blur parameter is outside the range 1-100
; ;
; ; notes					This function will not dispose of the original bitmap
; ;}
; Gdip_BlurBitmap(pBitmap, Blur)
; {
; 	if (Blur > 100) || (Blur < 1)
; 		return -1	
	
; 	sWidth := Gdip_GetImageWidth(pBitmap), sHeight := Gdip_GetImageHeight(pBitmap)
; 	dWidth := sWidth//Blur, dHeight := sHeight//Blur

; 	pBitmap1 := Gdip_CreateBitmap(dWidth, dHeight)
; 	G1 := Gdip_GraphicsFromImage(pBitmap1)
; 	Gdip_SetInterpolationMode(G1, 7)
; 	Gdip_DrawImage(G1, pBitmap, 0, 0, dWidth, dHeight, 0, 0, sWidth, sHeight)

; 	Gdip_DeleteGraphics(G1)

; 	pBitmap2 := Gdip_CreateBitmap(sWidth, sHeight)
; 	G2 := Gdip_GraphicsFromImage(pBitmap2)
; 	Gdip_SetInterpolationMode(G2, 7)
; 	Gdip_DrawImage(G2, pBitmap1, 0, 0, sWidth, sHeight, 0, 0, dWidth, dHeight)

; 	Gdip_DeleteGraphics(G2)
; 	Gdip_DisposeImage(pBitmap1)
; 	return pBitmap2
; }

; ;{#####################################################################################

; ; Function:     		Gdip_SaveBitmapToFile
; ; Description:  		Saves a bitmap to a file in any supported format onto disk
; ;   
; ; pBitmap				Pointer to a bitmap
; ; sOutput      			The name of the file that the bitmap will be saved to. Supported extensions are: .BMP,.DIB,.RLE,.JPG,.JPEG,.JPE,.JFIF,.GIF,.TIF,.TIFF,.PNG
; ; Quality      			If saving as jpg (.JPG,.JPEG,.JPE,.JFIF) then quality can be 1-100 with default at maximum quality
; ;
; ; return      			If the function succeeds, the return value is zero, otherwise:
; ;						-1 = Extension supplied is not a supported file format
; ;						-2 = Could not get a list of encoders on system
; ;						-3 = Could not find matching encoder for specified file format
; ;						-4 = Could not get WideChar name of output file
; ;						-5 = Could not save file to disk
; ;
; ; notes					This function will use the extension supplied from the sOutput parameter to determine the output format
; ;}
; Gdip_SaveBitmapToFile(pBitmap, sOutput, Quality:=75)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	SplitPath(sOutput, , , &Extension)
; 	if !(Extension ~= "^(?i:BMP|DIB|RLE|JPG|JPEG|JPE|JFIF|GIF|TIF TIFF|PNG)$")
; 		return -1
; 	Extension := "." Extension

; 	DllCall("gdiplus\GdipGetImageEncodersSize", "uint*", &nCount, "uint*", &nSize)
; 	VarSetStrCapacity(&ci, nSize) ; V1toV2: if 'ci' is NOT a UTF-16 string, use 'ci := Buffer(nSize)'
; 	DllCall("gdiplus\GdipGetImageEncoders", "UInt", nCount, "UInt", nSize, "Ptr", ci)
; 	if !(nCount && nSize)
; 		return -2
	
; 	If (1){
; 		StrGet_Name := "StrGet"
; 		Loop nCount
; 		{
; 			sString := %StrGet_Name%(NumGet(ci, (idx := (48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize, "UPtr"), "UTF-16")
; 			if !InStr(sString, "*" Extension)
; 				continue
			
; 			pCodec := &ci+idx
; 			break
; 		}
; 	} else {
; 		Loop nCount
; 		{
; 			Location := NumGet(ci, 76*(A_Index-1)+44)
; 			nSize := DllCall("WideCharToMultiByte", "UInt", 0, "UInt", 0, "UInt", Location, "Int", -1, "UInt", 0, "Int", 0, "UInt", 0, "UInt", 0)
; 			VarSetStrCapacity(&sString, nSize) ; V1toV2: if 'sString' is NOT a UTF-16 string, use 'sString := Buffer(nSize)'
; 			DllCall("WideCharToMultiByte", "UInt", 0, "UInt", 0, "UInt", Location, "Int", -1, "str", sString, "Int", nSize, "UInt", 0, "UInt", 0)
; 			if !InStr(sString, "*" Extension)
; 				continue
			
; 			pCodec := &ci+76*(A_Index-1)
; 			break
; 		}
; 	}
	
; 	if !pCodec
; 		return -3

; 	if (Quality != 75)
; 	{
; 		Quality := (Quality < 0) ? 0 : (Quality > 100) ? 100 : Quality
; 		if (Extension ~= "^(?i:\.JPG|\.JPEG|\.JPE|\.JFIF)$")
; 		{
; 			DllCall("gdiplus\GdipGetEncoderParameterListSize", "Ptr", pBitmap, "Ptr", pCodec, "uint*", &nSize)
; 			EncoderParameters := Buffer(nSize, 0) ; V1toV2: if 'EncoderParameters' is a UTF-16 string, use 'VarSetStrCapacity(&EncoderParameters, nSize)'
; 			DllCall("gdiplus\GdipGetEncoderParameterList", "Ptr", pBitmap, "Ptr", pCodec, "UInt", nSize, "Ptr", EncoderParameters)
; 			Loop NumGet(EncoderParameters, "UInt")      ;%
; 			{
; 				elem := (24+(A_PtrSize ? A_PtrSize : 4))*(A_Index-1) + 4 + (pad := A_PtrSize = 8 ? 4 : 0)
; 				if (NumGet(EncoderParameters, elem+16, "UInt") = 1) && (NumGet(EncoderParameters, elem+20, "UInt") = 6)
; 				{
; 					p := elem+&EncoderParameters-pad-4
; 					NumPut(NumGet(NumPut(NumPut("UPtr", 1, p+0)+20), "UPtr"))
; 					break
; 				}
; 			}      
; 		}
; 	}

; 	if (!1)
; 	{
; 		nSize := DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "Ptr", sOutput, "Int", -1, "Ptr", 0, "Int", 0)
; 		VarSetStrCapacity(&wOutput, nSize*2) ; V1toV2: if 'wOutput' is NOT a UTF-16 string, use 'wOutput := Buffer(nSize*2)'
; 		DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "Ptr", sOutput, "Int", -1, "Ptr", wOutput, "Int", nSize)
; 		VarSetStrCapacity(&wOutput, -1) ; V1toV2: if 'wOutput' is NOT a UTF-16 string, use 'wOutput := Buffer(-1)'
; 		if !VarSetStrCapacity(&wOutput) ; V1toV2: if 'wOutput' is NOT a UTF-16 string, use 'wOutput := Buffer()'
; 			return -4
; 		E := DllCall("gdiplus\GdipSaveImageToFile", "Ptr", pBitmap, "Ptr", wOutput, "Ptr", pCodec, "UInt", p ? p : 0)
; 	}
; 	else
; 		E := DllCall("gdiplus\GdipSaveImageToFile", "Ptr", pBitmap, "Ptr", sOutput, "Ptr", pCodec, "UInt", p ? p : 0)
; 	return E ? -5 : 0
; }

; ;{#####################################################################################

; ; Function				Gdip_GetPixel
; ; Description			Gets the ARGB of a pixel in a bitmap
; ;
; ; pBitmap				Pointer to a bitmap
; ; x						x-coordinate of the pixel
; ; y						y-coordinate of the pixel
; ;
; ; return				Returns the ARGB value of the pixel
; ;}
; Gdip_GetPixel(pBitmap, x, y)
; {
; 	DllCall("gdiplus\GdipBitmapGetPixel", A_PtrSize ? "UPtr" : "UInt", pBitmap, "Int", x, "Int", y, "uint*", &ARGB)
; 	return ARGB
; }

; ;{#####################################################################################

; ; Function				Gdip_SetPixel
; ; Description			Sets the ARGB of a pixel in a bitmap
; ;
; ; pBitmap				Pointer to a bitmap
; ; x						x-coordinate of the pixel
; ; y						y-coordinate of the pixel
; ;
; ; return				status enumeration. 0 = success
; ;}
; Gdip_SetPixel(pBitmap, x, y, ARGB)
; {
;    return DllCall("gdiplus\GdipBitmapSetPixel", A_PtrSize ? "UPtr" : "UInt", pBitmap, "Int", x, "Int", y, "Int", ARGB)
; }

; ;{#####################################################################################

; ; Function				Gdip_GetImageWidth
; ; Description			Gives the width of a bitmap
; ;
; ; pBitmap				Pointer to a bitmap
; ;
; ; return				Returns the width in pixels of the supplied bitmap

; Gdip_GetImageWidth(pBitmap)
; {
;    DllCall("gdiplus\GdipGetImageWidth", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", &Width)
;    return Width
; }

; ;{#####################################################################################

; ; Function				Gdip_GetImageHeight
; ; Description			Gives the height of a bitmap
; ;
; ; pBitmap				Pointer to a bitmap
; ;
; ; return				Returns the height in pixels of the supplied bitmap

; Gdip_GetImageHeight(pBitmap)
; {
;    DllCall("gdiplus\GdipGetImageHeight", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", &Height)
;    return Height
; }

; ;{#####################################################################################

; ; Function				Gdip_GetDimensions
; ; Description			Gives the width and height of a bitmap
; ;
; ; pBitmap				Pointer to a bitmap
; ; Width					ByRef variable. This variable will be set to the width of the bitmap
; ; Height				ByRef variable. This variable will be set to the height of the bitmap
; ;
; ; return				No return value
; ;						Gdip_GetDimensions(pBitmap, ThisWidth, ThisHeight) will set ThisWidth to the width and ThisHeight to the height

; Gdip_GetImageDimensions(pBitmap, &Width, &Height)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
; 	DllCall("gdiplus\GdipGetImageWidth", "Ptr", pBitmap, "uint*", &Width)
; 	DllCall("gdiplus\GdipGetImageHeight", "Ptr", pBitmap, "uint*", &Height)
; }

; ;#####################################################################################

; Gdip_GetDimensions(pBitmap, &Width, &Height)
; {
; 	Gdip_GetImageDimensions(pBitmap, Width, Height)
; }

; ;#####################################################################################

; Gdip_GetImagePixelFormat(pBitmap)
; {
; 	DllCall("gdiplus\GdipGetImagePixelFormat", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "UInt*", &Format)
; 	return Format
; }

; ;#####################################################################################

; ; Function				Gdip_GetDpiX
; ; Description			Gives the horizontal dots per inch of the graphics of a bitmap
; ;
; ; pBitmap				Pointer to a bitmap
; ; Width					ByRef variable. This variable will be set to the width of the bitmap
; ; Height				ByRef variable. This variable will be set to the height of the bitmap
; ;
; ; return				No return value
; ;						Gdip_GetDimensions(pBitmap, ThisWidth, ThisHeight) will set ThisWidth to the width and ThisHeight to the height

; Gdip_GetDpiX(pGraphics)
; {
; 	DllCall("gdiplus\GdipGetDpiX", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float*", &dpix)
; 	return Round(dpix)
; }

; ;#####################################################################################

; Gdip_GetDpiY(pGraphics)
; {
; 	DllCall("gdiplus\GdipGetDpiY", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float*", &dpiy)
; 	return Round(dpiy)
; }

; ;#####################################################################################
; Gdip_GetImageHorizontalResolution(pBitmap)
; {
; 	DllCall("gdiplus\GdipGetImageHorizontalResolution", A_PtrSize ? "UPtr" : "UInt", pBitmap, "float*", &dpix)
; 	return Round(dpix)
; }
; ;#####################################################################################
; Gdip_GetImageVerticalResolution(pBitmap)
; {
; 	DllCall("gdiplus\GdipGetImageVerticalResolution", A_PtrSize ? "UPtr" : "UInt", pBitmap, "float*", &dpiy)
; 	return Round(dpiy)
; }
; ;#####################################################################################
; Gdip_BitmapSetResolution(pBitmap, dpix, dpiy)
; {
; 	return DllCall("gdiplus\GdipBitmapSetResolution", A_PtrSize ? "UPtr" : "UInt", pBitmap, "float", dpix, "float", dpiy)
; }
; ;#####################################################################################
; Gdip_CreateBitmapFromFile(sFile, IconNumber:=1, IconSize:="")
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"	, PtrA := A_PtrSize ? "UPtr*" : "UInt*"
	
; 	SplitPath(sFile, , , &ext)
; 	if (ext ~= "^(?i:exe|dll)$")
; 	{
; 		Sizes := IconSize ? IconSize : 256 "|" 128 "|" 64 "|" 48 "|" 32 "|" 16
; 		BufSize := 16 + (2*(A_PtrSize ? A_PtrSize : 4))
		
; 		buf := Buffer(BufSize, 0) ; V1toV2: if 'buf' is a UTF-16 string, use 'VarSetStrCapacity(&buf, BufSize)'
; 		Loop Parse, Sizes, "|"
; 		{
; 			DllCall("PrivateExtractIcons", "str", sFile, "Int", IconNumber-1, "Int", A_LoopField, "Int", A_LoopField, PtrA, hIcon, PtrA, 0, "UInt", 1, "UInt", 0)
			
; 			if !hIcon
; 				continue

; 			if !DllCall("GetIconInfo", "Ptr", hIcon, "Ptr", buf)
; 			{
; 				DestroyIcon(hIcon)
; 				continue
; 			}
			
; 			hbmMask  := NumGet(buf, 12 + ((A_PtrSize ? A_PtrSize : 4) - 4), "UPtr")
; 			hbmColor := NumGet(buf, 12 + ((A_PtrSize ? A_PtrSize : 4) - 4) + (A_PtrSize ? A_PtrSize : 4), "UPtr")
; 			if !(hbmColor && DllCall("GetObject", "Ptr", hbmColor, "Int", BufSize, "Ptr", buf))
; 			{
; 				DestroyIcon(hIcon)
; 				continue
; 			}
; 			break
; 		}
; 		if !hIcon
; 			return -1

; 		Width := NumGet(buf, 4, "Int"), Height := NumGet(buf, 8, "Int")
; 		hbm := CreateDIBSection(Width, -Height), hdc := CreateCompatibleDC(), obm := SelectObject(hdc, hbm)
; 		if !DllCall("DrawIconEx", "Ptr", hdc, "Int", 0, "Int", 0, "Ptr", hIcon, "UInt", Width, "UInt", Height, "UInt", 0, "Ptr", 0, "UInt", 3)
; 		{
; 			DestroyIcon(hIcon)
; 			return -2
; 		}
		
; 		VarSetStrCapacity(&dib, 104) ; V1toV2: if 'dib' is NOT a UTF-16 string, use 'dib := Buffer(104)'
; 		DllCall("GetObject", "Ptr", hbm, "Int", A_PtrSize = 8 ? 104 : 84, "Ptr", dib) ; sizeof(DIBSECTION) = 76+2*(A_PtrSize=8?4:0)+2*A_PtrSize
; 		Stride := NumGet(dib, 12, "Int"), Bits := NumGet(dib, 20 + (A_PtrSize = 8 ? 4 : 0), "UPtr") ; padding
; 		DllCall("gdiplus\GdipCreateBitmapFromScan0", "Int", Width, "Int", Height, "Int", Stride, "Int", 0x26200A, "Ptr", Bits, PtrA, pBitmapOld)
; 		pBitmap := Gdip_CreateBitmap(Width, Height)
; 		G := Gdip_GraphicsFromImage(pBitmap)		, Gdip_DrawImage(G, pBitmapOld, 0, 0, Width, Height, 0, 0, Width, Height)
; 		SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
; 		Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmapOld)
; 		DestroyIcon(hIcon)
; 	}
; 	else
; 	{
; 		if (!1)
; 		{
; 			VarSetStrCapacity(&wFile, 1024) ; V1toV2: if 'wFile' is NOT a UTF-16 string, use 'wFile := Buffer(1024)'
; 			DllCall("kernel32\MultiByteToWideChar", "UInt", 0, "UInt", 0, "Ptr", sFile, "Int", -1, "Ptr", wFile, "Int", 512)
; 			DllCall("gdiplus\GdipCreateBitmapFromFile", "Ptr", wFile, PtrA, pBitmap)
; 		}
; 		else
; 			DllCall("gdiplus\GdipCreateBitmapFromFile", "Ptr", sFile, PtrA, pBitmap)
; 	}
	
; 	return pBitmap
; }
; ;#####################################################################################
; Gdip_CreateBitmapFromHBITMAP(hBitmap, Palette:=0)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "Ptr", hBitmap, "Ptr", Palette, A_PtrSize ? "UPtr*" : "uint*", &pBitmap)
; 	return pBitmap
; }
; ;#####################################################################################
; Gdip_CreateHBITMAPFromBitmap(pBitmap, Background:=0xffffffff)
; {
; 	DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", &hbm, "Int", Background)
; 	return hbm
; }
; ;#####################################################################################
; Gdip_CreateBitmapFromHICON(hIcon)
; {
; 	DllCall("gdiplus\GdipCreateBitmapFromHICON", A_PtrSize ? "UPtr" : "UInt", hIcon, A_PtrSize ? "UPtr*" : "uint*", &pBitmap)
; 	return pBitmap
; }
; ;#####################################################################################
; Gdip_CreateHICONFromBitmap(pBitmap)
; {
; 	DllCall("gdiplus\GdipCreateHICONFromBitmap", A_PtrSize ? "UPtr" : "UInt", pBitmap, A_PtrSize ? "UPtr*" : "uint*", &hIcon)
; 	return hIcon
; }
; ;#####################################################################################
; Gdip_CreateBitmap(Width, Height, Format:=0x26200A)
; {
;     DllCall("gdiplus\GdipCreateBitmapFromScan0", "Int", Width, "Int", Height, "Int", 0, "Int", Format, A_PtrSize ? "UPtr" : "UInt", 0, A_PtrSize ? "UPtr*" : "uint*", &pBitmap)
;     Return pBitmap
; }
; ;#####################################################################################
; Gdip_CreateBitmapFromClipboard()
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	if !DllCall("OpenClipboard", "Ptr", 0)
; 		return -1
; 	if !DllCall("IsClipboardFormatAvailable", "UInt", 8)
; 		return -2
; 	if !hBitmap := DllCall("GetClipboardData", "UInt", 2, "Ptr")
; 		return -3
; 	if !pBitmap := Gdip_CreateBitmapFromHBITMAP(hBitmap)
; 		return -4
; 	if !DllCall("CloseClipboard")
; 		return -5
; 	DeleteObject(hBitmap)
; 	return pBitmap
; }
; ;#####################################################################################
; Gdip_SetBitmapToClipboard(pBitmap)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
; 	off1 := A_PtrSize = 8 ? 52 : 44, off2 := A_PtrSize = 8 ? 32 : 24
; 	hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
; 	DllCall("GetObject", "Ptr", hBitmap, "Int", oi := Buffer(A_PtrSize = 8 ? 104 : 84, 0), "Ptr", oi) ; V1toV2: if 'oi' is a UTF-16 string, use 'VarSetStrCapacity(&oi, A_PtrSize = 8 ? 104 : 84)'
; 	hdib := DllCall("GlobalAlloc", "UInt", 2, "Ptr", 40+NumGet(oi, off1, "UInt"), "Ptr")
; 	pdib := DllCall("GlobalLock", "Ptr", hdib, "Ptr")
; 	DllCall("RtlMoveMemory", "Ptr", pdib, "Ptr", oi+off2, "Ptr", 40)
; 	DllCall("RtlMoveMemory", "Ptr", pdib+40, "Ptr", NumGet(oi, off2 - (A_PtrSize ? A_PtrSize : 4), Ptr), "Ptr", NumGet(oi, off1, "UInt"))
; 	DllCall("GlobalUnlock", "Ptr", hdib)
; 	DllCall("DeleteObject", "Ptr", hBitmap)
; 	DllCall("OpenClipboard", "Ptr", 0)
; 	DllCall("EmptyClipboard")
; 	DllCall("SetClipboardData", "UInt", 8, "Ptr", hdib)
; 	DllCall("CloseClipboard")
; }
; ;#####################################################################################
; Gdip_CloneBitmapArea(pBitmap, x, y, w, h, Format:=0x26200A)
; {
; 	DllCall("gdiplus\GdipCloneBitmapArea"					, "float", x					, "float", y					, "float", w					, "float", h					, "Int", Format					, A_PtrSize ? "UPtr" : "UInt", pBitmap					, A_PtrSize ? "UPtr*" : "UInt*", pBitmapDest)
; 	return pBitmapDest
; }
; ;#####################################################################################
; ; Create resources
; ;#####################################################################################
; Gdip_CreatePen(ARGB, w)
; {
;    DllCall("gdiplus\GdipCreatePen1", "UInt", ARGB, "float", w, "Int", 2, A_PtrSize ? "UPtr*" : "UInt*", &pPen)
;    return pPen
; }
; ;#####################################################################################
; Gdip_CreatePenFromBrush(pBrush, w)
; {
; 	DllCall("gdiplus\GdipCreatePen2", A_PtrSize ? "UPtr" : "UInt", pBrush, "float", w, "Int", 2, A_PtrSize ? "UPtr*" : "UInt*", &pPen)
; 	return pPen
; }
; ;#####################################################################################
; Gdip_BrushCreateSolid(ARGB:=0xff000000)
; {
; 	DllCall("gdiplus\GdipCreateSolidFill", "UInt", ARGB, A_PtrSize ? "UPtr*" : "UInt*", &pBrush)
; 	return pBrush
; }
; ;{#####################################################################################

; ; HatchStyleHorizontal = 0
; ; HatchStyleVertical = 1
; ; HatchStyleForwardDiagonal = 2
; ; HatchStyleBackwardDiagonal = 3
; ; HatchStyleCross = 4
; ; HatchStyleDiagonalCross = 5
; ; HatchStyle05Percent = 6
; ; HatchStyle10Percent = 7
; ; HatchStyle20Percent = 8
; ; HatchStyle25Percent = 9
; ; HatchStyle30Percent = 10
; ; HatchStyle40Percent = 11
; ; HatchStyle50Percent = 12
; ; HatchStyle60Percent = 13
; ; HatchStyle70Percent = 14
; ; HatchStyle75Percent = 15
; ; HatchStyle80Percent = 16
; ; HatchStyle90Percent = 17
; ; HatchStyleLightDownwardDiagonal = 18
; ; HatchStyleLightUpwardDiagonal = 19
; ; HatchStyleDarkDownwardDiagonal = 20
; ; HatchStyleDarkUpwardDiagonal = 21
; ; HatchStyleWideDownwardDiagonal = 22
; ; HatchStyleWideUpwardDiagonal = 23
; ; HatchStyleLightVertical = 24
; ; HatchStyleLightHorizontal = 25
; ; HatchStyleNarrowVertical = 26
; ; HatchStyleNarrowHorizontal = 27
; ; HatchStyleDarkVertical = 28
; ; HatchStyleDarkHorizontal = 29
; ; HatchStyleDashedDownwardDiagonal = 30
; ; HatchStyleDashedUpwardDiagonal = 31
; ; HatchStyleDashedHorizontal = 32
; ; HatchStyleDashedVertical = 33
; ; HatchStyleSmallConfetti = 34
; ; HatchStyleLargeConfetti = 35
; ; HatchStyleZigZag = 36
; ; HatchStyleWave = 37
; ; HatchStyleDiagonalBrick = 38
; ; HatchStyleHorizontalBrick = 39
; ; HatchStyleWeave = 40
; ; HatchStylePlaid = 41
; ; HatchStyleDivot = 42
; ; HatchStyleDottedGrid = 43
; ; HatchStyleDottedDiamond = 44
; ; HatchStyleShingle = 45
; ; HatchStyleTrellis = 46
; ; HatchStyleSphere = 47
; ; HatchStyleSmallGrid = 48
; ; HatchStyleSmallCheckerBoard = 49
; ; HatchStyleLargeCheckerBoard = 50
; ; HatchStyleOutlinedDiamond = 51
; ; HatchStyleSolidDiamond = 52
; ; HatchStyleTotal = 53
; ;}
; Gdip_BrushCreateHatch(ARGBfront, ARGBback, HatchStyle:=0)
; {
; 	DllCall("gdiplus\GdipCreateHatchBrush", "Int", HatchStyle, "UInt", ARGBfront, "UInt", ARGBback, A_PtrSize ? "UPtr*" : "UInt*", &pBrush)
; 	return pBrush
; }
; ;#####################################################################################
; Gdip_CreateTextureBrush(pBitmap, WrapMode:=1, x:=0, y:=0, w:="", h:="")
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"	, PtrA := A_PtrSize ? "UPtr*" : "UInt*"
	
; 	if !(w && h)
; 		DllCall("gdiplus\GdipCreateTexture", "Ptr", pBitmap, "Int", WrapMode, PtrA, pBrush)
; 	else
; 		DllCall("gdiplus\GdipCreateTexture2", "Ptr", pBitmap, "Int", WrapMode, "float", x, "float", y, "float", w, "float", h, PtrA, pBrush)
; 	return pBrush
; }
; ;{#####################################################################################

; ; WrapModeTile = 0
; ; WrapModeTileFlipX = 1
; ; WrapModeTileFlipY = 2
; ; WrapModeTileFlipXY = 3
; ; WrapModeClamp = 4
; ;}
; Gdip_CreateLineBrush(x1, y1, x2, y2, ARGB1, ARGB2, WrapMode:=1)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	CreatePointF(PointF1, x1, y1), CreatePointF(PointF2, x2, y2)
; 	DllCall("gdiplus\GdipCreateLineBrush", "Ptr", PointF1, "Ptr", PointF2, "UInt", ARGB1, "UInt", ARGB2, "Int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", &LGpBrush)
; 	return LGpBrush
; }
; ;{#####################################################################################

; ; LinearGradientModeHorizontal = 0
; ; LinearGradientModeVertical = 1
; ; LinearGradientModeForwardDiagonal = 2
; ; LinearGradientModeBackwardDiagonal = 3
; ;}
; Gdip_CreateLineBrushFromRect(x, y, w, h, ARGB1, ARGB2, LinearGradientMode:=1, WrapMode:=1)
; {
; 	CreateRectF(RectF, x, y, w, h)
; 	DllCall("gdiplus\GdipCreateLineBrushFromRect", A_PtrSize ? "UPtr" : "UInt", RectF, "Int", ARGB1, "Int", ARGB2, "Int", LinearGradientMode, "Int", WrapMode, A_PtrSize ? "UPtr*" : "UInt*", &LGpBrush)
; 	return LGpBrush
; }
; ;#####################################################################################
; Gdip_CloneBrush(pBrush)
; {
; 	DllCall("gdiplus\GdipCloneBrush", A_PtrSize ? "UPtr" : "UInt", pBrush, A_PtrSize ? "UPtr*" : "UInt*", &pBrushClone)
; 	return pBrushClone
; }

; ;#####################################################################################
; ; Delete resources
; ;#####################################################################################
; Gdip_DeletePen(pPen)
; {
;    return DllCall("gdiplus\GdipDeletePen", A_PtrSize ? "UPtr" : "UInt", pPen)
; }
; ;#####################################################################################
; Gdip_DeleteBrush(pBrush)
; {
;    return DllCall("gdiplus\GdipDeleteBrush", A_PtrSize ? "UPtr" : "UInt", pBrush)
; }
; ;#####################################################################################
; Gdip_DisposeImage(pBitmap)
; {
;    return DllCall("gdiplus\GdipDisposeImage", A_PtrSize ? "UPtr" : "UInt", pBitmap)
; }
; ;#####################################################################################
; Gdip_DeleteGraphics(pGraphics)
; {
;    return DllCall("gdiplus\GdipDeleteGraphics", A_PtrSize ? "UPtr" : "UInt", pGraphics)
; }
; ;#####################################################################################
; Gdip_DisposeImageAttributes(ImageAttr)
; {
; 	return DllCall("gdiplus\GdipDisposeImageAttributes", A_PtrSize ? "UPtr" : "UInt", ImageAttr)
; }
; ;#####################################################################################
; Gdip_DeleteFont(hFont)
; {
;    return DllCall("gdiplus\GdipDeleteFont", A_PtrSize ? "UPtr" : "UInt", hFont)
; }
; ;#####################################################################################
; Gdip_DeleteStringFormat(hFormat)
; {
;    return DllCall("gdiplus\GdipDeleteStringFormat", A_PtrSize ? "UPtr" : "UInt", hFormat)
; }
; ;#####################################################################################
; Gdip_DeleteFontFamily(hFamily)
; {
;    return DllCall("gdiplus\GdipDeleteFontFamily", A_PtrSize ? "UPtr" : "UInt", hFamily)
; }
; ;#####################################################################################
; Gdip_DeleteMatrix(Matrix)
; {
;    return DllCall("gdiplus\GdipDeleteMatrix", A_PtrSize ? "UPtr" : "UInt", Matrix)
; }
; ;#####################################################################################
; ; Text functions
; ;#####################################################################################

; Gdip_TextToGraphics(pGraphics, Text, Options, Font:="Arial", Width:="", Height:="", Measure:=0)
; {
; 	IWidth := Width, IHeight:= Height
	
; 	RegExMatch(Options, "i)X([\-\d\.]+)(p*)", &xpos)
; 	RegExMatch(Options, "i)Y([\-\d\.]+)(p*)", &ypos)
; 	RegExMatch(Options, "i)W([\-\d\.]+)(p*)", &Width)
; 	RegExMatch(Options, "i)H([\-\d\.]+)(p*)", &Height)
; 	RegExMatch(Options, "i)C(?!(entre|enter))([a-f\d]+)", &Colour)
; 	RegExMatch(Options, "i)Top|Up|Bottom|Down|vCentre|vCenter", &vPos)
; 	RegExMatch(Options, "i)NoWrap[0]", &NoWrap)
; 	RegExMatch(Options, "i)R(\d)", &Rendering)
; 	RegExMatch(Options, "i)S(\d+)(p*)", &Size)

; 	if !Gdip_DeleteBrush(Gdip_CloneBrush(Colour[2]))
; 		PassBrush := 1, pBrush := Colour[2]
	
; 	if !(IWidth && IHeight) && (xpos[2] || ypos[2] || Width[2] || Height[2] || Size[2])
; 		return -1

; 	Style := 0, Styles := "Regular|Bold|Italic|BoldItalic|Underline|Strikeout"
; 	Loop Parse, Styles, "|"
; 	{
; 		if RegExMatch(Options, "\b" A_loopField)
; 		Style |= (A_LoopField != "StrikeOut") ? (A_Index-1) : 8
; 	}
	
; 	Align := 0, Alignments := "Near|Left|Centre|Center|Far|Right"
; 	Loop Parse, Alignments, "|"
; 	{
; 		if RegExMatch(Options, "\b" A_loopField)
; 			Align |= A_Index//2.1      ; 0|0|1|1|2|2
; 	}

; 	xpos := (xpos[1] != "") ? xpos[2] ? IWidth*(xpos[1]/100) : xpos[1] : 0
; 	ypos := (ypos[1] != "") ? ypos[2] ? IHeight*(ypos[1]/100) : ypos[1] : 0
; 	Width := Width[1] ? Width[2] ? IWidth*(Width[1]/100) : Width[1] : IWidth
; 	Height := Height[1] ? Height[2] ? IHeight*(Height[1]/100) : Height[1] : IHeight
; 	if !PassBrush
; 		Colour := "0x" (Colour[2] ? Colour[2] : "ff000000")
; 	Rendering := ((Rendering[1] >= 0) && (Rendering[1] <= 5)) ? Rendering[1] : 4
; 	Size := (Size[1] > 0) ? Size[2] ? IHeight*(Size[1]/100) : Size[1] : 12

; 	hFamily := Gdip_FontFamilyCreate(Font)
; 	hFont := Gdip_FontCreate(hFamily, Size[0], Style)
; 	FormatStyle := NoWrap[0] ? 0x4000 | 0x1000 : 0x4000
; 	hFormat := Gdip_StringFormatCreate(FormatStyle)
; 	pBrush := PassBrush ? pBrush : Gdip_BrushCreateSolid(Colour[0])
; 	if !(hFamily && hFont && hFormat && pBrush && pGraphics)
; 		return !pGraphics ? -2 : !hFamily ? -3 : !hFont ? -4 : !hFormat ? -5 : !pBrush ? -6 : 0
	 
; 	CreateRectF(RC, xpos[0], ypos[0], Width[0], Height[0])
; 	Gdip_SetStringFormatAlign(hFormat, Align)
; 	Gdip_SetTextRenderingHint(pGraphics, Rendering[0])
; 	ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)

; 	if vPos[0]
; 	{
; 		ReturnRC := StrSplit(ReturnRC, "|")
		
; 		if (vPos[0] = "vCentre") || (vPos[0] = "vCenter")
; 			ypos[0] += (Height[0]-ReturnRC4)//2
; 		else if (vPos[0] = "Top") || (vPos[0] = "Up")
; 			ypos := 0
; 		else if (vPos[0] = "Bottom") || (vPos[0] = "Down")
; 			ypos := Height[0]-ReturnRC4
		
; 		CreateRectF(RC, xpos[0], ypos[0], Width[0], ReturnRC4)
; 		ReturnRC := Gdip_MeasureString(pGraphics, Text, hFont, hFormat, RC)
; 	}

; 	if !Measure
; 		E := Gdip_DrawString(pGraphics, Text, hFont, hFormat, pBrush, RC)

; 	if !PassBrush
; 		Gdip_DeleteBrush(pBrush)
; 	Gdip_DeleteStringFormat(hFormat)   
; 	Gdip_DeleteFont(hFont)
; 	Gdip_DeleteFontFamily(hFamily)
; 	return E ? E : ReturnRC
; }

; ;#####################################################################################

; Gdip_DrawString(pGraphics, sString, hFont, hFormat, pBrush, &RectF)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	if (!1)
; 	{
; 		nSize := DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "Ptr", sString, "Int", -1, "Ptr", 0, "Int", 0)
; 		VarSetStrCapacity(&wString, nSize*2) ; V1toV2: if 'wString' is NOT a UTF-16 string, use 'wString := Buffer(nSize*2)'
; 		DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "Ptr", sString, "Int", -1, "Ptr", wString, "Int", nSize)
; 	}
	
; 	return DllCall("gdiplus\GdipDrawString"					, Ptr, pGraphics					, Ptr, 1 ? &sString : &wString					, "Int", -1					, Ptr, hFont					, Ptr, &RectF					, Ptr, hFormat					, Ptr, pBrush)
; }

; ;#####################################################################################

; Gdip_MeasureString(pGraphics, sString, hFont, hFormat, &RectF)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	VarSetStrCapacity(&RC, 16) ; V1toV2: if 'RC' is NOT a UTF-16 string, use 'RC := Buffer(16)'
; 	if !1
; 	{
; 		nSize := DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "Ptr", sString, "Int", -1, "UInt", 0, "Int", 0)
; 		VarSetStrCapacity(&wString, nSize*2)    ; V1toV2: if 'wString' is NOT a UTF-16 string, use 'wString := Buffer(nSize*2)'
; 		DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "Ptr", sString, "Int", -1, "Ptr", wString, "Int", nSize)
; 	}
	
; 	DllCall("gdiplus\GdipMeasureString"					, Ptr, pGraphics					, Ptr, 1 ? &sString : &wString					, "Int", -1					, Ptr, hFont					, Ptr, &RectF					, Ptr, hFormat					, Ptr, &RC					, "uint*", Chars					, "uint*", Lines)
	
; 	return &RC ? NumGet(RC, 0, "float") "|" NumGet(RC, 4, "float") "|" NumGet(RC, 8, "float") "|" NumGet(RC, 12, "float") "|" Chars "|" Lines : 0
; }

; ; Near = 0
; ; Center = 1
; ; Far = 2
; Gdip_SetStringFormatAlign(hFormat, Align)
; {
;    return DllCall("gdiplus\GdipSetStringFormatAlign", A_PtrSize ? "UPtr" : "UInt", hFormat, "Int", Align)
; }

; ; StringFormatFlagsDirectionRightToLeft    = 0x00000001
; ; StringFormatFlagsDirectionVertical       = 0x00000002
; ; StringFormatFlagsNoFitBlackBox           = 0x00000004
; ; StringFormatFlagsDisplayFormatControl    = 0x00000020
; ; StringFormatFlagsNoFontFallback          = 0x00000400
; ; StringFormatFlagsMeasureTrailingSpaces   = 0x00000800
; ; StringFormatFlagsNoWrap                  = 0x00001000
; ; StringFormatFlagsLineLimit               = 0x00002000
; ; StringFormatFlagsNoClip                  = 0x00004000 
; Gdip_StringFormatCreate(Format:=0, Lang:=0)
; {
;    DllCall("gdiplus\GdipCreateStringFormat", "Int", Format, "Int", Lang, A_PtrSize ? "UPtr*" : "UInt*", &hFormat)
;    return hFormat
; }

; ; Regular = 0
; ; Bold = 1
; ; Italic = 2
; ; BoldItalic = 3
; ; Underline = 4
; ; Strikeout = 8
; Gdip_FontCreate(hFamily, Size[0], Style:=0)
; {
;    DllCall("gdiplus\GdipCreateFont", A_PtrSize ? "UPtr" : "UInt", hFamily, "float", Size[0], "Int", Style, "Int", 0, A_PtrSize ? "UPtr*" : "UInt*", &hFont)
;    return hFont
; }

; Gdip_FontFamilyCreate(Font)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	if (!1)
; 	{
; 		nSize := DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "Ptr", Font, "Int", -1, "UInt", 0, "Int", 0)
; 		VarSetStrCapacity(&wFont, nSize*2) ; V1toV2: if 'wFont' is NOT a UTF-16 string, use 'wFont := Buffer(nSize*2)'
; 		DllCall("MultiByteToWideChar", "UInt", 0, "UInt", 0, "Ptr", Font, "Int", -1, "Ptr", wFont, "Int", nSize)
; 	}
	
; 	DllCall("gdiplus\GdipCreateFontFamilyFromName"					, Ptr, 1 ? &Font : &wFont					, "UInt", 0					, A_PtrSize ? "UPtr*" : "UInt*", hFamily)
	
; 	return hFamily
; }

; ;#####################################################################################
; ; Matrix functions
; ;#####################################################################################

; Gdip_CreateAffineMatrix(m11, m12, m21, m22, x, y)
; {
;    DllCall("gdiplus\GdipCreateMatrix2", "float", m11, "float", m12, "float", m21, "float", m22, "float", x, "float", y, A_PtrSize ? "UPtr*" : "UInt*", &Matrix)
;    return Matrix
; }

; Gdip_CreateMatrix()
; {
;    DllCall("gdiplus\GdipCreateMatrix", A_PtrSize ? "UPtr*" : "UInt*", &Matrix)
;    return Matrix
; }

; ;#####################################################################################
; ; GraphicsPath functions
; ;#####################################################################################

; ; Alternate = 0
; ; Winding = 1
; Gdip_CreatePath(BrushMode:=0)
; {
; 	DllCall("gdiplus\GdipCreatePath", "Int", BrushMode, A_PtrSize ? "UPtr*" : "UInt*", &Path)
; 	return Path
; }

; Gdip_AddPathEllipse(Path, x, y, w, h)
; {
; 	return DllCall("gdiplus\GdipAddPathEllipse", A_PtrSize ? "UPtr" : "UInt", Path, "float", x, "float", y, "float", w, "float", h)
; }

; Gdip_AddPathPolygon(Path, Points)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	Points := StrSplit(Points, "|" )
; 	VarSetStrCapacity(&PointF, 8*Points0)    ; V1toV2: if 'PointF' is NOT a UTF-16 string, use 'PointF := Buffer(8*Points0)'
; 	Loop Points0
; 	{
; 		Coord := StrSplit( Points%A_Index%, "`")
; 		NumPut("float", Coord1, PointF, 8*(A_Index-1)), NumPut("float", Coord2, PointF, (8*(A_Index-1))+4)
; 	}   

; 	return DllCall("gdiplus\GdipAddPathPolygon", "Ptr", Path, "Ptr", PointF, "Int", Points0)
; }

; Gdip_DeletePath(Path)
; {
; 	return DllCall("gdiplus\GdipDeletePath", A_PtrSize ? "UPtr" : "UInt", Path)
; }

; ;#####################################################################################
; ; Quality functions
; ;#####################################################################################

; ; SystemDefault = 0
; ; SingleBitPerPixelGridFit = 1
; ; SingleBitPerPixel = 2
; ; AntiAliasGridFit = 3
; ; AntiAlias = 4
; Gdip_SetTextRenderingHint(pGraphics, Rendering["Hint"])
; {
; 	return DllCall("gdiplus\GdipSetTextRenderingHint", A_PtrSize ? "UPtr" : "UInt", pGraphics, "Int", Rendering["Hint"])
; }

; ; Default = 0
; ; LowQuality = 1
; ; HighQuality = 2
; ; Bilinear = 3
; ; Bicubic = 4
; ; NearestNeighbor = 5
; ; HighQualityBilinear = 6
; ; HighQualityBicubic = 7
; Gdip_SetInterpolationMode(pGraphics, InterpolationMode)
; {
;    return DllCall("gdiplus\GdipSetInterpolationMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "Int", InterpolationMode)
; }

; ; Default = 0
; ; HighSpeed = 1
; ; HighQuality = 2
; ; None = 3
; ; AntiAlias = 4
; Gdip_SetSmoothingMode(pGraphics, SmoothingMode)
; {
;    return DllCall("gdiplus\GdipSetSmoothingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "Int", SmoothingMode)
; }

; ; CompositingModeSourceOver = 0 (blended)
; ; CompositingModeSourceCopy = 1 (overwrite)
; Gdip_SetCompositingMode(pGraphics, CompositingMode:=0)
; {
;    return DllCall("gdiplus\GdipSetCompositingMode", A_PtrSize ? "UPtr" : "UInt", pGraphics, "Int", CompositingMode)
; }

; ;#####################################################################################
; ; Extra functions
; ;#####################################################################################

; Gdip_Startup()
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	if !DllCall("GetModuleHandle", "str", "gdiplus", "Ptr")
; 		DllCall("LoadLibrary", "str", "gdiplus")
; 	si := Buffer(A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1) ; V1toV2: if 'si' is a UTF-16 string, use 'VarSetStrCapacity(&si, A_PtrSize = 8 ? 24 : 16)'
; 	DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", &pToken, "Ptr", si, "Ptr", 0)
; 	return pToken
; }

; Gdip_Shutdown(pToken)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	DllCall("gdiplus\GdiplusShutdown", "Ptr", pToken)
; 	if hModule := DllCall("GetModuleHandle", "str", "gdiplus", "Ptr")
; 		DllCall("FreeLibrary", "Ptr", hModule)
; 	return 0
; }

; ; Prepend = 0; The new operation is applied before the old operation.
; ; Append = 1; The new operation is applied after the old operation.
; Gdip_RotateWorldTransform(pGraphics, Angle, MatrixOrder:=0)
; {
; 	return DllCall("gdiplus\GdipRotateWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", Angle, "Int", MatrixOrder)
; }

; Gdip_ScaleWorldTransform(pGraphics, x, y, MatrixOrder:=0)
; {
; 	return DllCall("gdiplus\GdipScaleWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "Int", MatrixOrder)
; }

; Gdip_TranslateWorldTransform(pGraphics, x, y, MatrixOrder:=0)
; {
; 	return DllCall("gdiplus\GdipTranslateWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "Int", MatrixOrder)
; }

; Gdip_ResetWorldTransform(pGraphics)
; {
; 	return DllCall("gdiplus\GdipResetWorldTransform", A_PtrSize ? "UPtr" : "UInt", pGraphics)
; }

; Gdip_GetRotatedTranslation(Width[0], Height[0], Angle, &xTranslation, &yTranslation)
; {
; 	pi := 3.14159, TAngle := Angle*(pi/180)	

; 	Bound := (Angle >= 0) ? Mod(Angle, 360) : 360-Mod(-Angle, -360)
; 	if ((Bound >= 0) && (Bound <= 90))
; 		xTranslation := Height[0]*Sin(TAngle), yTranslation := 0
; 	else if ((Bound > 90) && (Bound <= 180))
; 		xTranslation := (Height[0]*Sin(TAngle))-(Width[0]*Cos(TAngle)), yTranslation := -Height[0]*Cos(TAngle)
; 	else if ((Bound > 180) && (Bound <= 270))
; 		xTranslation := -(Width[0]*Cos(TAngle)), yTranslation := -(Height[0]*Cos(TAngle))-(Width[0]*Sin(TAngle))
; 	else if ((Bound > 270) && (Bound <= 360))
; 		xTranslation := 0, yTranslation := -Width[0]*Sin(TAngle)
; }

; Gdip_GetRotatedDimensions(Width[0], Height[0], Angle, &RWidth, &RHeight)
; {
; 	pi := 3.14159, TAngle := Angle*(pi/180)
; 	if !(Width[0] && Height[0])
; 		return -1
; 	RWidth := Ceil(Abs(Width[0]*Cos(TAngle))+Abs(Height[0]*Sin(TAngle)))
; 	RHeight := Ceil(Abs(Width[0]*Sin(TAngle))+Abs(Height[0]*Cos(TAngle)))
; }

; ; RotateNoneFlipNone   = 0
; ; Rotate90FlipNone     = 1
; ; Rotate180FlipNone    = 2
; ; Rotate270FlipNone    = 3
; ; RotateNoneFlipX      = 4
; ; Rotate90FlipX        = 5
; ; Rotate180FlipX       = 6
; ; Rotate270FlipX       = 7
; ; RotateNoneFlipY      = Rotate180FlipX
; ; Rotate90FlipY        = Rotate270FlipX
; ; Rotate180FlipY       = RotateNoneFlipX
; ; Rotate270FlipY       = Rotate90FlipX
; ; RotateNoneFlipXY     = Rotate180FlipNone
; ; Rotate90FlipXY       = Rotate270FlipNone
; ; Rotate180FlipXY      = RotateNoneFlipNone
; ; Rotate270FlipXY      = Rotate90FlipNone 

; Gdip_ImageRotateFlip(pBitmap, RotateFlipType:=1)
; {
; 	return DllCall("gdiplus\GdipImageRotateFlip", A_PtrSize ? "UPtr" : "UInt", pBitmap, "Int", RotateFlipType)
; }

; ; Replace = 0
; ; Intersect = 1
; ; Union = 2
; ; Xor = 3
; ; Exclude = 4
; ; Complement = 5
; Gdip_SetClipRect(pGraphics, x, y, w, h, CombineMode:=0)
; {
;    return DllCall("gdiplus\GdipSetClipRect", A_PtrSize ? "UPtr" : "UInt", pGraphics, "float", x, "float", y, "float", w, "float", h, "Int", CombineMode)
; }

; Gdip_SetClipPath(pGraphics, Path, CombineMode:=0)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
; 	return DllCall("gdiplus\GdipSetClipPath", "Ptr", pGraphics, "Ptr", Path, "Int", CombineMode)
; }

; Gdip_ResetClip(pGraphics)
; {
;    return DllCall("gdiplus\GdipResetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics)
; }

; Gdip_GetClipRegion(pGraphics)
; {
; 	Region := Gdip_CreateRegion()
; 	DllCall("gdiplus\GdipGetClip", A_PtrSize ? "UPtr" : "UInt", pGraphics, "UInt*", &Region)
; 	return Region
; }

; Gdip_SetClipRegion(pGraphics, Region, CombineMode:=0)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("gdiplus\GdipSetClipRegion", "Ptr", pGraphics, "Ptr", Region, "Int", CombineMode)
; }

; Gdip_CreateRegion()
; {
; 	DllCall("gdiplus\GdipCreateRegion", "UInt*", &Region)
; 	return Region
; }

; Gdip_DeleteRegion(Region)
; {
; 	return DllCall("gdiplus\GdipDeleteRegion", A_PtrSize ? "UPtr" : "UInt", Region)
; }

; ;#####################################################################################
; ; BitmapLockBits
; ;#####################################################################################

; Gdip_LockBits(pBitmap, x, y, w, h, &Stride, &Scan0, &BitmapData, LockMode := 3, PixelFormat := 0x26200a)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	CreateRect(Rect, x, y, w, h)
; 	BitmapData := Buffer(16+2*(A_PtrSize ? A_PtrSize : 4), 0) ; V1toV2: if 'BitmapData' is a UTF-16 string, use 'VarSetStrCapacity(&BitmapData, 16+2*(A_PtrSize ? A_PtrSize : 4))'
; 	E := DllCall("Gdiplus\GdipBitmapLockBits", "Ptr", pBitmap, "Ptr", Rect, "UInt", LockMode, "Int", PixelFormat, "Ptr", BitmapData)
; 	Stride := NumGet(BitmapData, 8, "Int")
; 	Scan0 := NumGet(BitmapData, 16, Ptr)
; 	return E
; }

; ;#####################################################################################

; Gdip_UnlockBits(pBitmap, &BitmapData)
; {
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	return DllCall("Gdiplus\GdipBitmapUnlockBits", "Ptr", pBitmap, "Ptr", BitmapData)
; }

; ;#####################################################################################

; Gdip_SetLockBitPixel(ARGB, Scan0, x, y, Stride)
; {
; 	NumPut("UInt", ARGB, Scan0+0, (x*4)+(y*Stride))
; }

; ;#####################################################################################

; Gdip_GetLockBitPixel(Scan0, x, y, Stride)
; {
; 	return NumGet(Scan0+0, (x*4)+(y*Stride), "UInt")
; }

; ;#####################################################################################

; Gdip_PixelateBitmap(pBitmap, &pBitmapOut, BlockSize)
; {
; 	static PixelateBitmap
	
; 	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
; 	if (!PixelateBitmap)
; 	{
; 		if (A_PtrSize != 8) ; x86 machine code
; 		MCode_PixelateBitmap := "
; 		(LTrim Join
; 		558BEC83EC3C8B4514538B5D1C99F7FB56578BC88955EC894DD885C90F8E830200008B451099F7FB8365DC008365E000894DC88955F08945E833FF897DD4
; 		397DE80F8E160100008BCB0FAFCB894DCC33C08945F88945FC89451C8945143BD87E608B45088D50028BC82BCA8BF02BF2418945F48B45E02955F4894DC4
; 		8D0CB80FAFCB03CA895DD08BD1895DE40FB64416030145140FB60201451C8B45C40FB604100145FC8B45F40FB604020145F883C204FF4DE475D6034D18FF
; 		4DD075C98B4DCC8B451499F7F98945148B451C99F7F989451C8B45FC99F7F98945FC8B45F899F7F98945F885DB7E648B450C8D50028BC82BCA83C103894D
; 		C48BC82BCA41894DF48B4DD48945E48B45E02955E48D0C880FAFCB03CA895DD08BD18BF38A45148B7DC48804178A451C8B7DF488028A45FC8804178A45F8
; 		8B7DE488043A83C2044E75DA034D18FF4DD075CE8B4DCC8B7DD447897DD43B7DE80F8CF2FEFFFF837DF0000F842C01000033C08945F88945FC89451C8945
; 		148945E43BD87E65837DF0007E578B4DDC034DE48B75E80FAF4D180FAFF38B45088D500203CA8D0CB18BF08BF88945F48B45F02BF22BFA2955F48945CC0F
; 		B6440E030145140FB60101451C0FB6440F010145FC8B45F40FB604010145F883C104FF4DCC75D8FF45E4395DE47C9B8B4DF00FAFCB85C9740B8B451499F7
; 		F9894514EB048365140033F63BCE740B8B451C99F7F989451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB
; 		038975F88975E43BDE7E5A837DF0007E4C8B4DDC034DE48B75E80FAF4D180FAFF38B450C8D500203CA8D0CB18BF08BF82BF22BFA2BC28B55F08955CC8A55
; 		1488540E038A551C88118A55FC88540F018A55F888140183C104FF4DCC75DFFF45E4395DE47CA68B45180145E0015DDCFF4DC80F8594FDFFFF8B451099F7
; 		FB8955F08945E885C00F8E450100008B45EC0FAFC38365DC008945D48B45E88945CC33C08945F88945FC89451C8945148945103945EC7E6085DB7E518B4D
; 		D88B45080FAFCB034D108D50020FAF4D18034DDC8BF08BF88945F403CA2BF22BFA2955F4895DC80FB6440E030145140FB60101451C0FB6440F010145FC8B
; 		45F40FB604080145F883C104FF4DC875D8FF45108B45103B45EC7CA08B4DD485C9740B8B451499F7F9894514EB048365140033F63BCE740B8B451C99F7F9
; 		89451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB038975F88975103975EC7E5585DB7E468B4DD88B450C
; 		0FAFCB034D108D50020FAF4D18034DDC8BF08BF803CA2BF22BFA2BC2895DC88A551488540E038A551C88118A55FC88540F018A55F888140183C104FF4DC8
; 		75DFFF45108B45103B45EC7CAB8BC3C1E0020145DCFF4DCC0F85CEFEFFFF8B4DEC33C08945F88945FC89451C8945148945103BC87E6C3945F07E5C8B4DD8
; 		8B75E80FAFCB034D100FAFF30FAF4D188B45088D500203CA8D0CB18BF08BF88945F48B45F02BF22BFA2955F48945C80FB6440E030145140FB60101451C0F
; 		B6440F010145FC8B45F40FB604010145F883C104FF4DC875D833C0FF45108B4DEC394D107C940FAF4DF03BC874068B451499F7F933F68945143BCE740B8B
; 		451C99F7F989451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB038975F88975083975EC7E63EB0233F639
; 		75F07E4F8B4DD88B75E80FAFCB034D080FAFF30FAF4D188B450C8D500203CA8D0CB18BF08BF82BF22BFA2BC28B55F08955108A551488540E038A551C8811
; 		8A55FC88540F018A55F888140883C104FF4D1075DFFF45088B45083B45EC7C9F5F5E33C05BC9C21800
; 		)"
; 		else ; x64 machine code
; 		MCode_PixelateBitmap := "
; 		(LTrim Join
; 		4489442418488954241048894C24085355565741544155415641574883EC28418BC1448B8C24980000004C8BDA99488BD941F7F9448BD0448BFA8954240C
; 		448994248800000085C00F8E9D020000418BC04533E4458BF299448924244C8954241041F7F933C9898C24980000008BEA89542404448BE889442408EB05
; 		4C8B5C24784585ED0F8E1A010000458BF1418BFD48897C2418450FAFF14533D233F633ED4533E44533ED4585C97E5B4C63BC2490000000418D040A410FAF
; 		C148984C8D441802498BD9498BD04D8BD90FB642010FB64AFF4403E80FB60203E90FB64AFE4883C2044403E003F149FFCB75DE4D03C748FFCB75D0488B7C
; 		24188B8C24980000004C8B5C2478418BC59941F7FE448BE8418BC49941F7FE448BE08BC59941F7FE8BE88BC69941F7FE8BF04585C97E4048639C24900000
; 		004103CA4D8BC1410FAFC94863C94A8D541902488BCA498BC144886901448821408869FF408871FE4883C10448FFC875E84803D349FFC875DA8B8C249800
; 		0000488B5C24704C8B5C24784183C20448FFCF48897C24180F850AFFFFFF8B6C2404448B2424448B6C24084C8B74241085ED0F840A01000033FF33DB4533
; 		DB4533D24533C04585C97E53488B74247085ED7E42438D0C04418BC50FAF8C2490000000410FAFC18D04814863C8488D5431028BCD0FB642014403D00FB6
; 		024883C2044403D80FB642FB03D80FB642FA03F848FFC975DE41FFC0453BC17CB28BCD410FAFC985C9740A418BC299F7F98BF0EB0233F685C9740B418BC3
; 		99F7F9448BD8EB034533DB85C9740A8BC399F7F9448BD0EB034533D285C9740A8BC799F7F9448BC0EB034533C033D24585C97E4D4C8B74247885ED7E3841
; 		8D0C14418BC50FAF8C2490000000410FAFC18D04814863C84A8D4431028BCD40887001448818448850FF448840FE4883C00448FFC975E8FFC2413BD17CBD
; 		4C8B7424108B8C2498000000038C2490000000488B5C24704503E149FFCE44892424898C24980000004C897424100F859EFDFFFF448B7C240C448B842480
; 		000000418BC09941F7F98BE8448BEA89942498000000896C240C85C00F8E3B010000448BAC2488000000418BCF448BF5410FAFC9898C248000000033FF33
; 		ED33F64533DB4533D24533C04585FF7E524585C97E40418BC5410FAFC14103C00FAF84249000000003C74898488D541802498BD90FB642014403D00FB602
; 		4883C2044403D80FB642FB03F00FB642FA03E848FFCB75DE488B5C247041FFC0453BC77CAE85C9740B418BC299F7F9448BE0EB034533E485C9740A418BC3
; 		99F7F98BD8EB0233DB85C9740A8BC699F7F9448BD8EB034533DB85C9740A8BC599F7F9448BD0EB034533D24533C04585FF7E4E488B4C24784585C97E3541
; 		8BC5410FAFC14103C00FAF84249000000003C74898488D540802498BC144886201881A44885AFF448852FE4883C20448FFC875E941FFC0453BC77CBE8B8C
; 		2480000000488B5C2470418BC1C1E00203F849FFCE0F85ECFEFFFF448BAC24980000008B6C240C448BA4248800000033FF33DB4533DB4533D24533C04585
; 		FF7E5A488B7424704585ED7E48418BCC8BC5410FAFC94103C80FAF8C2490000000410FAFC18D04814863C8488D543102418BCD0FB642014403D00FB60248
; 		83C2044403D80FB642FB03D80FB642FA03F848FFC975DE41FFC0453BC77CAB418BCF410FAFCD85C9740A418BC299F7F98BF0EB0233F685C9740B418BC399
; 		F7F9448BD8EB034533DB85C9740A8BC399F7F9448BD0EB034533D285C9740A8BC799F7F9448BC0EB034533C033D24585FF7E4E4585ED7E42418BCC8BC541
; 		0FAFC903CA0FAF8C2490000000410FAFC18D04814863C8488B442478488D440102418BCD40887001448818448850FF448840FE4883C00448FFC975E8FFC2
; 		413BD77CB233C04883C428415F415E415D415C5F5E5D5BC3
; 		)"
		
; 		VarSetStrCapacity(&PixelateBitmap, StrLen(MCode_PixelateBitmap)//2) ; V1toV2: if 'PixelateBitmap' is NOT a UTF-16 string, use 'PixelateBitmap := Buffer(StrLen(MCode_PixelateBitmap)//2)'
; 		Loop StrLen(MCode_PixelateBitmap)//2		;%
; 			NumPut("UChar", "0x" SubStr(MCode_PixelateBitmap, ((2*A_Index)-1)<1 ? ((2*A_Index)-1)-1 : ((2*A_Index)-1), 2), PixelateBitmap, A_Index-1)
; 		DllCall("VirtualProtect", "Ptr", PixelateBitmap, "Ptr", VarSetStrCapacity(&PixelateBitmap), "UInt", 0x40, A_PtrSize ? "UPtr*" : "UInt*", &0) ; V1toV2: if 'PixelateBitmap' is NOT a UTF-16 string, use 'PixelateBitmap := Buffer()'
; 	}

; 	Gdip_GetImageDimensions(pBitmap, Width[0], Height[0])
	
; 	if (Width[0] != Gdip_GetImageWidth(pBitmapOut) || Height[0] != Gdip_GetImageHeight(pBitmapOut))
; 		return -1
; 	if (BlockSize > Width[0] || BlockSize > Height[0])
; 		return -2

; 	E1 := Gdip_LockBits(pBitmap, 0, 0, Width[0], Height[0], Stride1, Scan01, BitmapData1)
; 	E2 := Gdip_LockBits(pBitmapOut, 0, 0, Width[0], Height[0], Stride2, Scan02, BitmapData2)
; 	if (E1 || E2)
; 		return -3

; 	E := DllCall(PixelateBitmap, "Ptr", Scan01, "Ptr", Scan02, "Int", Width[0], "Int", Height[0], "Int", Stride1, "Int", BlockSize)
	
; 	Gdip_UnlockBits(pBitmap, BitmapData1), Gdip_UnlockBits(pBitmapOut, BitmapData2)
; 	return 0
; }

; ;#####################################################################################

; Gdip_ToARGB(A, R, G, B)
; {
; 	return (A << 24) | (R << 16) | (G << 8) | B
; }

; ;#####################################################################################

; Gdip_FromARGB(ARGB, &A, &R, &G, &B)
; {
; 	A := (0xff000000 & ARGB) >> 24
; 	R := (0x00ff0000 & ARGB) >> 16
; 	G := (0x0000ff00 & ARGB) >> 8
; 	B := 0x000000ff & ARGB
; }

; ;#####################################################################################

; Gdip_AFromARGB(ARGB)
; {
; 	return (0xff000000 & ARGB) >> 24
; }

; ;#####################################################################################

; Gdip_RFromARGB(ARGB)
; {
; 	return (0x00ff0000 & ARGB) >> 16
; }

; ;#####################################################################################

; Gdip_GFromARGB(ARGB)
; {
; 	return (0x0000ff00 & ARGB) >> 8
; }

; ;#####################################################################################

; Gdip_BFromARGB(ARGB)
; {
; 	return 0x000000ff & ARGB
; }

; ;#####################################################################################

; StrGetB(Address, Length:=-1, Encoding:=0)
; {
; 	; Flexible parameter handling:
; 	if !isInteger(Length)
; 	Encoding := Length,  Length := -1

; 	; Check for obvious errors.
; 	if (Address+0 < 1024)
; 		return

; 	; Ensure 'Encoding' contains a numeric identifier.
; 	if (Encoding = "UTF-16")
; 		Encoding := 1200
; 		else if (Encoding = "UTF-8")
; 		Encoding := 65001
; 	else if SubStr(Encoding, 1, 2)="CP"
; 		Encoding := SubStr(Encoding, 3)

; 	if !Encoding ; "" or 0
; 	{
; 		; No conversion necessary, but we might not want the whole string.
; 		if (Length == -1)
; 			Length := DllCall("lstrlen", "UInt", Address)
; 		VarSetStrCapacity(&String, Length) ; V1toV2: if 'String' is NOT a UTF-16 string, use 'String := Buffer(Length)'
; 		DllCall("lstrcpyn", "str", String, "UInt", Address, "Int", Length + 1)
; 	}
; 		else if (Encoding = 1200) ; UTF-16
; 	{
; 		char_count := DllCall("WideCharToMultiByte", "UInt", 0, "UInt", 0x400, "UInt", Address, "Int", Length, "UInt", 0, "UInt", 0, "UInt", 0, "UInt", 0)
; 		VarSetStrCapacity(&String, char_count) ; V1toV2: if 'String' is NOT a UTF-16 string, use 'String := Buffer(char_count)'
; 		DllCall("WideCharToMultiByte", "UInt", 0, "UInt", 0x400, "UInt", Address, "Int", Length, "str", String, "Int", char_count, "UInt", 0, "UInt", 0)
; 	}
; 	else 	if isInteger(Encoding)
; 	{
; 		; Convert from target encoding to UTF-16 then to the active code page.
; 		char_count := DllCall("MultiByteToWideChar", "UInt", Encoding, "UInt", 0, "UInt", Address, "Int", Length, "UInt", 0, "Int", 0)
; 		VarSetStrCapacity(&String, char_count * 2) ; V1toV2: if 'String' is NOT a UTF-16 string, use 'String := Buffer(char_count * 2)'
; 		char_count := DllCall("MultiByteToWideChar", "UInt", Encoding, "UInt", 0, "UInt", Address, "Int", Length, "UInt", String, "Int", char_count * 2)
; 		String := StrGetB(&String, char_count, 1200)
; 	}
	
; 	return String
; }


; ; ...........................................................................................

; /*q:: ;Notepad - set active position (caret) at right
; { ; V1toV2: Added bracket
; PostMessage, 0xB1, 5, 10, Edit1, A ;EM_SETSEL := 0xB1
; return
; } ; V1toV2: Added Bracket before hotkey or Hotstring

; w:: ;Notepad - set active position (caret) at left
; { ; V1toV2: Added bracket
; PostMessage, 0xB1, 10, 5, Edit1, A ;EM_SETSEL := 0xB1
; return
; */
; } ; Added bracket before function
; JEE_EditGetRange(hCtl, &vPos1, &vPos2)
; {
;     VarSetStrCapacity(&vPos1, 4), VarSetStrCapacity(&vPos2, 4) ; V1toV2: if 'vPos2' is NOT a UTF-16 string, use 'vPos2 := Buffer(4)'
;     if (type(vPos[2])="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
;        ErrorLevel := SendMessage(0xB0, &vPos1, vPos[2], , "ahk_id " hCtl)
;     } else{
;        ErrorLevel := SendMessage(0xB0, &vPos1, StrPtr(vPos[2]), , "ahk_id " hCtl)
;     } ;EM_GETSEL := 0xB0 ;(left, right)
;     vPos[1] := NumGet(&vPos1, 0, "UInt"), vPos[2] := NumGet(&vPos2, 0, "UInt")
; }

; ;==================================================

; JEE_EditSetRange(hCtl, vPos[1], vPos[2], vDoScroll:=0)
; {
;     ErrorLevel := SendMessage(0xB1, vPos[1], vPos[2], , "ahk_id " hCtl) ;EM_SETSEL := 0xB1 ;(anchor, active)
;     if vDoScroll
;         ErrorLevel := SendMessage(0xB7, 0, 0, , "ahk_id " hCtl) ;EM_SCROLLCARET := 0xB7
; }

; ;==================================================

; dfbdfgdfg ;note: although this involves deselecting and selecting it seems to happen invisibly
; JEE_EditGetRangeAnchorActive(hCtl, &vPos1, &vPos2)
; {
;     ;get selection
;     VarSetStrCapacity(&vPos1, 4), VarSetStrCapacity(&vPos2, 4) ; V1toV2: if 'vPos2' is NOT a UTF-16 string, use 'vPos2 := Buffer(4)'
;     if (type(vPos[2])="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
;        ErrorLevel := SendMessage(0xB0, &vPos1, vPos[2], , "ahk_id " hCtl)
;     } else{
;        ErrorLevel := SendMessage(0xB0, &vPos1, StrPtr(vPos[2]), , "ahk_id " hCtl)
;     } ;EM_GETSEL := 0xB0
;     vPos[1] := NumGet(&vPos1, 0, "UInt"), vPos[2] := NumGet(&vPos2, 0, "UInt")
;     if (vPos[1] = vPos[2])
;         return
;     vPos1X := vPos[1], vPos2X := vPos[2]

;     ;set selection to 0 characters and get active position
;     ErrorLevel := SendMessage(0xB1, -1, 0, , "ahk_id " hCtl) ;EM_SETSEL := 0xB1
;     VarSetStrCapacity(&vPos2, 4) ; V1toV2: if 'vPos2' is NOT a UTF-16 string, use 'vPos2 := Buffer(4)'
;     ErrorLevel := SendMessage(0xB0, &vPos2, 0, , "ahk_id " hCtl) ;EM_GETSEL := 0xB0
;     vPos[2] := NumGet(&vPos2, 0, "UInt")

;     ;restore selection
;     vPos[1] := (vPos[2] = vPos["2X"]) ? vPos["1X"] : vPos["2X"]
;     ErrorLevel := SendMessage(0xB1, vPos[1], vPos[2], , "ahk_id " hCtl) ;EM_SETSEL := 0xB1 ;(anchor, active)
; }

MyIcon_B64()
{
		
		icostr := "
		(LTrim Join
		AAABAAEAICAAAAEAIACoEAAAFgAAACgAAAAgAAAAQAAAAAEAIAAAAAAAgBAAAGAbAABgGwAAAAAAAAAAAAD7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////////////////////////////////////f/////RERE//tcQv/7XEL////////////////////////////////////////////////3/////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL///////////////////////////f/////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC////////////////////////////////90RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC////////////////////////////////////////////////////////////////////////////////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL///////////////////////////////////////////f////3////9/////f///////////////////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//////////////////////////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC////////////////////////////////////////////RERE//tcQv/7XEL/+1xC//tcQv////////////////////////////////////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
		)"
		return icostr
} 
