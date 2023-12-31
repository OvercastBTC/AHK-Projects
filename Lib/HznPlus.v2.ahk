/************************************************************************
 * function ......: Horizon Button ==> A Horizon function library
 * @description ..: This library is a collection of functions and buttons that deal with missing interfaces with Horizon.
 * @file HznPlus.v2.ahk
 * @author OvercastBTC
 * @date 2023.09.15
 * @version 3.0.2
 * @ahkversion v2+
 * @Section .....: Auto-Execution
 ***********************************************************************/
; ---------------------------------------------------------------------------
;@Ahk2Exe-AddResource HznPlus256.ico, 160  ; Replaces 'H on blue'
;@Ahk2Exe-AddResource HznPlus256.ico, 206  ; Replaces 'S on green'
;@Ahk2Exe-AddResource HznPlus256.ico, 207  ; Replaces 'H on red'
;@Ahk2Exe-AddResource HznPlus256.ico, 208  ; Replaces 'S on red'
/************************************************************************
 * function ...........: Resource includes for .exe standalone
 * @author OvercastBTC
 * @date 2023.09.28
 * @version 3.0.2
 ***********************************************************************/
; ---------------------------------------------------------------------------
Persistent(1)
#Include <Directives\__AE.v2>
#Include <Directives\__HznToolbar>
#Include <System\DPI>
; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
#Include <EnumAllMonitorsDPI.v2>
#Include <GetNearestMonitorInfo().v2>
#Include <Class\RTE\RichEdit>
#Include <Class\RTE\RichEditDlgs>
#Include <__receiver>
#Include <Tools\Info>
; #Include <Misc\Out>
#Include <System\UIA>
#Include <_GuiReSizer>

; ---------------------------------------------------------------------------
; ; @Ahk2Exe-AddResource %A_ScriptDir%\RTE.v2\Project Files\RichEdit_Editor_v2.ahk, 1
; @Ahk2Exe-AddResource RichEdit_Editor_v2.exe
; #Include %A_ScriptDir%\RTE.v2\Project Files\RichEdit_Editor_v2.ahk
; #Include <RRTE.v2\Project Files\RichEdit_Editor_v2>
; #Include *i %A_ScriptDir%\Lib\RRTE.v2\Project Files\RichEdit_Editor_v2.ahk
; ---------------------------------------------------------------------------
/************************************************************************
 * ;Description ...: Create Tray Icon
* @description ...: Create the tray icon using the embedded B64 via Create_HznHorizon_ico()
* @author OvercastBTC
* @date 2023.08.15
* @version 2.0.1
***********************************************************************/
TraySetIcon('HICON:' Create_HznHorizon_ico())
; ---------------------------------------------------------------------------
#Include <__A_Process.v2> ;! needs to be here AFTER the TraySetIcon => Icon disabled in A_Process
#Include <Class\JSON\jsongo.v2>
#Include <Includes\Includes_Runner>
#Include <Includes\Includes_Extensions>
; Check_Startup_Status()
; ---------------------------------------------------------------------------
/************************************************************************
* @Title .........: Create Tray Menu
* @Description ...: Create options (//TODO add functions here) for use with the script (e.g., run at startup, open horizon, etc.)
* @file HznPlus.v2.ahk
* @author OvercastBTC
* @date 2023.08.09
* @version 0.0.1
* @TODO ;[ ] TODO	.: Convert from v1 to v2
 ***********************************************************************/
; --------------------------------------------------------------------------------------------

; HznTray := A_TrayMenu
; see at the bottom for the functions
; return
; ---------------------------------------------------------------------------------------------
/************************************************************************
; function ...: Horizon Hotkeys
@description: Hotkeys (shortcuts) for normal Windows hotkeys that should exist
@author OvercastBTC
@notes
@function Italics 		(CTRL+I)
@function Bold			(CTRL+B)
@function Underline		(CTRL+U)
@function SelectAll		(CTRL+A)
@function Save			(CTRL+S)
@function HznGetText 	(CTRL+SHIFT+C) (like Ctrl+c & displays the text)
@function tab 			Enables Tab in the edit control
 ***********************************************************************/

; ---------------------------------------------------------------------------

; #HotIf WinActive('ahk_exe hznhorizon.exe')
; #HotIf
; ---------------------------------------------------------------------------
#HotIf WinActive('ahk_exe hznhorizon.exe')
tab::Suspend(1), WinGetTitle(ControlGetFocus('A')) ~= 'i)txttextbox' ? HznSendTabSC() : HznTab(), Suspend(0)
; ---------------------------------------------------------------------------
F5::button(120) 			; find (focused tab) and find/replace
^f::button(120)				; find (focused tab) and find/replace
^h::HznFindReplace()		; find/replace (focused tab) and find
; ---------------------------------------------------------------------------
^a::HznSelectAll()
^End::AE_Select_End()
^Home::AE_Select_Beginning()
^b::button(100)			; bold
^i::button(101)			; italics
^u::button(102)			; underline
;! ---------------------------------------------------------------------------
/**
 * ;! The following buttons are NOT ENABLED
 * @example
 * Reason:
 * 		Primary: the cut, copy, paste, undo, and redo buttons are not needed as the Windows functionality already exists
 * 		Secondary: The justification buttons don't work in almost all places an FE would enter information.
 */
;! button(103) = Separator
;! ^l::button(104) 		; Align Left
;! ^r::button(105) 		; Align Right ; fix => cut???
;! ^e::button(106) 		; Align Center
;! ^j::button(107) 		; Justitfied
;! button(108) = Separator
; ^x::button(109) 		; cut
; ^c::button(110) 		; copy
; ^v::button(111) 		; paste
; ^z::button(113) 		; undo
; ^y::button(114) 		; redo
;! idCommand (115) unknown but does something?
;! ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
+F12::button(116) 		; Bulleted List
; ---------------------------------------------------------------------------
F7::button(117)			; spell check
; ---------------------------------------------------------------------------
^F12::button(118)		; Insert Table ; fix (drop down)
; ---------------------------------------------------------------------------
^=::HznSuperScript()	; [super script]
^+=::HznSubScript()		; [sub script]
; ---------------------------------------------------------------------------
^+c::HznGetText()
; ---------------------------------------------------------------------------
^!v::HznPaste()
*^s::HznSave()
; ^F4::HznClose() 		; fix [] => need to only be on certain screen(s).
^n::HznNew()
; ---------------------------------------------------------------------------
^+8::HznTbCustomize() 	; works!!! enables and shows all buttons on the toolbar
; ^+9::HznEnableButtons(hTb := HznToolbar._hTb()) ; works!!!
#HotIf
HznNew(){
	_AE_bInpt_sLvl(1), fCtl := ControlGetFocus('A'), ClassNN := ControlGetClassNN(fCtl), WinT := WinGetTitle('A'), bNew := ''
	try bNew := ControlGetClassNN('New Standard')
	try bNew := ControlGetClassNN('New')
	; (button_new = '') ? HznSave_Icon() : ControlClick(button_new)
	ControlClick(bNew)
	_AE_bInpt_sLvl(0)
}
class testjson extends Paths {
	static testdirname := 'WriteFileTest'
	static testdir := Paths.Lib '\' this.testdirname
	static json_dir := this.testdir
	static json_dirname := this.json_dir '\WriteToJSONTest'
	static jsongo_dirname := this.json_dir '\WriteToJSONGOTest'
}
^+9::Lookie()
lookie(){
	fCtl := 0, ahWnd := 0, WinPID := 0, WinID := 0, WinpE := 0, hHzn := 0, WinE := 0, WinA := 0
	nCtl := '', WinPN := '', WinT := '', Hzn := '',  gaWinT := '', text := '', state := '', visible := '', style := '', exstyle := '',
	name := '',  item := '', hJson := '', ClassNN := '', WinC := '', list := '', fname := '', json_dir := '', json_dir_fname:='', 
	hznArray := [], items := [], hznMapArray := []
	hznMap 	 := Map(), hznAMap := Map()
	; ---------------------------------------------------------------------------\
	static json_dir := testjson.json_dir
	static json_dirname := testjson.json_dirname
	static jsongo_dirname := testjson.jsongo_dirname
	; ---------------------------------------------------------------------------
	default_fname := ('test' format(A_Now, 'YYYY.MM.DD') '.jsonc')
	Hzn := 'ahk_exe hznHorizon.exe'
	hHzn := WinWaitActive(Hzn)
	try fCtl := ControlGetFocus('A')
	try nCtl := ControlGetClassNN(fCtl)
	WinE := WinExist('ahk_exe hznHorizon.exe')
	WinA := WinActive('A')
	try WinPN := WinGetProcessName(WinA)
	try WinPID := WinGetPID('ahk_exe ' WinPN)
	try WinID := WinGetID(WinPID)
	try WinpE := WinExist(WinID)
	try {
		hGetAncestor := DllCall("GetAncestor", "UInt", hHzn, "Uint", 2)
		hGApID := WinGetProcessName(hGetAncestor)
		hWinE := WinExist(hGetAncestor)
		; WinT := WinGetTitle(hGetAncestor)
		gaWinT := WinGetTitle(hWinE)
	}
	try WinT := WinGetTitle(WinActive('A'))
	; ---------------------------------------------------------------------------
	; Infos(WinpA '`n' WinT)
	; Infos(
		; 	'f: ' fCtl
		; 	'`n'
		; 	'n: ' nCtl
		; 	'`n'
	; 	'a: ' WinA
	; 	'`n'
	; 	'Proc: ' WinPN
	; 	'`n'
	; 	'pID: ' WinPID
	; 	'`n'
	; 	'pIDExist: ' WinpE
	; 	'`n'
	; 	'WinT: ' WinT
	; 	'`n'
	; 	'hGetAncestor: ' hGetAncestor
	; 	'`n'
	; 	'hGApID: ' hGApID
	; 	'`n'
	; 	'gaWinT: ' gaWinT
	; )
	; ---------------------------------------------------------------------------
	name := StrSplit(WinT, '  ', '  ' ,2)
	; fname := StrSplit(WinT, ' ',,3)
	fname := StrSplit(name[1], ' - ' ,,3)
		; ---------------------------------------------------------------------------
	; try Infos(
	; 		name[1]
	; 		'`n'
	; 		name[2]
	; 		; fname[3]
	; 	)
	; ---------------------------------------------------------------------------
	; fname := strsplit(fname[2], ' ',2)
	fname[2] := RegExReplace(fname[2], ' ','-')
	static jsonfname := fname[2] '.jsconc'
	; MsgBox(jsonfname,,3).OnEvent('Cancel', Exit())
	; ---------------------------------------------------------------------------
	json_dir_fname := (json_dirname '\' jsonfname)
	jsongo_dir_fname := (jsongo_dirname '\' jsonfname)
	dirArray := [json_dirname, jsongo_dirname]
	fileArray := [json_dir '\' jsonfname, json_dir_fname, jsongo_dir_fname]
	result := '', text := '', existsArray:= []
	; ---------------------------------------------------------------------------
	hznArray := WinGetControlsHwnd(WinT)
	; try Infos(fname[1] '`n' fname[2] '`n' fname[3])
	; hznArray := WinGetControlsHwnd(WinA)
	; ---------------------------------------------------------------------------
	for each,value in dirArray {
		If result := !DirExist(value) {
			DirCreate(value)
		}
		(result = 0) ? result := 'Dir Exists' : result := 'Dir Created'
		existsArray.Push(value ': ' result)
		; Infos(result)
	}
	for each, value in fileArray {
		if result := !FileExist(value) {
			AppendFile(value, text)
		}
		(result = 0) ? result := 'File Exists' : result := 'File Created'
		existsArray.Push(value ': ' result)
		; Infos(result)
	}
	var := _ArrayToString(existsArray, ',`n')
	Infos(var)
	; ---------------------------------------------------------------------------
	for each, ahWnd in hznArray{
		try {
			ClassNN := ControlGetClassNN(ahWnd)
			SafeSet(hznAMap,ClassNN, ahWnd)
		} catch {
			WinC := WinGetClass(ahWnd)
			SafeSet(hznAMap,ClassNN, ahWnd)
		}
		SafeSetMap(hznAMap,hznMAP)
		for key, value in hznAMap {
			list .= key ' ' value '`n'
			hznMapArray.Push(key)
			hznMapArray.Push(value)
		}
		a2s := hznMapArray.ToString()
		Infos(a2s)
		AppendFile((testjson.testdir '\' fname[1] '.ahk'), a2s)
	; }	
		return
		DPI.WinGetPos(&wX,&wY,&wW,&wH,ahWnd)
		try state := ControlGetEnabled(ahWnd)
		; ---------------------------------------------------------------------------
		if ((state != 0) &&	(wW != 0 || wH != 0)) {
			try visible := ControlGetVisible(ahWnd)
			if (visible != 0) {
				try {
					style := ControlGetStyle(ahWnd)
					style := Format("0x{:08x}", style)
					if (ClassNN ~= 'i)button') {
						style := styleconverter(style)
					}
				}	
				; } catch {
				; 	style := WinGetStyle(ahWnd)
				; 	style := Format("0x{:08x}", style)
				; }
				try exstyle := ControlGetExStyle(ahWnd)
				try exstyle := Format("0x{:08x}", exstyle)
				try text := '`n' ControlGetText(ahWnd)
				try items := ControlGetItems(ahWnd)
				try for each, item in items {
					; DrawBorder(ahWnd)
					; Infos(
						; OutputDebug(
						; 	'C: ' ClassNN ' L[' items.Length '] ' item
						; 	'`n'
						; )
						; test := (value != 'No' || 'Yes' || '')
						; if test = 0 {
							; 	test := 'false'
							; } else {
								; 	test := 'true'
								; }
								; Infos('test: ' test)
								; if (value != '' || value != ' ' || value != '`t' || value != 'No' || value != 'Yes'){
									; 	A_Clipboard := value
									; 	try name := GetKeyName(value)
									; 	Infos('[' value ']' name)
									; KeyWait('RAlt', 'D')
									; Infos.DestroyAll()
									; }
				}
				(text = '`n') ? text := text '(no text)' : text
				; OutputDebug(
				; 	ClassNN
				; 	text
				; 	'`n'
				; 	'S[' state ']' 
				; 	' Vis[' visible ']'
				; 	' st[' style ']'
				; 	' exst[' exstyle ']'
				; 	'`n'
				; 	'wX: ' wX
				; 	' wY: ' wY
				; 	' wW: ' wW
				; 	' wH: ' wH
				; 	'`n'
				; )
				; OutputDebug(toJson)
				; DrawBorder(ahWnd)
				; KeyWait('RAlt', 'D')
			}
		}
		; ---------------------------------------------------------------------------
		toJson := (	
				ClassNN
				' S[' state ']' 
				' Vis[' visible ']'
				' st[' style ']'
				' exst[' exstyle ']'
				'`n'
				'wX: ' wX
				' wY: ' wY
				' wW: ' wW
				' wH: ' wH
				'`n'
				text
			)
		hJson .= toJson
		if ((wW != 0 || wH != 0) && (visible != 0) ) {
			try {
				hznClass := ControlGetClassNN(value)
				hznMap.Set(hznClass, value)
			}
		}
	}
	; ---------------------------------------------------------------------------
	for key, value in hznMap {
		DPI.WinGetPos(&wX,&wY,&wW,&wH,value)
		try visible := ControlGetVisible(value)
		if ((wW != 0 || wH != 0) && (visible != 0) ) {
			try text := '`n' ControlGetText(value)
			try state := ControlGetEnabled(value)
			; try visible := ControlGetVisible(value)
			if (text = '`n'){
				text := ''
			}
			if state != 0 {
				; Infos(
				; OutputDebug(
				; 	'[' state '] '
				; 	key ' (' value ')'
				; 	' wX: ' wX
				; 	' wY: ' wY
				; 	' wW: ' wW
				; 	' wH: ' wH
				; 	text
				; 	'`n'
				; )
				; DrawBorder(value)
				; KeyWait('RAlt', 'D')
			}
		}
		; Infos.DestroyAll()
		; Infos(hznClassNN ' (' value ')')
		; Try {
		; 	hznClass := ControlGetClassNN(value)
		; }
		; Catch {
		; 	hznClass := WinGetClass(value)
		; }
		; Infos(hznClass)
		; DrawBorder(value)
		; KeyWait('LAlt','D')
		; Infos.DestroyAll()
	}
	hznCtlJson := jsongo._Stringify(hznMap,'','`t', true)
	; if FileExist(fname[2] '.jsonc') {
	; 	FileDelete(fname[2] '.jsonc')
	; }

	ApplyJson() => WriteFile(A_ScriptDir '\WriteToJSONTest\' fname[2] '.jsconc', json.stringify(hznMap,,'`t', true))
	AppendFile(A_ScriptDir '\WriteToJSONGOTest\' fname[2] '.jsonc',hznCtlJson)
	; OutputDebug(hznCtlJson)
	DrawBorder(WA:=WinActive("A")){
		Static OS:=3
		Static BG:="FF0000"
		Static myGui:=Gui("+AlwaysOnTop +ToolWindow -Caption","GUI4Border")
		myGui.BackColor:=BG
		; WA:=WinActive("A")
		If WA && !WinGetMinMax(WA) && !WinActive("GUI4Border ahk_class AutoHotkeyGUI"){
			DPI.WinGetPos(&wX,&wY,&wW,&wH,WA)
			myGui.Show("x" wX " y" wY " w" wW " h" wH " NA")
			Try WinSetRegion("0-0 " wW "-0 " wW "-" wH " 0-" wH " 0-0 " OS "-" OS " " wW-OS
			. "-" OS " " wW-OS "-" wH-OS " " OS "-" wH-OS " " OS "-" OS,"GUI4Border")
		}
		; }Else{
		; 	myGui.Hide()
		; }
	}
	; hGui := Gui(fCtl)
	; hGui := Gui(rCtl)
	; text := RichEdit(hGui,'',true).GetRTF()
	; OutputDebug(
	; 	; 'rCtl: ' rCtl
	; 	'`n'
	; 	'Control: ' nCtl
	; 	' (' fCtl ')'
	; 	'`n'
	; 	'text:`n' text
	; )
	; SaveToJson(*) {		
	; 	hznMap.Set(WinT, Map("title", Saved.RecTitle,	"recommendation", Saved.RecText, "hazard", Saved.RecHazard, "technical detail", Saved.RecTechDetail))
		
	; 	this.ApplyJson()
	; }

	styleconverter(style){
		StyleMap := Map(
			0x6 , 'BS_AUTO3STATE' ; Creates a button that is the same as a three-state check box, except that the box changes its state when the user selects it. The state cycles through checked, indeterminate, and cleared.
			,
			0x3 , 'BS_AUTOCHECKBOX' ; Creates a button that is the same as a check box, except that the check state automatically toggles between checked and cleared each time the user selects the check box.
			,
			0x9 , 'BS_AUTORADIOBUTTON'	; Creates a button that is the same as a radio button, except that when the user selects it, the system automatically sets the button's check state to checked and automatically sets the check state for all other buttons in the same group to cleared.
			,
			0x100 , 'BS_LEFT' ; +/-Left. Left-aligns the text.
			,
			0x0 , 'BS_PUSHBUTTON' ; Creates a push button that posts a WM_COMMAND message to the owner window when the user selects the button.
			,
			0x1000 , 'BS_PUSHLIKE' ; Makes a checkbox or radio button look and act like a push button. The button looks raised when it isn't pushed or checked, and sunken when it is pushed or checked.
			,
			0x200 , 'BS_RIGHT' ; +/-Right. Right-aligns the text.
			,
			0x20 , 'BS_RIGHTBUTTON' ; +Right (i.e. +Right includes both BS_RIGHT and BS_RIGHTBUTTON, but -Right removes only BS_RIGHT, not BS_RIGHTBUTTON). Positions a checkbox square or radio button circle on the right side of the control's available width instead of the left.
			,
			0x800 , 'BS_BOTTOM' ; Places the text at the bottom of the control's available height.
			,
			0x300 , 'BS_CENTER' ; +/-Center. Centers the text horizontally within the control's available width.
			,
			0x1 , 'BS_DEFPUSHBUTTON' ; +/-Default. Creates a push button with a heavy black border. If the button is in a dialog box, the user can select the button by pressing Enter, even when the button does not have the input focus. This style is useful for enabling the user to quickly select the most likely option.
			,
			0x2000 , 'BS_MULTILINE' ; +/-Wrap. Wraps the text to multiple lines if the text is too long to fit on a single line in the control's available width. This also allows linefeed (`n) to start new lines of text.
			,
			0x4000 , 'BS_NOTIFY' ; Enables a button to send BN_KILLFOCUS and BN_SETFOCUS notification codes to its parent window. Note that buttons send the BN_CLICKED notification code regardless of whether it has this style. To get BN_DBLCLK notification codes, the button must have the BS_RADIOBUTTON or BS_OWNERDRAW style.
			,
			0x400 , 'BS_TOP' ; Places text at the top of the control's available height.
			,
			0xC00 , 'BS_VCENTER' ; Vertically centers text in the control's available height.
			,
			0x8000 , 'BS_FLAT' ; Specifies that the button is two-dimensional; it does not use the default shading to create a 3-D effect.
			,
			0x7 , 'BS_GROUPBOX' ; Creates a rectangle in which other controls can be grouped. Any text associated with this style is displayed in the rectangle's upper left corner.
		)
		for key, value in StyleMap {
			if style ~= key {
				return value
			}
		}
	}

}

; ---------------------------------------------------------------------------
HznTab() => SendEvent('^i')
HznSendTabSC() => SendEvent('{sc0f}')
; ---------------------------------------------------------------------------
hznButtonCount(hTb := HznToolbar._hTb()) {
	Static Msg := TB_BUTTONCOUNT := 1048, wParam := 0, lParam := 0
	BUTTONCOUNT := SendMessage(TB_BUTTONCOUNT, wParam, lParam, , hTb)
	OutputDebug('Used hznButtonCount()`n # of buttons is ' BUTTONCOUNT)
	return BUTTONCOUNT
}
; ---------------------------------------------------------------------------
HznSuperScript(){
	button(119) 		; [super script]
	SendEvent('{Space}')
	SendEvent('!o')
}
; ---------------------------------------------------------------------------
HznSubScript(){
	button(119) 		
	SendEvent('{Down}')
	SendEvent('{Space}')
	SendEvent('!o')
}
; ---------------------------------------------------------------------------
/************************************************************************
* Function ...: HznFindReplace()
* @author OvercastBTC 
***********************************************************************/
HznFindReplace()
{
	SendLevel(5)
	cBak := ClipboardAll()
	A_Clipboard := ''
	Send('^c')
	If A_Clipboard != '' {
		Send('^f')
		ControlFocus('ThunderRT6TextBox2')
		Send('^v')
	} Else {
		Send('^f')
	}
	WinWaitActive('Find and Replace',,5)
	SendEvent('{LAlt down}p{LAlt Up}{Tab}')
	A_Clipboard := cBak
}
; ---------------------------------------------------------------------------
/************************************************************************
* Function ...: HznSave() (Ctrl-s)
* @author OvercastBTC 
***********************************************************************/

HznSave(){
	SendLevel(1), BlockInput(1), fCtl := ControlGetFocus('A'), ClassNN := ControlGetClassNN(fCtl), WinT := WinGetTitle('A'), button_save := ''
	try button_save := ControlGetClassNN('Save')
	(button_save = '') ? HznSave_Icon() : ControlClick(button_save)
	BlockInput(0), SendLevel(0)
}
; ---------------------------------------------------------------------------
HznSave_Icon(){
	DetectHiddenText(0),DetectHiddenWindows(0)
	fCtl := ControlGetFocus('A')
	idWin := WinGetID('ahk_exe hznHorizon.exe')
	WinActivate(idWin)
	hWnd := WinActive('A')
	SendEvent('{LAlt down}')
	SendEvent('f') ; SendEvent required
	ssWinId := WinGetID('A')
	WinC := WinGetClass(ssWinId)
	Loop (WinC != 'SSMenu') {
		Sleep(15)
	} Until (WinC = 'SSMenu')
	SendEvent('{LAlt Up}')
	try ControlClick('Save')
	try SendEvent('{Enter}')
	Sleep(50)
	ControlFocus(fCtl, 'A')
}
HznSave_NotIcon(){
	try ControlClick('Save')
}
; ---------------------------------------------------------------------------
/************************************************************************
 * @function HznClose() (Ctrl-F4)
 * @author OvercastBTC 
 * @author Descolada and his UIA library and functions
 * @description Horizon Close Button (Ctrl-F4) ==> ≠ Alt-F4
***********************************************************************/
; ---------------------------------------------------------------------------

HznClose(*)
{
	initialSendLevel := A_SendLevel
	SendLevel(((A_SendLevel < 100) && (initialSendLevel >= 1) ? (A_SendLevel) : (A_SendLevel + 1)))
	; prevents the user from doing anything to screw it up by blocking all input
	BlockInput(1)
	; ---------------------------------------------------------------------------
	/** @function Alt + - (Hzn Hotkey for hidden menuitems )						*/
	pvTxt := A_DetectHiddenText, 	DetectHiddenText(0)
	pvWin := A_DetectHiddenWindows, DetectHiddenWindows(0)
	idWin := WinGetID('ahk_exe hznHorizon.exe')
	WinActivate(idWin)
	Sleep(100)
	; ; ---------------------------------------------------------------------------
	; Send('{LAlt down}')
	; SendEvent('-') ; SendEvent required
	; Sleep(100)
	; Send('{LAlt Up}')
	; Sleep(300)
	; Send('c')
	; ---------------------------------------------------------------------------
	DetectHiddenText(pvTxt), DetectHiddenWindows(pvWin)
	; MenuSelect(idWin,,'2&')
	SendLevel(0)
	BlockInput(0)
}

; --------------------------------------------------------------------------------------------
/************************************************************************
 * Desc ......: Horizon Hotkey - Select-All (Ctrl-A)
 * @author ...: Descolada, OvercastBTC
 * Function ..: Select-All() (Ctrl-A)
 * @param Msg - EM_SETSEL := 177 - the Windows API message for "Set Selection"
 * @param wParam - := 0
 * @param lParam := -1
***********************************************************************/

HznSelectAll(*)
{
	Static Msg := EM_SETSEL := 177, wParam := 0, lParam := -1
	hCtl := ControlGetFocus('A')
	DllCall('SendMessage', 'UInt', hCtl, 'UInt', Msg, 'UInt', wParam, 'UIntP', lParam)
}
; ---------------------------------------------------------------------------

/************************************************************************
 * Function ..: HznGetText() (Ctrl+Shift+c)
 * @author ...: OvercastBTC
 * @param hCtl ........: Gets the handle (hwnd) to the control in focus
 * @param A_Clipboard .: The AHK builtin clipboard
 * @returns {text in the control (RT6TextBox or TX11)}
***********************************************************************/

HznGetText(*)
{
	initialSendLevel := A_SendLevel
	SendLevel(((A_SendLevel < 100) && (initialSendLevel >= 1) ? (A_SendLevel) : (A_SendLevel + 1)))
	BlockInput(1) ; 1 = On, 0 = Off
	rect := Map()
	hRect := []
	fname := ''
	hHzn := ''
	; static hCtl := ControlGetFocus('A')
	hCtl := ControlGetFocus('A')
	static nCtl := ControlGetClassNN(hCtl)
	static hCtl_title := WinGetTitle()
	static hHzn := WinExist('ahk_exe hznHorizon.exe')
	bak := ClipboardAll()
	A_Clipboard := ''
	; Try{
	; 	switch hHzn {
	; 		case hHzn := (WinGetProcessName(receiver.rect['hCtl']) ~= 'hznHorizon'):
	; 	}
	; }
	; HznSelectAll(hCtl)
	; HznSelectAll()
	; ; Send('^c')
	; SendMessage(0x0301, 0, 0, hCtl)
	; ; clip_it()
	; MsgBox(A_Clipboard)
	fName := A_ScriptDir '\' nCtl '(' hCtl ')_' hCtl_title '.rtf'
	if !FileExist(fName) {
		FileAppend(A_Clipboard, fName)
	} else {
		FileDelete(fName)
		FileAppend(A_Clipboard, fName)
	}
	; switch {
	; 	case fName :
	; 		fName := A_ScriptDir '\' nCtl '(' hCtl ')_' hCtl_title '.rtf'
	; 	default:
	; 		fName := A_ScriptDir '\' 'default' '.rtf'
	; }
	try receiver.rect.Set('fName', fName)
	; try FileDelete(fName)
	; FileAppend(A_Clipboard, fName)
	; while !FileExist(fName) {
	; 	Sleep(50)
	; }
	; rFile := FileRead(fName)
	LineCount := 0
	loop read fName {
		LineCount := A_Index
	}
	nLineCount := LineCount
	try DPI.ControlGetPos(&x, &y, &w, &h, nCtl, 'A')
	; mRect := WindowGetRect(hCtl)
	; width := mRect.width
	; height := mRect.height
	width := w
	height := LineCount * 16
	rect.Set('width',width, 'height',height, 'x', x, 'y', y, 'hCtl', hCtl, 'nCtl', nCtl)
	; RTE_Title := 'hznRTE - A Rich Text Editor for Horizon'
	RTE_Title := 'Horizon Rich Text Editor - hznRTE -- A Rich Text Editor for Horizon'
	file_name := '__receiver.ahk'
	file_line := '', TX11 := '', match:='', aLine := ''
	aTX11 := [], new_map := []
	width_needle := 'i)width', height_needle := 'i)height',	x_needle := 'i)x', y_needle := 'i)y', hCtl_needle := 'i)hCtl', nCtl_needle := 'i)nCtl'
	match_array := [width_needle, height_needle, x_needle, y_needle, hCtl_needle, nCtl_needle]
	; ---------------------------------------------------------------------------
	; HznSelectAll(hCtl)
	; clip_it()
	; ---------------------------------------------------------------------------
	hzntx11 := FileOpen(file_name,'rw','UTF-8')
	Sleep(300)
	; ---------------------------------------------------------------------------
	Update_Receiver_Rect_Map(file_name)
	; ---------------------------------------------------------------------------
	Update_Receiver_Rect_Map(file_name){
		loop read file_name {
			aTX11.Push(A_LoopReadLine)
			file_line .= A_LoopReadLine . '`n'
		}
		; Sleep(500)
		; ---------------------------------------------------------------------------
		for each, aLine in aTX11 {
			; ---------------------------------------------------------------------------
			for each, match in match_array {
				if ((aLine ~= match)) {
					str_match := StrSplit(match,')','i ) "')
					rMatch := str_match[2]
					; Infos(rMatch)
					rect_match := rect[rMatch]
					; rect_match := dpiRect.%str_match[2]%
					new_str := RegExReplace(aLine, ':= ([0-9].*)', ':= ' rect_match . ',' )
					aLine := new_str
					aTX11.RemoveAt(A_Index)
					aTX11.InsertAt(A_Index, aLine)
				}
			}
			; ---------------------------------------------------------------------------
			; function: write each value in the array to @param TX11 (string variable) */
			TX11 .= aLine . '`n'
			; ---------------------------------------------------------------------------
		}
		; Infos(file_line . '`n' . TX11)
		; ---------------------------------------------------------------------------
		; hzntx11 := FileOpen(file_name,'rw','UTF-8')
		hzntx11.Write(TX11)
		hzntx11 := ''
		return 0
	}
	HznSelectAll()
	; Send('^c')
	Try {
		SendMessage(0x0301, 0, 0, hCtl)
	} catch {
		SendMessage(0x0301, 0, 0, receiver.rect['hCtl'])
	}
	; clip_it()
	; MsgBox(A_Clipboard)
	; Infos(A_Clipboard)
	; -----------------------------------------------------------------------------
	; Info('Loading Rich Text Editor...', WinWaitActive(RTE_Title))
	; Info('Loading Rich Text Editor...', 3000)
	; Sleep(500)
	; try {
	; 	hznRTE := A_ScriptDir '\RTE.v2\Project Files\RichEdit_Editor_v2.ahk'
	; 	Run(hznRTE)
	; }
	; try Run(%'#1'%)
	; RTE := '"{1}" "%1" %*'
	; Run(%'#1'%)
	; if A_IsCompiled {
	; 	RTE_RSS := '"{1}*"'
	; 	Run(RTE_RSS)
	; } else {
	; 	; hznRTE := A_ScriptDir '\RTE.v2\Project Files\RichEdit_Editor_v2.ahk'
	; 	; hznRTE := '%A_ScriptDir%\RTE.v2\Project Files\RichEdit_Editor_v2.ahk'
	; 	; Run(hznRTE)
	; 	RTE()
	; }
	Run(A_ScriptName ' /script RichEdit_Editor_v2.exe')
	; RTE()
	; hRTE := WinWaitActive('hznRTE ')
	hRTE := WinExist(RTE_Title)
	pid_RTE := WinGetPID(hRTE)
	Sleep(500)
	; hRTE.Focus()
	; Infos(ControlGetClassNN(ControlFocus('A')))
	; SendMessage(0x0302, 0, 0, hRTE)
	; clip_it()
	; Send('^+v')
	Send('^v')
	; Infos(ControlGetClassNN(ControlGetFocus('A')))
	reCtl := (ControlGetClassNN(ControlGetFocus('A')))
	; AE_Select_End()
	; Send('+{Left}')
	; Send('{Del}')
	; ---------------------------------------------------------------------------
	; MsgBox(text '`n`n' '[This text has been copied to the clipboard. Use Ctrl+v to paste, or right-click and select Paste in your window of choice.]`n`n[This message will autoclose in 30 seconds]','Copy of Horizon Text', 'T30')
	; MsgBox('[This text has been copied to the clipboard. Use Ctrl+v, or right-click and select paste, to paste in your window of choice.]`n`n[This message will autoclose in 3 seconds]','Copy of Horizon Text', 'T3')
	; Infos('[This text has been copied to the clipboard. Use Ctrl+v, or right-click and select paste, to paste in your window of choice.]`n`n[This message will autoclose in 3 seconds]', 3000)
	; ---------------------------------------------------------------------------
	; return text
	ProcessWaitClose(pid_RTE)
	; FileCloseFN()
	WinActivate(hHzn)
	ControlFocus(hCtl, hHzn)
	HznSelectAll(hCtl)
	Sleep(100)
	; Send('+{Insert}') ;! <==== DON'T USE THIS, IT PASTES THE WINDOWS DEFAULT FONT WHICH IS ARIAL 12, HORIZON IS TIMES NEW ROMAN 11.
	Send('^v')
	BlockInput(0)
	SendLevel(0)
	A_Clipboard := bak
}

; ---------------------------------------------------------------------------
/************************************************************************
 * Function ..: HznPaste() (Ctrl+Shift+v)
 * @author ...: OvercastBTC
 * @source ...: https://learn.microsoft.com/en-us/windows/win32/dataxchg/wm-paste
 * @sourceparam .......: #define WM_PASTE                        0x0302
 * @param hCtl ........: Gets the control in focus hwnd, then the class name
 * @param Msg .........: Windows API message => WM_PASTE
 * @param WM_PASTE ....: Decimal number (versus hex = 0x0302) for WM_PASTE
 * @param wParam ......: This parameter is not used and must be zero.
 * @param lParam ......: This parameter is not used and must be zero.
 * @returns {null} ....: This message does not return a value.
***********************************************************************/

HznPaste(*) {
	Static Msg := WM_PASTE := 770, wParam := 0, lParam := 0
	hCtl := ControlGetFocus('A')
	DllCall('SendMessage', 'Ptr', hCtl, 'UInt', Msg, 'UInt', wParam, 'UIntP', lParam)
	return
}
; ---------------------------------------------------------------------------

; ---------------------------------------------------------------------------
; HznEnableButtons(hTb?, *)
HznEnableButtons(hTb) {
	initialSendLevel := A_SendLevel
	SendLevel(((A_SendLevel < 100) && (initialSendLevel >= 1) ? (A_SendLevel) : (A_SendLevel + 1)))
	BlockInput(1) ; 1 = On, 0 = Off
	; hTb := HznToolbar._hTb()
	; ---------------------------------------------------------------------------
	Static   WM_COMMAND := 273, TB_GETBUTTON:= 1047, TB_BUTTONCOUNT:= 1048,TB_COMMANDTOINDEX := 1049,TB_GETITEMRECT := 1053,MEM_PHYSICAL := 4,MEM_RELEASE := 32768,TB_GETSTATE := 1042,TB_GETBUTTONSIZE := 1082, TB_ENABLEBUTTON := 0x0401, TB_SETSTATE := 0x0411,TBSTATE_ENABLED := 4,TBSTATE_DISABLED := 0, TBSTATE_HIDDEN := 8 
	; ---------------------------------------------------------------------------

	; Step: count and load all the msvb_lib_toolbar buttons into memory
	; ---------------------------------------------------------------------------
	buttonCount := SendMessage(TB_BUTTONCOUNT, 0, 0,, hTb)
	; Infos('Btn Ct: ' buttonCount)
	; ---------------------------------------------------------------------------
	; Step: Use the @params to enable the button
	; ---------------------------------------------------------------------------
	Loop buttonCount {
		idCommand := A_Index +99
		If (idCommand <= 102) {
			Msg := TB_SETSTATE, wParam := idCommand, lParam_HI := 4, lParam_LO := TBSTATE_ENABLED, control := hTb
		; SendMessage(TB_SETSTATE, idCommand, 0|TBSTATE_ENABLED,,hTb)
			SendMessage(Msg, wParam, lParam_HI|lParam_LO,control,hTb)
			tryGetItemList(idCommand)
		}
		If (idCommand > 108) {
			Msg := TB_SETSTATE, wParam := idCommand, lParam_HI := 4, lParam_LO := TBSTATE_ENABLED, control := hTb
		; SendMessage(TB_SETSTATE, idCommand, 0|TBSTATE_ENABLED,,hTb)
			SendMessage(Msg, wParam, lParam_HI|lParam_LO,control,hTb)
		}
		tryGetItemList(control) {
			try {
				button_items_rows := ControlGetItems(control)
				item := ''
				item_list := ''
				; try {
					for item in button_items_rows {
						item_list .= item . '`n'
						FileAppend(item_list, '_button_items_rows.ahk', 'UTF-8')
					}
				; }
			}
		}
	}
	; Infos(item_list)
	BlockInput(0)
	SendLevel(0)
	; return
}
/************************************************************************
 * function: HznTbCustomize()
 * @description : enables and shows all buttons on the toolbar
 * @hotkey 		: ^+8::
 * @param 		hTb 
 * @returns 	{void} 
 ***********************************************************************/

HznTbCustomize(hTb?)
{
	initialSendLevel := A_SendLevel
	SendLevel(((A_SendLevel < 100) && (initialSendLevel >= 1) ? (A_SendLevel) : (A_SendLevel + 1)))
	BlockInput(1) ; 1 = On, 0 = Off
	hTb := HznToolbar._hTb()
	Static TB_CUSTOMIZE := 1051, wParam := 0, lParam := 0, control := hTb
	try SendMessage(TB_CUSTOMIZE, wParam, lParam, control, hTb) ;wow, this works!!!
	BlockInput(0)
	SendLevel(0)
	return
}
; ---------------------------------------------------------------------------

; ---------------------------------------------------------------------------
/************************************************************************
 * @function button()
 * @author ....: Descolada, OvercastBTC
 * @Desc ......:  Call the Horizon msvb_lib_toolbar buttons using the button() function
 * @param A_ThisHotkey - AHK's built in variable.
 * @param idCommand .: optional => idCommand := 0 (preset value, else => idCommand?)
***********************************************************************/
button(idCommand:=0)
{
	initialSendLevel := A_SendLevel
	SendLevel(((A_SendLevel < 100) && (initialSendLevel >= 1) ? (A_SendLevel) : (A_SendLevel + 1)))
	BlockInput(1) ; 1 = On, 0 = Off
	Static  WM_COMMAND := 273, TB_GETBUTTON := 1047, TB_BUTTONCOUNT := 1048
	Static	TB_COMMANDTOINDEX := 1049, TB_GETITEMRECT := 1053 
	Static	MEM_PHYSICAL := 4, MEM_RELEASE := 32768, TB_GETSTATE := 1042
	Static	TB_GETBUTTONSIZE := 1082, TB_ENABLEBUTTON := 0x0401
	hTb := HznToolbar._hTb()
	nCtl := HznToolbar._nCtl()
	; ---------------------------------------------------------------------------
	; HznButton(hTb, idCommand, nCtl)
	; function: !!! ===> Programatically "Click" the button!!! <=== !!!
	Msg := WM_COMMAND, wParam_hi := 0, wParam_lo := idCommand, lParam := control := hTb
	; DllCall('SendMessage', 'UInt', hTb, 'UInt', Msg, 'UInt', wParam_hi | wParam_lo, 'UIntP', lParam)
	SendMessage(Msg, wParam_hi | wParam_lo, lParam, , hTb)
	; ---------------------------------------------------------------------------
	SendLevel(0) ; restore normal SendLevel
	BlockInput(0) ; 1 = On, 0 = Off
	return
}
; ---------------------------------------------------------------------------
/************************************************************************
 * @function idButton()
 * @author ....: Descolada, OvercastBTC
 * @Desc ......:  Call the Horizon msvb_lib_toolbar buttons using the button() function
 * @param A_ThisHotkey - AHK's built in variable.
 * @param idBtn .: optional => idCommand := 0 (preset value, else => idCommand?)
***********************************************************************/

; idButton(buttonhotkey?)
; {
; 	try {
; 		(buttonhotkey >= 100) ? idBtn := (buttonhotkey - 99) : buttonhotkey
; 	}
; 	catch{
; 		idBtn:= (A_ThisHotkey = "^b")  ? 1 	: 	;.........: bold
; 				(A_ThisHotkey = "^i")  ? 2 	: 	;.........: italic
; 				(A_ThisHotkey = "^u")  ? 3 	: 	; ........: underline
; 				(A_ThisHotkey = '^+b') ? 15	:	; ........: Bulleted List
; 				(A_ThisHotkey = 'F5')  ? 19	:	; ........: Find/Replace
; 				(A_ThisHotkey = '^F5') ? 19	:	; ........: Find/Replace
; 				(A_ThisHotkey = 'F7')  ? 16	:	; ........: Spell Check
; 				(A_ThisHotkey = '^F7') ? 16	: OutputDebug('idBtn: ' idBtn '`n')	; ........: Spell Check
; 				; (A_ThisHotkey = "^x")  ? 8 	:	; ........: cut
; 				; (A_ThisHotkey = "^c")  ? 9 	:	; ........: copy
; 				; (A_ThisHotkey = "^v")  ? 10	:	; ........: paste
; 				; (A_ThisHotkey = "^z")  ? 12	:	; ........: undo
; 				; (A_ThisHotkey = "^y")  ? 13	:	; ........: redo
; 				; (A_ThisHotkey = '^+s') ? 18	:	; ........: super|sub script
; 			}
; 	OutputDebug('idBtn: ' idBtn '`n')
; 	return idBtn
; }
; --------------------------------------------------------------------------------------------
/************************************************************************
 * Function .....: HznButton()
 * @Desc Clicks the nth item in a Win32 application toolbar.
 * @author ......: Descolada, OvercastBTC
 * @param hTb - The handle of the toolbar control.
 * @param hTb - same as hTb
 * @param fCtl* - [OPTIONAL] The ClassNN of the "focused" control.
 * @param fCtlInstance - The ClassNN [instance] of the "focused" control.
 * @param nCtl - The [ClassNN and instance] of the toolbar control.
 * @function param:=0 => in AHK v2 => optional
 ***********************************************************************/
; ---------------------------------------------------------------------------
; HznButton(hTb, nCtl, idCommand, n?, pID?, fCtl?, hTx?, fCtlInstance?) {
HznButton(hTb, idCommand, nCtl?) {
	initialSendLevel := A_SendLevel
	SendLevel(((A_SendLevel < 100) && (initialSendLevel >= 1) ? (A_SendLevel) : (A_SendLevel + 1)))
	BlockInput(1) ; 1 = On, 0 = Off
	; ---------------------------------------------------------------------------
	Static  WM_COMMAND := 273, TB_GETBUTTON := 1047, TB_BUTTONCOUNT := 1048
	Static	TB_COMMANDTOINDEX := 1049, TB_GETITEMRECT := 1053 
	Static	MEM_PHYSICAL := 4, MEM_RELEASE := 32768, TB_GETSTATE := 1042
	Static	TB_GETBUTTONSIZE := 1082, TB_ENABLEBUTTON := 0x0401
	; ---------------------------------------------------------------------------
	; Step: count and load all the msvb_lib_toolbar buttons into memory
	; ---------------------------------------------------------------------------
	buttonCount := SendMessage(TB_BUTTONCOUNT, 0, 0, , hTb)
	; ---------------------------------------------------------------------------
	; Step: Use the @params to press the button
	; ---------------------------------------------------------------------------
	
	try if (idCommand >= 100 && idCommand <= (buttonCount + 99)) {
		; * Get the toolbar "thread" process ID (PID)
		DllCall("GetWindowThreadProcessId", "Ptr", hTb, "UInt*", &tpID := 0)
		; ---------------------------------------------------------------------------
		; * Open the process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
		hProcess := DllCall('OpenProcess', 'UInt', 8 | 16 | 32, "Int", 0, "UInt", tpID, "Ptr")
		; ---------------------------------------------------------------------------
		; * Identify if the process is 32 or 64 bit (efficiency step)
		Is32bit := Win32_64_Bit(hProcess)
		; ---------------------------------------------------------------------------
		; * Allocate memory for the TBBUTTON structure in the target process's address space
		remoteMemory := remote_mem_buff(hProcess, Is32bit, &TBBUTTON_SIZE)
		; ---------------------------------------------------------------------------
		; DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", MEM_RELEASE)
		; DllCall("CloseHandle", "Ptr", hProcess)
		; ---------------------------------------------------------------------------
		; Step: Store previous and set min delay
		; ---------------------------------------------------------------------------
		pCD := A_ControlDelay, pMD := A_MouseDelay, pWD := A_WinDelay
		SetControlDelay(-1), SetMouseDelay(-1), SetWinDelay(-1)
		; ---------------------------------------------------------------------------
		; try (idCommand < 100) ? idCommand := ((n - 1) + 100) : idCommand
		; btnstate := GETBUTTONSTATE(idCommand, hTb)
		; If (!btnstate = 4) || (!btnstate = 6) ;! note: (AJB - 09/2023) verified
		; 	return
		
		; ---------------------------------------------------------------------------
		; ; function: !!! ===> Programatically "Click" the button!!! <=== !!!
		; Msg := WM_COMMAND, wParam_hi := 0, wParam_lo := idCommand, lParam := control := hTb
		; ; DllCall('SendMessage', 'UInt', hTb, 'UInt', Msg, 'UInt', wParam_hi | wParam_lo, 'UIntP', lParam)
		; SendMessage(Msg, wParam_hi | wParam_lo, lParam, , hTb)
		; ---------------------------------------------------------------------------
		; Step: Restore previous and set delay
		; ---------------------------------------------------------------------------
		SetControlDelay(pCD), SetMouseDelay(pMD), SetWinDelay(pWD)
		; ---------------------------------------------------------------------------
		BlockInput(0) ; 1 = On, 0 = Off
		; ---------------------------------------------------------------------------
	}
	catch
		throw ValueError("The specified toolbar " nCtl " was not found. Please ensure the edit field has been selected and try again.", -1)
	; Return 0
}
; ---------------------------------------------------------------------------
/**
 * @function ControlClick()
 * @note All of these are equivalent as of 09.11.23
 */
HznControlClick(X, Y)
{
; ControlClick("x" ((X+(W/2))*DPIsc) " y" ((Y+(H/2))*DPIsc), hTb,,,, "NA")
; ControlClick("x" (X2*DPIsc) " y" (Y2*DPIsc), hTb,,,, "NA")
; ControlClick("x" X " y" Y, hTb,,,, "NA") ; <===== this one is the best usable
}
; ---------------------------------------------------------------------------
; Callback definition for EVENT_SYSTEM_CAPTURESTART
; msvb_lib_toolbar_created := CallbackCreate(CallBack_TB_CREATED)
; ^+!q::
; EnumWindowsProc(&nCtl:='', &hTb:=0)
; {
; 	nCtl := ''
; 	win_get_controls := WinGetControls('A')
; 	list_controls := DisplayObj(win_get_controls)
; 	OutputDebug(list_controls)
; 	bak_TitleMatchMode := A_TitleMatchMode
; 	OutputDebug(bak_TitleMatchMode)
; 	SetTitleMatchMode('RegEx')
; 	RegExMatch(list_controls, 'msvb_lib_toolbar\d', &m)
; 	OutputDebug(m)
; 	SetTitleMatchMode(bak_TitleMatchMode)
; 	&nCtl := m[]
; 	&hTb := ControlGethWnd(nCtl, "A")
; 	MsgBox(nCtl ' ' hTb . '`n')
; 	return
; }	
; ---------------------------------------------------------------------------
remote_mem_buff(hProcess, Is32bit?, &CTRL_SIZE?)
{
	Static MEM_PHYSICAL := 4 ; 0x04 ; 0x00400000, ; via MSDN Win32
	Static MEM_COMMIT := 4096
	Is32bit := 0
	RPtrSize := Is32bit ? 4 : 8
	CTRL_SIZE := 8 + (RPtrSize * 3) 
	remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", CTRL_SIZE, "UInt", MEM_COMMIT, "UInt", MEM_PHYSICAL, "Ptr")
	return remoteMemory
}
; ---------------------------------------------------------------------------
/**
 * function: Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
 * @param tpID
 * @param PROCESS_VM_READ
 * 		@param Int32
 * 		@Dec_Value 8
 * 		@Hex_Value 0x00000008 ??? or 0x0018 ???
 * @param PROCESS_VM_READ
 * 		@param Int32
 * 		@Dec_Value 16
 * 		@Hex_Value 0x00000010 ??? or 0x0010
 * @param PROCESS_VM_WRITE
 * 		@param Int32
 * 		@Dec_Value 32
 * 		@Hex_Value 0x00000020 ??? or 0x0020
 * @example hProcess := DllCall('OpenProcess', 'UInt', 0x0018 | 0x0010 | 0x0020, 'Int', 0, 'UInt', tpID, 'Ptr')
 * @returns {hProcess}
 */
_hProcess(tpID)
{
	Static PROCESS_VM_OPERATION := 8, PROCESS_VM_READ := 16, PROCESS_VM_WRITE := 32
	; hProcess := DllCall( 'OpenProcess', 'UInt'
						; , PROCESS_VM_OPERATION | PROCESS_VM_READ | PROCESS_VM_WRITE
						; , "Int", 0
						; , "UInt", tpID
						; , "Ptr")
	; return hProcess
	return DllCall( 'OpenProcess', 'UInt', PROCESS_VM_OPERATION | PROCESS_VM_READ | PROCESS_VM_WRITE, "Int", 0, "UInt", tpID, "Ptr")
}
; ---------------------------------------------------------------------------
; rect := WindowGetRect("window title etc.")
; MsgBox(rect.width "`n" rect.height)
hIntersectRect(l1, t1, r1, b1, l2, t2, r2, b2) {
	rect1 := Buffer(16), rect2 := Buffer(16), rectOut := Buffer(16)
	NumPut("int", l1, "int", t1, "int", r1, "int", b1, rect1)
	NumPut("int", l2, "int", t2, "int", r2, "int", b2, rect2)
	if DllCall("user32\IntersectRect", "Ptr", rectOut, "Ptr", rect1, "Ptr", rect2)
		return {l:NumGet(rectOut, 0, "Int"), t:NumGet(rectOut, 4, "Int"), r:NumGet(rectOut, 8, "Int"), b:NumGet(rectOut, 12, "Int")}
}
WindowGetRect(hwnd) {
    try {
        rect := Buffer(64, 0) ; V1toV2: if 'rect' is a UTF-16 string, use 'VarSetStrCapacity(&rect, 16)'
        DllCall("GetClientRect", "Ptr", hwnd, "Ptr", rect)
        ; return {width: NumGet(rect, 8, "Int"), height: NumGet(rect, 12, "Int")}
		return {Left: NumGet(rect, 0, "Int"), Top: NumGet(rect, 4, "Int"), Right: NumGet(rect, 8, "Int"), Bottom: NumGet(rect, 12, "Int"), Height: ((NumGet(rect, 12, "Int")) - (NumGet(rect, 4, "Int"))), Width: ((NumGet(rect, 8, "Int") - (NumGet(rect, 0, "Int")))) }
    }
}
GetRect(hwnd, &RC := "", *) { ; Retrieves the rich edit control's formatting rectangle
; Returns an object with keys L (eft), T (op), R (ight), and B (ottom).
; If a variable is passed in the Rect parameter, the complete RECT structure will be stored in it.
RC := Buffer(32, 0)
; SendMessage(0x00B2, 0, RC.Ptr, HWND)
SendMessage(178, 0, RC.Ptr, HWND)
; Return {L: NumGet(RC, 0, "Int"), T: NumGet(RC, 4, "Int"), R: NumGet(RC, 8, "Int"), B: NumGet(RC, 12, "Int")}
Return {Left: NumGet(RC, 0, "Int"), Top: NumGet(RC, 4, "Int"), Right: NumGet(RC, 8, "Int"), Bottom: NumGet(RC, 12, "Int"), Height: ((NumGet(RC, 12, "Int")) - (NumGet(RC, 4, "Int"))), Width: ((NumGet(RC, 8, "Int") - (NumGet(RC, 0, "Int")))) }
}
GetClientSize(hCtl)
{
	BtnStructSize := 32
	; rc := Buffer(BtnStructSize, 0)
	rc := Buffer(BtnStructSize, 16)
	; Buffer(rc:=0,16)
    ; DllCall("GetClientRect", "Ptr", hCtl, "Ptr", rc)
	tbRECT := GETITEMRECT(hCtl)
	l:=tbRECT.Left
	b:=tbRECT.Bottom
	; SendMessage(Msg, wParam, lParam,, hTb)
	; l := NumGet(rc, 0, "Int")
	; t := NumGet(rc, 4, "Int")
    ; r := NumGet(rc, 8, "int")
    ; b := NumGet(rc, 12, "int")
	; w := l - r
	; h := b-t

	; MsgBox('w:' . w . ' ' . 'h: ' . h . '`n')
	; return {Left:l,Top:t,Right:r,Bottom:b,Width:w, Height:h}
	return {Left:l,Bottom:b}
}
GetClientRect(hCtl, hCtl_title){
	
	mTX11 := Map()
	dpi_hzn := DPI.MonitorFromWindow('hznHorizon.exe')
	Info('dpi_hzn: ' . dpi_hzn, 30000)
	RECT := Buffer(32, 0)
	DllCall("MapWindowPoints", "Ptr", hCtl, "Ptr", 0, "Ptr", RECT, "UInt", 2)
	Left:= NumGet(RECT, 0, "Int")
	Top:= NumGet(RECT, 4, "Int"), 
	Right:= NumGet(RECT, 8, "Int")
	Bottom:= NumGet(RECT, 12, "Int")
	Width := (Left + (Right/2))
	Height := (Top + (Bottom/2))
	mTX11.Set('Left', Left, 'Right', Right, 'Top', Top, 'Bottom', Bottom, 'height', height, 'width', width)
	; Info(
	; 	'Left: ' . Left . ' ' . 'Right: ' . Right
	; 	. '`n'
	; 	'Top: ' . Top . '`n' . 'Bottom: ' . Bottom
	; 	. '`n'
	; 	'Height: ' . Height . '`n' . 'Width: ' . Width
	; 	, 30000)
	return mTX11
}
; fix
^+7::somestufffortoolbar()

somestufffortoolbar(idButton?, hTb?){
	buttons := hznButtonCount()
    hTb := HznToolbar._hTb()
    hTx := ControlGetFocus('A')
    pID := HznToolbar._pID()
    tpID := HznToolbar._tpID()
	hTx := ControlGetFocus('A')
	Text := Buffer(128, 0)
	RECT := Buffer(32, 0)
	a_idButton := []
	aStrings := []
	a_text := []
	a_Rect := []
	vButton := ''
	idButton := ''
	vText := ''
	a_bText := ''
	b_bText := ''
	dText := ''
	vRect := ''
	text := ''
    TB_GETBUTTON := 1047
	Static Msg := TB_GETITEMRECT := 1053
	; Static Msg := EM_GETRECT := 178
	static wParam := 1
	Static PROCESS_VM_OPERATION := 8, PROCESS_VM_READ := 16, PROCESS_VM_WRITE := 32
	hCtl := hTb
	DllCall("GetWindowThreadProcessId", "Ptr", hCtl, "UInt*", &tpID := 0)
	hProcess := DllCall( 'OpenProcess', 'UInt', 8 | 16 | 32, "Int", 0, "UInt", tpID, "Ptr")
	Static MEM_PHYSICAL := 4 ; 0x04 ; 0x00400000, ; via MSDN Win32
	Static MEM_COMMIT := 4096
	Is32bit := 0, RPtrSize := Is32bit ? 4 : 8, CTRL_SIZE := 8 + (RPtrSize * 3) 
	remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 1, "UPtr", CTRL_SIZE, "UInt", MEM_COMMIT, "UInt", MEM_PHYSICAL, "Ptr")
	; remoteMemory := remote_mem_buff(hProcess, , &CTRL_SIZE)
	lParam := remoteMemory
	SendMessage(Msg, wParam, lParam, hCtl, hCtl)
	RECT := Buffer(CTRL_SIZE, 0)
	; Note : Winapi TBBUTTON struct(32 bytes on x64, 20 bytes on x86)
	Is32bit := Win32_64_Bit(remoteMemory)
	BtnStructSize := Is32bit ? 20 : 32
	; RECT := BtnStruct := Buffer(BtnStructSize, 0)
	; BtnStruct := Buffer(BtnStructSize, 0)
	; ---------------------------------------------------------------------------
	; * Read the button information stored in the RECT (remoteMemory)
	DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", RECT, "UPtr", BtnStructSize, "UInt*", &bytesRead:=32, "Int")
	Loop buttons {
		button := (A_Index + 99)
		idButton := String(button)
		; Get_Button := _GETBUTTON(idButton)
		hProcess := DllCall('OpenProcess', 'UInt', 8 | 16 | 32, "Int", 0, "UInt", tpID, "Ptr")
		remoteMemory := remote_buffer := remote_mem_buff(hProcess,0,&TBBUTTON_SIZE)
		GETBUTTON := SendMessage(TB_GETBUTTON, idButton, remoteMemory, hTb, hTb)

		a_nText 	:= NumGet(Text, 0, 	"UInt")
		b_nText 	:= NumGet(Text, 4, 	"UInt")
		c_nText 	:= NumGet(Text, 8, 	"Int")
		d_nText 	:= NumGet(Text, 12, "Int")
		fsState 	:= NumGet(Text, 16, "UChar")
		fsStyle 	:= NumGet(Text, 17, "UChar")
		cxWORD 		:= NumGet(Text, 18, "UShort")

		Info(
			'[' button . '] ' 
			; '1 ' . txt_strcap . ' ' 
			; '2 ' . txt_buff . ' ' 
			'3 ' . a_bText   . ' ' 
			'4 ' . b_bText . ' ' 
			'5 ' . vText . ' ' 
			'6 ' . a_nText . ' '
			'7 ' . b_nText . ' ' 
			'8 ' . c_nText . ' '
			'9 ' . d_nText . ' ' 
			'10 ' . fsState . ' '
			'11 ' . fsStyle . ' '	
			'12 ' . cxWORD . ' '
			, 30000
		)
		; dText .= '[' . button . '] ' . 'a_bText: ' . a_bText . ' ' 
		; . 'b_bText: ' . b_bText . ' ' . 'vText: ' . vText . ' ' . 'a_nText: ' 
		; . a_nText . '`n' . 'b_nText: ' . b_nText . '`n' 
		; . 'c_nText: ' . c_nText . ' ' . 'd_nText: ' . d_nText . '`n'
		; dText := 'idButton: ' . button . '`n' . 'a_bText: ' . a_bText . '`n' . 'b_bText: ' . b_bText . '`n' . 'vText: ' . vText . '`n' . 'a_nText: ' 
		; ; . a_nText . '`n' . 'b_nText: ' . b_nText . '`n' 
		; . 'c_nText: ' . c_nText . '`n' . 'd_nText: ' . d_nText . '`n'
	}
	; Info(dText, 30000)
	; for each, idButton in a_idButton {
	; 	a_text.Push(text)
		; ---------------------------------------------------------------------------
	; SendMessage(0x433, idButton, RECT, hTx , hTx)	; TB_GETRECT
	DllCall("MapWindowPoints", "Ptr", hTx, "Ptr", 0, "Ptr", RECT, "UInt", 2)
	Left := NumGet(RECT, 0, "Int")
	Bottom := NumGet(RECT, 12, "Int")
	Info('Left: ' . Left . '`n' . 'Bottom: ' . Bottom, 30000)
	; 	a_Rect.Push(Left)
	; 	a_Rect.Push(Bottom)
	; }
	; for each, vButton in a_idButton {
	; 	idButton .= vButton . '`n'
	; 	for each, vText in a_text {
	; 		bText .= vText . '`n'
	; 	}
	; }
	; for each, vRect in a_Rect {
	; 	bRect := ''
	; 	bRect .= 'L: ' Left . ' ' . 'B: ' Bottom 
	; }
	; info(
	; 	'Buttond ID: ' 	. idButton 	. '`n'
	; 	'Text: ' 		. text 		. '`n'
	; 	'Left: ' 		. Left 		. '`n'
	; 	'Bottom: ' 		. Bottom 	. '`n'
	; 	, 30000
	; )
}
_GETBUTTON(n:=1, hTb?, pID?, hProcess?)
{
	Static 	TB_GETBUTTON := 1047 ; hex = 0x417
	OutputDebug('n: ' n '`n')
	; pID := WinGetPID(hTb)
	pID := HznToolbar._pID()
	tpID := HznToolbar._tpID()
	hTb := HznToolbar._hTb()
	hProcess := _hProcess(tpID)
	; hProcess = 0 ? hProcess := hp_Remote(pID) : hpRemote := hpRemote
	remoteMemory := remote_buffer := remote_mem_buff(hProcess,0,&TBBUTTON_SIZE)
	GETBUTTON := SendMessage(TB_GETBUTTON, n-1, remoteMemory, hTb, hTb)
	; MsgBox(GETBUTTON) ; ===> displays a zero (0)
	return GETBUTTON
}
GETBUTTONINFO(hTb?){
	hTb := HznToolbar._hTb()
	; wParam := idButton, lParam := struct(), 
	; SendMessage(0x43F, wParam, lParam, , hTb) ; TB_GETBUTTONINFOW
	;;TBBUTTONINFO=48:32

	; typedef struct {
	; 	0: 0,
	; 	"UInt" UINT cbSize ;
	; 	4: 4,
	; 	"UInt" DWORD dwMask ;
	; 	8: 8,
	; 	"Int" int idCommand ;
	; 	12: 12,
	; 	"Int" int iImage ;
	; 	16: 16,
	; 	"UChar" BYTE fsState ;
	; 	17: 17,
	; 	"UChar" BYTE fsStyle ;
	; 	18: 18,
	; 	"UShort" WORD cx ;
	; 	24: 20,
	; 	"UPtr" DWORD_PTR lParam ;
	; 	32: 24,
	; 	"Ptr" LPTSTR pszText ;
	; 	40: 28,
	; 	"Int" int cchText ;
	; } TBBUTTONINFO, *LPTBBUTTONINFO ;
	; 48: 32
}
GETBUTTONSTATE(idButton, hTb := HznToolbar._hTb())
{
	Static TB_GETSTATE := 1042 ; 0x0412
	; hTb := HznToolbar._hTb()
	btnCt := hznButtonCount()
	; Infos(btnCt)
	Msg := TB_GETSTATE, wParam := idButton, lParam := 0, control := hTb
	GETSTATE := SendMessage(TB_GETSTATE, wParam, lParam, hTb, hTb)
	btnstate := SubStr(GETSTATE,1,1)
	btnname := idButton = 100 ? 'Bold' : idButton = 101 ? 'Italic' : idButton = 102 ? 'Underline' : ''
	; If (btnstate = 4) || (btnstate = 6) || (btnstate = 1)
	; 	{
	; 	return btnstate
	; 	}
	; MsgBox(   'The ' btnname
	; 		. ' button is not available.' '`n'
	; 		. 'idButton: ' idButton '`n'
	; 		. 'btnstate: ' btnstate)
	; OutputDebug("btnstate: " . btnstate . "`n")
	return btnstate
}
; ---------------------------------------------------------------------------
/**
 * @function COMMANDBUTTON()
 * @param Msg := WM_COMMAND
 * @param wParam_hi := control defined notification code => := 0 or !btnstate (opposite of current position => 4 || 6)
 * @param wParam_lo := control identifier => idCommand from above
 * @param lParam 	:= handle to the control => hTb
 */
COMMANDBUTTON(idCommand, hTb, btnstate:=0)
{
	Static WM_COMMAND := 273 ; hex = 0x111
	Static Msg := WM_COMMAND, wParam_hi := !btnstate , wParam_lo := idCommand, lParam := control := hTb := hTb
	; ---------------------------------------------------------------------------
	SendMessage(Msg, wParam_hi | wParam_lo,lParam,, hTb)
	; ---------------------------------------------------------------------------
	; if(btnstate = 4) ? SendMessage(TB_SETSTATE, idCommand, 6 | 0, hTb, hTb) : SendMessage(TB_SETSTATE, idCommand, 4 | 0, hTb, hTb)
	; WM_NCLBUTTONDOWN := 0x00A1
	; WM_NCLBUTTONUP := 0x00A2
	; SendMessage(WM_LBUTTONDOWN,,X1|Y1,hTb,hTb)
	; Sleep(100)
	; SendMessage(WM_LBUTTONUP,,X1|Y1,hTb,hTb)
}
; ---------------------------------------------------------------------------
Win32_64_Bit(hpRemote)
; Win32_64_Bit(hpRemote, &Is32:='False')
{
	A_Is64bitOS ? DllCall("IsWow64Process", "Ptr", hpRemote, "Int*", Is32bit := 0) : DllCall("IsWow64Process", "Ptr", hpRemote, "Int*", Is32bit := 1)
	; If (A_Is64bitOS)
	; 	{
	; 		Static Is32bit := 0
	; 	Try
	; 		DllCall("IsWow64Process", "Ptr", hpRemote, "Int*", Is32bit)
	; 	catch
	; 		Is32bit := 1
		Is32bit = 0 ? Is32:='False' : is32:='True'
	OutputDebug("Is32bit: " Is32 "`n")
	return Is32bit
}
; ---------------------------------------------------------------------------
; /*
HznDPI(hCtl?,hCtl_title?, &arHznDPI:='', &DPIsc:=0)
{
	hCtl := ControlGetFocus('A')
	hCtl_title := WinGetTitle(hCtl)
	arHznDPI := Array()
	try {
		nmHwnd 	:= GetNearestMonitorInfo(hCtl, hCtl_title).Handle
		nmName 	:= GetNearestMonitorInfo(hCtl, hCtl_title).Name
		nmNum 	:= GetNearestMonitorInfo(hCtl, hCtl_title).Number
		nmPri 	:= GetNearestMonitorInfo(hCtl, hCtl_title).Primary
		mDPIx 	:= GetNearestMonitorInfo(hCtl, hCtl_title).x
		mDPIy 	:= GetNearestMonitorInfo(hCtl, hCtl_title).y
		mDPIw 	:= GetNearestMonitorInfo(hCtl, hCtl_title).WinDPI
		DPImw 	:= DPI.GetForWindow(hCtl, hCtl_title)
		DPIsc 	:= DPI.GetScaleFactor(DPImw) ; <====== this one
		; DPIsc1 	:= DPI.GetScaleFactor(mDPIx)
	} catch Error as e {
		; OutputDebug('nmHwnd: '	nmHwnd '`n'
		; 		.	'nmName: '	nmName '`n'
		; 		.	'nmNum: '	nmNum '`n'
		; 		.	'nmPri: '	nmPri '`n'
		; 		.	'mDPIx: '	mDPIx '`n'
		; 		.	'mDPIy: '	mDPIy '`n'
		; 		.	'mDPIw: '	mDPIw '`n'
		; 		.	'DPImw: '	DPImw '`n'
		; 		.	'DPIsc: '	DPIsc '`n'
		; 		; .	'DPIsc1: '	DPIsc1 '`n'
		; 		.	'PriDPI: '	A_ScreenDPI '`n'
		; 		)		
		throw e		
	}
	arHznDPI.Push(
		{  	  Number: '(' nmNum ')'
			, 1_Handle:nmHwnd
			, 2_Name:nmName
			, 3_x:mDPIx
			, 4_y:mDPIy
			, 5_WinDPI:mDPIw
			, 6_MainWinDPI:DPImw
			, 7_ScreenDPI:DPIsc
		})
	; ---------------------------------------------------------------------------
	return {arHznDPI:arHznDPI,DPIsc:DPIsc}
}
; */
; ---------------------------------------------------------------------------
; TODO need to validate that this works, but not high priority
/**
 * function .: for use in a button call that requires ControlCLick() and DPI adjustments
 * @description Get the bounds of each button (Get Item Rectangle)
 * @param GETITEMRECT( hProcess,n,remoteMemory,hTb,TBBUTTON_SIZE,Is32bit,&RECT,&BtnStructSize,&BtnStruct,&bytesRead,&Left,&Top,&Right,&Bottom, &X, &Y)
*/	
; GETITEMRECT(hProcess, n,remoteMemory,hTb, TBBUTTON_SIZE, Is32bit, &RECT, &BtnStructSize, &BtnStruct, &bytesRead, &Left, &Top, &Right, &Bottom, &X, &Y)
GETITEMRECT(hCtl)
{
	; wParam := n, lParam := remoteMemory, control := ''
	Static Msg := TB_GETITEMRECT := 1053
	RECT := Buffer(32, 0)
	DllCall("GetClientRect", "Ptr", hCtl, "Ptr", 0, "Ptr", RECT, "UInt", 2)
	Left := NumGet(RECT, 0, "Int")
	Bottom := NumGet(RECT, 12, "Int")
	Info('Left: ' . Left . '`n' . 'Bottom: ' . Bottom, 30000)
	Return {Left:Left, Bottom:Bottom}
	; ---------------------------------------------------------------------------
	; Note: Updated 09.11.23
	; hCtl_title := WinGetTitle(hCtl)
	; DPIsc := HznDPI(hCtl,hCtl_title).DPIsc
	; X1 			:= Left
	; Y1 			:= Top
	; Left 		:= X1
	; Top			:= Y1
	; W1 			:= Right-Left
	; H1 			:= Bottom-Top
	; ; W 			:= W1/2
	; W 			:= W1
	; ; H 			:= H1/2
	; H 			:= H1
	; X2 			:= X1+W
	; Y2 			:= Y1+H
	; dpiX 		:= X2*=DPIsc
	; dpiY 		:= Y2*=DPIsc
	; dpiWidth	:= Round((W*=DPIsc),0)
	; dpiHeight 	:= Round((H*=DPIsc),0)
	; ---------------------------------------------------------------------------
	; OutputDebug(
	; MsgBox(	
	; 	'X1:' X1 . ' ' . 'Y1:' . Y1 .  ' ' . 'W1:' . W1 . ' ' . 'H1:' . H1 . '`n'
	; 	. 'W:' . W . " " . 'H:' . H . '`n'
	; 	. 'X2:' X2 . ' ' . 'Y2:' . Y2 . '`n'
	; 	. 'X:' . X . ' ' . 'Y:' . Y . '`n'
	; 	)
}
; ---------------------------------------------------------------------------
/**
 * Installs the script to the user startup folder
 * @function Check_Startup_Status()
 * @param hWndToolbar - The handle of the toolbar control.
 * @param n - The index of the toolbar item to click (1-based). Note: Separators are considered items as well.
 * @returns {void} 
 */
; ---------------------------------------------------------------------------
Check_Startup_Status(){
arrStartup := Array(
	startup := A_Startup '\',
	script := StrSplit(A_Startup, '.'),
	scriptnoext := script[1],
	scriptlnk := script[1] . '.lnk',
	scriptSC := script[1] . script[2] . ' - Shortcut',
	)

Startup_Shortcut := arrStartup() 
; Startup_Shortcut := A_Startup "\" A_ScriptName
If (!FileExist(Startup_Shortcut))
    {
        
        myGui := Gui(,"Add Script to Startup Folder",)
        myGui.Opt("AlwaysOnTop")
        myGui.SetFont("s12")
        myGui.Add("Text",, "It is recommended you add this script to your Startup folder so`nthat it is active every time your computer starts.`n`nMake sure that the script is in the location you want to save`nit in before adding it to the startup folder.`n`nWould you like to add this script to the startup folder now?")
        myGui.Add("Button","x15 +default", "Add to Startup").OnEvent("Click", ClickedAdd)
        myGui.Add("Button","x+m", "Cancel").OnEvent("Click", ClickedCancel)
        myGui.Show("w500")
        
        ClickedAdd(*)
        {
            myGui.Destroy()
            FileCreateShortcut(A_ScriptDir "\" A_ScriptName, Startup_Shortcut)
            Run( "shell:startup")
            MsgBox("Shortcut added to your Startup folder at:`n`n" Startup_Shortcut "`n`nYour Startup folder has been opened for you. Please delete any old shortcuts.")
            Return
        }

        ClickedCancel(*)
        {
            myGui.Destroy()
            MsgBox("Please move the file to the location you want to save it, then run it again.")
            Return
        }
    } 
Else 
    {
		; MsgBox("Shortcut Exists") ; Test message for debugging. Leave commented out for normal operation.
        Return
    }
}
; ---------------------------------------------------------------------------
class RemoteTreeView
{
    ; Authors:
    ; rbrtryn (Initial script) (http://www.autohotkey.com/board/topic/84310-class-remote-treeview/)
    ; JnLlnd (https://www.autohotkey.com/boards/viewtopic.php?f=5&t=4998#p29502)
    ; just me
    ; Ahk_user (Conversion to V2)

    ; Constants for TreeView controls   
    static WC_TREEVIEW := "SysTreeView32",
        ; Messages =============================================================================================================
        TVM_CREATEDRAGIMAGE := 0x1112,    ; (TV_FIRST + 18)
        TVM_DELETEITEM := 0x1101,    ; (TV_FIRST + 1)
        TVM_EDITLABELA := 0x110E,   ; (TV_FIRST + 14)
        TVM_EDITLABELW := 0x1141,    ; (TV_FIRST + 65)
        TVM_ENDEDITLABELNOW := 0x1116,    ; (TV_FIRST + 22)
        TVM_ENSUREVISIBLE := 0x1114,    ; (TV_FIRST + 20)
        TVM_EXPAND := 0x1102,    ; (TV_FIRST + 2)
        TVM_GETBKCOLOR := 0x112F,    ; (TV_FIRST + 31)
        TVM_GETCOUNT := 0x1105,    ; (TV_FIRST + 5)
        TVM_GETEDITCONTROL := 0x110F,    ; (TV_FIRST + 15)
        TVM_GETEXTENDEDSTYLE := 0x112D,    ; (TV_FIRST + 45)
        TVM_GETIMAGELIST := 0x1108,    ; (TV_FIRST + 8)
        TVM_GETINDENT := 0x1106,    ; (TV_FIRST + 6)
        TVM_GETINSERTMARKCOLOR := 0x1126,    ; (TV_FIRST + 38)
        TVM_GETISEARCHSTRINGA := 0x1117,    ; (TV_FIRST + 23)
        TVM_GETISEARCHSTRINGW := 0x1140 ,   ; (TV_FIRST + 64)
        TVM_GETITEMA := 0x110C ,   ; (TV_FIRST + 12)
        TVM_GETITEMHEIGHT := 0x111C  ,  ; (TV_FIRST + 28)
        TVM_GETITEMPARTRECT := 0x1148 ,   ; (TV_FIRST + 72) ; >= Vista
        TVM_GETITEMRECT := 0x1104 ,   ; (TV_FIRST + 4)
        TVM_GETITEMSTATE := 0x1127 ,   ; (TV_FIRST + 39)
        TVM_GETITEMW := 0x113E ,   ; (TV_FIRST + 62)
        TVM_GETLINECOLOR := 0x1129 ,   ; (TV_FIRST + 41)
        TVM_GETNEXTITEM := 0x110A ,   ; (TV_FIRST + 10)
        TVM_GETSCROLLTIME := 0x1122 ,   ; (TV_FIRST + 34)
        TVM_GETSELECTEDCOUNT := 0x1146 ,   ; (TV_FIRST + 70) ; >= Vista
        TVM_GETTEXTCOLOR := 0x1120 ,   ; (TV_FIRST + 32)
        TVM_GETTOOLTIPS := 0x1119  ,  ; (TV_FIRST + 25)
        TVM_GETUNICODEFORMAT := 0x2006 ,   ; (CCM_FIRST + 6) CCM_GETUNICODEFORMAT
        TVM_GETVISIBLECOUNT := 0x1110 ,   ; (TV_FIRST + 16)
        TVM_HITTEST := 0x1111  ,  ; (TV_FIRST + 17)
        TVM_INSERTITEMA := 0x1100  ,  ; (TV_FIRST + 0)
        TVM_INSERTITEMW := 0x1142 ,   ; (TV_FIRST + 50)
        TVM_MAPACCIDTOHTREEITEM := 0x112A ,   ; (TV_FIRST + 42)
        TVM_MAPHTREEITEMTOACCID := 0x112B ,   ; (TV_FIRST + 43)
        TVM_SELECTITEM := 0x110B ,   ; (TV_FIRST + 11)
        TVM_SETAUTOSCROLLINFO := 0x113B ,   ; (TV_FIRST + 59)
        TVM_SETBKCOLOR := 0x111D ,   ; (TV_FIRST + 29)
        TVM_SETEXTENDEDSTYLE := 0x112C  ,  ; (TV_FIRST + 44)
        TVM_SETIMAGELIST := 0x1109 ,   ; (TV_FIRST + 9)
        TVM_SETINDENT := 0x1107 ,   ; (TV_FIRST + 7)
        TVM_SETINSERTMARK := 0x111A ,   ; (TV_FIRST + 26)
        TVM_SETINSERTMARKCOLOR := 0x1125 ,   ; (TV_FIRST + 37)
        TVM_SETITEMA := 0x110D ,   ; (TV_FIRST + 13)
        TVM_SETITEMHEIGHT := 0x111B ,   ; (TV_FIRST + 27)
        TVM_SETITEMW := 0x113F ,   ; (TV_FIRST + 63)
        TVM_SETLINECOLOR := 0x1128  ,  ; (TV_FIRST + 40)
        TVM_SETSCROLLTIME := 0x1121  ,  ; (TV_FIRST + 33)
        TVM_SETTEXTCOLOR := 0x111E ,   ; (TV_FIRST + 30)
        TVM_SETTOOLTIPS := 0x1118 ,   ; (TV_FIRST + 24)
        TVM_SETUNICODEFORMAT := 0x2005  ,  ; (CCM_FIRST + 5) ; CCM_SETUNICODEFORMAT
        TVM_SHOWINFOTIP := 0x1147 ,   ; (TV_FIRST + 71) ; >= Vista
        TVM_SORTCHILDREN := 0x1113  ,  ; (TV_FIRST + 19)
        TVM_SORTCHILDRENCB := 0x1115 ,   ; (TV_FIRST + 21)
        ; Notifications ========================================================================================================
        TVN_ASYNCDRAW := -420,    ; (TVN_FIRST - 20) >= Vista
        TVN_BEGINDRAGA := -427,    ; (TVN_FIRST - 7)
        TVN_BEGINDRAGW := -456,    ; (TVN_FIRST - 56)
        TVN_BEGINLABELEDITA := -410,    ; (TVN_FIRST - 10)
        TVN_BEGINLABELEDITW := -456,    ; (TVN_FIRST - 59)
        TVN_BEGINRDRAGA := -408,    ; (TVN_FIRST - 8)
        TVN_BEGINRDRAGW := -457,    ; (TVN_FIRST - 57)
        TVN_DELETEITEMA := -409,    ; (TVN_FIRST - 9)
        TVN_DELETEITEMW := -458,    ; (TVN_FIRST - 58)
        TVN_ENDLABELEDITA := -411,    ; (TVN_FIRST - 11)
        TVN_ENDLABELEDITW := -460,    ; (TVN_FIRST - 60)
        TVN_GETDISPINFOA := -403,    ; (TVN_FIRST - 3)
        TVN_GETDISPINFOW := -452,    ; (TVN_FIRST - 52)
        TVN_GETINFOTIPA := -412,    ; (TVN_FIRST - 13)
        TVN_GETINFOTIPW := -414,    ; (TVN_FIRST - 14)
        TVN_ITEMCHANGEDA := -418,    ; (TVN_FIRST - 18) ; >= Vista
        TVN_ITEMCHANGEDW := -419 ,   ; (TVN_FIRST - 19) ; >= Vista
        TVN_ITEMCHANGINGA := -416 ,   ; (TVN_FIRST - 16) ; >= Vista
        TVN_ITEMCHANGINGW := -417  ,  ; (TVN_FIRST - 17) ; >= Vista
        TVN_ITEMEXPANDEDA := -406   , ; (TVN_FIRST - 6)
        TVN_ITEMEXPANDEDW := -455  ,  ; (TVN_FIRST - 55)
        TVN_ITEMEXPANDINGA := -405,    ; (TVN_FIRST - 5)
        TVN_ITEMEXPANDINGW := -454,    ; (TVN_FIRST - 54)
        TVN_KEYDOWN := -412,    ; (TVN_FIRST - 12)
        TVN_SELCHANGEDA := -402,    ; (TVN_FIRST - 2)
        TVN_SELCHANGEDW := -451,    ; (TVN_FIRST - 51)
        TVN_SELCHANGINGA := -401,    ; (TVN_FIRST - 1)
        TVN_SELCHANGINGW := -450,    ; (TVN_FIRST - 50)
        TVN_SETDISPINFOA := -404,    ; (TVN_FIRST - 4)
        TVN_SETDISPINFOW := -453,    ; (TVN_FIRST - 53)
        TVN_SINGLEEXPAND := -415,    ; (TVN_FIRST - 15)
        ; Styles ===============================================================================================================
        TVS_CHECKBOXES := 0x0100,
        TVS_DISABLEDRAGDROP := 0x0010,
        TVS_EDITLABELS := 0x0008,
        TVS_FULLROWSELECT := 0x1000,
        TVS_HASBUTTONS := 0x0001,
        TVS_HASLINES := 0x0002,
        TVS_INFOTIP := 0x0800,
        TVS_LINESATROOT := 0x0004,
        TVS_NOHSCROLL := 0x8000,    ; TVS_NOSCROLL overrides this
        TVS_NONEVENHEIGHT := 0x4000,
        TVS_NOSCROLL := 0x2000,
        TVS_NOTOOLTIPS := 0x0080,
        TVS_RTLREADING := 0x0040,
        TVS_SHOWSELALWAYS := 0x0020,
        TVS_SINGLEEXPAND := 0x0400,
        TVS_TRACKSELECT := 0x0200,
        ; Exstyles =============================================================================================================
        TVS_EX_AUTOHSCROLL := 0x0020,    ; >= Vista
        TVS_EX_DIMMEDCHECKBOXES := 0x0200,    ; >= Vista
        TVS_EX_DOUBLEBUFFER := 0x0004,    ; >= Vista
        TVS_EX_DRAWIMAGEASYNC := 0x0400,    ; >= Vista
        TVS_EX_EXCLUSIONCHECKBOXES := 0x0100,    ; >= Vista
        TVS_EX_FADEINOUTEXPANDOS := 0x0040,    ; >= Vista
        TVS_EX_MULTISELECT := 0x0002,    ; >= Vista - Not supported. Do not use.
        TVS_EX_NOINDENTSTATE := 0x0008,    ; >= Vista
        TVS_EX_NOSINGLECOLLAPSE := 0x0001,    ; >= Vista - Intended for internal use; not recommended for use in applications.
        TVS_EX_PARTIALCHECKBOXES := 0x0080,    ; >= Vista
        TVS_EX_RICHTOOLTIP := 0x0010,    ; >= Vista
        ; Others ===============================================================================================================
        ; Item flags
        TVIF_CHILDREN := 0x0040,
        TVIF_DI_SETITEM := 0x1000,
        TVIF_EXPANDEDIMAGE := 0x0200,    ; >= Vista
        TVIF_HANDLE := 0x0010,
        TVIF_IMAGE := 0x0002,
        TVIF_INTEGRAL := 0x0080,
        TVIF_PARAM := 0x0004,
        TVIF_SELECTEDIMAGE := 0x0020,
        TVIF_STATE := 0x0008,
        TVIF_STATEEX := 0x0100,    ; >= Vista
        TVIF_TEXT := 0x0001,
        ; Item states
        TVIS_BOLD := 0x0010,
        TVIS_CUT := 0x0004,
        TVIS_DROPHILITED := 0x0008,
        TVIS_EXPANDED := 0x0020,
        TVIS_EXPANDEDONCE := 0x0040,
        TVIS_EXPANDPARTIAL := 0x0080,
        TVIS_OVERLAYMASK := 0x0F00,
        TVIS_SELECTED := 0x0002,
        TVIS_STATEIMAGEMASK := 0xF000,
        TVIS_USERMASK := 0xF000,
        ; TVITEMEX uStateEx
        TVIS_EX_ALL := 0x0002,    ; not documented
        TVIS_EX_DISABLED := 0x0002,    ; >= Vista
        TVIS_EX_FLAT := 0x0001,
        ; TVINSERTSTRUCT hInsertAfter
        TVI_FIRST := -65535,    ; (-0x0FFFF)
        TVI_LAST := -65534,    ; (-0x0FFFE)
        TVI_ROOT := -65536,    ; (-0x10000)
        TVI_SORT := -65533,    ; (-0x0FFFD)
        ; TVM_EXPAND wParam
        TVE_COLLAPSE := 0x0001,
        TVE_COLLAPSERESET := 0x8000,
        TVE_EXPAND := 0x0002,
        TVE_EXPANDPARTIAL := 0x4000,
        TVE_TOGGLE := 0x0003,
        ; TVM_GETIMAGELIST wParam
        TVSIL_NORMAL := 0,
        TVSIL_STATE := 2,
        ; TVM_GETNEXTITEM wParam
        TVGN_CARET := 0x0009,
        TVGN_CHILD := 0x0004,
        TVGN_DROPHILITE := 0x0008,
        TVGN_FIRSTVISIBLE := 0x0005,
        TVGN_LASTVISIBLE := 0x000A,
        TVGN_NEXT := 0x0001,
        TVGN_NEXTSELECTED := 0x000B,    ; >= Vista (MSDN)
        TVGN_NEXTVISIBLE := 0x0006,
        TVGN_PARENT := 0x0003,
        TVGN_PREVIOUS := 0x0002,
        TVGN_PREVIOUSVISIBLE := 0x0007,
        TVGN_ROOT := 0x0000,
        ; TVM_SELECTITEM wParam
        TVSI_NOSINGLEEXPAND := 0x8000,    ; Should not conflict with TVGN flags.
        ; TVHITTESTINFO flags
        TVHT_ABOVE := 0x0100,
        TVHT_BELOW := 0x0200,
        TVHT_NOWHERE := 0x0001,
        TVHT_ONITEMBUTTON := 0x0010,
        TVHT_ONITEMICON := 0x0002,
        TVHT_ONITEMINDENT := 0x0008,
        TVHT_ONITEMLABEL := 0x0004,
        TVHT_ONITEMRIGHT := 0x0020,
        TVHT_ONITEMSTATEICON := 0x0040,
        TVHT_TOLEFT := 0x0800,
        TVHT_TORIGHT := 0x0400,
        TVHT_ONITEM := 0x0046,    ; (TVHT_ONITEMICON | TVHT_ONITEMLABEL | TVHT_ONITEMSTATEICON)
        ; TVGETITEMPARTRECTINFO partID (>= Vista)
        TVGIPR_BUTTON := 0x0001,
        ; NMTREEVIEW action
        TVC_BYKEYBOARD := 0x0002,
        TVC_BYMOUSE := 0x0001,
        TVC_UNKNOWN := 0x0000,
        ; TVN_SINGLEEXPAND return codes
        TVNRET_DEFAULT := 0,
        TVNRET_SKIPOLD := 1,
        TVNRET_SKIPNEW := 2
        ; ======================================================================================================================

        static PAGE_NOACCESS := 0x01,
        PAGE_READONLY := 0x02,
        PAGE_READWRITE := 0x04,
        PAGE_WRITECOPY := 0x08,
        PAGE_EXECUTE := 0x10,
        PAGE_EXECUTE_READ := 0x20,
        PAGE_EXECUTE_READWRITE := 0x40,
        PAGE_EXECUTE_WRITECOPY := 0x80,
        PAGE_GUARD := 0x100,
        PAGE_NOCACHE := 0x200,
        PAGE_WRITECOMBINE := 0x400,
        MEM_COMMIT := 0x1000,
        MEM_RESERVE := 0x2000,
        MEM_DECOMMIT := 0x4000,
        MEM_RELEASE := 0x8000,
        MEM_FREE := 0x10000,
        MEM_PRIVATE := 0x20000,
        MEM_MAPPED := 0x40000,
        MEM_RESET := 0x80000,
        MEM_TOP_DOWN := 0x100000,
        MEM_WRITE_WATCH := 0x200000,
        MEM_PHYSICAL := 0x400000,
        MEM_ROTATE := 0x800000,
        MEM_LARGE_PAGES := 0x20000000,
        MEM_4MB_PAGES := 0x80000000,

        PROCESS_TERMINATE := (0x0001),
        PROCESS_CREATE_THREAD := (0x0002),
        PROCESS_SET_SESSIONID := (0x0004),
        PROCESS_VM_OPERATION := (0x0008),
        PROCESS_VM_READ := (0x0010),
        PROCESS_VM_WRITE := (0x0020),
        PROCESS_DUP_HANDLE := (0x0040),
        PROCESS_CREATE_PROCESS := (0x0080),
        PROCESS_SET_QUOTA := (0x0100),
        PROCESS_SET_INFORMATION := (0x0200),
        PROCESS_QUERY_INFORMATION := (0x0400),
        PROCESS_SUSPEND_RESUME := (0x0800),
        PROCESS_QUERY_LIMITED_INFORMATION := (0x1000)

    ;----------------------------------------------------------------------------------------------
    ; Method: __New
    ;         Stores the TreeView's Control HWnd in the object for later use
    ;
    ; Parameters:
    ;         TVHwnd			- HWND of the TreeView control
    ;
    ; Returns:
    ;         Nothing
    ;
    __New(TVHwnd){
        this.TVHwnd := TVHwnd
    }

    ;----------------------------------------------------------------------------------------------
    ; Method: SetSelection
    ;         Makes the given item selected and expanded. Optionally scrolls the
    ;         TreeView so the item is visible.
    ;
    ; Parameters:
    ;         pItem			    - Handle to the item you wish selected
    ;         defaultAction     - Determines of the default action is activated
    ;                         true : Send an Enter (default)
	;                         false : do noting
    ;
    ; Returns:
    ;         TRUE if successful, or FALSE otherwise
    ;
    SetSelection(pItem, defaultAction := true) {
        ; ORI SendMessage TVM_SELECTITEM, TVGN_CARET|TVSI_NOSINGLEEXPAND, pItem, , % "ahk_id " this.TVHwnd
        result := SendMessage(this.TVM_SELECTITEM, this.TVGN_CARET, pItem, , "ahk_id " this.TVHwnd)
        if (defaultAction){
            Controlsend("{Enter}", this.TVHwnd)
        }
        return result
        ; return SendMessage(this.TVM_SELECTITEM, this.TVGN_FIRSTVISIBLE, pItem, , "ahk_id " this.TVHwnd) ; Seemed not to work
    }
    ;----------------------------------------------------------------------------------------------
    ; Method: SetSelectionByText
    ;         Makes the given item selected and expanded. Optionally scrolls the
    ;         TreeView so the item is visible.
    ;
    ; Parameters:
    ;         text			    - Text of the item you wish selected
    ;         defaultAction     - Determines of the default action is activated
    ;                               true : Send an Enter (default)
	;                               false : do noting
    ;         index			    - Index of item if you do not want to use the first item
    ;
    ; Returns:
    ;         TRUE if successful, or FALSE otherwise
    ;
    SetSelectionByText(text, defaultAction := true, index := 1) {
        ; hItem := "0"    ; Causes the loop's first iteration to start the search at the top of the tree.
        hItem := this.GetHandleByText(text, index)
        if hItem{
            return this.SetSelection(hItem, defaultAction)
        }
        return false
    }
    ;----------------------------------------------------------------------------------------------
    ; Method: GetHandleByText
    ;         Retrieves the currently item with a specific text
    ;
    ; Parameters:
    ;         text			- Text of the item
    ;         index			- Index of item if you do not want to use the first item
    ;
    ; Returns:
    ;         Handle of Item
    ;
    GetHandleByText(Text, index := 1) {
        hItem := "0"    ; Causes the loop's first iteration to start the search at the top of the tree.
        i := 0
        Loop {
            hItem := this.GetNext(hItem, "Full")
            if !hItem{ ; No more items in tree.
                return false
            }    
            if (this.GetText(hItem)=Text){
                i++
                if (index = i){
                    return hItem
                }
            }
        }
        return false
    }

    ;----------------------------------------------------------------------------------------------
    ; Method: GetSelection
    ;         Retrieves the currently selected item
    ;
    ; Parameters:
    ;         None
    ;
    ; Returns:
    ;         Handle to the selected item if successful, Null otherwise.
    ;
    GetSelection() {
        return SendMessage(this.TVM_GETNEXTITEM, this.TVGN_CARET, 0, , "ahk_id " this.TVHwnd)
    }
    ;----------------------------------------------------------------------------------------------
    ; Method: GetSelectionText
    ;         Retrieves the currently selected text
    ;
    ; Parameters:
    ;         None
    ;
    ; Returns:
    ;         text of the selected item if successful, Null otherwise.
    ;
    GetSelectionText() {
        return this.GetText(this.GetSelection())
    }
    ;----------------------------------------------------------------------------------------------
    ; Method: GetRoot
    ;         Retrieves the root item of the treeview
    ;
    ; Parameters:
    ;         None
    ;
    ; Returns:
    ;         Handle to the topmost or very first item of the tree-view control
    ;         if successful, NULL otherwise.
    ;
    GetRoot() {
        return SendMessage(this.TVM_GETNEXTITEM, this.TVGN_ROOT, 0, , "ahk_id " this.TVHwnd)
    }
    ;----------------------------------------------------------------------------------------------
	; Method: GetParent
	;         Retrieves an item's parent
	;
	; Parameters:
	;         pItem			- Handle to the item
	;
	; Returns:
	;         Handle to the parent of the specified item. Returns
	;         NULL if the item being retrieved is the root node of the tree.
	;
	GetParent(pItem) {
		return SendMessage(this.TVM_GETNEXTITEM, this.TVGN_PARENT, pItem, , "ahk_id " this.TVHwnd)
	}

	;----------------------------------------------------------------------------------------------
	; Method: GetChild
	;         Retrieves an item's first child
	;
	; Parameters:
	;         pItem			- Handle to the item
	;
	; Returns:
	;         Handle to the first Child of the specified item, NULL otherwise.
	;
	GetChild(pItem) {
		return SendMessage(this.TVM_GETNEXTITEM, this.TVGN_CHILD, pItem, , "ahk_id " this.TVHwnd)
	}

	;----------------------------------------------------------------------------------------------
	; Method: GetNext
	;         Returns the handle of the sibling below the specified item (or 0 if none).
	;
	; Parameters:
	;         pItem			- (Optional) Handle to the item
	;
	;         flag          - (Optional) "FULL" or "F"
	;
	; Returns:
	;         This method has the following modes:
	;              1. When all parameters are omitted, it returns the handle
	;                 of the first/top item in the TreeView (or 0 if none). 
	;
	;              2. When the only first parameter (pItem) is present, it returns the 
	;                 handle of the sibling below the specified item (or 0 if none).
	;                 If the first parameter is 0, it returns the handle of the first/top
	;                 item in the TreeView (or 0 if none).
	;
	;              3. When the second parameter is "Full" or "F", the first time GetNext()
	;                 is called the hItem passed is considered the "root" of a sub-tree that 
	;                 will be transversed in a depth first manner. No nodes except the
	;                 decendents of that "root" will be visited. To traverse the entire tree, 
	;                 including the real root, pass zero in the first call.
	;
	;                 When all descendants have benn visited, the method returns zero.
	;
	; Example:
	;				hItem = 0  ; Start the search at the top of the tree.
	;				Loop
	;				{
	;					hItem := MyTV.GetNext(hItem, "Full")
	;					if not hItem  ; No more items in tree.
	;						break
	;					ItemText := MyTV.GetText(hItem)
	;					MsgBox The next Item is %hItem%, whose text is "%ItemText%".
	;				}
	;
    GetNext(pItem := 0, flag := ""){
        static Root := -1

        if (RegExMatch(flag, "i)^\s*(F|Full)\s*$")) {
            if (Root = -1) {
                Root := pItem
            }
            ErrorLevel := SendMessage(this.TVM_GETNEXTITEM, this.TVGN_CHILD, pItem, , "ahk_id " this.TVHwnd)
            if (ErrorLevel = 0) {
                ErrorLevel := SendMessage(this.TVM_GETNEXTITEM, this.TVGN_NEXT, pItem, , "ahk_id " this.TVHwnd)
                if (ErrorLevel = 0) {
                    Loop {
                        ErrorLevel := SendMessage(this.TVM_GETNEXTITEM, this.TVGN_PARENT, pItem, , "ahk_id " this.TVHwnd)
                        if (ErrorLevel = Root) {
                            Root := -1
                            return 0
                        }
                        pItem := ErrorLevel
                        ErrorLevel := SendMessage(this.TVM_GETNEXTITEM, this.TVGN_NEXT, pItem, , "ahk_id " this.TVHwnd)
                    } until ErrorLevel
                }
            }
            return ErrorLevel
        }

        Root := -1
        if (!pItem)
            ErrorLevel := SendMessage(this.TVM_GETNEXTITEM, this.TVGN_ROOT, 0, , "ahk_id " this.TVHwnd)
        else
            ErrorLevel := SendMessage(this.TVM_GETNEXTITEM, this.TVGN_NEXT, pItem, , "ahk_id " this.TVHwnd)
        return ErrorLevel
    }
	;----------------------------------------------------------------------------------------------
	; Method: GetPrev
	;         Returns the handle of the sibling above the specified item (or 0 if none).
	;
	; Parameters:
	;         pItem			- Handle to the item
	;
	; Returns:
	;         Handle of the sibling above the specified item (or 0 if none).
	;
	GetPrev(pItem){
		ErrorLevel := SendMessage(this.TVM_GETNEXTITEM, this.TVGN_PREVIOUS, pItem, , "ahk_id " this.TVHwnd)
		return ErrorLevel
	}
	
	;----------------------------------------------------------------------------------------------
	; Method: Expand
	;         Expands or collapses the specified tree node
	;
	; Parameters:
	;         pItem			- Handle to the item
	;
	;         flag			- Determines whether the node is expanded or collapsed.
	;                         true : expand the node (default)
	;                         false : collapse the node
	;
	;
	; Returns:
	;         Nonzero if the operation was successful, or zero otherwise.
	;
	Expand(pItem, DoExpand := true){
		flag := DoExpand ? this.TVE_EXPAND : this.TVE_COLLAPSE
		return SendMessage(this.TVM_EXPAND, flag, pItem, , "ahk_id " this.TVHwnd)
	}

	;----------------------------------------------------------------------------------------------
	; Method: Check
	;         Changes the state of a treeview item's check box
	;
	; Parameters:
	;         pItem			- Handle to the item
	;
	;         fCheck        - If true, check the node
	;                         If false, uncheck the node
	;
	;         Force			- If true (default), prevents this method from failing due to 
	;                         the node having an invalid initial state. See IsChecked 
	;                         method for more info.
	;
	; Returns:
	;         Returns true if if successful, otherwise false
	;
	; Remarks:
	;         This method makes pItem the current selection.
	;
	Check(pItem, fCheck, Force := true){
		SavedDelay := A_KeyDelay
		SetKeyDelay(30)
		
		CurrentState := this.IsChecked(pItem, false)
		if (CurrentState = -1) 
			if (Force) {
				ControlSend("{Space}", , "ahk_id " this.TVHwnd)
				CurrentState := this.IsChecked(pItem, false)
			}
			else 
				return false
		
		if (CurrentState and not fCheck) or (not CurrentState and fCheck )
			ControlSend("{Space}", , "ahk_id " this.TVHwnd)
		
		SetKeyDelay(SavedDelay)
		return true
	}

    ;----------------------------------------------------------------------------------------------
    ; Method: GetText
    ;         Retrieves the text/name of the specified node
    ;
    ; Parameters:
    ;         pItem         - Handle to the item
    ;
    ; Returns:
    ;         The text/name of the specified Item. If the text is longer than 127, only
    ;         the first 127 characters are retrieved.
    ;
    ; Fix from just me (http://ahkscript.org/boards/viewtopic.php?f=5&t=4998#p29339)
	;
    GetText(pItem){
        this.TVM_GETITEM := 1 ? this.TVM_GETITEMW : this.TVM_GETITEMA
		; this.TVHwnd := pItem
        ProcessId := WinGetpid("ahk_id " this.TVHwnd)
        hProcess := OpenProcess(this.PROCESS_VM_OPERATION|this.PROCESS_VM_READ
                               |this.PROCESS_VM_WRITE|this.PROCESS_QUERY_INFORMATION                               , false, ProcessId)

        ; Try to determine the bitness of the remote tree-view's process
        ProcessIs32Bit := A_PtrSize = 8 ? False : True
        If (A_Is64bitOS) && DllCall("Kernel32.dll\IsWow64Process", "Ptr", hProcess, "int*", &WOW64:=true)
            ProcessIs32Bit := WOW64

        Size := ProcessIs32Bit ?  60 : 80 ; Size of a TVITEMEX structure

        _tvi := VirtualAllocEx(hProcess, 0, Size, this.MEM_COMMIT, this.PAGE_READWRITE)
        _txt := VirtualAllocEx(hProcess, 0, 256,  this.MEM_COMMIT, this.PAGE_READWRITE)

        ; TVITEMEX Structure
        tvi := Buffer(Size, 0) ; V1toV2: if 'tvi' is a UTF-16 string, use 'VarSetStrCapacity(&tvi, Size)'
        NumPut("UInt", this.TVIF_TEXT|this.TVIF_HANDLE, tvi, 0)
        If (ProcessIs32Bit){
            NumPut("UInt", pItem, tvi, 4)
            NumPut("UInt", _txt, tvi, 16)
            NumPut("UInt", 127, tvi, 20)
        }
        Else{
            NumPut("UInt64", pItem, tvi, 8)
            NumPut("UInt64", _txt, tvi, 24)
            NumPut("UInt", 127, tvi, 32)
        }

        txt := Buffer(256, 0) ; V1toV2: if 'txt' is a UTF-16 string, use 'VarSetStrCapacity(&txt, 256)'
        WriteProcessMemory(hProcess, _tvi, tvi, Size)
        SendMessage(this.TVM_GETITEM, 0, _tvi, , "ahk_id " this.TVHwnd)
        ReadProcessMemory(hProcess, _txt, txt, 256)

        VirtualFreeEx(hProcess, _txt, 0, this.MEM_RELEASE)
        VirtualFreeEx(hProcess, _tvi, 0, this.MEM_RELEASE)
        CloseHandle(hProcess)

        return StrGet(txt)
    }
 
	;----------------------------------------------------------------------------------------------
	; Method: EditLabel
	;         Begins in-place editing of the specified item's text, replacing the text of the 
	;         item with a single-line edit control containing the text. This method implicitly 
	;         selects and focuses the specified item.
	;
	; Parameters:
	;         pItem			- Handle to the item
	;
	; Returns:
	;         Returns the handle to the edit control used to edit the item text if successful, 
	;         or NULL otherwise. When the user completes or cancels editing, the edit control 
	;         is destroyed and the handle is no longer valid.
	;
	EditLabel(pItem){
		this.TVM_EDITLABEL := 1 ? this.TVM_EDITLABELW : this.TVM_EDITLABELA
		return SendMessage(this.TVM_EDITLABEL, 0, pItem, , "ahk_id " this.TVHwnd)
	}
	
	;----------------------------------------------------------------------------------------------
	; Method: GetCount
	;         Returns the total number of expanded items in the control
	;
	; Parameters:
	;         None
	;
	; Returns:
	;         Returns the total number of expanded items in the control 
	;
	GetCount(){
		return SendMessage(this.TVM_GETCOUNT, 0, 0, , "ahk_id " this.TVHwnd)
	}
	
	;----------------------------------------------------------------------------------------------
	; Method: IsChecked
	;         Retrieves an item's checked status
	;
	; Parameters:
	;         pItem			- Handle to the item
	;
	;         force			- If true (default), forces the node to return a valid state.
	;                         Since this involves toggling the state of the check box, it
	;                         can have undesired side effects. Make this false to disable 
	;                         this feature.
	; Returns:
	;         Returns 1 if the item is checked, 0 if unchecked.
	;
	;         Returns -1 if the checkbox state cannot be determined because no checkbox
	;         image is currently associated with the node and Force is false. 
	;
	; Remarks:
	;         Due to a "feature" of Windows, a checkbox can be displayed even if no checkbox image
	;         is associated with the node. It is important to either check the actual value returned 
	;         or make the Force parameter true.
	; 
	;         This method makes pItem the current selection.
	;
	IsChecked(pItem, force := true){
		SavedDelay := A_KeyDelay
		SetKeyDelay(30)
		
		this.SetSelection(pItem)
		ErrorLevel := SendMessage(this.TVM_GETITEMSTATE, pItem, 0, , "ahk_id " this.TVHwnd)
		State := ((ErrorLevel & this.TVIS_STATEIMAGEMASK) >> 12) - 1
		
		if (State = -1 and force) {
			ControlSend("{Space 2}", , "ahk_id " this.TVHwnd)
			ErrorLevel := SendMessage(this.TVM_GETITEMSTATE, pItem, 0, , "ahk_id " this.TVHwnd)
			State := ((ErrorLevel & this.TVIS_STATEIMAGEMASK) >> 12) - 1
		}
		
		SetKeyDelay(SavedDelay)
		return State
	}
	
	;----------------------------------------------------------------------------------------------
	; Method: IsBold
	;         Check if a node is in bold font
	;
	; Parameters:
	;         pItem			- Handle to the item
	;
	; Returns:
	;         Returns true if the item is in bold, false otherwise.
	;
	IsBold(pItem){
		ErrorLevel := SendMessage(this.TVM_GETITEMSTATE, pItem, 0, , "ahk_id " this.TVHwnd)
		return (ErrorLevel & this.TVIS_BOLD) >> 4
	}
	
	;----------------------------------------------------------------------------------------------
	; Method: IsExpanded
	;         Check if a node has children and is expanded
	;
	; Parameters:
	;         pItem			- Handle to the item
	;
	; Returns:
	;         Returns true if the item has children and is expanded, false otherwise.
	;
	IsExpanded(pItem){
		ErrorLevel := SendMessage(this.TVM_GETITEMSTATE, pItem, 0, , "ahk_id " this.TVHwnd)
		return (ErrorLevel & this.TVIS_EXPANDED) >> 5
	}
	
	;----------------------------------------------------------------------------------------------
	; Method: IsSelected
	;         Check if a node is Selected
	;
	; Parameters:
	;         pItem			- Handle to the item
	;
	; Returns:
	;         Returns true if the item is selected, false otherwise.
	;
	IsSelected(pItem){
		ErrorLevel := SendMessage(this.TVM_GETITEMSTATE, pItem, 0, , "ahk_id " this.TVHwnd)
		return (ErrorLevel & this.TVIS_SELECTED) >> 1
	}

    ;----------------------------------------------------------------------------------------------
    ; Method: GetControlText
    ;     Returns a text representation of the control content, indented with tabs.
    ;
    ; Parameters:
    ;         pItem   - (Optional) Handle to the starting item
    ;
    ;         Level         - (Optional) Indention level
    ;
    ; Returns:
    ;         A text representation of the control content
    
    GetControlContent(Level:=0, pItem:=0){
        passed := false
        ControlText := ""
        
        loop {
            pItem := SendMessage(this.TVM_GETNEXTITEM, passed ? this.TVGN_NEXT : this.TVGN_CHILD , pItem, ,  "ahk_id " this.TVHwnd)
            if(pItem != 0){

                loop Level {
                    ControlText .= "`t"
                }
                ControlText .= this.GetText(pItem) "`n"
                ; ControlText .= RegexReplace(this.GetText(pItem),"^[-\.]","`t", &donechanges,1) . "`n"
                NextLevel := Level+1

                ControlText .= this.GetControlContent(NextLevel,pItem)
                passed := true
            } else {
                break
            }
        }
        return ControlText
    }
}

; Run("Explore C:\")

; if !WinWaitActive("ahk_class CabinetWClass", , 10)
;     Exit()
; Sleep(3000)
; WinId := WinActive("A")
; TVId := ControlGetHwnd("SysTreeView321", "ahk_id " WinId)
; MyTV := RemoteTreeView(TVId)

; ; Display the content of the treeview
; ; MsgBox(MyTV.GetControlContent())

; ; Set selection to Documents and activate it
; MyTV.SetSelectionByText("Documents")
; ; MyTV.SetSelectionByText("Photos")

; return


;----------------------------------------------------------------------------------------------
; Function: OpenProcess
;         Opens an existing local process object.
;
; Parameters:
;         DesiredAccess - The desired access to the process object. 
;
;         InheritHandle - If this value is TRUE, processes created by this process will inherit
;                         the handle. Otherwise, the processes do not inherit this handle.
;
;         ProcessId     - The Process ID of the local process to be opened. 
;
; Returns:
;         If the function succeeds, the return value is an open handle to the specified process.
;         If the function fails, the return value is NULL.
;
OpenProcess(DesiredAccess, InheritHandle, ProcessId){
	return DllCall("OpenProcess"	             
                    , "Int", DesiredAccess				 
                    , "Int", InheritHandle				 
                    , "Int", ProcessId				 
                    , "Ptr")
}

;----------------------------------------------------------------------------------------------
; Function: CloseHandle
;         Closes an open object handle.
;
; Parameters:
;         hObject       - A valid handle to an open object
;
; Returns:
;         If the function succeeds, the return value is nonzero.
;         If the function fails, the return value is zero.
;
CloseHandle(hObject){
	return DllCall("CloseHandle"	             
					, "Ptr", hObject				 
					, "Int")
}

;----------------------------------------------------------------------------------------------
; Function: VirtualAllocEx
;         Reserves or commits a region of memory within the virtual address space of the 
;         specified process, and specifies the NUMA node for the physical memory.
;
; Parameters:
;         hProcess      - A valid handle to an open object. The handle must have the 
;                         PROCESS_VM_OPERATION access right.
;
;         Address       - The pointer that specifies a desired starting address for the region 
;                         of pages that you want to allocate. 
;
;                         If you are reserving memory, the function rounds this address down to 
;                         the nearest multiple of the allocation granularity.
;
;                         If you are committing memory that is already reserved, the function rounds 
;                         this address down to the nearest page boundary. To determine the size of a 
;                         page and the allocation granularity on the host computer, use the GetSystemInfo 
;                         function.
;
;                         If Address is NULL, the function determines where to allocate the region.
;
;         Size          - The size of the region of memory to be allocated, in bytes. 
;
;         AllocationType - The type of memory allocation. This parameter must contain ONE of the 
;                          following values:
;								MEM_COMMIT
;								MEM_RESERVE
;								MEM_RESET
;
;         ProtectType   - The memory protection for the region of pages to be allocated. If the 
;                         pages are being committed, you can specify any one of the memory protection 
;                         constants:
;								 PAGE_NOACCESS
;								 PAGE_READONLY
;								 PAGE_READWRITE
;								 PAGE_WRITECOPY
;								 PAGE_EXECUTE
;								 PAGE_EXECUTE_READ
;								 PAGE_EXECUTE_READWRITE
;								 PAGE_EXECUTE_WRITECOPY
;
; Returns:
;         If the function succeeds, the return value is the base address of the allocated region of pages.
;         If the function fails, the return value is NULL.
;
VirtualAllocEx(hProcess, Address, Size, AllocationType, ProtectType){
	return DllCall("VirtualAllocEx"				 
				, "Ptr", hProcess				 
				, "Ptr", Address				 
				, "UInt", Size				 
				, "UInt", AllocationType				 
				, "UInt", ProtectType				 
				, "Ptr")
}
; ---------------------------------------------------------------------------
/**
 * Function: VirtualFreeEx
 * @example
		Releases, decommits, or releases and decommits a region of memory within the 
		virtual address space of a specified process

Parameters:
	hProcess - A valid handle to an open object. The handle must have the PROCESS_VM_OPERATION access right.

	Address - The pointer that specifies a desired starting address for the region to be freed. If the dwFreeType parameter is MEM_RELEASE, lpAddressmust be the base address returned by the VirtualAllocEx function when the region is reserved.
	Size - The size of the region of memory to be allocated, in bytes.If the FreeType parameter is MEM_RELEASE, dwSize must be 0 (zero). The function frees the entire region that is reserved in the initial allocation call to VirtualAllocEx.
	If FreeType is MEM_DECOMMIT, the function decommits all memory pages that contain one or more bytes in the range from the Address parameter to (lpAddress+dwSize). This means, for example, that a 2-byte region of memorythat straddles a page boundary causes both pages to be decommitted. If Address is the base address returned by VirtualAllocEx and dwSize is 0 (zero), thefunction decommits the entire region that is allocated by VirtualAllocEx. After that, the entire region is in the reserved state.
	FreeType - The type of free operation. This parameter can be one of the following values:
		MEM_DECOMMIT
		MEM_RELEASE

Returns:
	If the function succeeds, the return value is a nonzero value.
	If the function fails, the return value is 0 (zero). 
*/ ;! ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
VirtualFreeEx(hProcess, Address, Size, FType){
	return DllCall("VirtualFreeEx"				 
                    , "Ptr", hProcess				 
                    , "Ptr", Address				 
                    , "UInt", Size				 
                    , "UInt", FType				 
                    , "Int")
}
; ---------------------------------------------------------------------------
/** ;! ---------------------------------------------------------------------------
 * Function: WriteProcessMemory
 * @example
	Description:
	Writes data to an area of memory in a specified process. The entire area to be written to must be accessible or the operation fails
	Parameters:
 * @param hProcess
	@example - A valid handle to an open object. The handle must have the PROCESS_VM_WRITE and PROCESS_VM_OPERATION access right.
 * @param BaseAddress
	@example - A pointer to the base address in the specified process to which data is written. Before data transfer occurs, the system verifies that all data in the base address and memory of the specified size is accessible for write access, and if it is not accessible, the function fails.

 * @param Buffer
	@example - A pointer to the buffer that contains data to be written in the address space of the specified process.

 * @param Size
	@example - The number of bytes to be written to the specified process.

 * @param NumberOfBytesWritten 
	@example - A pointer to a variable that receives the number of bytes transferred into the specified process. This parameter is optional. If NumberOfBytesWritten is NULL, the parameter is ignored.
	Returns:
			If the function succeeds, the return value is a nonzero value.
			If the function fails, the return value is 0 (zero). 
*/ ;! ---------------------------------------------------------------------------

WriteProcessMemory(hProcess, BaseAddress, Buffer, Size, &NumberOfBytesWritten := 0){
	return DllCall("WriteProcessMemory"				 
                    , "Ptr", hProcess				 
                    , "Ptr", BaseAddress				 
                    , "Ptr", Buffer				 
                    , "Uint", Size				 
                    , "UInt*", NumberOfBytesWritten				 
                    , "Int")
}
; ---------------------------------------------------------------------------
/** ;! ---------------------------------------------------------------------------
 * Function: ReadProcessMemory
 * @example 
	Reads data from an area of memory in a specified process. The entire area to be read must be accessible or the operation fails
	Parameters:
        hProcess 		- A valid handle to an open object. The handle must have the PROCESS_VM_READ access right.

        BaseAddress 	- A pointer to the base address in the specified process from which to read. Before any data transfer occurs, the system verifies that all data in the base address and memory of the specified size is accessible for read access, and if it is not accessible the function fails.

        buffer - A pointer to a buffer that receives the contents from the address space of the specified process.

        Size 	- The number of bytes to be read from the specified process.

        NumberOfBytesWritten - A pointer to a variable that receives the number of bytes transferred into the specified buffer. If lpNumberOfBytesRead is NULL, the parameter is ignored.
	Returns:
		If the function succeeds, the return value is a nonzero value.
		If the function fails, the return value is 0 (zero). 
*/ ;! ---------------------------------------------------------------------------
ReadProcessMemory(hProcess, BaseAddress, Buffer, Size, &NumberOfBytesRead := 0){
	return DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", BaseAddress,"Ptr", Buffer, "UInt", Size, "UInt*", NumberOfBytesRead, "Int")
}
; ---------------------------------------------------------------------------
/************************************************************************
 * @function Create_HznHorizon_ico()
 * function: Create the .ico file for use in as the Tray Icon
 * @author 2.0.00.00 - 2023-07-31 - iPhilip - converted script to AutoHotkey v2
 * @param B64 - A picture converted to a string and encoded via b64
 * @source ;-> https://www.autohotkey.com/boards/viewtopic.php?f=83&t=119966
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
; ---------------------------------------------------------------------------
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
