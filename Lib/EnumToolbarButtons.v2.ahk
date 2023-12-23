/************************************************************************
 * @description Enumerate all the Toolbar32 buttons
 * @file EnumToolbarButtons.c2v2.ahk
 * @author I don't know who the original author was
 * @author Updates and conversion to v2 by OvercastBTC
 * @date 2023/08/25
 * @version 5.8.10
 ***********************************************************************/
#Requires AutoHotkey v2+
#Include <Directives\__AE.v2>
#Include <HznPlus.v2>
; --------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe hznhorizon.exe")

^i::enumbutton()
^b::enumbutton()
^u::enumbutton()
^-::enumbutton()
; ^a::HznSelectAll()
; ^s::HznSave()
; ^F4::HznClose()
#HotIf
; --------------------------------------------------------------------------------
enumbutton(*) {
	SendLevel(5)
	BlockInput(1) ; 1 = On, 0 = Off
	Static 	WM_COMMAND				:= 273 ; 0x111
	fCtl := ControlGetClassNN(ControlGetFocus("A"))
	bID := SubStr(fCtl, -1, 1)
	nCtl := "msvb_lib_toolbar" bID
	hTb := ControlGethWnd(nCtl, "A")
	hTx := ControlGethWnd(fCtl, "A")
	idBtn:= A_ThisHotkey = "^b" ? 1 : 1 ;.........: italic = 2
	idBtn:= A_ThisHotkey = "^i" ? 2 : 2 ;.........: italic = 2
	idBtn:= A_ThisHotkey = "^u" ? (enumGETBUTTONSTATE(103,hTB) != 4) MsgBox("There is no underline button available.") 0 : 9 ;.........: italic = 2
; ........: (AJB - 08/2023) FE Notepad, Comments, and COPE => u = 10; 3 worked somewhere? (???9 and 10???) (else i or b)
			; :  A_ThisHotkey = "^x" ? 108 ; ........: cut = 11 and 12
			; :  A_ThisHotkey = "^c" ? 109 ; ........: copy
			; :  A_ThisHotkey = "^v" ? 110 ; ........: paste
			; :  A_ThisHotkey = "^z" ? 111 ; ........: undo = 17 and 18
			; :  A_ThisHotkey = "^y" ? 112
			; :  A_ThisHotkey = "^-" ? 113 : 21 ; ...: redo
	; arbtn := EnumToolbarButtons(hTb)
	SendMessage(WM_COMMAND, idBtn,hTb,, hTb)
	; HznBtns := DisplayObj(arbtn)
	; MsgBox(HznBtns)
	SendLevel(0)
	BlockInput(0) ; 1 = On, 0 = Off
	return
}
; --------------------------------------------------------------------------------
Hznenumbutton(hTb, idButton, arbtn) {
	idButton := arbtn.cmd
	x := idButton.x
	y := idButton.y
	w := idButton.w
	h := idButton.y
	ctrlx := arbtn.cx
	ctrly := arbtn.cy
	Try ControlClick(ctrlx + x, ctrly + y)
}
; --------------------------------------------------------------------------------

#HotIf WinActive('ahk_exe hznhorizon.exe')

^+7::
{ ; V1toV2: Added bracket
	SendLevel(5)
	; fCtl := ControlGetClassNN(ControlGetFocus('A'))
	; --------------------------------------------------------------------------------
	; hWnd := ControlGetFocus('A')
	; flag := MONITOR_DEFAULTTONEAREST := 0x00000002
	; monWin := DllCall('user32\MonitorFromWindow', 'ptr', hWnd, 'int', flag)
	; OutputDebug('monWin: ' monWin)
	; monitorIndex := GetNearestMonitorInfo(hWnd).Number
	; GetNearestMonitorInfo(winTitle*) {
	; 	static MONITOR_DEFAULTTONEAREST := 0x00000002
	; 	hwnd := WinExist(winTitle*)
	; 	hMonitor := DllCall("MonitorFromWindow", "ptr", hwnd, "uint", MONITOR_DEFAULTTONEAREST, "ptr")
	; 	NumPut("uint", 104, MONITORINFOEX := Buffer(104))
	; 	if (DllCall("user32\GetMonitorInfo", "ptr", hMonitor, "ptr", MONITORINFOEX)) {
	; 		Return  { Handle   : hMonitor
	; 				, Name     : Name := StrGet(MONITORINFOEX.ptr + 40, 32)
	; 				, Number   : RegExReplace(Name, ".*(\d+)$", "$1")
	; 				, Left     : L  := NumGet(MONITORINFOEX,  4, "int")
	; 				, Top      : T  := NumGet(MONITORINFOEX,  8, "int")
	; 				, Right    : R  := NumGet(MONITORINFOEX, 12, "int")
	; 				, Bottom   : B  := NumGet(MONITORINFOEX, 16, "int")
	; 				, WALeft   : WL := NumGet(MONITORINFOEX, 20, "int")
	; 				, WATop    : WT := NumGet(MONITORINFOEX, 24, "int")
	; 				, WARight  : WR := NumGet(MONITORINFOEX, 28, "int")
	; 				, WABottom : WB := NumGet(MONITORINFOEX, 32, "int")
	; 				, Width    : Width  := R - L
	; 				, Height   : Height := B - T
	; 				, WAWidth  : WR - WL
	; 				, WAHeight : WB - WT
	; 				, Primary  : NumGet(MONITORINFOEX, 36, "uint")
	; 			}
	; 	}
	; 	throw Error("GetMonitorInfo: " A_LastError, -1)
	; }
	; OutputDebug('monitorIndex: ' monitorIndex)
	; ; --------------------------------------------------------------------------------
	; MonitorCount := MonitorGetCount()
	; MonitorPrimary := MonitorGetPrimary()
	; OutputDebug("Monitor Count:`t" MonitorCount "`nPrimary Monitor:`t" MonitorPrimary)
	; Loop MonitorCount
	; {
	; 	MonitorGet(A_Index, &L, &T, &R, &B)
	; 	MonitorGetWorkArea(A_Index, &WL, &WT, &WR, &WB)
	; 	OutputDebug
	; 	(
	; 		"Monitor:`t#" A_Index "
	; 		Name:`t" MonitorGetName(A_Index) "
	; 		Left:`t" L " (" WL " work)
	; 		Top:`t" T " (" WT " work)
	; 		Right:`t" R " (" WR " work)
	; 		Bottom:`t" B " (" WB " work)`n"
	; 		'Height: ' (B - T) '`n'
	; 		'Width: '  (R - L) '`n'
	; 		'Other (W/H): ' Format('{:.2f}', ((R - L)/(B - T))) '`n'
	; 		'Other (H/W): ' Format('{:.2f}', ((B - T)/(R - L)))
			
	; 	)
	; }
	; --------------------------------------------------------------------------------
	Static 	WM_COMMAND				:= 273 ; 0x111
	; --------------------------------------------------------------------------------
	; bID := SubStr(fCtl, -1, 1)
	; nCtl := "msvb_lib_toolbar" bID
	; hTb := ControlGethWnd(nCtl, "A")
	; hTx := ControlGethWnd(fCtl, "A")
	; hIDx:= A_ThisHotkey = "^i" ? 2 ; .........: italic = 2
	; 	:  A_ThisHotkey = "^b" ? 1 ; .........: bold = 1
	; 	:  A_ThisHotkey = "^u" ? 9 ; .........: u = 3 (???9 and 10???) (else i or b)
	; 	:  A_ThisHotkey = "^x" ? 11 ; ........: cut = 11 and 12
	; 	:  A_ThisHotkey = "^c" ? 13 ; ........: copy
	; 	:  A_ThisHotkey = "^v" ? 16 ; ........: paste
	; 	:  A_ThisHotkey = "^z" ? 17 ; ........: undo = 17 and 18
	; 	:  A_ThisHotkey = "^y" ? 20 : 21 ; ...: redo
	; ; EnumToolbarButtons(hTb)
	winList := []
	WinActivate('ahk_exe hznHorizon.exe')
	winList := WinGetList('A')
	winT := '' 
	winTList := ''
	for each, winT in winList {
		winTitle := WinGetTitle(winT)
		winClass := WinGetClass(winT)
		winTList .= 'winT: ' . winT . A_Space . 'winTitle: ' . winTitle . A_Space . 'winClass: ' . winClass . '`n'
	}
	OutputDebug(winTList)
	matches := []
	arbtn := []
	matches := testtest()
	v:=0
	for , v in matches{
		local hTb := v
		TB_BUTTONCOUNT := 1048, control := ctrlhwnd := v
		pid_target := WinGetPID(ctrlhwnd)
		hpRemote := DllCall("OpenProcess", "UInt", 8 | 16 | 32, "Int", 0, "UInt", pid_target, "Ptr")
		remote_buffer := RemoteBuffer(hpRemote, Is32bit := 0)
		Static Msg := TB_BUTTONCOUNT, wParam := 0, lParam := 0
		BUTTONCOUNT := SendMessage(TB_BUTTONCOUNT, wParam, lParam, control, ctrlhwnd)
		If (BUTTONCOUNT > 0){
			
			Try {
				; ClassNN := ControlGetClassNN(hTb)
				ClassNN := WinGetTitle(hTb)
				if (ClassNN = '') {
					Try {
						; ClassNN := WinGetTitle(hTb)
						ClassNN := ControlGetClassNN(hTb)
					}
				}
			arbtn.Push('ClassNN: ' ClassNN . A_Space . 'bntct: ' . BUTTONCOUNT . '`n')
			; arbtn.Push(BUTTONCOUNT)
			}
		}
		else If (BUTTONCOUNT == 0){
			xlist := WinGetControlsHwnd(hTb)
			otherv := 0
			otherotherv := 0
			for each, otherv in xlist
				ohTb := WinGetControlsHwnd(otherv)
				for each, otherotherv in ohTb
					BUTTONCOUNT := SendMessage(TB_BUTTONCOUNT, wParam, lParam, ohTb, ohTb)
					if !(BUTTONCOUNT == 0)
						arbtn.Push('[' . otherotherv . '] #' . BUTTONCOUNT)
		}
		; arbtn := EnumToolbarButtons(hTb)
	}
	; idCommand := arbtn.idButton
	index := 1
	for each, value in arbtn {
		HznBtns .= value
		; If (index < 2) {
		; 	index++
		; 	HznBtns .= value . A_Space
		; }
		; If (index == 2) {
		; 	HznBtns .= value . '`n'
		; 	index := 0
		; }
	}
	; HznBtns := DisplayObj(arbtn)
	MsgBox(HznBtns)
	; OutputDebug(HznBtns)
	; btnstate := enumGETBUTTONSTATE(101,hTb)
	; OutputDebug(btnstate)
	; CLICKBUTTONRECT(hTb, 101)
	; Reload()
	return
} 
#HotIf
; DisplayObj(Obj, Depth:=10, IndentLevel:="")
; {
; 	if Type(Obj) = "Object"
; 		Obj := Obj.OwnProps()
; 	for k,v in Obj
; 	{
; 		List.= IndentLevel "[" k "]"
; 		if (IsObject(v) && Depth>1)
; 			List.="`n" DisplayObj(v, Depth-1, IndentLevel . "    ")
; 		Else
; 			List.=" => " v
; 		List.="`n"
; 	}
; 	return RTrim(List)
; }
; --------------------------------------------------------------------------------
EnumToolbarButtons(ctrlhwnd, idBtn:=0) ;, is_apply_scale:=1) {
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
	; --------------------------------------------------------------------------------
	x1 :=0, x2 :=0, y1 :=0, y2 :=0
	; --------------------------------------------------------------------------------
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
	arbtn := Array()
	
	ControlGetPos(&ctrlx:=0, &ctrly:=0, &ctrlw:=0, &ctrlh:=0,ctrlhwnd, ctrlhwnd)
	
	;MsgBox % "X: "ctrlx " Y: "ctrly " W: " ctrlw " H: " ctrlh ; 06.25.2023 .. THIS WORKS!!!
	;MouseMove, ctrlx, ctrly ; 06.25.2023 .. THIS WORKS!!! It actually moves the mouse to the right location!!!
	;pid_target := ""
	/*
	pid_target := DllCall( "GetWindowThreadProcessId", "Ptr", ctrlhwnd)
	;                  , "UIntP") ;, pid_target)
	OutputDebug("pid_target: " . pid_target)

*/
	; --------------------------------------------------------------------------------
	; Step: Get the toolbar "thread" process ID (PID) 
	; DllCall("GetWindowThreadProcessId", "Ptr", ctrlhwnd, "UInt*", &targetProcessID:=0)
	pid_target := WinGetPID(ctrlhwnd) ; ==> replaced with above DllCall()
	; OutputDebug("pid_targetW: " . pid_target . "`n" "targetProcessID: " targetProcessID "`n")
	; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
	; --------------------------------------------------------------------------------
	; Step: Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
	hpRemote := DllCall("OpenProcess", "UInt", 8 | 16 | 32, "Int", 0, "UInt", pid_target, "Ptr")
	; hpRemote := hp_Remote(pid_target)

	; --------------------------------------------------------------------------------
	; Step: [OPTIONAL] Identify if the process is 32 or 64 bit (efficiency step)
	; --------------------------------------------------------------------------------
	; Is32bit := enumWin32_64_Bit(hpRemote)
	; --------------------------------------------------------------------------------
	; Step: Allocate memory for the TBBUTTON structure in the target process's address space
	; --------------------------------------------------------------------------------
	remote_buffer := RemoteBuffer(hpRemote, Is32bit:=0)
	; --------------------------------------------------------------------------------
	Static Msg := TB_BUTTONCOUNT, wParam := 0, lParam := 0, control := ctrlhwnd
	; --------------------------------------------------------------------------------
	; Step: count and load all the msvb_lib_toolbar buttons into memory
	; --------------------------------------------------------------------------------
	BUTTONCOUNT := SendMessage(TB_BUTTONCOUNT, wParam, lParam, control, ctrlhwnd)
	; buttons := SendMessage(TB_BUTTONCOUNT, wParam, lParam, control, ctrlhwnd)
	buttons := BUTTONCOUNT
	; OutputDebug("buttons: " . buttons . "`n") 
	RECT := Buffer(16,0)
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
		tbHwnd := ctrlhwnd

		GETBUTTON := SendMessage(TB_GETBUTTON, A_Index-1, remote_buffer, ctrlhwnd, ctrlhwnd)

		ReadRemoteBuffer(hpRemote, remote_buffer, &BtnStruct, 32)
		while (GETBUTTON == 1)
			GETBUTTON := 'Success'
		OutputDebug("GETBUTTON: " GETBUTTON "`n")
		idButton := NumGet(BtnStruct, 4, "IntP")
		OutputDebug("idButton: " . idButton . "`n")
		
		COMMANDTOINDEX := SendMessage(TB_COMMANDTOINDEX, idButton, 0, ctrlhwnd, ctrlhwnd) ; hope that 4KB is enough ; just a test
		Cmd2Indx := COMMANDTOINDEX
		C2I_0_base := Cmd2Indx
		OutputDebug("Cmd2Indx: " . Cmd2Indx . "`n")

		; --------------------------------------------------------------------------------
		btnstate := enumGETBUTTONSTATE(idButton, ctrlhwnd)
		; --------------------------------------------------------------------------------
		rectangle := Enum_GETITEMRECT(COMMANDTOINDEX, ctrlhwnd, hpRemote, remote_buffer, &RECT)
		ReadRemoteBuffer(hpRemote, remote_buffer, &RECT, 32)
		; --------------------------------------------------------------------------------
		; oldx1:=x1
		; oldx2:=x2
		; oldy1:=y1
		; --------------------------------------------------------------------------------
		x1 := NumGet(RECT, 0, "Int") 
		x2 := NumGet(RECT, 8, "Int") 
		y1 := NumGet(RECT, 4, "Int") 
		y2 := NumGet(RECT, 12, "Int")
		; --------------------------------------------------------------------------------
		; FileAppend("Index:" A_Index . "(idButton:" . idButton . ")" . " State: " btnstate . " " . "Cmd2Indx: " . Cmd2Indx . " " . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . "`n", "_emeditor_toolbar_buttons.txt") ; debug
		; --------------------------------------------------------------------------------
		OutputDebug('[' . A_Index . ']' . "(idButton:" . idButton . ")" 
					. " State: " btnstate . " " 
					. "Cmd2Indx: " . Cmd2Indx . " " 
					. " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . "`n") ; debug
		; --------------------------------------------------------------------------------
		; Try MouseMove(ctrlx + (x2+x1//2), ctrly + (y2+y1//2))

		; --------------------------------------------------------------------------------
		;if(is_apply_scale) {
		; scale := A_ScreenDPI
		; x1 := x1 /= scale
		; y1 := y1 /= scale
		; x2 := x2 /= scale
		; y2 := y2 /= scale
		; ; }
		; --------------------------------------------------------------------------------
		; If (x1=oldx1 And y1=oldy1 And x2=oldx2)
		; 	Continue
		; If (x2-x1<10)
		; 	Continue
		; If (x1>ctrlw Or y1>ctrlh)
		; 	Continue
		
		arbtn.Push(
			{  	  0_C2I_0_base: '(' COMMANDTOINDEX ')'
				, 1_Index:A_Index
				, 2_idButton:idButton
				, 3_state
					:	( btnstate = 4 )
					? '(' btnstate ')' "=>UP"
					:	( btnstate = 6 )
					? '(' btnstate ')' "=>PRESSED"
					: '(' btnstate ')' "=>Not Active"
				, 4_x:x1
				, 5_y:y1
				, 6_w:x2-x1
				, 7_h:y2-y1
			}) ; , text:BtnTextW})
		; --------------------------------------------------------------------------------
		; --------------------------------------------------------------------------------
		; Step: Restore previous and set delay
		; --------------------------------------------------------------------------------

		; --------------------------------------------------------------------------------
	}
	MEM_RELEASE := 32768
	; DllCall("VirtualFreeEx", "UInt", hpRemote, "UInt", remote_buffer, "UInt", 0, "UInt", 0x8000)
	DllCall("VirtualFreeEx", "UInt", hpRemote, "UInt", remote_buffer, "UInt", 0, "UInt", 32768)
	DllCall("CloseHandle", "UInt", hpRemote)
	return arbtn
}

hp_Remote(pid_target)
{
	; Step: Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
	
	; hpRemote: Remote process handle
	if !(hpRemote := DllCall("OpenProcess", "UInt", 8 | 16 | 32, "Int", 0, "UInt", pid_target, "Ptr"))
	{
		Throw ("Autohotkey: Cannot OpenProcess(pid=" . pid_target . ")")
		; return
	}
	return hpRemote := DllCall("OpenProcess", "UInt", 8 | 16 | 32, "Int", 0, "UInt", pid_target, "Ptr")
}

Enum_GETITEMRECT(COMMANDTOINDEX, ctrlhwnd, hpRemote, remote_buffer, &RECT)
{
	rectangle := Array()
	Static 	TB_GETITEMRECT  		:= 1053 ; 0x41D, WM_USER+29
	Cmd2Indx := COMMANDTOINDEX-1
	C2I_0_base := Cmd2Indx
	SendMessage(TB_GETITEMRECT, Cmd2Indx, remote_buffer, , ctrlhwnd)
	
	ReadRemoteBuffer(hpRemote, remote_buffer, &RECT, 32)
	x1 := NumGet(RECT, 0, "Int") 
	x2 := NumGet(RECT, 8, "Int") 
	y1 := NumGet(RECT, 4, "Int") 
	y2 := NumGet(RECT, 12, "Int")
	Left 	:= NumGet(RECT, 0, 	"Int")
	Top 	:= NumGet(RECT, 4, 	"Int")
	Right 	:= NumGet(RECT, 8, 	"Int")
	Bottom 	:= NumGet(RECT, 12, "Int")
	X 		:= Left
	Y 		:= Top
	W 		:= Right-Left
	H 		:= Bottom-Top
	rectangle.Push({x1:Left, x2:Right, y1:Top, y2:Bottom, W:W, H:H})
	return rectangle
}
; --------------------------------------------------------------------------------
RemoteBuffer(hpRemote, Is32bit?)
{
	Static MEM_PHYSICAL := 4 ; 0x04    ; 0x00400000, ; via MSDN Win32
	Static MEM_COMMIT := 4096 ; := 0x00001000
	try
		RPtrSize := Is32bit ? 4 : 8
	catch
		A_Is64bitOS ? RPtrSize := 8 : RPtrSize := 4
	TBBUTTON_SIZE := 8 + (RPtrSize * 3)
	; remote_buffer := DllCall("VirtualAllocEx", "Ptr", hpRemote, "Ptr", 0, "UPtr", TBBUTTON_SIZE, "UInt", 0x1000, "UInt", MEM_PHYSICAL, "Ptr")
	return remote_buffer := DllCall("VirtualAllocEx", "Ptr", hpRemote, "Ptr", 0, "UPtr", TBBUTTON_SIZE, "UInt", MEM_COMMIT, "UInt", MEM_PHYSICAL, "Ptr")
	; return remote_buffer
}
; --------------------------------------------------------------------------------
enumWin32_64_Bit(hpRemote)
{
	A_Is64bitOS ? DllCall("IsWow64Process", "Ptr", hpRemote, "Int*", Is32bit := 0) : DllCall("IsWow64Process", "Ptr", hpRemote, "Int*", Is32bit := 1)
	If (A_Is64bitOS)
		{
			Static Is32bit := 0
		Try
			DllCall("IsWow64Process", "Ptr", hpRemote, "Int*", Is32bit)
		catch
			Is32bit := 1
		Is32bit = 0 ? 'False' : 'True'
	}
	OutputDebug("Is32bit: " Is32bit "`n")
	return Is32bit
}
; --------------------------------------------------------------------------------
ReadRemoteBuffer(hpRemote, RemoteBuffer, &LocalVar, bytes) {
	return DllCall("ReadProcessMemory", "Ptr", hpRemote, "Ptr", RemoteBuffer, "Ptr", LocalVar, "UInt", bytes, "UInt", 0)
}
; --------------------------------------------------------------------------------
/**
 * Function ..: enumGETBUTTONSTATE()
 * @param idButton
 * @param hTB := ctrlhwnd
 */
enumGETBUTTONSTATE(idButton,hTb) {
	TB_GETSTATE := 1042 ; 0x0412 (hex)
	GETSTATE := SendMessage(TB_GETSTATE, idButton, 0, hTb, hTb)
	btnstate := SubStr(GETSTATE,1,1)
	If (btnstate == 4) || (btnstate == 6){
		return btnstate
	}
	btnname := idButton = 100 ? 'Bold' : idButton = 101 ? 'Italic' : idButton = 102 ? 'Underline' : ''
	OutputDebug(  'The ' btnname
				. ' button is not available.' '`n'
				. 'idButton: ' idButton '`n'
				. 'btnstate: ' btnstate)
	OutputDebug("btnstate: " . btnstate . "`n")
	return btnstate
}