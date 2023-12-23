/************************************************************************
 * @description Simple Regular Expression Tester for AutoHotkey v2 using RegExMatch()
 * @AHK_Version AHK v2 - 2.0.10
 * @AHK_Version Orgional: AutoHotkey_2.0-a100-52515e2
 * @file regexTester(RE).v2.ahk
 * @author OvercastBTC (update & customize)
 * @author plankoe (update)
 * @author oif2003 (original)
 * @date 2023/11/18
 * @version 0.0.0
 ***********************************************************************/
#Requires AutoHotkey v2+
#Include <Directives\__AE.v2>
#Include <Tools\Info>
#Include <Extensions\Gui>
#Include <Class\RTE\RichEdit>
#Include <Class\RTE\RichEditDlgs>

RE_Regex()
RE_Regex(defText?,defRegex?) {

	; --------------------------------------------------------------------------------
	;? Default Values
	; global gGui, regex, result, n2r
	; static gGui, regex, result, n2r
	static text
	; --------------------------------------------------------------------------------
	;? Default Text
	defText := 'History`n`nThe first public beta of AutoHotkey was released on November 10, 2003[10] after author Chris Mallett`'s proposal to integrate hotkey support into AutoIt v2 failed to generate response from the AutoIt community.[11][12] So the author began his own program from scratch basing the syntax on AutoIt v2 and using AutoIt v3 for some commands and the compiler.[13] Later, AutoIt v3 switched from GPL to closed source because of "other projects repeatedly taking AutoIt code" and "setting themselves up as competitors."[14]`n`nIn 2010, AutoHotkey v1.1 (originally called AutoHotkey_L) became the platform for ongoing development of AutoHotkey.[15] Another port of the program is AutoHotkey.dll.[16]`n`nhttps://en.wikipedia.org/wiki/AutoHotkey`n'
	; --------------------------------------------------------------------------------
	;? Default Regex
	defRegex := "A[^\s]*?y"
	; --------------------------------------------------------------------------------
	;Gui Stuff
	font := "Consolas", offset := 10, w := 800
	;? button width
	_w := 200
	gGui := Gui(, "Regular Expression Tester for AutoHotkey v2").NeverFocusWindow()
	gGui.SetFont("s9", font)
	; --------------------------------------------------------------------------------
	;? setup regex Section [Text label and Edit box]
	gGui.AddText('Section x' offset , "RegEx String:")
	;? setup regex edit box
	regex  := gGui.AddEdit("vgregex +Wrap Center" " x+" offset " r1 w" (w/2), defRegex)
	; --------------------------------------------------------------------------------
	;? setup RichEdit Section [Text label and RichEdit Box]
	gGui.AddText('x' offset, "Text:")
	;? setup RichEdit box
	text := RichEdit(gGui, "r20 w" w, true)
	text.WordWrap(1)
	text.SetText(defText)
	; --------------------------------------------------------------------------------
	;? test button
	; btn := gGui.Add("Button", "yp0 w" _w " x" w / 2 + gGui.MarginX - _w / 2 " Default", "Test RegEx (F5)")
	btn := gGui.AddButton('vTest Section Default' " w" _w " x" ((w / 2) - (_w / 2)) " Default", "Test RegEx (Ctrl+F5)") 
	; --------------------------------------------------------------------------------
	n2r := gGui.AddCheckBox('vConvert' " Checked", "Convert ``n (\n) to ``r (\r)")
	; --------------------------------------------------------------------------------
	;? setup Results Section [Text label and Edit Box]
	gGui.AddText('vResults x' offset , "Results:")
	result := gGui.AddEdit('Section x' offset " +readonly r15 w" w, ' ')
	; --------------------------------------------------------------------------------
	n2r.GetPos(,, &n2rPosW)
	; n2r.move(w - gGui.MarginX - n2rPosW, gGui.MarginY)
	gcToolTip.Add(n2r, "Enabling this option is recommended`nbecause this RichEdit box only uses ``r (\r).")
	gGui.OnEvent('Escape', (*)=>(text:="",ExitApp()))
	gGui.OnEvent("Close", (*)=>(text:="",ExitApp()))
	;? Run doRegEx() whenever changes are detected
	do_Regex := btn.OnEvent("Click", (*)=>doRegEx())
	doRegEx(defText)
	gGui.show()
	; --------------------------------------------------------------------------------
	; Todo: add navigation to next/prev match, add replace box, replace by function?
	;? called by RegExFunc in RichEdit for each match ...
	; todo: add RTF directly (???)
		;! No idea what the heck this is, or what it is doing
	;? if a match (OnMatch()) => get the starting point of the text, and length, then set the selection to that, and set the font's back color to yellow
	onMatch(oRE, _, sp, len) =>	oRE.SetSel(sp - 1, sp + len - 1) && oRE.SetFont({BkColor:"YELLOW"})
	; --------------------------------------------------------------------------------
	;? perform RegEx, highlight and print results
	HotKey("^F5", doRegEx,'On')
	doRegEx(deftext?) {
		; --------------------------------------------------------------------------------
		; global gGui, regex, text, result, n2r
		; global gGui, regex, result, n2r
		; --------------------------------------------------------------------------------
		;reset the result box
		rstr := regex.value
		result.value := ""	
		; --------------------------------------------------------------------------------
		;replace escaped `(backticks)
		list := n2r.value   ? Map("``n","`r", "\n","\r", "``t","`t", "``r","`r")
							: Map("``n","`n", "``t","`t", "``r","`r")
		for k, v in list {
			qReplace(&rstr, k, v)
		}
		; --------------------------------------------------------------------------------
		;? attempt RegExMatch
		try{
			;? if we have a match
			if (pos := RegExMatch(text.GetText(), rstr, &m)) {
				Infos('m.Len: ' m.Len)
				; --------------------------------------------------------------------------------
				;? save caret position
				sel := text.GetSel()
				;? highlight matches with onMatch()
				match := RegExFunc(text, rstr, (param*) => onMatch(text, param*))
				; Infos(match '`n' match.length)
				Infos('match.length: ' match.length)
				Infos('Starting Pos: ' pos) 
				eS := (pos-1), eE := ((eS+m.Len))
				ePos := text.SetSel(eS,eE)
				Infos('End Position: ' ePos)
				cMatch := match.Clone()
				for each, value in cMatch {
					; text.SetFont()
					matchedText .= (each==1 ? "" : chr(0x2DDF)) . value
					Infos('[' each '] ' value)
					ePos := text.SetSel(eS,eE)
					pos := RegExMatch(text.GetText(), rstr, &m, ePos)
					Infos('Pos: ' Pos)
					; eS := (pos-1), eE := ((eS+m.Len))
					; ePos := text.SetSel(eS,eE)
					; (pos := RegExMatch(value, rstr, &m, pos+(IsSet(match) ? match.length : 1)))
					Infos('ePos: ' ePos)
					gGui.Show()
				}
				; ;? restore caret position
				; text.SetSel(sel.S, sel.E) ;! if this is enabled, the next ePos has to be enabled to highlight
				; ePos := text.SetSel(eS,eE)

			; --------------------------------------------------------------------------------
			; vMatch := unset
			; for each, vMatch in match {
			; 	Infos('sel in match: ' vMatch
			; 		'`n' 'match[A_Index]: ' match[A_Index]
			; 		'`n' 'match.count: ' match.Length) ;! <== this gives the number of matches!!!
			; 	;? highlight matches with onMatch()
			; 	match := vMatch.RegExFunc(rstr, (param*) => onMatch(text, param*)) 	
			; }
			; --------------------------------------------------------------------------------
			;? prepare matchedText for result output
			for k, v in match {
				matchedText .= (k==1 ? "" : chr(0x2DDF)) . v
				Infos('v ' v)
			}
			; --------------------------------------------------------------------------------
			;? sort lengthwise and alphabetically
			matchedText := Sort(matchedText, "F mySort D" chr(0x2DDF))
			; --------------------------------------------------------------------------------
			;? count duplicates
			_match := StrSplit(matchedText, chr(0x2DDF))
			_mDict := Map()
			; --------------------------------------------------------------------------------
			; Todo: can probably make this better
			; --------------------------------------------------------------------------------
			;? remove duplicates and keep sort order by re-sorting
			for k, v in _match {
				_mDict.Has(v) ? _mDict[v] += 1 : _mDict[v] := 1
			}
			matchedText := Sort(matchedText, "U F mySort D" chr(0x2DDF))
			_match := StrSplit(matchedText, chr(0x2DDF))
			matchedText := ""
			; --------------------------------------------------------------------------------
			;? prep output
			for k, v in _match {
				_v := "`t" StrReplace(v, "`r", "`n`t")
				matchedText .= format("{:-12}{:}"
				(k == 1 ? "" : "`n") "[" k "] x " . _mDict[v],  _v)
			}
			; --------------------------------------------------------------------------------
			;print results
			Infos("First match at: " . pos 
			. "`n"
			. "Total matches : " . match.Length 
			. "`n"
			. "Unique matches: " . _match.Length 
			. "`n" 
			. matchedText 
			. "`n`n"
			. "Number of captured subpatterns: " . m.Count 
			. "`n")
			result.value .=   "First match at: " . pos 
			. "`n"
			. "Total matches : " . match.Length 
			. "`n"
			. "Unique matches: " . _match.Length 
			. "`n" 
			. matchedText 
			. "`n`n"
			. "Number of captured subpatterns: " . m.Count 
			. "`n"
			Infos('result: ' result)				
			; --------------------------------------------------------------------------------				
			;? if it has a name show it
			Loop (m.Count) {
				result.value .= "[" A_Index "]" . (m.Name(A_Index) ? " (" m.Name(A_Index) ")" : "")
				. " pos: " m.Pos(A_Index) . ", len: " m.length(A_Index) " => " 
				. Match[A_Index] "`n"
			}
			; --------------------------------------------------------------------------------
			;! untested, included for completeness sake
			if (m.Mark) {
				result.value .= "Name of last encountered (*MARK:NAME): " m.Mark "`n"
			}
		} else {
			;? reset format
			result.value .= "No matches found.`n"
			text.text := text.text
		}
		
		;? RegExMatch exceptions : straight from AutoHotkey documentation
	} catch as e {
		result.value := e.message != "PCRE execution error." ? e.message : 'PCRE execution error. (' e.extra ')`n`nLikely errors: "too many possible empty-string matches" (-22), "recursion too deep" (-21), and "reached match limit" (-8). If these happen, try to redesign the pattern to be more restrictive, such as replacing each * with a ?, +, or a limit like {0,3} wherever feasible.'
	}
	;? helper functions
	;? sort by length then by alphabetical order
	mySort(a, b) => StrLen(a) != StrLen(b) ? StrLen(a) - StrLen(b) : ((a > b) + !(a = b) - 1.5) * (a != b) * 2 
	;? by reference StrReplace wrapper
	qreplace(&str, a, b) => str := StrReplace(str, a, b)
}
}
;helper class for adding gui tooltips
class gcToolTip {
	static gTT := Map()
	;? gui, tooltip, timeout
	static Add(guictrl, tt, to := 4000) {
		(this.gTT.Count == 0) && OnMessage(0x200, (param*) => this.WM_MOUSEMOVE(param*))
		this.gTT[guictrl.Hwnd] := {tooltip:tt, timeout:to}
	}
	static WM_MOUSEMOVE(_, __, ___, Hwnd) {
		static PrevHwnd := 0
		if (Hwnd != PrevHwnd)
			PrevHwnd := Hwnd, ToolTip(), this.gTT.Has(Hwnd) && ToolTip(this.gTT[Hwnd].tooltip)
	}
}

RegExFunc(richedit, needle, function) {
	match := []
	if (isObject(function) && function.isBuiltIn != "") {
		textLen := richedit.GetTextLen()
		text := richedit.GetText()
		sp := 0
		len := 1
		; match := []
		while sp < textLen && sp := RegExMatch(text, needle, &m, sp + len)
			; len := m.len > 0 ? m.len : 1
			len := m.length > 0 ? m.length : 1
			; , _match := SubStr(text, sp, m.Len)
			, _match := SubStr(text, sp, m.length)
			, match.push(_match)
			, function.Call(_match, sp, len)
		return match
	} else {
		return false
	}
}