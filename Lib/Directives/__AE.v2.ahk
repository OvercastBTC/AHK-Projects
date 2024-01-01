/************************************************************************
 * function ......: Auto Execution (AE)
 * @description ..: A work in progress (WIP) of standard AE setup(s)
 * @file AE.v2.ahk
 * @author OvercastBTC
 * @date 2023.09.18
 * @version 1.0.0
 * @ahkversion v2+
 ***********************************************************************/
; --------------------------------------------------------------------------------
/************************************************************************
 * function ...........: Resource includes for .exe standalone
 * @author OvercastBTC
 * @date 2023.08.15
 * @version 3.0.2
 ***********************************************************************/
;@Ahk2Exe-IgnoreBegin
#Include <CheckUpdate\ScriptVersionMap>
version :=  ScriptVersion.ScriptVersionMap['main'] 
;@Ahk2Exe-IgnoreEnd
SetVersion := "3.0.0" ; If quoted literal not empty, do 'SetVersion'
;@Ahk2Exe-Nop
;@Ahk2Exe-Obey U_V, = "%A_PriorLine~U)^(.+")(.*)".*$~$2%" ? "SetVersion" : "Nop"
;@Ahk2Exe-%U_V% %A_PriorLine~U)^(.+")(.*)".*$~$2%
; --------------------------------------------------------------------------------
#Requires AutoHotkey v2+
#Warn All, OutputDebug
#SingleInstance Force
#WinActivateForce
; --------------------------------------------------------------------------------
#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
#MaxThreadsBuffer true
A_MaxHotkeysPerInterval := 1000
; --------------------------------------------------------------------------------
SendMode("Input")
SetWorkingDir(A_ScriptDir)
SetTitleMatchMode(2)
; --------------------------------------------------------------------------------
_AE_DetectHidden(true)
_AE_SetDelays(-1)
_AE_PerMonitor_DPIAwareness()

; --------------------------------------------------------------------------------
/**
 * Function: Includes
 */
#Include <App\Autohotkey>
#Include <Includes\Includes_Extensions>
#Include <Includes\Includes_DPI>
; #Include <Includes\Includes_Runner>
#Include <Tools\Info>
; ---------------------------------------------------------------------------
/**
 * Function ..: Create a shellhook to monitor for changes in Monitor DPI based on the Window location (hopefully).
 */
ShellHook(A_DPI_GetInfo)
; ---------------------------------------------------------------------------
toggleCapsLock(){
	SetCapsLockState(!GetKeyState('CapsLock', 'T'))
}
; ---------------------------------------------------------------------------
/**
 * function ...: Combine BlockInput() && SendLevel()
 * @example n 			 => default: n := 1
 * @example SendLevel()  => default: SendLevel(1)
 * @example BlockInput() => default: BlockInput(1) (1 = true)
 */
; ---------------------------------------------------------------------------
_AE_bInpt_sLvl(n := 1) => (SendLevel(n), BlockInput(n))
; _AE_bInpt_sLvl(n := 1) {
; 	SendLevel(n)
; 	BlockInput(n)
; }
; ---------------------------------------------------------------------------
_AE_DetectHidden(bool := true) {
	DetectHiddenText(bool)
	DetectHiddenWindows(bool)
}
; --------------------------------------------------------------------------------
_AE_SetDelays(n := -1) {
	SetControlDelay(n)
	SetMouseDelay(n)
	SetWinDelay(n)
}
; --------------------------------------------------------------------------------
_AE_PerMonitor_DPIAwareness() {
	MaximumPerMonitorDpiAwarenessContext := VerCompare(A_OSVersion, ">=10.0.15063") ? -4 : -3
	Global 	DefaultDpiAwarenessContext := MaximumPerMonitorDpiAwarenessContext, 
			A_DPIAwareness := DefaultDpiAwarenessContext
	try {
		DllCall("SetThreadDpiAwarenessContext", "ptr", MaximumPerMonitorDpiAwarenessContext, "ptr")
	}
	catch{ 
		DllCall("SetThreadDpiAwarenessContext", "ptr", -4, "ptr")
	}
	else {
		DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
	}
	return A_DPIAwareness
}
__AE_CopyLib() {
	local Lib := A_MyDocuments '\AutoHotkey\Lib'
	If !(DirExist(Lib)) {
		DirCreate(Lib)
	}
	FileCopy(A_ScriptName, Lib A_ScriptName, 1)
}
; ---------------------------------------------------------------------------
; $^c:: clip_it() ; Clip hotkey
; $^b:: clip_it(1) ; Paste last clip hotkey
clip_sleep(n:=50){
	; ---------------------------------------------------------------------------
	; @step If clipboard still in use (long paste), sleep for a bit
	; @param n ...: default value = 50 ms
	; ---------------------------------------------------------------------------
	While !DllCall('GetOpenClipboardWindow') {
		Sleep(n)
	}
}
clip_it(send_clip := 0) {
	Static last_clip := "" ; Track last clipboard
	If send_clip ; If send_clip is true
	{
		bak := ClipboardAll() ; Backup current clipboard
		A_Clipboard := last_clip ; Put last_clip onto clipboard
		Send('^v') ; Paste
		clip_sleep()
		A_Clipboard := bak ; Restore original clipboard
	}
	Else ; Else if send_clip false
	{
		last_clip := A_Clipboard ; Update last_clip with current clipboard
		clip_sleep()
		Send('^c') ; And then copy new contents to active clipboard
	}
}

AE_SelectAll(hCtl := ControlGetFocus('A'),*) {
	Static Msg := EM_SETSEL := 177, wParam := 0, lParam := -1
	return DllCall('SendMessage', 'UInt', hCtl, 'UInt', Msg, 'UInt', wParam, 'UIntP', lParam)
}
AE_Select_End(*) {
	Static Msg := EM_SETSEL := 177, wParam := -1, lParam := -1
	hCtl := ControlGetFocus('A')
	DllCall('SendMessage', 'UInt', hCtl, 'UInt', Msg, 'UInt', wParam, 'UInt', lParam)
	; return
}
AE_Select_Beginning(*) {
	Static Msg := EM_SETSEL := 177, wParam := 0, lParam := 0
	hCtl := ControlGetFocus('A')
	DllCall('SendMessage', 'UInt', hCtl, 'UInt', Msg, 'UInt', wParam, 'UInt', lParam)
	; return
}
AE_Set_Sel(wParam := 0, lParam := 0, hWnd := tryHwnd(),*) {
	Static Msg := EM_SETSEL := 177 ;, wParam := 0, lParam := 0
	; hCtl := ControlGetFocus('A')
	; DllCall('SendMessage', 'UInt', hCtl, 'UInt', Msg, 'UInt', wParam, 'UInt', lParam)
	DllCall('SendMessage', 'UInt', hWnd, 'UInt', Msg, 'UInt', wParam, 'UInt', lParam)
	; return
}
AE_Get_TEXTLIMIT(*) {
	; Static Msg := EM_GETLIMITTEXT := 1061, wParam := 0, lParam := 0
	; Static Msg := EM_GETTEXTLENGTH := 0x000E, wParam := 0, lParam := 0
	; Static Msg := WM_GETFONT := 0x0031, wParam := 0, lParam := 0
	; text := StrPtr('hznRTE ')
	; Static Msg := WM_SETTEXT := 0x000C, wParam := 0, lParam := text

	hCtl := ControlGetFocus('A')
	; Limit := DllCall('SendMessage', 'UInt', hCtl, 'UInt', Msg, 'UInt', wParam, 'UInt', lParam)
	; Limit := SendMessage(Msg,wParam, lParam, hCtl, hCtl)
	buff_size := 64000
	VarSetStrCapacity(&buff, buff_size)
	Static Msg := WM_GETTEXT := 0x000D, wParam := buff_size, lParam := &buff
	Text := SendMessage(Msg,wParam, lParam, hCtl, hCtl)
	afont := []
	afont := GuiCtrlTextSize(hCtl,text)
	for each, value in afont {
		font := ''
		font .= value . '`n'
	}
	Infos(font)
	GuiCtrlTextSize(GuiCtrlObj, Text)
	{
		Static WM_GETFONT := 0x0031, DT_CALCRECT := 0x400
		hDC := DllCall('GetDC', 'Ptr', GuiCtrlObj.Hwnd, 'Ptr')
		hPrevObj := DllCall('SelectObject', 'Ptr', hDC, 'Ptr', SendMessage(WM_GETFONT, , , GuiCtrlObj), 'Ptr')
		height := DllCall('DrawText', 'Ptr', hDC, 'Str', Text, 'Int', -1, 'Ptr', buf := Buffer(16), 'UInt', DT_CALCRECT)
		width := NumGet(buf, 8, 'Int') - NumGet(buf, 'Int')
		DllCall('SelectObject', 'Ptr', hDC, 'Ptr', hPrevObj, 'Ptr')
		DllCall('ReleaseDC', 'Ptr', GuiCtrlObj.Hwnd, 'Ptr', hDC)
		Return { Width: Round(width * 96 / A_ScreenDPI), Height: Round(height * 96 / A_ScreenDPI) }
	}
	; Return Limit
}
AE_GetSelText(ClassNN := ControlGetClassNN(ControlGetFocus('A')), hWnd := tryHwnd()) { ; Retrieves the currently selected text as plain text
	; Returns selected text.
	; EM_GETSELTEXT = 0x043E, EM_EXGETSEL = 0x0434
	Txt := ""
	CR := AE_GetSel()
	TxtL := CR.E - CR.S + 1
	If (TxtL > 1) {
		VarSetStrCapacity(&Txt, TxtL)
		SendMessage(0x043E, 0, StrPtr(Txt), ClassNN, hWnd)
		VarSetStrCapacity(&Txt, -1)
	}
	Return Txt
}
; --------------------------------------------------------------------------------
; Retrieves the starting and ending character positions of the selection in a rich edit control
; ---------------------------------------------------------------------------
AE_GetSel(ClassNN := 0, hWnd := tryHwnd()) { 
	; Returns an object containing the keys S (start of selection) and E (end of selection)).
	; EM_EXGETSEL = 0x0434
	try ClassNN := ControlGetClassNN(ControlGetFocus('A'))
	CR := Buffer(8, 0)
	CE := Buffer(8, 0)
	; SendMessage(0x0434, 0, CR.Ptr,ClassNN, hWnd)
	; SendMessage(0x00B0, 0, CE.Ptr,ClassNN, hWnd)
	; SendMessage(0x00B0, CR.Ptr,0 ,ClassNN, hWnd)
	SendMessage(0x00B0, 0, CE.Ptr,hWnd, hWnd)
	SendMessage(0x00B0, CR.Ptr,0 ,hWnd, hWnd)
	Return {S: NumGet(CR, 0, "Int"), E: NumGet(CE, 0, "Int")}
}
; --------------------------------------------------------------------------------
AE_GetText(ClassNN := ControlGetClassNN(ControlGetFocus('A')), hWnd := tryHwnd()) {  ; Gets the whole content of the control as plain text
	; EM_GETTEXTEX = 0x045E
	Txt := ""
	; If (TxtL := AE_GetTextLen() + 1) {
	If (TxtL := AE_GetTextLen(ClassNN, hWnd) + 1) {
		GTX := Buffer(12 + (A_PtrSize * 2), 0) ; GETTEXTEX structure
		NumPut("UInt", TxtL * 2, GTX) ; cb
		NumPut("UInt", 1200, GTX, 8)  ; codepage = Unicode
		VarSetStrCapacity(&Txt, TxtL)
		SendMessage(0x045E, GTX.Ptr, StrPtr(Txt), ClassNN, hWnd)
		VarSetStrCapacity(&Txt, -1)
	}
	Return Txt
}
; ---------------------------------------------------------------------------
; Calculates text length in various ways
; ---------------------------------------------------------------------------
AE_GetTextLen(ClassNN := ControlGetClassNN(ControlGetFocus('A')), hWnd := tryHwnd()) { 
	EM_GETTEXTLENGTHEX := 0x045F
	GTL := Buffer(8, 0)     ; GETTEXTLENGTHEX structure
	; GTL := Buffer(64000000, 0)     ; GETTEXTLENGTHEX structure
	NumPut("UInt", 1200, GTL.Ptr, 4)  ; codepage = Unicode
	Return SendMessage(EM_GETTEXTLENGTHEX, GTL.Ptr, 0, ClassNN,hWnd)
}
; ---------------------------------------------------------------------------
; @function ..: Replaces the selected text with the specified text
; ---------------------------------------------------------------------------
AE_ReplaceSel(Text := "", ClassNN := '', hWnd := tryHwnd()) { 
	EM_REPLACESEL := 194 ; 0xC2
	If (ClassNN = '') {
		try ClassNN := ControlGetClassNN(ControlGetFocus('A'))
		try text := SendMessage(EM_REPLACESEL, 1, StrPtr(Text), ClassNN, hWnd)
	} else if (text = '') {
		try text := SendMessage(EM_REPLACESEL, 1, StrPtr(Text), , hWnd)
	} else (text := '')
		try SndMsgPaste()
	; Return SendMessage(EM_REPLACESEL, 1, StrPtr(Text), ClassNN, hWnd)
	Return text
}
; ---------------------------------------------------------------------------
tryHwnd() {
	hWnd := ''
	try hWnd := ControlGetFocus('A')
	try hWnd := WinActive('A')
	try hWnd := WinGetID('A')
	return hWnd
	; try hWnd := ControlGetFocus('A')
	; try hWnd := WinGetID('A')
	; try hWnd := ControlGetText(ControlGetFocus('A'), 'A')
}
; --------------------------------------------------------------------------------
; Line handling
; --------------------------------------------------------------------------------
; Get the line containing the caret
; ---------------------------------------------------------------------------
AE_GetCaretLine(line := -1, ClassNN := ControlGetClassNN(ControlGetFocus('A')), hWnd := tryHwnd()) {
	static EM_LINEINDEX := 187, EM_EXLINEFROMCHAR := 1078, EM_LINEFROMCHAR:= 201
	CL := 0
	; Result := SendMessage(EM_LINEINDEX, line, 0, ClassNN,hWnd)
	Result := (SendMessage(EM_LINEINDEX, -1, 0, ClassNN,hWnd)-1) ;? starting character number
	; CL := (SendMessage(EM_EXLINEFROMCHAR,0, 100, ClassNN, hWnd) + 1)
	CL := (SendMessage(EM_LINEFROMCHAR, -1, 0, ClassNN, hWnd) + 1)
	Return CL
}
; --------------------------------------------------------------------------------
; Get the total number of lines
; ---------------------------------------------------------------------------
AE_GetLineCount(ClassNN := ControlGetClassNN(ControlGetFocus('A')), hWnd := tryHwnd()) {
	static LC := 0, EM_GETLINECOUNT := 186
	; LC := SendMessage(EM_GETLINECOUNT,,,,'ahk_id ' hWnd)
	LC := SendMessage(0xBA,,,ClassNN,hwnd)
	; Infos('LC: ' LC)
	Return LC 
}
; --------------------------------------------------------------------------------
; Get the index of the first character of the specified line.
; ---------------------------------------------------------------------------
AE_GetLineIndex(LineNumber, ClassNN := ControlGetClassNN(ControlGetFocus('A')), hWnd := tryHwnd()) { 
	Static EM_LINEINDEX := 187 ;, LI := 0
	; LineNumber   -  zero-based line number
	LI := SendMessage(EM_LINEINDEX, LineNumber, 0, ClassNN, hWnd)
	; Infos('LI: ' LI)
	Return LI 
}

; --------------------------------------------------------------------------------
; Statistics
; Get some statistic values
; Get the line containing the caret, it's position in this line, the total amount of lines, the absulute caret
; position and the total amount of characters.
; EM_GETSEL = 0xB0, EM_LINEFROMCHAR = 0xC9, EM_LINEINDEX = 0xBB, EM_GETLINECOUNT = 0xBA
; --------------------------------------------------------------------------------
AE_GetStats(hWnd := tryHwnd()) {
	static EM_LINEINDEX := 187, EM_EXLINEFROMCHAR := 1078
	static EM_GETSEL := 176, EM_LINEFROMCHAR:= 201, EM_GETLINE := 196
	SB := 0, LI := 0
	LinePos := 0,Line := 0,LineCount := 0,CharCount := 0, L := 0, sel := '', getline := 0, selected := '', fCtl := '', ClassNN := ''
	getsel := [], ctrls := [], ctrl := []
	; Stats := {}
	; Stats := [LinePos,Line,LineCount,CharCount]
	Stats := []
	SB := Buffer(A_PtrSize, 0)
	SBgl := Buffer(A_PtrSize, 0)
	try {
		fCtl := ControlGetFocus('A')
		ClassNN := ControlGetClassNN(fCtl)
	}	
	try {
		; egcl := EditGetLineCount(ClassNN)
		Selected := EditGetSelectedText(ClassNN, hWnd)
		getSel := AE_GetSel(ClassNN, hWnd)
		MaxLinePos := SendMessage(EM_GETSEL, SB.Ptr, 0,ClassNN,hWnd) ;? total characters in edit control
		LineCount := EditGetLineCount(ClassNN,'A')
		LineCount1 := AE_GetLineCount(ClassNN, hWnd)
		; getline := SendMessage(EM_GETLINE,1, SBgl.Ptr, ClassNN , hWnd)
		Line := (SendMessage(EM_LINEFROMCHAR, -1, 0, ClassNN,hWnd) + 1)
		
		GetCaretLine := AE_GetCaretLine(-1,ClassNN, hWnd)
		CurrentCol := EditGetCurrentCol(ClassNN, hWnd)
		; ---------------------------------------------------------------------------
		; @grouped -1 = current line => @param ...: this_line := -1
		; ---------------------------------------------------------------------------
		this_line := -1
		Result := (SendMessage(EM_LINEINDEX, this_line, 0, ClassNN,hWnd)) ;? starting character number
		LI := AE_GetLineIndex(this_line, ClassNN, hWnd) ;
		; LinePos := (NumGet(SB, "Ptr") - (LI + 1))
		LinePos := (NumGet(SB, "Ptr") - (LI+1))
		; ---------------------------------------------------------------------------
		; @group 1 => +1 line to try and get the difference between the two
		; ---------------------------------------------------------------------------
		n_line := 1
		Result1 := (SendMessage(EM_LINEINDEX, this_line+1, 0, ClassNN,hWnd)) ;? starting character number
		LI1 := AE_GetLineIndex(this_line+1, ClassNN, hWnd) ;
		LinePos1 := (NumGet(SB, "Ptr") - (LI1+1))
		; num_of_chars := LI1 - LI
		num_of_chars := SendMessage(WM_GETTEXTLENGTH := 0x000E, 0, 0, ,hWnd)
		; LI = 0 ? LinePos++ : false
		; ---------------------------------------------------------------------------
		CharCount := AE_GetTextLen(ClassNN, hWnd)
		; start := 
		Infos(
			; 'fCtl: ' fCtl
			; '`n'
			; 'ClassNN: ' ClassNN
			; '`n'
			'getsel.s (start): ' getsel.S '`n' 
			'getsel.e   (end): ' getsel.E '`n' 
			'Total Chars: ' MaxLinePos '`n' 
			'LineCount: ' LineCount '`n' 
			'LineCount1: ' LineCount1 '`n' 
			'getline: ' getline '`n'
			'Line: ' Line '`n'
			; '`n'
			'-----------------------------------`n'
			'Selected: "' Selected '"`n'
			'Chars: ' Selected.Length '`n'
			'Spaces: ' RegExMatch(Selected.Length, '[ ]+$') '`n'
			'-----------------------------------`n'
			'CurrentCol: ' CurrentCol '`n'
			'-----------------------------------`n'
			'Result: ' Result '`n'
			'LineIndex (charpos @ BOL): ' LI '`n'
			'LinePos(chars in line = LinePos+1): ' LinePos '`n'
			'-----------------------------------`n'
			'Result1: ' Result1 '`n'
			'LineIndex1 (charpos @ BOL): ' LI1 '`n'
			'LinePos1(chars in line = LinePos+1): ' LinePos1 '`n'
			'-----------------------------------`n'
			'num_of_chars: ' num_of_chars '`n'
			'-----------------------------------`n'
			'GetCaretLine: ' GetCaretLine '`n'
			'CharCount: ' CharCount
				)
		; , 3000)
	}
	
	; Stats.SafePush(getsel.S)
	; Stats.SafePush(getsel.E)
	Stats.SafePush('LinePos: ' LinePos)
	Stats.SafePush('Line: ' Line)
	Stats.SafePush('LineCount: ' LineCount)
	Stats.SafePush('CharCount: ' CharCount)
	Return Stats
}
; ---------------------------------------------------------------------------
; Hides or shows the selection ;! still doesn't work
; ---------------------------------------------------------------------------
AE_HideSelection(Mode, ClassNN := ControlGetClassNN(ControlGetFocus('A')), hWnd := tryHwnd()) { 
	; Mode : True to hide or False to show the selection.
	EM_HIDESELECTION := 0x043F ; (WM_USER + 63)
	; SendMessage(EM_HIDESELECTION, !!Mode, 0, hWnd)
	SendMessage(EM_HIDESELECTION, !!Mode, 0, ClassNN, hWnd)
	Return True
}
Class AE {
	; --------------------------------------------------------------------------------
	static _AE_DetectHidden(bool := true){
		DetectHiddenText(bool)
		DetectHiddenWindows(bool)
	}
	static _DetectHidden(bool := true){
		DetectHiddenText(bool)
		DetectHiddenWindows(bool)
	}
	; --------------------------------------------------------------------------------
	static _AE_SetDelays(n := -1) {
		SetControlDelay(n)
		SetMouseDelay(n)
		SetWinDelay(n)
	}
	static _SetDelays(n := -1) {
		SetControlDelay(n)
		SetMouseDelay(n)
		SetWinDelay(n)
	}
	; --------------------------------------------------------------------------------
	static _AE_PerMonitor_DPIAwareness() {
		global A_DPIAwareness
		MaximumPerMonitorDpiAwarenessContext := VerCompare(A_OSVersion, ">=10.0.15063") ? -4 : -3
		Global DefaultDpiAwarenessContext := MaximumPerMonitorDpiAwarenessContext, A_DPIAwareness := DefaultDpiAwarenessContext
		try {
			DllCall("SetThreadDpiAwarenessContext", "ptr", MaximumPerMonitorDpiAwarenessContext, "ptr")
		} catch {
			DllCall("SetThreadDpiAwarenessContext", "ptr", -4, "ptr")
		} else{
			DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
		}
		return A_DPIAwareness
	}
	static _DPIAwareness() {
		global A_DPIAwareness
		A_DPIAwareness := DPI.MaximumPerMonitorDpiAwarenessContext()
		tooltip(A_DPIAwareness)
		; MaximumPerMonitorDpiAwarenessContext := VerCompare(A_OSVersion, ">=10.0.15063") ? -4 : -3
		; Global DefaultDpiAwarenessContext := MaximumPerMonitorDpiAwarenessContext, A_DPIAwareness := DefaultDpiAwarenessContext
		; try {
		; 	DllCall("SetThreadDpiAwarenessContext", "ptr", MaximumPerMonitorDpiAwarenessContext, "ptr")
		; } catch {
		; 	DllCall("SetThreadDpiAwarenessContext", "ptr", -4, "ptr")
		; } else{
		; 	DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
		; }
		return A_DPIAwareness
	}
}

; --------------------------------------------------------------------------------
;              Ctrl+s Reload AutoHotKey Scripts (to test/load changes)
; --------------------------------------------------------------------------------
#HotIf WinActive(" - Visual Studio Code")
	; ~^s::ReloadAllAhkScripts()
	~^s::Reload()
#HotIf
; --------------------------------------------------------------------------------
/**
 * function ...: Reload AutoHotKey Script (to load changes)
 * @example Ctrl+Shift+Alt+r
 * Note: I think the 654*** is for v2 => avoid the 653***'s
	[x] Reload:		65400
	[x] Help: 		65411 ; 65401 doesn't really work or do anything that I can tell
	[x] Spy: 			65402
	[x] Pause: 		65403
	[x] Suspend: 		65404
	[x] Exit: 		65405
	[x] Variables:	65406
	[x] Lines Exec:	65407 & 65410
	[x] HotKeys:		65408
	[x] Key History:	65409
	[x] AHK Website:	65412 ; Opens https://www.autohotkey.com/ in default browser; and 65413
	[x] Save?:		65414
	! Don't use these => static a := { Open: 65300, Help:    65301, Spy: 65302, XXX (nonononono) Reload: 65303 [bad reload like Reload()], Edit: 65304, Suspend: 65305, Pause: 65306, Exit:   65307 }
	scripts .=  (scripts ? "`r`n" : "") . RegExReplace(title, " - AutoHotkey v[\.0-9]+$")
 * @example
	Refactored:
		- Changed DetectHiddenWindows(true) to AE._DetectHidden(true)
		- Declared vars: oList := [], aList := [], i := '', v := '', scripts := "", excludeTitle := '', excludeText := ''
		- Added a RegExMatch => via ~= => to see if the Title or Text exists
 *	//; TODO Change exList's to Arrays, and create for-loops
 */
; --------------------------------------------------------------------------------
^+!r::ReloadAllAhkScripts()
; ^+!r::ReloadList()
ReloadAllAhkScripts() {
	AE._DetectHidden(true)
	aList := [], title := '', WinTitle := '', scripts := ''
	aList := ReloadList()
	Infos(_ArrayToString(aList, ',`n'))
	static  WM_COMMAND := 273, ; 0x111 or 0x00000111
			; menucmdid := cmdidOLEObjectMenuButton := 65400,
			menucmdid := cmdidOLEObjectMenuButton := 65303,
			Msg := WM_COMMAND, wParam := menucmdid, lParam := 0
	; Loop aList.Length {
	for each, WinTitle in aList {
			; WinTitle := 'ahk_id ' aList[A_Index]
		WinTitle := 'ahk_id ' WinTitle
		title := WinGetTitle(WinTitle)
			; PostMessage(WM_COMMAND,65400,0,,"ahk_id " aList[A_Index])
			; PostMessage(Msg,wParam,lParam,,title)
			; SendMessage(Msg,wParam,lParam,,title)
		Run(title)
		WinKill(title)
		; Exit()
		scripts .=  (scripts ? "`r`n" : "") . RegExReplace(title, " - AutoHotkey v[\.0-9]+$")
	}
		Infos(scripts)
}
ReloadList() {
	AE._DetectHidden(true)
	static oList := [], aList := [], exListTitleArr := [], exclTitleArr := [], exListTextArr := [], exclTextArr := [], sList := [], noList := []
	static  i := '', v := '', scripts := '', excludeTitle := '', excludeText := '',
			aTitleExcl := '', aTextExcl := '', WinT := '', WinE := 0
	static  WM_COMMAND := 273, ; 0x111 or 0x00000111
			menucmdid := cmdidOLEObjectMenuButton := 65400
	static exListTitleArr := ['RichEdit'], exListTextArr := ['Horizon']
	for each, aTitleExcl in exListTitleArr {
		try {
			WinE := WinExist(aTitleExcl)
			WinT := WinGetTitle(WinE)
		}
		try {
			if WinT ~= aTitleExcl {
				excludeTitle := WinT
				noList.SafePush(excludeTitle)
			}
		}
	}
	static oList := WinGetList("ahk_class AutoHotkey",,excludeTitle)
	List := oList.Length
	for i, v in oList {
		aList.SafePush(v)
	}
	for each, WinTitle in aList {
		; WinTitle := 'ahk_id ' aList[A_Index]
	WinTitle := 'ahk_id ' WinTitle
	title := WinGetTitle(WinTitle)
	sList.SafePush(title)
}
	; Loop aList.Length {
	; 	local WinTitle := 'ahk_id ' aList[A_Index]
	; 	title := WinGetTitle(WinTitle)
	; 	sList.SafePush(title)
	; }
	return aList
}
; ---------------------------------------------------------------------------
ShellHook(callback := '') {
	; HSHELL_RUDEAPPACTIVATED := 32772
	; hWnd := WinActive('A')
	rVal := ''
	hWnd := ControlGetFocus('A')
	DllCall("RegisterShellHookWindow", "UInt", A_ScriptHwnd)
	OnMessage(DllCall("RegisterWindowMessage", "Str", "SHELLHOOK"), rval := callback)
	; OnMessage(DllCall("RegisterWindowMessage", "Str", "SHELLHOOK"), MyFunc)
	return rVal
}
; ---------------------------------------------------------------------------
A_DPI_GetInfo(event := HSHELL_WINDOWCREATED := 1, hWnd := WinActive('A'),info*) {
	CoordMode('ToolTip', 'Screen')
	_AE_DetectHidden()
	_AE_bInpt_sLvl()
	; --------------------------------------------------------------------------------
	; hook := SetWinEventHook(HandleWinEvent)
	; --------------------------------------------------------------------------------
	static HSHELL_WINDOWCREATED := 1, HSHELL_WINDOWDESTROYED := 2, HSHELL_ACTIVATESHELLWINDOW := 3, HSHELL_WINDOWACTIVATED := 4, HSHELL_WINDOWACTIVATED := 32772, HSHELL_GETMINRECT := 5, HSHELL_REDRAW := 6, HSHELL_TASKMAN := 7, HSHELL_LANGUAGE := 8, HSHELL_SYSMENU := 9, HSHELL_ENDTASK := 10, HSHELL_ACCESSIBILITYSTATE := 11, HSHELL_APPCOMMAND := 12, HSHELL_WINDOWREPLACED := 13, HSHELL_WINDOWREPLACING := 14, HSHELL_HIGHBIT := 32768, HSHELL_RUDEAPPACTIVATED := 32772, HSHELL_FLASH := 32774
	; ---------------------------------------------------------------------------
	static hznHwnd := 0, match := '', A_Process := '', A_DPI := 0, mName := '', name := ''
	matches := [], ProcessInfo := []
	processInfoMap := Map()
	; ---------------------------------------------------------------------------
	nEvent := (event = 1) ? 'HSHELL_WINDOWCREATED' : (event = 2) ? 'HSHELL_WINDOWDESTROYED' : (event = 3) ? 'HSHELL_ACTIVATESHELLWINDOW' : (event = 4) ? 'HSHELL_WINDOWACTIVATED' : (event = 32772) ? 'HSHELL_RUDEAPPACTIVATED' : (event = 5) ? 'HSHELL_GETMINRECT' : (event = 6) ? 'HSHELL_REDRAW' : (event = 7) ? 'HSHELL_TASKMAN' : (event = 8) ? 'HSHELL_LANGUAGE' : (event = 9) ? 'HSHELL_SYSMENU' : (event = 10) ? 'HSHELL_ENDTASK' : (event = 11) ? 'HSHELL_ACCESSIBILITYSTATE' : (event = 12) ? 'HSHELL_APPCOMMAND' : (event = 13) ? 'HSHELL_WINDOWREPLACED' : (event = 14) ? 'HSHELL_WINDOWREPLACING' : (event = 32768) ? 'HSHELL_HIGHBIT' : (event = 32774) ? 'HSHELL_FLASH' : 'No Event'
	if ((event = 1) || (event = 4) || (event = 32772)) {
		; hWnd := WinActive('A')
		DllCall("GetWindowThreadProcessId", "Int", hwnd, "Int*", &tpID := 0)
		try name := WinGetProcessName(hwnd)
		if name = '' {
			return
		}
		A_Process := name
		Monitor := DPI.GetMonitorInfo(hWnd)
		; hMon_Win := DPI.MonitorFromWindow(hwnd)
		hMon  := Monitor.Handle
		mName := Monitor.Name
		wDPI  := Monitor.winDPI
		A_DPI := Monitor.DPI
		; mName := RegExReplace(mName, '\\\\\.\\', '')
		; mDPI := DPI.GetForMonitor(hMon_Win)
		; ToolTip(hMon_Win ': ' mDPI  ' : ' A_DPIAwareness, 0,0, 2)
		; wDPI := DPI.WinGetDPI(A_Process)
		; Infos(wDPI)
		; A_DPI := [mDPI, Monitor.x, Monitor.y]
		; A_DPI := A_DPI.ToString(' ')
		; A_DPI := wDPI
		ProcessInfo.SafePush(A_Process)
		processInfoMap.SafeSet('Process', A_Process)
		processInfoMap.SafeSet('Monitor', mName)
		processInfoMap.SafeSet('hMon', hMon)
		processInfoMap.SafeSet('A_DPI', A_DPI)
	}
	; --------------------------------------------------------------------------------
	; --------------------------------------------------------------------------------
	_AE_bInpt_sLvl(0)
	; match := processInfoMap.ToString('`n')
	; ToolTip(A_Process ': ' A_DPI ' : ' A_DPIAwareness, 0, 100, 1)
	; ToolTip(match, 0, 0, 1)
	ToolTip(A_DPI, 0, 0, 1)
	; Infos(match)
	return processInfoMap
}