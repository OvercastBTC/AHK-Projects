/************************************************************************
 * @description Enumerate all the Toolbar32 buttons
 * @file EnumToolbarButtons.c2v2.ahk
 * @author I don't know who the original author was
 * @author Updates and conversion to v2 by OvercastBTC
 * @date 2023/08/25
 * @version 5.8.10
 ***********************************************************************/
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
DllCall("SetThreadDpiAwarenessContext", "ptr", -4, "ptr")
; --------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe hznhorizon.exe")

^i::button()
^b::button()
^u::button()
^-::button()
; ^a::HznSelectAll()
; ^s::HznSave()
; ^F4::HznClose()
#HotIf
; --------------------------------------------------------------------------------
button(*) {
	SendLevel(5)
	BlockInput(1) ; 1 = On, 0 = Off
	fCtl := ControlGetClassNN(ControlGetFocus("A"))
	bID := SubStr(fCtl, -1, 1)
	nCtl := "msvb_lib_toolbar" bID
	hTb := ControlGethWnd(nCtl, "A")
	hTx := ControlGethWnd(fCtl, "A")
	idBtn:= A_ThisHotkey = "^i" ? 101 ;.........: italic = 2
			:  A_ThisHotkey = "^b" ? 100 ; .........: bold = 1
			:  A_ThisHotkey = "^u" ? (getbuttonstate(103,hTB) != 4) Send("There is no underline button available.") ; ........: (AJB - 08/2023) FE Notepad, Comments, and COPE => u = 10; 3 worked somewhere? (???9 and 10???) (else i or b)
			:  A_ThisHotkey = "^x" ? 108 ; ........: cut = 11 and 12
			:  A_ThisHotkey = "^c" ? 109 ; ........: copy
			:  A_ThisHotkey = "^v" ? 110 ; ........: paste
			:  A_ThisHotkey = "^z" ? 111 ; ........: undo = 17 and 18
			:  A_ThisHotkey = "^y" ? 112
			:  A_ThisHotkey = "^-" ? 113 : 21 ; ...: redo
	EnumToolbarButtons(hTb, idBtn)
	SendLevel(0)
	BlockInput(0) ; 1 = On, 0 = Off
	return
}
; --------------------------------------------------------------------------------
HznButton(hTb, idButton, arbtn) {
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

^+9::
{ ; V1toV2: Added bracket
	SendLevel(5)
	fCtl := ControlGetClassNN(ControlGetFocus('A'))
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
	; EnumToolbarButtons(hTb)
	arbtn := EnumToolbarButtons(hTb)
	HznBtns := DisplayObj(arbtn)
	MsgBox(HznBtns)
	; btnstate := getbuttonstate(101,hTb)
	; OutputDebug(btnstate)
	; CLICKBUTTONRECT(hTb, 101)
	Reload()
} 
#HotIf
DisplayObj(Obj, Depth:=10, IndentLevel:="")
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
	A_Is64bitOS ? DllCall("IsWow64Process", "Ptr", hpRemote, "Int*", Is32bit := 0) : Is32bit := 1
	If (A_Is64bitOS) {
		Try DllCall("IsWow64Process", "Ptr", hpRemote, "Int*", Is32bit := true)
	} Else {
		Is32bit := True
	}
	OutputDebug("Is32bit: " Is32bit "`n")
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
		Cmd2Indx := COMMANDTOINDEX
		OutputDebug("Cmd2Indx: " . Cmd2Indx . "`n")

		; --------------------------------------------------------------------------------
		/**
		 * Function ..: getbuttonstate()
		 * @param idButton
		 * @param ctrlhwnd
		 */
		btnstate := getbuttonstate(idButton, ctrlhwnd)
		; --------------------------------------------------------------------------------
		
		SendMessage(TB_GETITEMRECT, A_Index-1, remote_buffer, , "ahk_id " ctrlhwnd)
		
		ReadRemoteBuffer(hpRemote, remote_buffer, &rect, 32)
		oldx1:=x1
		oldx2:=x2
		oldy1:=y1
		x1 := NumGet(rect, 0, "Int") 
		x2 := NumGet(rect, 8, "Int") 
		y1 := NumGet(rect, 4, "Int") 
		y2 := NumGet(rect, 12, "Int")
		
		FileAppend("Index:" A_Index . "(idButton:" . idButton . ")" . " State: " btnstate . " " . "Cmd2Indx: " . Cmd2Indx . " " . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . "`n", "_emeditor_toolbar_buttons.txt")  ; debug
		; --------------------------------------------------------------------------------
		OutputDebug("Index:" A_Index . "(idButton:" . idButton . ")" . " State: " btnstate . " " . "Cmd2Indx: " . Cmd2Indx . " " . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . "`n")                                 ; debug
		; --------------------------------------------------------------------------------
		If (btnstate = 4){
			hTb := ctrlhwnd 
			Try MouseMove(ctrlx + (x2+x1//2), ctrly + (y2+y1//2))
			KeyWait(A_Space)
			; Try ControlClick(ctrlx + (x2+x1//2), ctrly + (y2+y1//2), hTb,,,, "NA")
			; Sleep(1000)
		} Else If (btnstate = 6){
			hTb := ctrlhwnd 
			Try MouseMove(ctrlx + (x2+x1//2), ctrly + (y2+y1//2))
			; Try ControlClick(ctrlx + (x2+x1//2), ctrly + (y2+y1//2), hTb,,,, "NA")
			; Sleep(1000)			
		}
		;if(is_apply_scale) {
		; scale := A_ScreenDPI
		; x1 := x1 /= scale
		; y1 := y1 /= scale
		; x2 := x2 /= scale
		; y2 := y2 /= scale
		; ; }
		
		; If (x1=oldx1 And y1=oldy1 And x2=oldx2)
		; 	Continue
		; If (x2-x1<10)
		; 	Continue
		; If (x1>ctrlw Or y1>ctrlh)
		; 	Continue
		
		arbtn.Push({1_Index:A_Index
			, 4_x:x1
			, 5_y:y1
			, 6_w:x2-x1
			, 7_h:y2-y1
			, 2_cmd:idButton
			, 0_based_Cmd2Indx: '(' COMMANDTOINDEX ')'
			, 3_state: (btnstate = 4) 	? '(' btnstate ')' "-UP"
					 : (btnstate = 6) 	? '(' btnstate ')' "-PRESSED"
										: '(' btnstate ')' "-Not Active"}) ; , text:BtnTextW})
		;arbtn.Insert( {"x":x1, "y":y1, "w":x2-x1, "h":y2-y1, "cmd":idButton, "text":BtnText} )
		;line:=100000000+Floor((ctrly+y1)/same)*10000+(ctrlx+x1)
		;lines=%lines%%line%%A_Tab%%ctrlid%%A_Tab%%class%`n
		; arbtn := ({x:x1, y:y1, w:x2-x1, h:y2-y1, cmd:idButton, text:BtnTextW})
		; For key, value in arbtn{
			; 	FileAppend("Key:" . key . " = " . value . "`n", "_arbtn.txt")
			; }
		; --------------------------------------------------------------------------------
		; Step: Restore previous and set delay
		; --------------------------------------------------------------------------------

		; --------------------------------------------------------------------------------
	}
	
	DllCall("VirtualFreeEx", "UInt", hpRemote, "UInt", remote_buffer, "UInt", 0, "UInt", 0x8000)
	DllCall("CloseHandle", "UInt", hpRemote)
	return arbtn
}

ReadRemoteBuffer(hpRemote, RemoteBuffer, &LocalVar, bytes) {
	DllCall("ReadProcessMemory", "Ptr", hpRemote, "Ptr", RemoteBuffer, "Ptr", LocalVar, "UInt", bytes, "UInt", 0) 
}

GETBUTTONSTATE(idButton,hTb){
	TB_GETSTATE := 0x0412
	GETSTATE := SendMessage(TB_GETSTATE, idButton, 0, hTb, hTb) ; hope that 4KB is enough ; just a test
	btnstate := SubStr(GETSTATE,1,1)
	OutputDebug("btnstate: " . btnstate . "`n")
	return btnstate
}

CLICKBUTTONRECT(hTb, idButton){
	static ctrlhwnd := hTb
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
	ControlGetPos(&ctrlx:=0, &ctrly:=0, &ctrlw:=0, &ctrlh:=0,hTb, hTb)
	Static gbCtl := ctrlhwnd
	Static tbHwnd := ctrlhwnd
	Static gbCtl := Integer(ctrlhwnd)
	rect := Buffer(16,0)
	BtnStruct := Buffer(32,0)
	pid_target := WinGetPID(hTb) ; ==> replaced with above DllCall()
	hpRemote := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", pid_target, "Ptr")
	; --------------------------------------------------------------------------------
	A_Is64bitOS ? DllCall("IsWow64Process", "Ptr", hpRemote, "Int*", Is32bit := 0) : Is32bit := 1
	If (A_Is64bitOS) {
		Try DllCall("IsWow64Process", "Ptr", hpRemote, "Int*", Is32bit := true)
	} Else {
		Is32bit := True
	}
	OutputDebug("Is32bit: " Is32bit "`n")
	; --------------------------------------------------------------------------------
	RPtrSize := Is32bit ? 4 : 8
	TBBUTTON_SIZE := 8 + (RPtrSize * 3) 
	remote_buffer := DllCall("VirtualAllocEx", "Ptr", hpRemote, "Ptr", 0, "UPtr", TBBUTTON_SIZE, "UInt", 0x1000, "UInt", MEM_PHYSICAL, "Ptr")
	; --------------------------------------------------------------------------------
	Static Msg := TB_BUTTONCOUNT, wParam := 0, lParam := 0, control := ctrlhwnd
	BUTTONCOUNT := SendMessage(TB_BUTTONCOUNT, wParam, lParam, control, "ahk_id " ctrlhwnd)
	buttons := SendMessage(TB_BUTTONCOUNT, wParam, lParam, hTb,hTb)
	buttons := BUTTONCOUNT
	OutputDebug("buttons: " . buttons . "`n") 


	GETBUTTON := SendMessage(TB_GETBUTTON, 101, remote_buffer,hTb,hTb)
	ReadRemoteBuffer(hpRemote, remote_buffer, &BtnStruct, 32)
	;idButton := NumGet(BtnStruct, 4, "IntP")
	SendMessage(TB_GETITEMRECT, 1, remote_buffer, , "ahk_id " ctrlhwnd)
	
	ReadRemoteBuffer(hpRemote, remote_buffer, &rect, 32)
	oldx1:=x1
	oldx2:=x2
	oldy1:=y1
	x1 := NumGet(rect, 0, "Int") 
	x2 := NumGet(rect, 8, "Int") 
	y1 := NumGet(rect, 4, "Int") 
	y2 := NumGet(rect, 12, "Int")
	
	; FileAppend("Index:" A_Index . "(idButton:" . idButton . ")" . " State: " btnstate . " " . "Cmd2Indx: " . Cmd2Indx . " " . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . "`n", "_emeditor_toolbar_buttons.txt")  ; debug
	FileAppend("(idButton:" . idButton . ")" . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . "`n", "_emeditor_toolbar_buttons.txt")  ; debug
	; --------------------------------------------------------------------------------
	OutputDebug("Index:" A_Index . "(idButton:" . idButton . ")" . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . "`n")                                 ; debug
	; --------------------------------------------------------------------------------
	DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
	GETBUTTONSTATE(idButton,hTb)
	; try ControlClick(ctrlx + (x2+x1//2), ctrly + (y2+y1//2), hTb,,,, "NA")
	try Click(ctrlx + (x2+x1//2) ctrly + (y2+y1//2)) ;, hTb,,,, "NA")
	GETBUTTONSTATE(idButton,hTb)
	DllCall("VirtualFreeEx", "UInt", hpRemote, "UInt", remote_buffer, "UInt", 0, "UInt", 0x8000)
	DllCall("CloseHandle", "UInt", hpRemote)
}