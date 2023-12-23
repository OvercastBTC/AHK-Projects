; ---------------------------------------------------------------------------
; function ....:  Rich Text Editor - Customized for Horizon
; ---------------------------------------------------------------------------
#Requires AutoHotkey v2+
#Include <Directives\__AE.v2>
#Include <Class\RTE\RichEdit>
#Include <Class\RTE\RichEditDlgs>
#Include <__receiver>
#Include <_GuiReSizer>
#Include <System\DPI>
; #Include <HznPlus.v2>
; TraySetIcon('HICON:' Create_HznHorizon_ico())
/** ; ---------------------------------------------------------------------------
 * function ...: Create a Gui with RichEdit controls
 */ ; ---------------------------------------------------------------------------
;! ---------------------------------------------------------------------------
; /** ; ---------------------------------------------------------------------------
;  * function: Initial values
;  */ ; ---------------------------------------------------------------------------
; global GuiTitle := 'Horizon Rich Text Editor - hznRTE -- A Rich Text Editor for Horizon',
; FontName := "Times New Roman", FontSize := "11",
; BackColor := "cYellow", FontStyle := "Norm",
; FontCharSet := 1, TextColor := "cBlack",
; TextBkColor := "Auto",
; WordWrap := True, AutoURL := False, ShowWysiwyg := False, HasFocus := False, 
; Zoom := "100 %", CurrentLine := 0, CurrentLineCount := 0,
; ; ---------------------------------------------------------------------------
; hMult := 5, wMult := 2, gHmult := 2,div := 5, MarginX := 10, MarginY := 10
; ; Infos(WinGetProcessName(receiver.rect['hCtl']),5000)
; ; Infos(WinExist(receiver.rect['hCtl']),5000)
; ; switch (WinGetProcessName(receiver.rect['hCtl']) ~= 'hznHorizon') {
; switch {
; 	case WinExist(receiver.rect['hCtl']):
; 		EditW := (receiver.rect['width']+ (MarginX * wMult))
; 		EditW := Round((EditW / div) * (div - 1))
; 		EditH := (receiver.rect['height'] + (MarginY * hMult))
; 		EditH := Round(EditH)
; 	default:
; 		EditW := (A_ScreenHeight / 2)
; 		EditH := 1000
; }
; ; switch WinActive('ahk_exe hznHorizon'){
; ; 	case true: 
; ; 		EditH := receiver.rect['height']
; ; 		EditH := Round(EditH)
; ; 	default: EditH := 1000
		
; ; }
; ; EditW := (A_ScreenHeight / 2),
; ; EditH := 1000,
; ; EditW := receiver.rect['width'], EditW := Round((EditW / div) * (div - 1)),
; ; EditH := receiver.rect['height'], EditH := Round(EditH),
; w := EditW, h := EditH
; GuiW := Round(A_ScreenWidth * (1/4)), GuiH := Round(A_ScreenHeight * (1/4)),
; REW := w, REH := h,
; (GuiH > EditH) ? GuiH := Round(EditH + (MarginY * hMult)) : (GuiH = EditH) ? GuiH := Round(EditH + (MarginY * 2)) : GuiH := Round(EditH + (MarginY * hMult))
; EditH := Round(GuiH + (MarginY * hMult))
; If (EditW > GuiW) {
; 	EditW := (GuiW * 1.75)
; }
; if (EditW < GuiW) {
; 	EditW := (GuiW * 1.75)
; }
; ; Infos(
; ; 	"GuiW: " GuiW
; ; 	'`n'
; ; 	'EditW: ' EditW
; ; 	'`n'
; ; 	'GuiH: ' GuiH
; ; 	'`n'
; ; 	'EditH: ' EditH
; ; )
; RTE()
RTE(){
	/** ; ---------------------------------------------------------------------------
	 * function: Initial values
	 */ ; ---------------------------------------------------------------------------

	global GuiTitle := 'Horizon Rich Text Editor - hznRTE -- A Rich Text Editor for Horizon',
	FontName := "Times New Roman", FontSize := "11",
	BackColor := "cYellow", FontStyle := "Norm",
	FontCharSet := 1, TextColor := "cBlack",
	TextBkColor := "Auto",
	WordWrap := True, AutoURL := False, ShowWysiwyg := False, HasFocus := False, 
	Zoom := "100 %", CurrentLine := 0, CurrentLineCount := 0,
	; ---------------------------------------------------------------------------
	hMult := 5, wMult := 2, gHmult := 2,div := 5, MarginX := 10, MarginY := 10,
	EditH:=0, EditW:=0, w := EditW, h := EditH, GuiW := Round(A_ScreenWidth * (1/4)),
	GuiH := Round(A_ScreenHeight * (1/4)), REW := w, REH := h
	; Infos(WinGetProcessName(receiver.rect['hCtl']),5000)
	; Infos(WinExist(receiver.rect['hCtl']),5000)
	; switch (WinGetProcessName(receiver.rect['hCtl']) ~= 'hznHorizon') {
	switch {
		case WinExist(receiver.rect['hCtl']):
			EditW := (receiver.rect['width']+ (MarginX * wMult))
			EditW := Round((EditW / div) * (div - 1))
			EditH := (receiver.rect['height'] + (MarginY * hMult))
			EditH := Round(EditH)
		default:
			EditW := (A_ScreenHeight / 2)
			EditH := 1000
	}
	
	((GuiH > EditH)  ? GuiH := Round(EditH + (MarginY * hMult)) 
					: (GuiH = EditH) ? GuiH := Round(EditH + (MarginY * 2)) 
					: GuiH := Round(EditH + (MarginY * hMult)))
	Global EditH := Round(GuiH + (MarginY * hMult))
	If (EditW > GuiW) {
		EditW := (GuiW * 1.75)
	}
	if (EditW < GuiW) {
		EditW := (GuiW * 1.75)
	}
	; Infos(
	; 	"GuiW: " GuiW
	; 	'`n'
	; 	'EditW: ' EditW
	; 	'`n'
	; 	'GuiH: ' GuiH
	; 	'`n'
	; 	'EditH: ' EditH
	; )
	;* ---------------------------------------------------------------------------
	;*					Test of Organization
	;* ---------------------------------------------------------------------------
	RE_FileMenu()
	RE_EditMenu()
	RE_SearchMenu()
	RE_AlignMenu()
	RE_IndentMenu()
	RE_LineSpacingMenu()
	RE_NumberingMenu()
	RE_TabstopsMenu()
	RE_ParaSpacingMenu()
	RE_ParagraphMenu()
	RE_TxColorMenu()
	RE_BkColorMenu()
	RE_CharacterMenu()
	RE_FormatMenu()
	RE_BackgroundMenu()
	RE_ZoomMenu()
	RE_ViewMenu()
	RE_ContextMenu()
	RE_MainMenuBar()
	;! ---------------------------------------------------------------------------
	RE_MainGui()
	;! ---------------------------------------------------------------------------
	;* ---------------------------------------------------------------------------
; }
;! ---------------------------------------------------------------------------
;!					Main Gui
;! ---------------------------------------------------------------------------

RE_MainGui(*){
	Global  FontName, FontSize, MainFNAME, MainFSIZE, 
			MainGui, MainBNCF, MainBNFP, MainBNFM,
			MainSB, MainBNSV, MainBNTC, MainBNBC, 
			; MainBNSB, MainBNSI, MainBNSU, MainBNSS, 
			; MainBNSH, MainBNSL, MainBNSN
	GuiNum := 1
	Options := (
			' +Resize'
			' +Border'
			' +DPIScale'
			' +Caption'
			)
	global MainGui := Gui(Options , GuiTitle)
	MainGui.OnEvent("Size", MainGuiSize)
	MainGui.OnEvent("Close", MainGuiClose)
	MainGui.OnEvent("ContextMenu", RE_MainContextMenu)
	MainGui.MenuBar := MainMenuBar
	MainGui.MarginX := MarginX
	MainGui.MarginY := MarginY
	defaultFont()
	; ---------------------------------------------------------------------------
	bBold()
	bItalic()
	bUnderline()
	bStrikeout()
	; ---------------------------------------------------------------------------
	bSuperscript()
	bSubscript()
	; ---------------------------------------------------------------------------
	bNormal()
	bTextColor()
	bTextBkColor()
	; ---------------------------------------------------------------------------
	bChooseFont()
	bFontSize_Increase()
	bFontSize_Decrease()
	; ---------------------------------------------------------------------------
	defaultFont()
	; ---------------------------------------------------------------------------
	RE1_Gui_ToolBar() ; RE_1()
	; ---------------------------------------------------------------------------
	RE2_RichEditor() ; RE_2()
	; ---------------------------------------------------------------------------
}
/** ;! ---------------------------------------------------------------------------
 * @example RichEdit #1 (RE1)
 * function: RE1_Gui_ToolBar()
 * @param RE1
 */ ;! ---------------------------------------------------------------------------
RE1_Gui_ToolBar(){	; RE_1(){
	global RE1
	defaultFont()
	MainT1 := MainGui.AddText("x+10 yp hp", "WWWWWWWW")
	MainT1.GetPos(&TX := 0, &TY := 0, &TW := 0, &TH := 0)
	TX := (EditW - TW) - (MarginX * 5.75)
	MainT1.Move(TX)
	; ---------------------------------------------------------------------------
	Options := (
				' x' TX ' y' TY ' w' TW ' h' TH
				' Redraw'
			)
	global RE1 := RichEdit(MainGui, Options, False)
	defaultFont()
	; ---------------------------------------------------------------------------
	If !IsObject(RE1) {
		Throw("Could not create the RE1 RichEdit control!", -1)
	}
	RE1.ReplaceSel("AaBbYyZz")
	RE1.AlignText("CENTER")
	RE1.SetOptions(["READONLY"], "SET")
	RE1.SetParaSpacing({Before: 2})
	; ---------------------------------------------------------------------------
	;? Set buttons
	; ---------------------------------------------------------------------------
	defaultFont()
	bAlign_Left()
	bAlign_Center()
	bAlign_Right()
	bAlign_Justified()
	bLineSpacing_Single()
	bLineSpacing_OnePtFive()
	bLineSpacing_Double()
	bSave()
	return RE1
}

;! --------------------------------------------------------------------------------
;!								RichEdit #2
;!							  Rich Text Editor
;! --------------------------------------------------------------------------------
; RE_2(){
RE2_RichEditor(){
	Global RE2, MainSB, FontName, FontSize
	Options := ''
	MainFNAME.Text := FontName
	MainFSIZE.Text := FontSize
	static EN_SELCHANGE := 1794 ; 0x0702
	static EN_LINK := 1803 ; 0x070B
	; MainGui.SetFont('s11 Q5', FontName)
	MainGui.SetFont('Q5', FontName)
	; Options := "xm y+5 w" . EditW . " r20"
	; Options := "xm y+5 w" (EditW-MarginX) ' h' (EditH-MarginY)
	Options := (
			" xm"
			" y+5"
			" w" EditW
			' h' EditH
			' Redraw'
			)
	If !IsObject(RE2 := RichEdit(MainGui, Options)){
		Throw("Could not create the RE2 RichEdit control!", -1)
	}
	RE2.SetFont(FontSize ' ' FontName)
	RE2.SetOptions(["SELECTIONBAR"])
	RE2.AutoURL(True)
	RE2.SetEventMask(["SELCHANGE", "LINK"])
	RE2.OnNotify(EN_SELCHANGE, RE2_SelChange)
	RE2.OnNotify(EN_LINK, RE2_Link)
	DPI.ControlGetPos(,,&REW, &REH, RE2)
	; RE2.GetPos( , , &REW, &REH)
	defaultFont()
	; ---------------------------------------------------------------------------
	;? The rest
	; ---------------------------------------------------------------------------
	MainSB := MainGui.AddStatusbar()
	MainSB.SetParts(10, 200)
	MainGui.Show()
	RE2.Focus()
	RE_SetHotkeys()
	RE2.WordWrap(True)
	UpdateGui()
	MainGui.Show()
	MainGui.Show()
	Return RE2.Hwnd
}

; ---------------------------------------------------------------------------
;! 								  Menus
; ---------------------------------------------------------------------------
;?								FileMenu
; ---------------------------------------------------------------------------
RE_FileMenu(){
	Global FileMenu
	FileMenu := Menu()
	FileMenu.Add("&Open", FileLoadFN.Bind("Open"))
	FileMenu.Add("&Append", FileLoadFN.Bind("Append"))
	FileMenu.Add("&Insert", FileLoadFN.Bind("Insert"))
	FileMenu.Add("&Close", FileCloseFN)
	FileMenu.Add("&Save", FileSaveFN)
	FileMenu.Add("Save &as", FileSaveAsFN)
	FileMenu.Add()
	FileMenu.Add("Page &Margins", PageSetupFN)
	FileMenu.Add("&Print", PrintFN)
	FileMenu.Add()
	FileMenu.Add("&Exit", MainGuiClose)
}
; ---------------------------------------------------------------------------
;?								EditMenu
; ---------------------------------------------------------------------------
RE_EditMenu(*) {
	Global EditMenu
	EditMenu := Menu()
	EditMenu.Add("&Undo`tCtrl+Z", UndoFN)
	EditMenu.Add("&Redo`tCtrl+Y", RedoFN)
	EditMenu.Add()
	EditMenu.Add("C&ut`tCtrl+X", CutFN)
	EditMenu.Add("&Copy`tCtrl+C", CopyFN)
	EditMenu.Add("&Paste`tCtrl+V", PasteFN)
	EditMenu.Add("C&lear`tDel", ClearFN)
	EditMenu.Add()
	EditMenu.Add("Select &all `tCtrl+A", SelAllFN)
	EditMenu.Add("&Deselect all", DeselectFN)
}
; ---------------------------------------------------------------------------
;?							SearchMenu
; ---------------------------------------------------------------------------
RE_SearchMenu(*){
	Global SearchMenu
	SearchMenu := Menu()
	SearchMenu.Add("&Find", FindFN)
	SearchMenu.Add("&Replace", ReplaceFN)
}
; ---------------------------------------------------------------------------
;!					FormatMenu
; ---------------------------------------------------------------------------
;?					Paragraph
; ---------------------------------------------------------------------------
RE_AlignMenu(){
	global AlignMenu
	AlignMenu := Menu()
	AlignMenu.Add("Align &left`tCtrl+L", AlignFN.Bind("Left"))
	AlignMenu.Add("Align &center`tCtrl+E", AlignFN.Bind("Center"))
	AlignMenu.Add("Align &right`tCtrl+R", AlignFN.Bind("Right"))
	AlignMenu.Add("Align &justified", AlignFN.Bind("Justify"))
	return AlignMenu
}
; ---------------------------------------------------------------------------
RE_IndentMenu(){
	global IndentMenu
	IndentMenu := Menu()
	IndentMenu.Add("&Set", IndentationFN.Bind("Set"))
	IndentMenu.Add("&Reset", IndentationFN.Bind("Reset"))
	return IndentMenu
}
; ---------------------------------------------------------------------------
RE_LineSpacingMenu(){
	Global LineSpacingMenu
	LineSpacingMenu := Menu()
	LineSpacingMenu.Add("1 line`tCtrl+1", SpacingFN.Bind(1.0))
	LineSpacingMenu.Add("1.5 lines`tCtrl+5", SpacingFN.Bind(1.5))
	LineSpacingMenu.Add("2 lines`tCtrl+2", SpacingFN.Bind(2.0))
	return LineSpacingMenu
}
; ---------------------------------------------------------------------------
RE_NumberingMenu(){
	Global NumberingMenu
	NumberingMenu := Menu()
	NumberingMenu.Add("&Set", NumberingFN.Bind("Set"))
	NumberingMenu.Add("&Reset", NumberingFN.Bind("Reset"))
	return NumberingMenu
}
; ---------------------------------------------------------------------------
RE_TabstopsMenu() {
	global TabstopsMenu
	TabstopsMenu := Menu()
	TabstopsMenu.Add("&Set Tabstops", SetTabstopsFN.Bind("Set"))
	TabstopsMenu.Add("&Reset to Default", SetTabstopsFN.Bind("Reset"))
	TabstopsMenu.Add()
	TabstopsMenu.Add("Set &Default Tabs", SetTabstopsFN.Bind("Default"))
	return TabstopsMenu
}
; ---------------------------------------------------------------------------
RE_ParaSpacingMenu(){
	Global ParaSpacingMenu
	ParaSpacingMenu := Menu()
	ParaSpacingMenu.Add("&Set", ParaSpacingFN.Bind("Set"))
	ParaSpacingMenu.Add("&Reset", ParaSpacingFN.Bind("Reset"))
	return ParaSpacingMenu
}
; ---------------------------------------------------------------------------
RE_ParagraphMenu() {
	Global ParagraphMenu
	ParagraphMenu := Menu()
	ParagraphMenu.Add("&Alignment", AlignMenu)
	ParagraphMenu.Add("&Indentation", IndentMenu)
	ParagraphMenu.Add("&Numbering", NumberingMenu)
	ParagraphMenu.Add("&Linespacing", LineSpacingMenu)
	ParagraphMenu.Add("&Space before/after", ParaSpacingMenu)
	ParagraphMenu.Add("&Tabstops", TabstopsMenu)
	return ParagraphMenu
}
; ---------------------------------------------------------------------------
;!					Character
; ---------------------------------------------------------------------------
RE_TxColorMenu() {
	Global TxColorMenu
	TxColorMenu := Menu()
	TxColorMenu.Add("&Choose", TextColorFN.Bind("Choose"))
	TxColorMenu.Add("&Auto", TextColorFN.Bind("Auto"))
	return TxColorMenu
}
; ---------------------------------------------------------------------------
RE_BkColorMenu(){
	Global BkColorMenu
	BkColorMenu := Menu()
	BkColorMenu.Add("&Choose", TextBkColorFN.Bind("Choose"))
	BkColorMenu.Add("&Auto", TextBkColorFN.Bind("Auto"))
	return BkColorMenu
}
; ---------------------------------------------------------------------------
RE_CharacterMenu(){
	Global CharacterMenu
	CharacterMenu := Menu()
	CharacterMenu.Add("&Font", ChooseFontFN)
	CharacterMenu.Add("&Text color", TxColorMenu)
	CharacterMenu.Add("Text &Backcolor", BkColorMenu)
	return CharacterMenu
}
; ---------------------------------------------------------------------------
;?					Format
; ---------------------------------------------------------------------------
RE_FormatMenu(*){
	Global FormatMenu
	FormatMenu := Menu()
	FormatMenu.Add("&Character", CharacterMenu)
	FormatMenu.Add("&Paragraph", ParagraphMenu)
	return FormatMenu
}
; ---------------------------------------------------------------------------
;! 							ViewMenu
; ---------------------------------------------------------------------------
;?					Background
; ---------------------------------------------------------------------------
RE_BackgroundMenu(*) {
	Global BackgroundMenu
	BackgroundMenu := Menu()
	BackgroundMenu.Add("&Choose", BackGroundColorFN.Bind("Choose"))
	BackgroundMenu.Add("&Auto", BackgroundColorFN.Bind("Auto"))
	return BackgroundMenu
}
; ---------------------------------------------------------------------------
;?					Zoom
; ---------------------------------------------------------------------------
RE_ZoomMenu(*) {
	Global ZoomMenu
	ZoomMenu := Menu()
	ZoomMenu.Add("200 %", ZoomFN.Bind(200))
	ZoomMenu.Add("150 %", ZoomFN.Bind(150))
	ZoomMenu.Add("125 %", ZoomFN.Bind(125))
	ZoomMenu.Add("100 %", Zoom100FN)
	ZoomMenu.Check("100 %")
	ZoomMenu.Add("75 %", ZoomFN.Bind(75))
	ZoomMenu.Add("50 %", ZoomFN.Bind(50))
}
; ---------------------------------------------------------------------------
;?					View
; ---------------------------------------------------------------------------
RE_ViewMenu(*) {
	Global ViewMenu, MenuWordWrap, MenuWysiwyg
	ViewMenu := Menu()
	MenuWordWrap := "&Word-wrap"
	ViewMenu.Add(MenuWordWrap, WordWrapFN)
	MenuWysiwyg := "Wrap as &printed"
	ViewMenu.Add(MenuWysiwyg, WysiWygFN)
	ViewMenu.Add("&Zoom", RE_ZoomMenu)
	ViewMenu.Add()
	ViewMenu.Add("&Background Color", RE_BackgroundMenu)
	ViewMenu.Add("&URL Detection", AutoURLDetectionFN)
	return ViewMenu
}
; ---------------------------------------------------------------------------
;?					ContextMenu
; ---------------------------------------------------------------------------
RE_ContextMenu() {
	Global ContextMenu
	ContextMenu := Menu()
	ContextMenu.Add("&File", FileMenu)
	ContextMenu.Add("&Edit", EditMenu)
	ContextMenu.Add("&Search", SearchMenu)
	ContextMenu.Add("F&ormat", FormatMenu)
	ContextMenu.Add("&View", ViewMenu)
}
; ---------------------------------------------------------------------------
; 						MainMenuBar
; ---------------------------------------------------------------------------
RE_MainMenuBar(){
	Global MainMenuBar
	MainMenuBar := MenuBar()
	MainMenuBar.Add("&File", FileMenu)
	MainMenuBar.Add("&Edit", EditMenu)
	MainMenuBar.Add("&Search", SearchMenu)
	MainMenuBar.Add("F&ormat", FormatMenu)
	MainMenuBar.Add("&View", ViewMenu)
}

; ---------------------------------------------------------------------------
;?					Style buttons
; ---------------------------------------------------------------------------
bBold(){
	global MainBNSB, MainGui	
	MainGui.SetFont("Norm Bold", FontName)
	; MainGui.SetFont("Bold", FontName)
	MainBNSB := MainGui.AddButton("xm y3 w20 h20", "&B")
	MainBNSB.OnEvent("Click", SetFontStyleFN.Bind("B"))
	GuiCtrlSetTip(MainBNSB, "Bold (Ctl+B)")
	defaultFont()
	return MainBNSB
}	
; ---------------------------------------------------------------------------
bItalic(){
	global MainBNSI, MainGui
	MainGui.SetFont("Norm Italic")
	; MainGui.SetFont("Italic")
	MainBNSI := MainGui.AddButton("x+0 yp wp hp", "&I")
	MainBNSI.OnEvent("Click", SetFontStyleFN.Bind("I"))
	GuiCtrlSetTip(MainBNSI, "Italic (Ctl+I)")
	defaultFont()
}
; ---------------------------------------------------------------------------
bUnderline(){
	global MainBNSU, MainGui
	MainGui.SetFont("Norm Underline")
	; MainGui.SetFont("Underline")
	MainBNSU := MainGui.AddButton("x+0 yp wp hp", "&U")
	MainBNSU.OnEvent("Click", SetFontStyleFN.Bind("U"))
	GuiCtrlSetTip(MainBNSU, "Underline (Ctl+U)")
	defaultFont()
	return MainBNSU
}	
; ---------------------------------------------------------------------------
bStrikeout(){
	global MainBNSS, MainGui
	MainGui.SetFont("Norm Strike")
	; MainGui.SetFont("Strike")
	MainBNSS := MainGui.AddButton("x+0 yp wp hp", "&S")
	MainBNSS.OnEvent("Click", SetFontStyleFN.Bind("S"))
	GuiCtrlSetTip(MainBNSS, "Strikeout (Alt+S)")
	defaultFont()
	return MainBNSS
}	
; ---------------------------------------------------------------------------
bSuperscript(){
	global MainBNSH, MainGui
	MainGui.SetFont("Norm s" FontSize, FontName)
	MainBNSH := MainGui.AddButton("x+0 yp wp hp", "¯")
	MainBNSH.OnEvent("Click", SetFontStyleFN.Bind("H"))
	GuiCtrlSetTip(MainBNSH, "Superscript (Ctrl+Shift+'+')")
	defaultFont()
	return MainBNSH
}	
; ---------------------------------------------------------------------------
bSubscript(){
	global MainBNSL, MainGui
	MainBNSL := MainGui.AddButton("x+0 yp wp hp", "_")
	MainBNSL.OnEvent("Click", SetFontStyleFN.Bind("L"))
	GuiCtrlSetTip(MainBNSL, "Subscript (Ctrl+'+')")
	defaultFont()
	return MainBNSL
}
; ---------------------------------------------------------------------------
bNormal(){
	global MainBNSN, MainGui
	MainBNSN := MainGui.AddButton("x+0 yp wp hp", "&N")
	MainBNSN.OnEvent("Click", SetFontStyleFN.Bind("N"))
	GuiCtrlSetTip(MainBNSN, "Normal (Alt+N)")
	defaultFont()
}
; ---------------------------------------------------------------------------
bTextColor(){
	global MainBNTC, MainGui
	MainBNTC := MainGui.SetFont('s10')
	MainBNTC := MainGui.AddButton("x+10 yp wp+70 hp", "&Text Color")
	MainBNTC.OnEvent("Click", TextColorFN.Bind("Choose"))
	GuiCtrlSetTip(MainBNTC, "Text color (Alt+T)")
	; MainBNTC := MainGui.SetFont('s' FontSize, FontName)
	defaultFont()
	return MainBNTC
}
; ---------------------------------------------------------------------------
bTextBkColor(){
	global MainBNBC, MainColors, MainGui
	MainColors := MainGui.AddProgress("x+0 yp wp hp BackgroundYellow cNavy Border", 50)
	MainBNBC := MainGui.SetFont('s10')
	MainBNBC := MainGui.AddButton("x+0 yp wp hp", "Txt Bkg Color")
	; 
	if (WinActive() = 'ahk_exe hznHorizon.exe'){
		MainBNBC.OnEvent("Click", MainGuiSize)
	} else {
		MainBNBC.OnEvent("Click", TextBkColorFN.Bind("Choose"))
	}
	GuiCtrlSetTip(MainBNBC, "Text backcolor")
	defaultFont()
	return MainBNBC
}	
; ---------------------------------------------------------------------------
bChooseFont(){
	Global MainFNAME, MainBNCF, MainGui
	; MainFNAME := MainGui.AddEdit("x+10 yp w150 hp ", FontName)
	MainFNAME := MainGui.AddEdit("x+10 yp w150 hp +ReadOnly", FontName)
	; MainFNAME := MainGui.AddText("x+10 yp w150 hp Center", FontName)
	MainBNCF := MainGui.AddButton("x+0 yp w20 hp", "...")
	MainBNCF.OnEvent("Click", ChooseFontFN)
	GuiCtrlSetTip(MainBNCF, "Choose Font")
	defaultFont()
	return MainFNAME
}
; ---------------------------------------------------------------------------
bFontSize_Increase(){
	global MainBNFP, MainGui
	MainBNFP := MainGui.AddButton("x+5 yp wp hp", "&+")
	MainBNFP.OnEvent("Click", ChangeSize.Bind(1))
	GuiCtrlSetTip(MainBNFP, "Increase size (Alt+'+')")
	defaultFont()
	return MainBNFP
}
; ---------------------------------------------------------------------------
bFontSize_Decrease(){
	Global MainFSIZE, MainBNFM, MainGui
	; MainFSIZE := MainGui.AddEdit("x+0 yp w30 hp", FontSize)
	MainFSIZE := MainGui.AddEdit("x+0 yp w30 hp +ReadOnly", FontSize)
	; MainFSIZE := MainGui.AddText("x+0 yp w30 hp Center", FontSize)
	MainFSIZE.SetFont('s' FontSize, FontName)
	MainBNFM := MainGui.AddButton("x+5 yp wp hp", "&-")
	MainBNFM.OnEvent("Click", ChangeSize.Bind(-1))
	GuiCtrlSetTip(MainBNFM, "Decrease size (Alt+'-')")
	return MainBNFM
}
; ---------------------------------------------------------------------------
bSave(){
	global MainBNSV, MainGui
	local x := (editw / 2) - (MarginX * 5)
	MainBNSV := MainGui.AddButton('x' x ' yp wp+30 hp Center', '&Save')
	defaultFont()
	return MainBNSV
}
; ---------------------------------------------------------------------------
SendToHzn(){
	try WinA := WinActive('ahk_exe hznHorizon')
	if WinA = true {
		try hCtl := receiver.rect['hCtl']
		Infos(hCtl ' I exist')
		try nCtl := receiver.nect['nCtl']
	}
	return
}
; ---------------------------------------------------------------------------
defaultFont(){
	global MainGui, FontName, FontSize
	MainGui.SetFont("Norm")
	MainGui.SetFont('s' FontSize ' Q5', FontName)
	return MainGui
}
; ---------------------------------------------------------------------------
;?					Alignment
; ---------------------------------------------------------------------------
bAlign_Left(){
	Global MainBNAL
	MainGui.AddText("+Wrap 0x1000 xm y+2 h2 w" EditW)
	MainBNAL := MainGui.AddButton("x10 y+1 w30 h20",  "|<")
	MainBNAL.OnEvent("Click", AlignFN.Bind("Left"))
	GuiCtrlSetTip(MainBNAL, "Align left (Ctrl+L)")
	defaultFont()
	return MainBNAL
}
; ---------------------------------------------------------------------------
bAlign_Center(){
	global MainBNAC
	MainBNAC := MainGui.AddButton("x+0 yp wp hp", "><")
	MainBNAC.OnEvent("Click", AlignFN.Bind("Center"))
	GuiCtrlSetTip(MainBNAC, "Align center (Ctrl+E)")
	defaultFont()
	return MainBNAC
}
; ---------------------------------------------------------------------------
bAlign_Right(){
	global MainBNAR
	MainBNAR := MainGui.AddButton("x+0 yp wp hp", ">|")
	MainBNAR.OnEvent("Click", AlignFN.Bind("Right"))
	GuiCtrlSetTip(MainBNAR, "Align right (Ctrl+R)")
	defaultFont()
	return MainBNAR
}
; ---------------------------------------------------------------------------
bAlign_Justified(){
	global MainBNAJ
	MainBNAJ := MainGui.AddButton("x+0 yp wp hp", "|<>|")
	MainBNAJ.OnEvent("Click", AlignFN.Bind("Justify"))
	GuiCtrlSetTip(MainBNAJ, "Align justified")
	defaultFont()
	return MainBNAJ
}
; ---------------------------------------------------------------------------
;?					Line Spacing
; ---------------------------------------------------------------------------
bLineSpacing_Single(){
	global MainBN10
	MainBN10 := MainGui.AddButton("x+10 yp wp hp", "1")
	MainBN10.OnEvent("Click", SpacingFN.Bind(1.0))
	GuiCtrlSetTip(MainBN10, "Linespacing 1 line (Ctrl+1)")
	defaultFont()
	return MainBN10
}
; ---------------------------------------------------------------------------
bLineSpacing_OnePtFive(){
	global MainBN15
	MainBN15 := MainGui.AddButton("x+0 yp wp hp", "1½")
	MainBN15.OnEvent("Click", SpacingFN.Bind(1.5))
	GuiCtrlSetTip(MainBN15, "Linespacing 1,5 lines (Ctrl+5)")
	defaultFont()
	return MainBN15
}
; ---------------------------------------------------------------------------
bLineSpacing_Double(){
	global MainBN20
	MainBN20 := MainGui.AddButton("x+0 yp wp hp", "2")
	MainBN20.OnEvent("Click", SpacingFN.Bind(2.0))
	GuiCtrlSetTip(MainBN20, "Linespacing 2 lines (Ctrl+2)")
	defaultFont()
	return MainBN20
}
; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
;!					End of auto-execute section
; ---------------------------------------------------------------------------
; #HotIf RE2.Focused
RE_SetHotkeys(){
	HotKey('^b', ModifierToggle, 'On')
	HotKey('^i', ModifierToggle, 'On')
	HotKey('^u', ModifierToggle, 'On')
	HotKey('^h', ModifierToggle, 'On')
	; HotKey('^l', ModifierToggle, 'On')
	HotKey('^n', ModifierToggle, 'On')
	HotKey('^p', ModifierToggle, 'On')
	HotKey('!s', ModifierToggle, 'On')
}
; HotIf()
; #HotIf RE2.Focused
; FontStyles
; ^!b::  ; bold
; ^!h::  ; superscript
; ^!i::  ; italic
; ^!l::  ; subscript
; ^!n::  ; normal
; ^!p::  ; protected
; ^!s::  ; strikeout
; ^!u::  ; underline
; ^b::  ; bold
; ^h::  ; superscript
; ^i::  ; italic
; ^l::  ; subscript
; ^n::  ; normal
; ^p::  ; protected
; ^s::  ; strikeout
; ^u::  ; underline
ModifierToggle(*){
	global RE2
	; RE2.ToggleFontStyle(SubStr(A_ThisHotkey, 3))
	RE2.ToggleFontStyle(SubStr(A_ThisHotkey, -1, 1))
	UpdateGui()
	return RE2
}
; #HotIf
; ---------------------------------------------------------------------------
;?					Testing
; ---------------------------------------------------------------------------
RE2_SelChange(RE, L) {
	SetTimer(UpdateGui, -10)
}
; ---------------------------------------------------------------------------
RE2_Link(RE, L) {
	wParam := 0, lParam := 0, cpMin := 0, cpMax := 0, URLtoOpen := ''
	If (NumGet(L, A_PtrSize * 3, "Int") = 0x0202) { ; WM_LBUTTONUP
		wParam  := NumGet(L, (A_PtrSize * 3) + 4, "UPtr")
		lParam  := NumGet(L, (A_PtrSize * 4) + 4, "UPtr")
		cpMin   := NumGet(L, (A_PtrSize * 5) + 4, "Int")
		cpMax   := NumGet(L, (A_PtrSize * 5) + 8, "Int")
		URLtoOpen := RE2.GetTextRange(cpMin, cpMax)
		ToolTip("0x0202 - " wParam " - " lParam " - " cpMin " - " cpMax " - " URLtoOpen)
		Run('"' URLtoOpen '"')
	}
}
;! --------------------------------------------------------------------------------
;!					UpdateGui
;! --------------------------------------------------------------------------------
UpdateGui(*) {
	_AE_PerMonitor_DPIAwareness()
	Global MainSB, RE1, RE2, FontSize, FontName, FontStyle, FontCharSet, TextColor, TextBkColor
	; Static FontName := "", FontCharset := 0, FontStyle := 0, FontSize := 0, TextColor := 0, TxBkColor := 0
	Static TxBkColor := 0
	Local Font := RE2.GetFont()
	If (FontName != Font.Name || FontCharset != Font.CharSet || FontStyle != Font.Style || FontSize != Font.Size || TextColor != Font.Color || TxBkColor != Font.BkColor) {
		; FontStyle := Font.Style
		FontStyle := FontStyle
		; TextColor := Font.Color
		TextColor := TextColor
		TxBkColor := TxBkColor
		FontCharSet := FontCharSet
		; ---------------------------------------------------------------------------
		; If (FontName != Font.Name) {
		; 	; FontName := Font.Name
		; 	MainFNAME.Text := FontName
		; }
		; ---------------------------------------------------------------------------
		MainFNAME.Text := FontName
		; ---------------------------------------------------------------------------
		; If (FontSize != Font.Size) {
		; 	; FontSize := Round(Font.Size)
		; 	MainFSIZE.Text := FontSize
		; }
		; ---------------------------------------------------------------------------
		MainFSIZE.Text := FontSize
		Font.Size := FontSize
		RE1.SetSel(0, -1) ; select all
		RE1.SetFont(Font)
		RE1.SetSel(0, 0)  ; deselect all
	}
	RE_MainSB()
	RE_MainSB(){
		Local Stats := RE2.GetStatistics()
		MainSB.SetText('')
		MainSB.SetText('Ln (' Stats.Line ':' Stats.LinePos ')' " #Lns (" Stats.LineCount ")" ' Chs[' Stats.CharCount ']', 2)

	}
	; _AE_PerMonitor_DPIAwareness()
	MainGui.Show()
	MainGuiSize()
	MainGui.Show()
}
; ---------------------------------------------------------------------------
;!					Gui related
; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
;?					GuiClose
; ---------------------------------------------------------------------------
MainGuiClose(*) {
	Global RE1, RE2
	; -------------
	SelAllFN(),	CopyFN() ;, Sleep(100)
	If IsObject(RE1){
		RE1 := ""
	}
	If IsObject(RE2){
		RE2 := ""
	}
	MainGui.Destroy()
	ExitApp()
}
; ---------------------------------------------------------------------------
;! ---------------------------------------------------------------------------
;?					GuiSize
;! ---------------------------------------------------------------------------
MainGuiSize(GuiObj?, MinMax?, Width?, Height?) {
	_AE_PerMonitor_DPIAwareness()
	Global GuiW, GuiH, REW, REH, MarginX, MarginY, EditH, EditW
	Width := 0, Height := 0
	Critical()
	; If (MinMax = 1){
	; 	Return
	; }
	If (GuiW = 0) {
		GuiW := (Width + MarginX)
		GuiH := (Height + MarginY)
	}
	If (Width != GuiW || Height != GuiH) {
		WinA := WinActive('A')
		; DPI.WinGetPos(&REX, &REY, &REW, &REH)
		MainGui.GetPos(&REX, &REY, &REW, &REH)
		REW += (EditW - GuiW)-(46)
		REH += (EditH - GuiH)
		RE2.Move( , , REW, REH)
		GuiW := (EditW + MarginX)
		GuiH := (EditH + MarginY)
	}
	MainGui.Show()
}
; ---------------------------------------------------------------------------
;?					GuiContextMenu
; ---------------------------------------------------------------------------
RE_MainContextMenu(GuiObj, GuiCtrlObj, *) {
	Global ContextMenu
	If (GuiCtrlObj = RE2)
		ContextMenu.Show()
	return ContextMenu
}
;! --------------------------------------------------------------------------------
;!					Text operations
;! --------------------------------------------------------------------------------
; ---------------------------------------------------------------------------
;?					SetFontStyle
; ---------------------------------------------------------------------------
SetFontStyleFN(Style, GuiCtrl, *) {
	RE2.ToggleFontStyle(Style)
	UpdateGui()
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					ChangeSize
; ---------------------------------------------------------------------------
ChangeSize(IncDec, GuiCtrl, *) {
	Global FontSize := RE2.ChangeFontSize(IncDec)
	MainFSIZE.Text := Round(FontSize)
	RE2.Focus()
	; return MainFSIZE.Text := FontSize
	return FontSize := MainFSIZE.Text
}
; ---------------------------------------------------------------------------
;!					Menu File
; ---------------------------------------------------------------------------
;?					FileAppend
;?					FileOpen
;?					FileInsert
; ---------------------------------------------------------------------------
FileLoadFN(Mode, *) {
	Global Open_File
	If (File := RichEditDlgs.FileDlg(RE2, "O")) {
		RE2.LoadFile(File, Mode)
		If (Mode = "O") {
			MainGui.Opt("+LastFound")
			Title := WinGetTitle()
			Title := StrSplit(Title, "-", " ")
			WinSetTitle(Title[1] . " - " . File)
			Open_File := File
		}
		UpdateGui()
	}
	RE2.SetModified()
	RE2.Focus()
	return Open_File
}
; ---------------------------------------------------------------------------
;?					FileClose
; ---------------------------------------------------------------------------
FileCloseFN(*) {
	Global Open_File
	If (Open_File) {
		If RE2.IsModified() {
			MainGui.Opt("+OwnDialogs")
			Switch MsgBox(35, "Close File", "Content has been modified!`nDo you want to save changes?") {
				Case "Cancel": 	RE2.Focus()
				Case "Yes": 	FileSaveFN()
			}
		}
		If RE2.SetText() {
			MainGui.Opt("+LastFound")
			Title := WinGetTitle()
			Title := StrSplit(Title, "-", " ")
			WinSetTitle(Title[1])
			Open_File := ""
		}
		UpdateGui()
	}
	RE2.SetModified()
	RE2.Focus()
	return Open_File
}
; ---------------------------------------------------------------------------
;?					FileSave
; ---------------------------------------------------------------------------
FileSaveFN(*) {
	If !(Open_File){
		FileSaveAsFN()
		; Return 
	}
	RE2.SaveFile(Open_File)
	RE2.SetModified()
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					FileSaveAs
; ---------------------------------------------------------------------------
FileSaveAsFN(*) {
	; Global Open_File := File
	If (File := RichEditDlgs.FileDlg(RE2, "S")) {
		RE2.SaveFile(File)
		MainGui.Opt("+LastFound")
		Title := WinGetTitle()
		Title := StrSplit(Title, "-", " ")
		WinSetTitle(Title[1] . " - " . File)
	}
	RE2.Focus()
	; return Open_File
}
; ---------------------------------------------------------------------------
;?					PageSetup
; ---------------------------------------------------------------------------
PageSetupFN(*) {
	RichEditDlgs.PageSetup(RE2)
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					Print
; ---------------------------------------------------------------------------
PrintFN(*) {
	RE2.Print()
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;!					Menu Edit
; ---------------------------------------------------------------------------
;?					Undo
; ---------------------------------------------------------------------------
UndoFN(*) {
	RE2.Undo()
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					Redo
; ---------------------------------------------------------------------------
RedoFN(*) {
	RE2.Redo()
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					Cut
; ---------------------------------------------------------------------------
CutFN(*) {
	RE2.Cut()
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					Copy
; ---------------------------------------------------------------------------
CopyFN(*) {
	RE2.Copy()
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					Paste:
; ---------------------------------------------------------------------------
PasteFN(*) {
	RE2.Paste()
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					Clear
; ---------------------------------------------------------------------------
ClearFN(*) {
	RE2.Clear()
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					Select All
; ---------------------------------------------------------------------------
SelAllFN(*) {
	RE2.SelAll()
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					Deselect
; ---------------------------------------------------------------------------
DeselectFN(*) {
	RE2.Deselect()
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;! 								Menu View
; ---------------------------------------------------------------------------
;? 								WordWrap
; ---------------------------------------------------------------------------
WordWrapFN(Item, *) {
	Global WordWrap ^= True
	RE2.WordWrap(WordWrap)
	ViewMenu.ToggleCheck(Item)
	If (WordWrap)
		ViewMenu.Disable(MenuWysiwyg)
	Else
		ViewMenu.Enable(MenuWysiwyg)
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?								 Zoom
; ---------------------------------------------------------------------------
Zoom100FN(*) => ZoomFN(100, "100 %")
ZoomFN(Ratio, Item, *) {
	Global Zoom
	ZoomMenu.UnCheck(Zoom)
	Zoom := Item
	ZoomMenu.Check(Zoom)
	RE2.SetZoom(Ratio)
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?								WYSIWYG
; ---------------------------------------------------------------------------
WYSIWYGFN(Item, *) {
	Global ShowWysiwyg ^= True
	If (ShowWysiwyg)
		Zoom100FN()
	RE2.WYSIWYG(ShowWysiwyg)
	RE_ViewMenu.ToggleCheck(Item)
	If (ShowWysiwyg)
		ViewMenu.Disable(MenuWordWrap)
	Else
		ViewMenu.Enable(MenuWordWrap)
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					BackgroundColor
; ---------------------------------------------------------------------------
BackgroundColorFN(Mode, *) {
	Global BackColor
	Switch Mode {
		Case "Auto": 	RE2.BackColor := "Auto"
		Case "Choose":	RE2.SetBkgndColor("cYellow")
			; If RE2.BackColor != "Auto"
			; 	Color := RE2.BackColor
			; Else
			; 	Color := RE2.GetRGB(DllCall("GetSysColor", "Int", 5, "UInt")) ; COLOR_WINDOW
			; NC := RichEditDlgs.ChooseColor(RE2, Color)
			; If (NC != "") {
			; 	RE2.SetBkgndColor(NC)
			; 	RE2.BackColor := NC
			; }
	}
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					AutoURLDetection
; ---------------------------------------------------------------------------
AutoURLDetectionFN(ItemName, ItemPos, MenuObj) {
	RE2.AutoURL(AutoURL ^= True)
	MenuObj.ToggleCheck(ItemName)
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;!					Menu Character
; ---------------------------------------------------------------------------
;?					ChooseFont
; ---------------------------------------------------------------------------
ChooseFontFN(*) {
	Global FontName, FontSize
	RichEditDlgs.ChooseFont(RE2)
	Font := RE2.GetFont()
	FontName := Font.Name
	FontSize := Font.Size
	MainFNAME.Text := FontName
	MainFSIZE.Text := Round(FontSize)
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					MTextColor    ; menu label
;?					BTextColor    ; button label
; ---------------------------------------------------------------------------
TextColorFN(Mode, *) {
	Global TextColor
	Switch Mode {
		Case "Auto":	RE2.SetFont({Color: "cBlack"})
			; RE2.TextColor := "Auto"
		Case "Choose":	RE2.SetFont({Color: "cBlack"})
			; If RE2.TextColor != "Auto"
			; 	Color := RE2.TextColor
			; Else
			; 	Color := RE2.GetRGB(DllCall("GetSysColor", "Int", 8, "UInt")) ; COLOR_WINDOWTEXT
			; NC := RichEditDlgs.ChooseColor(RE2, Color)
			; If (NC != "") {
			; 	RE2.SetFont({Color: NC})
			; 	RE2.TextColor := NC
			; }
	}
	UpdateGui()
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					MTextBkColor  ; menu label
;?					BTextBkColor  ; button label
; ---------------------------------------------------------------------------
TextBkColorFN(Mode, *) {
	Global TextBkColor
	Switch Mode {
		Case "Auto":
			RE2.SetFont({BkColor: "Auto"})
			Color := RE2.GetRGB(DllCall("GetSysColor", "Int", 5, "UInt")) ; COLOR_WINDOW
		Case "Choose":
			RE2.SetFont({BkColor: "Auto"})
			; If RE2.TxBkColor != "Auto"
			; 	Color := RE2.TxBkColor
			; Else
			; 	Color := RE2.GetRGB(DllCall("GetSysColor", "Int", 5, "UInt")) ; COLOR_WINDOW
			; NC := RichEditDlgs.ChooseColor(RE2, Color)
			; If (NC != "") {
			; 	RE2.SetFont({BkColor: NC})
			; 	RE2.TxBkColor := NC
			; }
	}
	UpdateGui()
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;!							Menu Paragraph
; ---------------------------------------------------------------------------
;? 							AlignLeft
;? 							AlignCenter
;? 							AlignRight:
;? 							AlignJustify
; ---------------------------------------------------------------------------
AlignFN(Alignment, *) {
	Static Align := {Left: 1, Right: 2, Center: 3, Justify: 4}
	If Align.HasProp(Alignment)
		RE2.AlignText(Align.%Alignment%)
	RE2.Focus()
}
; ---------------------------------------------------------------------------
IndentationFN(Mode, *) {
	Switch Mode {
		Case "Set": RE_ParaIndentGui(RE2)
		Case "Reset": RE2.SetParaIndent()
	}
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					Numbering
; ---------------------------------------------------------------------------
NumberingFN(Mode, *) {
	Switch Mode {
		Case "Set": RE_ParaNumberingGui(RE2)
		Case "Reset": RE2.SetParaNumbering()
	}
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					ParaSpacing
;?					ResetParaSpacing
; ---------------------------------------------------------------------------
ParaSpacingFN(Mode, *) {
	Switch Mode {
		Case "Set": RE_ParaSpacingGui(RE2)
		Case "Reset": RE2.SetParaSpacing()
	}
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					Spacing10
;?					Spacing15
;?					Spacing20
; ---------------------------------------------------------------------------
SpacingFN(Val, *) {
	RE2.SetLineSpacing(Val)
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					SetTabStops
;?					ResetTabStops
;?					SetDefTabs
; ---------------------------------------------------------------------------
SetTabStopsFN(Mode, *) {
	Switch Mode {
		Case "Set": RE_SetTabStopsGui(RE2)
		Case "Reset": RE2.SetTabStops()
		Case "Default": RE2.SetDefaultTabs(1)
	}
	RE2.Focus()
}
; ---------------------------------------------------------------------------
;?					Menu Search
; ---------------------------------------------------------------------------
FindFN(*) {
	RichEditDlgs.FindText(RE2)
}
; ---------------------------------------------------------------------------
ReplaceFN(*) {
	RichEditDlgs.ReplaceText(RE2)
}
; ---------------------------------------------------------------------------
;!					ParaIndentation GUI
; ---------------------------------------------------------------------------
RE_ParaIndentGui(RE) {
	Static   Owner := "",
				Success := False
	Metrics := RE.GetMeasurement()
	PF2 := RE.GetParaFormat()
	Owner := RE.Gui.Hwnd
	ParaIndentGui := Gui("+Owner" . Owner . " +ToolWindow +LastFound", "Paragraph Indentation")
	ParaIndentGui.OnEvent("Close", ParaIndentGuiClose)
	ParaIndentGui.MarginX := 20
	ParaIndentGui.MarginY := 10
	ParaIndentGui.AddText("Section h20 0x200", "First line left indent (absolute):")
	ParaIndentGui.AddText("xs hp 0x200", "Other lines left indent (relative):")
	ParaIndentGui.AddText("xs hp 0x200", "All lines right indent (absolute):")
	EDLeft1 := ParaIndentGui.AddEdit("ys hp Limit5")
	EDLeft2 := ParaIndentGui.AddEdit("hp Limit6")
	EDRight := ParaIndentGui.AddEdit("hp Limit5")
	CBStart := ParaIndentGui.AddCheckBox("ys x+5 hp", "Apply")
	CBOffset := ParaIndentGui.AddCheckBox("hp", "Apply")
	CBRight := ParaIndentGui.AddCheckBox("hp", "Apply")
	Left1 := Round((PF2.StartIndent / 1440) * Metrics, 2)
	If (Metrics = 2.54)
		Left1 := RegExReplace(Left1, "\.", ",")
	EDLeft1.Text := Left1
	Left2 := Round((PF2.Offset / 1440) * Metrics, 2)
	If (Metrics = 2.54)
		Left2 := RegExReplace(Left2, "\.", ",")
	EDLeft2.Text := Left2
	Right := Round((PF2.RightIndent / 1440) * Metrics, 2)
	If (Metrics = 2.54)
		Right := RegExReplace(Right, "\.", ",")
	EDRight.Text := Right
	BN1 := ParaIndentGui.AddButton("xs", "Apply")
	BN1.OnEvent("Click", ParaIndentGuiApply)
	BN2 := ParaIndentGui.AddButton("x+10 yp", "Cancel")
	BN2.OnEvent("Click", ParaIndentGuiClose)
	BN2.GetPos( , , &BW := 0)
	BN1.Move( , , BW)
	CBRight.GetPos(&CX := 0, , &CW := 0)
	BN2.Move(CX + CW - BW)
	RE.Gui.Opt("+Disabled")
	ParaIndentGui.Show()
	WinWaitActive()
	WinWaitClose()
	Return Success
	; ---------------------------------------------------------------------------
	ParaIndentGuiClose(*) {
		Success := False
		RE.Gui.Opt("-Disabled")
		ParaIndentGui.Destroy()
	}
	; ---------------------------------------------------------------------------
	ParaIndentGuiApply(*) {
		ApplyStart := CBStart.Value
		ApplyOffset := CBOffset.Value
		ApplyRight := CBRight.Value
		Indent := {}
		If ApplyStart {
			Start := EDLeft1.Text
			If (Start = "")
				Start := 0
			If !RegExMatch(Start, "^\d{1,2}((\.|,)\d{1,2})?$") {
				EDLeft1.Text := ""
				EDLeft1.Focus()
				Return
			}
			Indent.Start := StrReplace(Start, ",", ".")
		}
		If (ApplyOffset) {
			Offset := EDLeft2.Text
			If (Offset = "")
				Offset := 0
			If !RegExMatch(Offset, "^(-)?\d{1,2}((\.|,)\d{1,2})?$") {
				EDLeft2.Text := ""
				EDLeft2.Focus()
				Return
			}
			Indent.Offset := StrReplace(Offset, ",", ".")
		}
		If (ApplyRight) {
			Right := EDRight.Text
			If (Right = "")
				Right := 0
			If !RegExMatch(Right, "^\d{1,2}((\.|,)\d{1,2})?$") {
				EDRight.Text := ""
				EDRight.Focus()
				Return
			}
			Indent.Right := StrReplace(Right, ",", ".")
		}
		Success := RE.SetParaIndent(Indent)
		RE.Gui.Opt("-Disabled")
		ParaIndentGui.Destroy()
	}
}
; ---------------------------------------------------------------------------
;!					ParaNumbering GUI
; ---------------------------------------------------------------------------
RE_ParaNumberingGui(RE) {
	Static	Owner := "",
			Bullet := "•",
			StyleArr := ["1)", "(1)", "1.", "1", "w/o"],
			TypeArr := [Bullet, "0, 1, 2", "a, b, c", "A, B, C", "i, ii, iii", "I, I, III"],
			PFN := ["Bullet", "Arabic", "LCLetter", "UCLetter", "LCRoman", "UCRoman"],
			PFNS := ["Paren", "Parens", "Period", "Plain", "None"],
			Success := False
	Metrics := RE.GetMeasurement()
	PF2 := RE.GetParaFormat()
	Owner := RE.Gui.Hwnd
	ParaNumberingGui := Gui("+Owner" . Owner . " +ToolWindow +LastFound", "Paragraph Numbering")
	ParaNumberingGui.OnEvent("Close", ParaNumberingGuiClose)
	ParaNumberingGui.MarginX := 20
	ParaNumberingGui.MarginY := 10
	ParaNumberingGui.AddText("Section h20 w100 0x200", "Type:")
	DDLType := ParaNumberingGui.AddDDL("xp y+0 wp AltSubmit", TypeArr)
	If (PF2.Numbering)
		DDLType.Choose(PF2.Numbering)
	ParaNumberingGui.AddText("xs h20 w100 0x200", "Start with:")
	EDStart := ParaNumberingGui.AddEdit("y+0 wp hp Limit5", PF2.NumberingStart)
	ParaNumberingGui.AddText("ys h20 w100 0x200", "Style:")
	DDLStyle := ParaNumberingGui.AddDDL("y+0 wp AltSubmit Choose1", StyleArr)
	If (PF2.NumberingStyle)
		DDLStyle.Choose((PF2.NumberingStyle // 0x0100) + 1)
	ParaNumberingGui.AddText("h20 w100 0x200", "Distance:  (" . (Metrics = 1.00 ? "in." : "cm") . ")")
	EDDist := ParaNumberingGui.AddEdit("y+0 wp hp Limit5")
	Tab := Round((PF2.NumberingTab / 1440) * Metrics, 2)
	If (Metrics = 2.54)
		Tab := RegExReplace(Tab, "\.", ",")
	EDDist.Text := Tab
	BN1 := ParaNumberingGui.AddButton("xs", "Apply") ; gParaNumberingGuiApply hwndhBtn1, Apply
	BN1.OnEvent("Click", ParaNumberingGuiApply)
	BN2 := ParaNumberingGui.AddButton("x+10 yp", "Cancel") ;  gParaNumberingGuiClose hwndhBtn2, Cancel
	BN2.OnEvent("Click", ParaNumberingGuiClose)
	BN2.GetPos( , , &BW := 0)
	BN1.Move( , , BW)
	DDLStyle.GetPos(&DX := 0, , &DW := 0)
	BN2.Move(DX + DW - BW)
	RE.Gui.Opt("+Disabled")
	ParaNumberingGui.Show()
	WinWaitActive()
	WinWaitClose()
	Return Success
	; ---------------------------------------------------------------------------
	ParaNumberingGuiClose(*) {
		Success := False
		RE.Gui.Opt("-Disabled")
		ParaNumberingGui.Destroy()
	}
	; ---------------------------------------------------------------------------
	ParaNumberingGuiApply(*) {
	Type := DDLType.Value
	Style := DDLStyle.Value
	Start := EDStart.Text
	Tab := EDDist.Text
	If !RegExMatch(Tab, "^\d{1,2}((\.|,)\d{1,2})?$") {
		EDDist.Text := ""
		EDDist.Focus()
		Return
	}
	Numbering := {Type: PFN[Type], Style: PFNS[Style]}
	Numbering.Tab := RegExReplace(Tab, ",", ".")
	Numbering.Start := Start
	Success := RE.SetParaNumbering(Numbering)
	RE.Gui.Opt("-Disabled")
	ParaNumberingGui.Destroy()
	}
}
; ---------------------------------------------------------------------------
;!					ParaSpacing GUI
; ---------------------------------------------------------------------------
RE_ParaSpacingGui(RE) {
	Static Owner := "",
			Success := False
	PF2 := RE.GetParaFormat()
	Owner := RE.Gui.Hwnd
	ParaSpacingGui := Gui("+Owner" . Owner . " +ToolWindow +LastFound", "Paragraph Spacing") ; +LabelParaSpacingGui
	ParaSpacingGui.OnEvent("Close", ParaSpacingGuiClose)
	ParaSpacingGui.MarginX := 20
	ParaSpacingGui.MarginY := 10
	ParaSpacingGui.AddText("Section h20 0x200", "Space before in points:")
	ParaSpacingGui.AddText("xs y+10 hp 0x200", "Space after in points:")
	EDBefore := ParaSpacingGui.AddEdit("ys hp Number Limit2 Right", "00")
	EDBefore.Text := PF2.SpaceBefore // 20
	EDAfter := ParaSpacingGui.AddEdit("xp y+10 hp Number Limit2 Right", "00")
	EDAfter.Text := PF2.SpaceAfter // 20
	BN1 := ParaSpacingGui.AddButton("xs", "Apply")
	BN1.OnEvent("Click", ParaSpacingGuiApply)
	BN2 := ParaSpacingGui.AddButton("x+10 yp", "Cancel")
	BN2.OnEvent("Click", ParaSpacingGuiClose)
	BN2.GetPos( , ,&BW := 0)
	BN1.Move( , ,BW)
	EDAfter.GetPos(&EX := 0, , &EW := 0)
	X := EX + EW - BW
	BN2.Move(X)
	RE.Gui.Opt("+Disabled")
	ParaSpacingGui.Show()
	WinWaitActive()
	WinWaitClose()
	Return Success
	; ---------------------------------------------------------------------------
	ParaSpacingGuiClose(*) {
		Success := False
		RE.Gui.Opt("-Disabled")
		ParaSpacingGui.Destroy()
	}
	; ---------------------------------------------------------------------------
	ParaSpacingGuiApply(*) {
		Before := EDBefore.Text
		After := EDAfter.Text
		Success := RE.SetParaSpacing({Before: Before, After: After})
		RE.Gui.Opt("-Disabled")
		ParaSpacingGui.Destroy()
	}
}
; ---------------------------------------------------------------------------
;!					SetTabStops GUI
; ---------------------------------------------------------------------------
RE_SetTabStopsGui(RE) {
	; Set paragraph's tabstobs
	; Call with parameter mode = "Reset" to reset to default tabs
	; EM_GETPARAFORMAT = 0x43D, EM_SETPARAFORMAT = 0x447
	; PFM_TABSTOPS = 0x10
	Static  Owner   := "",
			Metrics := 0,
			MinTab  := 0.30,     ; minimal tabstop in inches
			MaxTab  := 8.30,     ; maximal tabstop in inches
			AL := 0x00000000,    ; left aligned (default)
			AC := 0x01000000,    ; centered
			AR := 0x02000000,    ; right aligned
			AD := 0x03000000,    ; decimal tabstop
			Align := {0x00000000: "L", 0x01000000: "C", 0x02000000: "R", 0x03000000: "D"},
			TabCount := 0,       ; tab count
			MAX_TAB_STOPS := 32,
			Success := False     ; return value
	Metrics := RE.GetMeasurement()
	PF2 := RE.GetParaFormat()
	TabCount := PF2.TabCount
	Tabs := []
	Tabs.Length := PF2.Tabs.Length
	For I, V In PF2.Tabs
		Tabs[I] := [Format("{:.2f}", Round(((V & 0x00FFFFFF) * Metrics) / 1440, 2)), V & 0xFF000000]
	Owner := RE.Gui.Hwnd
	SetTabStopsGui := Gui("+Owner" . Owner . " +ToolWindow +LastFound", "Set Tabstops")
	SetTabStopsGui.OnEvent("Close", SetTabStopsGuiClose)
	SetTabStopsGui.MarginX := 10
	SetTabStopsGui.MarginY := 10
	SetTabStopsGui.AddText("Section", "Position: (" . (Metrics = 1.00 ? "in." : "cm") . ")")
	CBBTabs := SetTabStopsGui.AddComboBox("xs y+2 w120 r6 Simple +0x800 AltSubmit")
	CBBTabs.OnEvent("Change", SetTabStopsGuiSelChanged)
	If (TabCount) {
		For T In Tabs {
			I := SendMessage(0x0143, 0, StrPtr(T[1]), CBBTabs.Hwnd)  ; CB_ADDSTRING
			SendMessage(0x0151, I, T[2], CBBTabs.Hwnd)               ; CB_SETITEMDATA
		}
	}
	SetTabStopsGui.AddText("ys Section", "Alignment:")
	RBL := SetTabStopsGui.AddRadio("xs w60 Section y+2 Checked Group", "Left")
	RBC := SetTabStopsGui.AddRadio("wp", "Center")
	RBR := SetTabStopsGui.AddRadio("ys wp", "Right")
	RBD := SetTabStopsGui.AddRadio("wp", "Decimal")
	BNAdd := SetTabStopsGui.AddButton("xs Section w60 Disabled", "&Add")
	BNAdd.OnEvent("Click", SetTabStopsGuiAdd)
	BNRem := SetTabStopsGui.AddButton("ys w60 Disabled", "&Remove")
	BNRem.OnEvent("Click", SetTabStopsGuiRemove)
	BNAdd.GetPos(&X1 := 0)
	BNRem.GetPos(&X2 := 0, , &W2 := 0)
	W := X2 + W2 - X1
	BNClr := SetTabStopsGui.AddButton("xs w" . W, "&Clear all")
	BNClr.OnEvent("Click", SetTabStopsGuiRemoveAll)
	SetTabStopsGui.AddText("xm h5")
	BNApply := SetTabStopsGui.AddButton("xm y+0 w60", "&Apply")
	BNApply.OnEvent("Click", SetTabStopsGuiApply)
	X := X2 + W2 - 60
	BNCancel := SetTabStopsGui.AddButton("x" . X . " yp wp", "&Cancel")
	BNCancel.OnEvent("Click", SetTabStopsGuiClose)
	RE.Gui.Opt("+Disabled")
	SetTabStopsGui.Show()
	WinWaitActive()
	WinWaitClose()
	Return Success
	; ---------------------------------------------------------------------------
	SetTabStopsGuiClose(*) {
		Success := False
		RE.Gui.Opt("-Disabled")
		SetTabStopsGui.Destroy()
	}
	; ---------------------------------------------------------------------------
	SetTabStopsGuiSelChanged(*) {
		If (TabCount < MAX_TAB_STOPS)
			BNAdd.Enabled := !!RegExMatch(CBBTabs.Text, "^\d*[.,]?\d+$")
		If !(I := CBBTabs.Value) {
			BNRem.Enabled := False
			Return
		}
		BNRem.Enabled := True
		A := SendMessage(0x0150, I - 1, 0, CBBTabs.Hwnd) ; CB_GETITEMDATA
		C := A = AC ? RBC : A = AR ? RBR : A = AD ? RBD : RBl
		C.Value := 1
	}
	; ---------------------------------------------------------------------------
	SetTabStopsGuiAdd(*) {
		T := CBBTabs.Text
		If !RegExMatch(T, "^\d*[.,]?\d+$") {
			CBBTabs.Focus()
			Return
		}
		T := Round(StrReplace(T, ",", "."), 2)
		RT := Round(T / Metrics, 2)
		If (RT < MinTab) || (RT > MaxTab){
			CBBTabs.Focus()
			Return
		}
		A := RBC.Value ? AC : RBR.Value ? AR : RBD.Value ? AD : AL
		TabArr := ControlGetItems(CBBTabs.Hwnd)
		P := -1
		T := Format("{:.2f}", T)
		For I, V In TabArr {
			If (T < V) {
				P := I - 1
				Break
			}
			IF (T = V) {
				P := I - 1
				CBBTabs.Delete(I)
				Break
			}
		}
		I := SendMessage(0x014A, P, StrPtr(T), CBBTabs.Hwnd)  ; CB_INSERTSTRING
		SendMessage(0x0151, I, A, CBBTabs.Hwnd)               ; CB_SETITEMDATA
		TabCount++
		If !(TabCount < MAX_TAB_STOPS)
			BNAdd.Enabled := False
		CBBTabs.Text := ""
		CBBTabs.Focus()
	}
	; ---------------------------------------------------------------------------
	SetTabStopsGuiRemove(*) {
		If (I := CBBTabs.Value) {
			CBBTabs.Delete(I)
			CBBTabs.Text := ""
			TabCount--
			RBL.Value := 1
		}
		CBBTabs.Focus()
	}
	; ---------------------------------------------------------------------------
	SetTabStopsGuiRemoveAll(*) {
		CBBTabs.Text := ""
		CBBTabs.Delete()
		RBL.Value := 1
		CBBTabs.Focus()
	}
	; ---------------------------------------------------------------------------
	SetTabStopsGuiApply(*) {
		TabCount := SendMessage(0x0146, 0, 0, CBBTabs.Hwnd) << 32 >> 32 ; CB_GETCOUNT
		If (TabCount < 1)
			Return
		TabArr := ControlGetItems(CBBTabs.HWND)
		TabStops := {}
		For I, T In TabArr {
			Alignment := Format("0x{:08X}", SendMessage(0x0150, I - 1, 0, CBBTabs.HWND)) ; CB_GETITEMDATA
			TabPos := Format("{:i}", T * 100)
			TabStops.%TabPos% := Align.%Alignment%
		}
		Success := RE.SetTabStops(TabStops)
		RE.Gui.Opt("-Disabled")
		SetTabStopsGui.Destroy()
	}
}

/** ; ---------------------------------------------------------------------------
 * function ...: Sets multi-line tooltips for any Gui control.
 * Parameters:
 * @param GuiCtrl     -  A Gui.Control object
 * @param TipText     -  The text for the tooltip. If you pass an empty string for a formerly added control, its tooltip will be removed.
 * @param UseAhkStyle -  If set to true, the tooltips will be shown using the visual styles of AHK ToolTips. Otherwise, the current theme settings will be used.
 * 			@example Default: True
 * @param CenterTip   -  If set to true, the tooltip will be shown centered below/above the control.
 * 			@example Default: False
 * @example :
 * Return values:
 * True on success, otherwise False.
 * Remarks:
 * Text and Picture controls require the SS_NOTIFY (+0x0100) style.
 * MSDN: https://learn.microsoft.com/en-us/windows/win32/controls/tooltip-control-reference
 */ 
; ---------------------------------------------------------------------------

GuiCtrlSetTip(GuiCtrl, TipText, UseAhkStyle := True, CenterTip := False) {
	Static SizeOfTI := 24 + (A_PtrSize * 6)
	Static Tooltips := Map()
	Local Flags, HGUI, HCTL, HTT, TI
	; ---------------------------------------------------------------------------
	static  TTM_ADDTOOLW := 1074, 		; 0x0432
			TTM_SETMAXTIPWIDTH := 1048, ; 0x0418
			TTF_SUBCLASS := 16, 		; 0x00000010
			TTF_IDISHWND := 1, 			; 0x00000001
			TTF_CENTERTIP := 2 			; 0x00000002
			TTM_UPDATETIPTEXTW := 1081	; 0x0439
	; ---------------------------------------------------------------------------
	;* Check the passed GuiCtrl
	; ---------------------------------------------------------------------------
	If !(GuiCtrl Is Gui.Control)
		Return False
	HGUI := GuiCtrl.Gui.Hwnd
	; ---------------------------------------------------------------------------
	/**
	 * function: Create the TOOLINFO structure 
	 * -> msdn.microsoft.com/en-us/library/bb760256(v=vs.85).aspx
	 */
	; ---------------------------------------------------------------------------
	;? TTF_SUBCLASS | TTF_IDISHWND [| TTF_CENTERTIP]
	; ---------------------------------------------------------------------------
	Flags := 0x11 | (CenterTip ? 0x02 : 0x00)
	TI := Buffer(SizeOfTI, 0)
	/** ; -----------------------------------------------------------------------
	 * @param cbSize
	 * @param uFlags
	 * @param hwnd
	 * @param uID
	 */ ; -----------------------------------------------------------------------
	NumPut("UInt", SizeOfTI, "UInt", Flags, "UPtr", HGUI, "UPtr", HGUI, TI) 
	;? Create a tooltip control for this Gui, if needed
	If !ToolTips.Has(HGUI) {
		If !(HTT := DllCall(
			"CreateWindowEx", "UInt", 0, "Str", "tooltips_class32", "Ptr", 0, "UInt", 0x80000003, "Int", 0x80000000, "Int", 0x80000000, "Int", 0x80000000, "Int", 0x80000000, "Ptr", HGUI, "Ptr", 0, "Ptr", 0, "Ptr", 0, "UPtr")){
			Return False
		}
		If (UseAhkStyle){
			DllCall("Uxtheme.dll\SetWindowTheme", "Ptr", HTT, "Ptr", 0, "Ptr", 0)
		}
		SendMessage(TTM_ADDTOOLW, 0, TI.Ptr, HTT)
		Tooltips[HGUI] := {HTT: HTT, Ctrls: Map()}
	}
	HTT := Tooltips[HGUI].HTT
	HCTL := GuiCtrl.HWND
	; ---------------------------------------------------------------------------
	;? Add / remove a tool for this control
	; ---------------------------------------------------------------------------
	NumPut("UPtr", HCTL, TI, 8 + A_PtrSize) ; uID
	NumPut("UPtr", HCTL, TI, 24 + (A_PtrSize * 4)) ; uID
	;! add the control
	If !Tooltips[HGUI].Ctrls.Has(HCTL) { 
		If (TipText = "")
			Return False
		SendMessage(TTM_ADDTOOLW, 0, TI.Ptr, HTT)
		SendMessage(0x0418, 0, -1, HTT) 
		Tooltips[HGUI].Ctrls[HCTL] := True
	}
	;! remove the control
	Else If (TipText = "") { 
		SendMessage(0x0433, 0, TI.Ptr, HTT) ; TTM_DELTOOLW
		Tooltips[HGUI].Ctrls.Delete(HCTL)
		Return True
	}
	/** ; -------------------------------------------------------------------
	 * function: Set / Update the tool's text.
	 */ ; -------------------------------------------------------------------
	NumPut("UPtr", StrPtr(TipText), TI, 24 + (A_PtrSize * 3))  ; lpszText
	SendMessage(TTM_UPDATETIPTEXTW, 0, TI.Ptr, HTT) ; 
	Return True
}
;! ---------------------------------------------------------------------------
;! ---------------------------------------------------------------------------
;! ---------------------------------------------------------------------------
;! ---------------------------------------------------------------------------
;! ---------------------------------------------------------------------------
;! ---------------------------------------------------------------------------

}

;! ---------------------------------------------------------------------------
;! Testing
;! ---------------------------------------------------------------------------
^+1:: {
	RC := Buffer(16, 0)
	DllCall("SendMessage", "Ptr", RE2.HWND, "UInt", 0x00B2, "Ptr", 0, "Ptr", RC.Ptr) ; EM_GETRECT
	CharIndex := DllCall("SendMessage", "Ptr", RE2.HWND, "UInt", 0x00D7, "Ptr", 0, "Ptr", RC.Ptr, "Ptr") ; EM_CHARFROMPOS
	LineIndex := DllCall("SendMessage", "Ptr", RE2.HWND, "UInt", 0x0436, "Ptr", 0, "Ptr", Charindex, "Ptr") ; EM_EXLINEFROMCHAR
	MsgBox("First visible line = " . LineIndex)
}
^+f:: {
	static CFM_COLOR := 0x40000000, CFM_BOLD := 0x00000001, CFE_BOLD := 0x00000001
	CS := RE2.GetSel()
	SP := RE2.GetScrollPos()
	RE2.Opt("-Redraw")
	; CF2 := RichEdit.CHARFORMAT2()
	;? retrieve a CHARFORMAT2 object for the current selection
	CF2 := RE2.GetCharFormat()
	CF2.Mask := 0x40000001
	;? colors are BGR
	CF2.TextColor := 0xFF0000
	CF2.Effects := 0x01
	;? start searching at the begin of the text
	RE2.SetSel(0, 0)
	; While (RE2.FindText("Lorem", ["Down"]) != 0) ; find the specific phrase
	; RE2.SetCharFormat(CF2)                    ; apply the new settings
	;? apply the new settings
	RE2.SetCharFormat(CF2)
	CF2 := ""
	; RE2.SetScrollPos(SP.X, SP.Y)
	; RE2.SetSel(CS.X, CS.Y)
	RE2.Opt("+Redraw")
}
^+l:: {
	Sel := DllCall("SendMessage", "Ptr", RE2.HWND, "UInt", 0x00BB, "Ptr", 18, "Ptr", 0, "Ptr")
	RE2.SetSel(Sel, Sel)
	RE2.ScrollCaret()
}
^+b:: {
	RE2.SetBorder([10], [2])
}
; ---------------------------------------------------------------------------