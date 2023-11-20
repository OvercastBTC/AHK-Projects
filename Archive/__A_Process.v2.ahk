#Requires Autohotkey v2+
#Include <Directives\__AE.v2>
#Include <HznPlus.v2>
Persistent(1) ; Keeps script permanently running
CoordMode("ToolTip", "Screen")
; ProcessSetPriority('High')
; --------------------------------------------------------------------------------

; --------------------------------------------------------------------------------
ICON := '.\ICON\DllCall.ico'
TraySetIcon(ICON) ; this changes the icon into a little dllcall thing.
; --------------------------------------------------------------------------------
#HotIf WinActive('ahk_exe hznhorizon.exe')
; ShellHook_AProcess()
/**
 * @param h := hCtl --> hWnd_Ctrl
 * @param o := x := i_Obj := Object(),
 * @param a := y := i_Arr := Array(),
 * @param g := z := i_Gui := Gui(),
 * @param m := 	  i_Map := Map()
 * @param m[x] := 'Object'
 * @param m[y] := 'Array Object'
 * @param m[z] := 'GUI Object'
 * @param m[z] := 'GUI Object'
 */
global gOpenWindows := Map()
; Returns a map object containing key:value pairs
; Each key is the unique handle to that window
; Each value is a map with the following properties:
; title class process
Hzn := 'ahk_exe hznHorizon.exe'
hHzn := WinWaitActive(Hzn)
; get_win_details_all(hwnd?) {
; 	win_info := Map()
; 	for hwnd in WinGetList()
; 		win_info[hwnd] :=
; 			Map('title',    WinGetTitle(hwnd),
; 				'class',    WinGetClass(hwnd),
; 				'process',  WinGetProcessName(hwnd),
; 				'controls', WinGetControls(hwnd)
; 			)
; 	return win_info
; }
; p := win_info_process := get_win_details_all(hHzn).process
; OutputDebug('newValue: ' p '`n')
; initial_list_ClassNN := []
; i_lCtlN_h := initial_list_ClassNN
; initial_list_ClassNN_hwnd := []


; WinGetListList := []
; initial_controls_map := Map()

process_name := WinGetProcessName(hHzn)
process_hwnd_dll := DllCall('GetCurrentProcess', 'Ptr')
process_ID_dll := DllCall('GetCurrentProcessId')
name_process_ID_dll := WinGetProcessName()
try {
	GetAncestor_hwnd := DllCall("GetAncestor", "UInt", hHzn, "Uint", 2)
	GetAncestor_process_name := WinGetProcessName(GetAncestor_hwnd)
	try {
		if (GetAncestor_process_name == process_name) && (GetAncestor_hwnd == hHzn){
		OutputDebug('It`'s Horizon: ' . process_name . ' (' . hHzn . ')`n' . 'process_hwnd_dll: ' . process_hwnd_dll . '`n' . 'name_process_ID_dll: ' . name_process_ID_dll . ' process_ID_dll: ' . process_ID_dll . '`n')
		initial_list_ClassNN := WinGetControls('A')
		; for each, value in initial_list_ClassNN {
		; 	try {
		; 		initial_list_ClassNN_hwnd := ControlGetHwnd(initial_list_ClassNN, 'A')
		; 		OutputDebug('initial_list_ClassNN: ' . value . 'initial_list_ClassNN_hwnd' . initial_list_ClassNN_hwnd . '`n')
		; 		initial_controls_map.Push(initial_list_ClassNN . ' (' . initial_list_ClassNN_hwnd . ')')
		; 	}
		; }
		; } else {
		; 	try {	
		; 	OutputDebug(GetAncestor_process_name . ' (' . GetAncestor_hwnd . ')`n')
		; 		WinGetListList := WinGetList(hwnd)
		; 		for each, value in WinGetListList
		; 			OutputDebug('value:' . value . '`n')
		; 	}
		}
	}
}


; If (WinActive('A') ~= 'i).*h.*z.*n.*'){
; 	OutputDebug('First Try: ' . 'True' . '`n')
; }
; for hWinGetList in WinGetList() { ; TODO this is way way cooler and a more extensive list of stuff
; for hWinGetList in WinGetList(hwnd) {
; 	SendLevel(((A_SendLevel < 100) ? (A_SendLevel + 1):(A_SendLevel)))
; 	BlockInput(1)
; 	pvTxt := A_DetectHiddenText, DetectHiddenText(1)
; 	pvWin := A_DetectHiddenWindows, DetectHiddenWindows(1)
; 	; txneedle := 'i)\wt.*x.*'
; 	txneedle := 'i).*t.*x.*'
; 	; try {
; 		; gOpenWindows[hWinGetList] := ControlGetClassNN(hWinGetList)
; 		; tryWinGetList := gOpenWindows[hWinGetList] := ControlGetClassNN(hWinGetList)
; 		; OutputDebug('Pre(' . A_Index . ') ' . gOpenWindows[hWinGetList] . '`n') ; cool, but not useful
; 		; if ((gOpenWindows[hWinGetList] ~= 'i)t.*x.*'))
; 		; if ((tryWinGetList ~= txneedle))
; 		; 	OutputDebug('Post(' . A_Index . ') ' . tryWinGetList) ; cool, but not useful
; 	; } catch {
; 	try {
; 		gOpenWindows[hWinGetList] := DllCall("GetAncestor", "UInt", hWinGetList, "Uint", 2)
; 		; if (gOpenWindows[hWinGetList] = 'Default IME'){
; 		; 	return
; 		; }
; 		OutputDebug('Post1(' . A_Index . ') ' . gOpenWindows[hWinGetList] '`n') ; cool, but not useful
; 		if (gOpenWindows[hWinGetList] = 'Default IME'){
; 			return
; 		}
; 		gOpenWindows[hWinGetList] := WinGetTitle(hWinGetList)
; 		OutputDebug('Post2(' . A_Index . ') ' . gOpenWindows[hWinGetList] '`n') ; cool, but not useful
; 		if (gOpenWindows[hWinGetList] = 'Default IME'){
; 			return
; 		}
; 	} finally {
; 		gOpenWindows[hWinGetList] := WinGetClass(hWinGetList)
; 		OutputDebug('Post3(' . A_Index . ') ' . gOpenWindows[hWinGetList] '`n') ; cool, but not useful
; 	}
; 	DetectHiddenText(pvTxt), DetectHiddenWindows(pvWin)
; 	BlockInput(0)
; 	SendLevel(0)
; }
hook := SetWinEventHook(HandleWinEvent, hHzn)

SetWinEventHook(callbackFunc, winTitle := 0, eventMin := 0x8000, eventMax := 0x8001, flags := 0x0002) {
	initialSendLevel := A_SendLevel
	SendLevel(((A_SendLevel < 100) && (initialSendLevel >= 1) ? (A_SendLevel) : (A_SendLevel + 1)))
	BlockInput(1)
	pvTxt := A_DetectHiddenText, DetectHiddenText(1)
	pvWin := A_DetectHiddenWindows, DetectHiddenWindows(1)
	EVENT_OBJECT_ACCELERATORCHANGE 	:= 0x8012, 	EVENT_OBJECT_STATECHANGE := 32778, 
	EVENT_OBJECT_CLOAKED 			:= 0x8017, 	EVENT_OBJECT_CONTENTSCROLLED := 0x8015, 
	EVENT_OBJECT_CONTENTSCROLLED 	:= 0x8015, 	EVENT_OBJECT_DEFACTIONCHANGE := 0x8011, 
	EVENT_OBJECT_DESCRIPTIONCHANGE 	:= 0x800D, 	EVENT_OBJECT_CREATE := 32768, 
	EVENT_OBJECT_DESTROY 			:= 32769, 	EVENT_OBJECT_DRAGSTART := 0x8021, 
	EVENT_OBJECT_DRAGCANCEL 		:= 0x8022, 	EVENT_OBJECT_DRAGCOMPLETE := 0x8023, 
	EVENT_OBJECT_DRAGENTER 			:= 0x8024, 	EVENT_OBJECT_DRAGLEAVE := 0x8025, 
	EVENT_OBJECT_DRAGDROPPED 		:= 0x8026, 	EVENT_OBJECT_END := 32769, 
	EVENT_OBJECT_FOCUS 				:= 0x8005, 	EVENT_OBJECT_HELPCHANGE := 0x8010, 
	EVENT_OBJECT_HIDE 				:= 0x8003, 	EVENT_OBJECT_HOSTEDOBJECTSINVALIDATED := 0x8020, 
	EVENT_OBJECT_IME_HIDE 			:= 0x8028, 	EVENT_OBJECT_IME_SHOW := 0x8027, 
	EVENT_OBJECT_IME_CHANGE 		:= 0x8029, 	EVENT_OBJECT_INVOKED := 0x8013, 			EVENT_OBJECT_LIVEREGIONCHANGED 	:= 0x8019, 	EVENT_OBJECT_LOCATIONCHANGE := 0x800B, 		
	EVENT_OBJECT_NAMECHANGE 		:= 0x800C, 	EVENT_OBJECT_PARENTCHANGE := 0x800F, 
	EVENT_OBJECT_REORDER 			:= 0x8004, 	EVENT_OBJECT_SELECTION := 0x8006, 
	EVENT_OBJECT_SELECTIONADD 		:= 0x8007, 	EVENT_OBJECT_SELECTIONREMOVE := 0x8008, 	
	EVENT_OBJECT_SELECTIONWITHIN 	:= 0x8009, 	EVENT_OBJECT_SHOW := 0x8002, 
	EVENT_OBJECT_TEXTEDIT_CONVERSIONTARGETCHANGED 	:= 0x8030, 
	EVENT_OBJECT_TEXTSELECTIONCHANGED 				:= 0x8014, 
	EVENT_OBJECT_UNCLOAKED 			:= 0x8018, 
	EVENT_OBJECT_VALUECHANGE 		:= 0x800E, 	EVENT_SYSTEM_ALERT := 0x0002, 
	EVENT_SYSTEM_ARRANGMENTPREVIEW 	:= 0x8016, 	EVENT_SYSTEM_CAPTUREEND := 0x0009, 
	EVENT_SYSTEM_CAPTURESTART 		:= 0x0008, 	EVENT_SYSTEM_CONTEXTHELPEND := 0x000D, 
	EVENT_SYSTEM_CONTEXTHELPSTART 	:= 0x000C, 	EVENT_SYSTEM_DESKTOPSWITCH := 0x0020, 
	EVENT_SYSTEM_DIALOGEND 			:= 0x0011, 	EVENT_SYSTEM_DIALOGSTART := 0x0010, 
	EVENT_SYSTEM_DRAGDROPEND 		:= 0x000F, 	EVENT_SYSTEM_DRAGDROPSTART := 0x000E, 
	EVENT_SYSTEM_END 				:= 0x00FF, 	EVENT_SYSTEM_FOREGROUND := 0x0003, 
	EVENT_SYSTEM_MENUSTART 			:= 0x0004, 	EVENT_SYSTEM_MENUEND := 0x0005, 
	EVENT_SYSTEM_MENUPOPUPSTART 	:= 0x0006, 	EVENT_SYSTEM_MENUPOPUPEND := 0x0007, 
	EVENT_SYSTEM_MINIMIZEEND 		:= 0x0017, 	EVENT_SYSTEM_MINIMIZESTART := 0x0016, 
	EVENT_SYSTEM_MOVESIZEEND 		:= 0x000B, 	EVENT_SYSTEM_MOVESIZESTART := 0x000A, 
	EVENT_SYSTEM_SCROLLINGEND 		:= 0x0013, 	EVENT_SYSTEM_SCROLLINGSTART := 0x0012, 
	EVENT_SYSTEM_SOUND 				:= 0x0001, 	EVENT_SYSTEM_SWITCHEND := 0x0015, 
	EVENT_SYSTEM_SWITCHSTART 		:= 0x0014
	local PID := 0, callbackFuncType, 
	hook := { winTitle: winTitle, flags: flags, eventMin: eventMin, eventMax: eventMax, threadId: 0 }
	callbackFuncType := Type(callbackFunc)
	if !(callbackFuncType = "Func" || callbackFuncType = "Closure")
		throw ValueError("The callbackFunc argument must be a function", -1)
	if winTitle != 0 {
		if !(hook.winTitle := WinExist(winTitle))
			throw TargetError("Window not found", -1)
		hook.threadId := DllCall("GetWindowThreadProcessId", "Int", hook.winTitle, "UInt*", &PID)
		thPID := PID
	}
	OutputDebug('threadPID: ' . thPID . '`n')
	hook.hHook := DllCall("SetWinEventHook",
		"UInt", eventMin, 
		"UInt", eventMax, 
		"Ptr", 	0, 
		; "Ptr", 	hook.callback := CallbackCreate(callbackFunc, "C Fast", 7), 
		"Ptr", 	hook.callback := CallbackCreate(callbackFunc,, 7), 
		"UInt", hook.PID := PID, "UInt", hook.threadId, "UInt", flags)
	
	hook.DefineProp("__Delete", 
	{ call: (this) => (DllCall("UnhookWinEvent", "Ptr", this.hHook), CallbackFree(this.callback)) })

	DetectHiddenText(pvTxt), DetectHiddenWindows(pvWin)
	BlockInput(0)
	SendLevel(0)
	return hook
}
HandleWinEvent(hWinEventHook, event, ghwnd, idObject, idChild, idEventThread, dwmsEventTime) {
	initialSendLevel := A_SendLevel
	SendLevel(((A_SendLevel < 100) && (initialSendLevel >= 1) ? (A_SendLevel):(A_SendLevel + 1)))
	BlockInput(1)
	pvTxt := A_DetectHiddenText, DetectHiddenText(1)
	pvWin := A_DetectHiddenWindows, DetectHiddenWindows(1)
	static EVENT_OBJECT_CREATE := 32768, EVENT_OBJECT_DESTROY := 32769, OBJID_WINDOW := 0, INDEXID_CONTAINER := 0
	; global gOpenWindows
	; static hznCtrls_map := Map()
	static hznCtrlsarray_ClassNN := []
	static hznCtrlsarray_hwnd := []
	; static hznCtrlsList := []
	static hznmsvbTbClassNN := []
	static hznmsvbTbHwnd := []
	; --------------------------------------------------------------------------------
	mKey := ''
	mVal := ''
	instr_array_Tb := []
	instr_array_hTb := []
	instr_map := Map()
	static match_instr_map := Map()
	static destroyed_instr_map := Map()
	; --------------------------------------------------------------------------------
	static needle := 'i)m.*bar\d'
	static pneedle := 'i).*hznhorizon.*'
	hznCtrls := ''
	matchTbClassNN := ''
	matchTbHwnd := ''
	matchTb := ''
	; needle := 'im)(\w+\sbar\w+)'
	static hwnd := WinExist('ahk_exe hznhorizon.exe')
	static process_name := WinGetProcessName(hwnd)
	static win_active_title_array := []
	static win_active_array := []
	try {
		win_active := WinActive('A')
		win_active_title := WinGetTitle(win_active)
		win_active_title_array.Push(win_active_title)
	for each, value in win_active_title_array {
		if (win_active_title_array.Has(value)) {
			OutputDebug('titlebreak: ' . win_active_title_array.Has(value))
			break
		}
	}
	win_active_array.Push(win_active)
	for each, value in win_active_array {
		if (win_active_array.Has(value)){
			OutputDebug('titlebreak: ' . win_active_array.Has(value))
			break
		}
	}
	}
	try {
		OutputDebug('Should Only Be One:`n' . 'win_active: ' . win_active_title . ' (' . win_active . ')' . '`n')
	}
	while !(process_name ~= pneedle){
		break
	}
	if (process_name ~= pneedle) && (WinGetProcessName(WinActive('A')) ~= pneedle){
		try {
			hznCtrlsarray_ClassNN := WinGetControls('A')
		}
		for hznCtrls in hznCtrlsarray_ClassNN {
			; --------------------------------------------------------------------------------
			if (instr_map.Has(hznCtrls)) {
				return
			}
			; ; --------------------------------------------------------------------------------
			; else if (InStr(hznCtrls, '_toolbar')) {
			; 	; ----------------------------------------
			; 	instr_hTb := ControlGetHwnd(hznCtrls, 'A')
			; 	; ----------------------------------------
			; 	instr_Instance := SubStr(hznCtrls, -1, 1)
			; 	test_split := StrSplit(hznCtrls, instr_Instance)
			; 	; ----------------------------------------
			; 	instr_array_Tb.Push(hznCtrls)
			; 	instr_array_hTb.Push(instr_hTb)
			; 	; instr_map.Set('Instance',instr_Instance,hznCtrls,instr_hTb)
			; 	instr_map.Set(hznCtrls,instr_hTb)
			; 	OutputDebug(  'InStr: ' hznCtrls . '`n' 
			; 				. 'has? ' hznmsvbTbClassNN.Has(hznCtrls) . '`n' 
			; 				. 'length: ' . hznmsvbTbClassNN.Length . '`n'
			; 				. 'TbPush: ' . hznCtrls . ' hTbPush(' . instr_hTb . ')' . '`n'
			; 				. 'Instance: ' . instr_Instance . '`n'
			; 			)
			; }
			; if (hznCtrls ~= needle) {
			; 	if (hznmsvbTbClassNN.Has(hznCtrls)){
			; 		matchTbHwnd := ControlGetHwnd(hznCtrls, 'A')
			; 		while (hznmsvbTbHwnd.Has(matchTbHwnd)) {
			; 			OutputDebug('hTb_break: ' . hznmsvbTbHwnd.Has(matchTbHwnd))
			; 			break
			; 		}
			; 	} else {
			; 		try {
			; 			hznmsvbTbClassNN.Push(hznCtrls)
			; 			matchTbHwnd := ControlGetHwnd(hznCtrls, 'A')
			; 			hznmsvbTbHwnd.Push(matchTbHwnd)
			; 			OutputDebug('New: ' . hznCtrls . ' (' . matchTbHwnd . ')' . '`n')
			; 		}
			; 	}
			; }
		}
	}
	if (event == EVENT_OBJECT_CREATE) {
		; --------------------------------------------------------------------------------
		for hznCtrls in hznCtrlsarray_ClassNN {
			; --------------------------------------------------------------------------------
			try if (InStr(hznCtrls, '_toolbar')) {
				; ----------------------------------------
				instr_hTb := ControlGetHwnd(hznCtrls, 'A')
				; ----------------------------------------
				instr_Instance := SubStr(hznCtrls, -1, 1)
				test_split := StrSplit(hznCtrls, instr_Instance)
				; ----------------------------------------
				instr_array_Tb.Push(hznCtrls)
				instr_array_hTb.Push(instr_hTb)
				; instr_map.Set('Instance',instr_Instance,hznCtrls,instr_hTb)
				instr_map.Set(hznCtrls,instr_hTb)
				OutputDebug(  'InStr: ' hznCtrls . '`n' 
							. 'has? ' hznmsvbTbClassNN.Has(hznCtrls) . '`n' 
							. 'length: ' . hznmsvbTbClassNN.Length . '`n'
							. 'TbPush: ' . hznCtrls . ' hTbPush(' . instr_hTb . ')' . '`n'
							. 'Instance: ' . instr_Instance . '`n'
						)
				try {
					for mKey, mVal in instr_map {
						OutputDebug(  '----------[instr_map]----------------`n'
									. 'key: ' 	. mKey 				. '`n'
									. 'value: ' . mVal 				. '`n'
									. 'count: ' . instr_map.Count 	. '`n'
									. 'split: ' . test_split[1]		. '`n'
									. '-------------------------------------`n'
								)
						HznEnableButtons(mVal)
						match_instr_map.Set(mKey,mVal)
					}
				}
			}
			; --------------------------------------------------------------------------------
		}
		; --------------------------------------------------------------------------------
	} else if (event = EVENT_OBJECT_DESTROY) {
		; --------------------------------------------------------------------------------
		for hznCtrls in hznCtrlsarray_ClassNN {
			; --------------------------------------------------------------------------------
			if (match_instr_map.Has(hznCtrls)) {
				dTb := hznCtrls
				dhTb := ControlGetHwnd(hznCtrls)
				destroyed_instr_map.Set(dTb,dhTb)
				OutputDebug(  'dTb: ' . dTb . '`n'
							. 'dhTb: ' . dhTb . '`n' )
				match_instr_map.Delete(hznCtrls)
			}
			; --------------------------------------------------------------------------------
			mTb := ''
			mhTb := ''
			for mTb, mhTb in match_instr_map {
				; instr_array_Tb.RemoveAt(A_Index)
				match_instr_map.Delete(mTb)
				destroyed_instr_map.Set(mTb,mhTb)
				OutputDebug(  '---------[match_instr_map]-----------`n'
							. 'mTb: ' 	. mTb 	. '`n'
							. 'mhTb: ' 	. mhTb 	. '`n'
							. '-------------------------------------`n'
						)
			}
			; --------------------------------------------------------------------------------
		}
		; --------------------------------------------------------------------------------
		des_Tb := ''
		des_hTb := ''
		for des_Tb, des_hTb in destroyed_instr_map {
			; instr_array_Tb.RemoveAt(A_Index)
			OutputDebug(  '---------[EVENT_OBJECT_DESTROY]---------`n'
						. 'des_Tb: ' 	. des_Tb 	. '`n'
						. 'des_hTb: ' 	. des_hTb 	. '`n'
						. '----------------------------------------`n'
					)
		}
	}
	; --------------------------------------------------------------------------------
	DetectHiddenText(pvTxt), DetectHiddenWindows(pvWin)
	BlockInput(0)
	SendLevel(0)
}

; --------------------------------------------------------------------------------
ShellHook_AProcess()
{
	; Global HSHELL_RUDEAPPACTIVATED := 32772
	hWnd := WinActive('A')
	DllCall("RegisterShellHookWindow", "UInt", A_ScriptHwnd)
	OnMessage(DllCall("RegisterWindowMessage", "Str", "SHELLHOOK"), A_Process_GetInfo)
	; OnMessage(DllCall("RegisterWindowMessage", "Str", "SHELLHOOK"), MyFunc)
}
A_Process_GetInfo(event, hwnd,*) {
	initialSendLevel := A_SendLevel
	SendLevel(((A_SendLevel < 100) && (initialSendLevel >= 1) ? (A_SendLevel) : (A_SendLevel + 1)))
	BlockInput(1)
	pvTxt := A_DetectHiddenText, DetectHiddenText(1)
	pvWin := A_DetectHiddenWindows, DetectHiddenWindows(1)
	; --------------------------------------------------------------------------------
	hook := SetWinEventHook(HandleWinEvent)
	; --------------------------------------------------------------------------------
	HSHELL_WINDOWCREATED := 1, HSHELL_WINDOWDESTROYED := 2, HSHELL_ACTIVATESHELLWINDOW := 3, HSHELL_WINDOWACTIVATED := 4, HSHELL_WINDOWACTIVATED := 32772, HSHELL_GETMINRECT := 5, HSHELL_REDRAW := 6, HSHELL_TASKMAN := 7, HSHELL_LANGUAGE := 8, HSHELL_SYSMENU := 9, HSHELL_ENDTASK := 10, HSHELL_ACCESSIBILITYSTATE := 11, HSHELL_APPCOMMAND := 12, HSHELL_WINDOWREPLACED := 13, HSHELL_WINDOWREPLACING := 14, HSHELL_HIGHBIT := 32768, HSHELL_RUDEAPPACTIVATED := 32772, HSHELL_FLASH := 32774

	nEvent := (event = 1) ? 'HSHELL_WINDOWCREATED' : (event = 2) ? 'HSHELL_WINDOWDESTROYED' : (event = 3) ? 'HSHELL_ACTIVATESHELLWINDOW' : (event = 4) ? 'HSHELL_WINDOWACTIVATED' : (event = 32772) ? 'HSHELL_RUDEAPPACTIVATED' : (event = 5) ? 'HSHELL_GETMINRECT' : (event = 6) ? 'HSHELL_REDRAW' : (event = 7) ? 'HSHELL_TASKMAN' : (event = 8) ? 'HSHELL_LANGUAGE' : (event = 9) ? 'HSHELL_SYSMENU' : (event = 10) ? 'HSHELL_ENDTASK' : (event = 11) ? 'HSHELL_ACCESSIBILITYSTATE' : (event = 12) ? 'HSHELL_APPCOMMAND' : (event = 13) ? 'HSHELL_WINDOWREPLACED' : (event = 14) ? 'HSHELL_WINDOWREPLACING' : (event = 32768) ? 'HSHELL_HIGHBIT' : (event = 32774) ? 'HSHELL_FLASH' : 'No Event'
	if ((event = 1) || (event = 3) || (event = 4) || (event = 32772)) {

		hznHwnd := 0
		matches := []
		match := ''
		hWnd := WinActive('A')
		DllCall("GetWindowThreadProcessId", "Int", hwnd, "Int*", &tpID := 0)
		name := WinGetProcessName(hwnd)
		A_Process := name
		HznToolTip()
	}
	; --------------------------------------------------------------------------------
	HznToolTip() {
		ToolTip('A_Process: ' . A_Process . ' '
			. tpID . ' (tPID) ' . hWnd . ' (hWnd)' . '`n'
			. 'Event: ' . nEvent . ' (' . event . ')' . '`n'
			, 0, 0
		)
	}
	; --------------------------------------------------------------------------------
	DetectHiddenText(pvTxt), DetectHiddenWindows(pvWin)
	BlockInput(0), SendLevel(0)
	return A_Process
}







/*
test_A_Process_GetInfo(event, hwnd,*) {
	; Shell Hook Events:
	HSHELL_WINDOWCREATED := 1, HSHELL_WINDOWDESTROYED := 2, HSHELL_ACTIVATESHELLWINDOW := 3, HSHELL_WINDOWACTIVATED := 4, HSHELL_WINDOWACTIVATED := 32772, HSHELL_GETMINRECT := 5, HSHELL_REDRAW := 6, HSHELL_TASKMAN := 7, HSHELL_LANGUAGE := 8, HSHELL_SYSMENU := 9, HSHELL_ENDTASK := 10, HSHELL_ACCESSIBILITYSTATE := 11, HSHELL_APPCOMMAND := 12, HSHELL_WINDOWREPLACED := 13, HSHELL_WINDOWREPLACING := 14, HSHELL_HIGHBIT := 32768, HSHELL_RUDEAPPACTIVATED := 32772, HSHELL_FLASH := 32774
	; 32768 = 0x8000 = HSHELL_HIGHBIT := 32768
	; 32772 = 0x8000 + 4 = 0x8004 = HSHELL_RUDEAPPACTIVATED := 32772 (HSHELL_HIGHBIT + HSHELL_WINDOWACTIVATED)
	; 32774 = 0x8000 + 6 = 0x8006 = HSHELL_FLASH := 32774 (HSHELL_HIGHBIT + HSHELL_REDRAW)
	; EVENT_OBJECT_CREATE := 32768 (0x8000)
	; --------------------------------------------------------------------------------
	EVENT_OBJECT_ACCELERATORCHANGE := 0x8012, 	EVENT_OBJECT_STATECHANGE := 32778, 
	EVENT_OBJECT_CLOAKED := 0x8017, 			EVENT_OBJECT_CONTENTSCROLLED := 0x8015, 
	EVENT_OBJECT_CONTENTSCROLLED := 0x8015, 	EVENT_OBJECT_DEFACTIONCHANGE := 0x8011, 
	EVENT_OBJECT_DESCRIPTIONCHANGE := 0x800D, 	EVENT_OBJECT_CREATE := 32768, 
	EVENT_OBJECT_DESTROY := 0x8001, 			EVENT_OBJECT_DRAGSTART := 0x8021, 
	EVENT_OBJECT_DRAGCANCEL := 0x8022, 			EVENT_OBJECT_DRAGCOMPLETE := 0x8023, 
	EVENT_OBJECT_DRAGENTER := 0x8024, 			EVENT_OBJECT_DRAGLEAVE := 0x8025, 
	EVENT_OBJECT_DRAGDROPPED := 0x8026, 		EVENT_OBJECT_END := 0x80FF, 
	EVENT_OBJECT_FOCUS := 0x8005, 				EVENT_OBJECT_HELPCHANGE := 0x8010, 
	EVENT_OBJECT_HIDE := 0x8003, 				EVENT_OBJECT_HOSTEDOBJECTSINVALIDATED := 0x8020, 
	EVENT_OBJECT_IME_HIDE := 0x8028, 			EVENT_OBJECT_IME_SHOW := 0x8027, 
	EVENT_OBJECT_IME_CHANGE := 0x8029, 			EVENT_OBJECT_INVOKED := 0x8013, 			EVENT_OBJECT_LIVEREGIONCHANGED := 0x8019, 	EVENT_OBJECT_LOCATIONCHANGE := 0x800B, 		
	EVENT_OBJECT_NAMECHANGE := 0x800C, 			EVENT_OBJECT_PARENTCHANGE := 0x800F, 
	EVENT_OBJECT_REORDER := 0x8004, 			EVENT_OBJECT_SELECTION := 0x8006, 
	EVENT_OBJECT_SELECTIONADD := 0x8007, 		EVENT_OBJECT_SELECTIONREMOVE := 0x8008, 	
	EVENT_OBJECT_SELECTIONWITHIN := 0x8009, 	EVENT_OBJECT_SHOW := 0x8002, 
	EVENT_OBJECT_TEXTEDIT_CONVERSIONTARGETCHANGED := 0x8030, 
	EVENT_OBJECT_TEXTSELECTIONCHANGED := 0x8014, 
	EVENT_OBJECT_UNCLOAKED := 0x8018, 
	EVENT_OBJECT_VALUECHANGE := 0x800E, 		EVENT_SYSTEM_ALERT := 0x0002, 
	EVENT_SYSTEM_ARRANGMENTPREVIEW := 0x8016, 	EVENT_SYSTEM_CAPTUREEND := 0x0009, 
	EVENT_SYSTEM_CAPTURESTART := 0x0008, 		EVENT_SYSTEM_CONTEXTHELPEND := 0x000D, 
	EVENT_SYSTEM_CONTEXTHELPSTART := 0x000C, 	EVENT_SYSTEM_DESKTOPSWITCH := 0x0020, 
	EVENT_SYSTEM_DIALOGEND := 0x0011, 			EVENT_SYSTEM_DIALOGSTART := 0x0010, 
	EVENT_SYSTEM_DRAGDROPEND := 0x000F, 		EVENT_SYSTEM_DRAGDROPSTART := 0x000E, 
	EVENT_SYSTEM_END := 0x00FF, 				EVENT_SYSTEM_FOREGROUND := 0x0003, 
	EVENT_SYSTEM_MENUSTART := 0x0004, 			EVENT_SYSTEM_MENUEND := 0x0005, 
	EVENT_SYSTEM_MENUPOPUPSTART := 0x0006, 		EVENT_SYSTEM_MENUPOPUPEND := 0x0007, 
	EVENT_SYSTEM_MINIMIZEEND := 0x0017, 		EVENT_SYSTEM_MINIMIZESTART := 0x0016, 
	EVENT_SYSTEM_MOVESIZEEND := 0x000B, 		EVENT_SYSTEM_MOVESIZESTART := 0x000A, 
	EVENT_SYSTEM_SCROLLINGEND := 0x0013, 		EVENT_SYSTEM_SCROLLINGSTART := 0x0012, 
	EVENT_SYSTEM_SOUND := 0x0001, 				EVENT_SYSTEM_SWITCHEND := 0x0015, 
	EVENT_SYSTEM_SWITCHSTART := 0x0014

	nEvent := (event = 1) ? 'HSHELL_WINDOWCREATED' : (event = 2) ? 'HSHELL_WINDOWDESTROYED' : (event = 3) ? 'HSHELL_ACTIVATESHELLWINDOW' : (event = 4) ? 'HSHELL_WINDOWACTIVATED' : (event = 32772) ? 'HSHELL_RUDEAPPACTIVATED' : (event = 5) ? 'HSHELL_GETMINRECT' : (event = 6) ? 'HSHELL_REDRAW' : (event = 7) ? 'HSHELL_TASKMAN' : (event = 8) ? 'HSHELL_LANGUAGE' : (event = 9) ? 'HSHELL_SYSMENU' : (event = 10) ? 'HSHELL_ENDTASK' : (event = 11) ? 'HSHELL_ACCESSIBILITYSTATE' : (event = 12) ? 'HSHELL_APPCOMMAND' : (event = 13) ? 'HSHELL_WINDOWREPLACED' : (event = 14) ? 'HSHELL_WINDOWREPLACING' : (event = 32768) ? 'HSHELL_HIGHBIT' : (event = 32774) ? 'HSHELL_FLASH' : 'No Event'
	; //0x800A = EVENT_OBJECT_STATECHANGE := 32778
	; (hookevent = 0x8012) ? 'EVENT_OBJECT_ACCELERATORCHANGE' : 'Fail'
	; = 'EVENT_OBJECT_CLOAKED'
	; if (event != HSHELL_RUDEAPPACTIVATED || !hwnd || !1){
	; 	return
	; }
	; if ((event = 1) || (event = 2) || (event = 3) || (event = 4) || (event = 32772)) {
	if ((event = 1) || (event = 3) || (event = 4) || (event = 32772)) {
	SendLevel((A_SendLevel + 1))
	BlockInput(1)
	pvTxt := A_DetectHiddenText, DetectHiddenText(1)
	pvWin := A_DetectHiddenWindows, DetectHiddenWindows(1)
	hznHwnd := 0
	matches := []
	match := ''
	hWnd := WinActive('A')
	
	; hznGUI := Gui('+LastFound') ;, A_Process)
	
	; hznGUI.Opt('LastFound')
	; OutputDebug(hznGUI.Opt('LastFound'))
	; GuiControlObj := GuiCtrlFromHwnd(Hwnd)
	DllCall("GetWindowThreadProcessId", "Int", hwnd, "Int*", &tpID := 0)
	name := WinGetProcessName(hwnd)
	A_Process := name
	; if (A_Process ~= 'i).*hznHorizon.*'){
	; 	hznGui.OnEvent('32768'||'32778'||'0x8002',OtherToolTip)
	; }
	; hznGUI.Show()

	HznToolTip()
; ------------------------------------------

; hWinEventHook := DllCall("SetWinEventHook"
; 	, "UInt", eventMin ;  UINT eventMin
; 	, "UInt", eventMax ;  UINT eventMax
; 	, "Ptr", 0x0 ;  HMODULE hmodWinEventProc
; 	, "Ptr", CB_WinEventProc ;  WINEVENTPROC lpfnWinEventProc
; 	, "UInt", idProcess ;  DWORD idProcess
; 	, "UInt", 0x0 ;  DWORD idThread
; 	, "UInt", 0x0 | 0x2) ;  UINT dwflags, OutOfContext|SkipOwnProcess
	; ------------------------------------------
	HznToolTip() {
		ToolTip('A_Process: ' . A_Process . ' '
			. tpID . ' (tPID) ' . hWnd . ' (hWnd)' . '`n'
			. 'Event: '		. event . '`n'
			. 'nEvent: '		. nEvent . '`n'
			; . 'C_Focus_Hwnd:  '	. fCtl . '`n'
			; . 'C_Focus_Class:  '	. hCtl . '`n'
			; . 'List: '		. list . '`n'
			, 0, 0
		)
	}
	OtherToolTip() {
		ToolTip('A_Process: ' . A_Process . ' '
			; . 'C_Focus_Hwnd:  '	. fCtl . '`n'
			; . 'C_Focus_Class:  '	. hCtl . '`n'
			; . 'List: '		. list . '`n'
			, 0, 0
		)
	}
	; ------------------------------------------
		DetectHiddenText(pvTxt), DetectHiddenWindows(pvWin)
		BlockInput(0)
		SendLevel(0)
		return A_Process
	}
	}
*/
class WinEventHook
{
	__New(eventMin, eventMax, hookProc, options := '', idProcess := 0, idThread := 0, dwFlags := 0) {
		this.pCallback := CallbackCreate(hookProc, options, 7)
		this.hHook := DllCall('SetWinEventHook', 'UInt', eventMin, 'UInt', eventMax, 'Ptr', 0, 'Ptr', this.pCallback
			, 'UInt', idProcess, 'UInt', idThread, 'UInt', dwFlags, 'Ptr')
	}
	__Delete() {
		DllCall('UnhookWinEvent', 'Ptr', this.hHook)
		CallbackFree(this.pCallback)
	}
}

; #Requires AutoHotkey v2

; Map out all open windows so we can keep track of their names when they're closed.
; After the window close event the windows no longer have their titles, so we can't do it afterwards.

; Set up our hook. Putting it in a variable is necessary to keep the hook alive, since once it gets
; rewritten (for example with hook := "") the hook is automatically destroyed.
; hook := SetWinEventHook(HandleWinEvent)
; We have no hotkeys, so Persistent is required to keep the script going.
; Persistent()

/**
 * Our event handler which needs to accept 7 arguments. To ignore some of them use the * character,
 * for example HandleWinEvent(hWinEventHook, event, hwnd, idObject, idChild, *)
 * @param hWinEventHook Handle to an event hook function. This isn't useful for our purposes 
 * @param event Specifies the event that occurred. This value is one of the event constants (https://learn.microsoft.com/en-us/windows/win32/winauto/event-constants).
 * @param hwnd Handle to the window that generates the event, or NULL if no window is associated with the event.
 * @param idObject Identifies the object associated with the event.
 * @param idChild Identifies whether the event was triggered by an object or a child element of the object.
 * @param idEventThread Id of the thread that triggered this event.
 * @param dwmsEventTime Specifies the time, in milliseconds, that the event was generated.
 */


/**
 * Sets a new WinEventHook and returns on object describing the hook. 
 * When the object is released, the hook is also released.
 * @param callbackFunc The function that will be called, which needs to accept 7 arguments:
 *    hWinEventHook, event, hwnd, idObject, idChild, idEventThread, dwmsEventTime
 * @param winTitle Optional: WinTitle of a certain window to hook to. Default is system-wide hook.
 * @param eventMin Optional: Specifies the event constant for the lowest event value in the range of events that are handled by the hook function.
 *  Default is EVENT_OBJECT_CREATE = 0x8000
 *  See more about event constants: https://learn.microsoft.com/en-us/windows/win32/winauto/event-constants
 * @param eventMax Optional: Specifies the event constant for the highest event value in the range of events that are handled by the hook function.
 *  Default is EVENT_OBJECT_DESTROY = 0x8001
 * @param flags Flag values that specify the location of the hook function and of the events to be skipped.
 *  Default is WINEVENT_OUTOFCONTEXT = 0 and WINEVENT_SKIPOWNPROCESS = 2. 
 * @returns {Object} 
 */
/*
