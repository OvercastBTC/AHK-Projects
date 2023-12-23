/*
	Simple Regular Expression Tester for AutoHotkey v2 using RegExMatch()
	Tested with build: AutoHotkey_2.0-a100-52515e2
*/
#Include <Directives\__AE.v2>
#Include <Tools\Info>
; #Include <RTE.v2\RichEditBox-master\Class_RichEdit>
#Include <Class\RTE\RichEdit>
#Include <Class\RTE\RichEditDlgs>

;Default Values
	defText := 'History`n`nThe first public beta of AutoHotkey was released on November 10, 2003[10] after author Chris Mallett`'s proposal to integrate hotkey support into AutoIt v2 failed to generate response from the AutoIt community.[11][12] So the author began his own program from scratch basing the syntax on AutoIt v2 and using AutoIt v3 for some commands and the compiler.[13] Later, AutoIt v3 switched from GPL to closed source because of "other projects repeatedly taking AutoIt code" and "setting themselves up as competitors."[14]`n`nIn 2010, AutoHotkey v1.1 (originally called AutoHotkey_L) became the platform for ongoing development of AutoHotkey.[15] Another port of the program is AutoHotkey.dll.[16]`n`nhttps://en.wikipedia.org/wiki/AutoHotkey`n'
	defRegex := "A[^\s]*?y"

;Gui Stuff
	font := "Consolas", offset := 10, w := 800, _w := 200 ;button width
	gGui:= Gui(, "Regular Expression Tester for AutoHotkey v2")
	gGui.SetFont('s10', font)
	; --------------------------------------------------------------------------------
	;setup regex Section [Text label and Edit box]
	gGui.AddText('Section x' offset , "RegEx String:")
	; setup regex edit box
	regex  := gGui.AddEdit("vgregex +Wrap Center" " x+" offset " r1 w" (w/2), defRegex) 
	; --------------------------------------------------------------------------------
	;setup RichEdit Section [Text label and RichEdit Box]
	gGui.AddText('x' offset, "Text:")
	;setup RichEdit box
	dRegTxt := RichEdit(gGui, "r20 w" w, true) 
	dRegTxt.WordWrap(1)
	dRegTxt.SetText(defText)
	btn := gGui.AddButton('vTest Section Default' " w" _w " x" ((w / 2) - (_w / 2)) " Default", "Test RegEx (F5)") 
	n2r := gGui.AddCheckBox('vConvert' " Checked", "Convert ``n (\n) to ``r (\r)")
	gGui.AddText('vResults x' offset , "Results:")
	result := gGui.AddEdit('Section x' offset " +readonly r15 w" w, ' ')
	gTT :=	gcToolTip()
	; gTT.Add(n2r, "Enabling this option is recommended`nbecause this RichEdit box only uses ``r (\r).")
	;test button
	; result.OnEvent('Change' (*) => gGui.Show())
	; defText.OnEvent('Change', (*) => doRegEx())
	gGui.OnEvent("Close", (*) => ExitApp())
	btn.OnEvent("Click", (*) => doRegEx())	;Run doRegEx() whenever changes are detected
	gGui.show()
	doRegEx()

f5::doRegEx()
;*To do: add navigation to next/prev match, add replace box, replace by function?

;called by RegExFunc in RichEdit for each match ...
; todo: add RTF directly (???)
	;! No idea what the heck this is, or what it is doing
;? if a match (OnMatch()) => get the starting point of the text, and length, then set the selection to that, and set the font's back color to yellow
; onMatch(oRE, _?, &sp?, &len?) => oRE.SetSel(sp - 1, sp + len - 1) && oRE.SetFont({BkColor:"YELLOW"})
onMatch(oRE, &sp?, &len?) => oRE.SetSel(sp - 1, sp + len - 1) && oRE.SetFont({BkColor:"YELLOW"})

;perform RegEx, highlight and print results
doRegEx() {
	global gGui, regex, text := defText, result, n2r
	;reset the result box
	result.value := ""
	rstr := defRegex
	
	;replace escaped `(backticks)
	list := RegExReplace(defText,"`n \n", '`r')
	Infos('L1: ' list)
	list := n2r.text ? Map("``n","`r", "\n","\r", "``t","`t", "``r","`r") : Map("``n","`n", "``t","`t", "``r","`r")
	
	for k, v in list {
		; qReplace(&str, a, b) => str := StrReplace(str, a, b)	;by reference StrReplace wrapper
		qReplace(&rstr, k, v)
		Infos('v => : ' v)
		Infos('rstr: ' rstr)
	}
	e := []
	;attempt RegExMatch
	try	{
		;if we have a match
		if (pos := RegExMatch(deftext, rstr, &m)) { 
			Infos('Starting POS: ' pos) ;? validate there are/is a match(s) by getting the position(s) of the match(s)
			vM := unset ;? same as ..: vM := '' (I used it to validate that understanding only)
			for each, vM in m {
				;? highlight matches
				; todo: restore scroll position.
					;! No idea how to do that, or why
				; todo: use RTF directly
					;! No idea how to do that, or why
				;? get the "value" of the match/selected text
				Infos('sel: ' vM)
				; text := dRegTxt.SetSel(pos-1, (pos+vm.length)-1)
				eS := (pos-1), eE := ((pos+vm.length)-1)
				ePos := dRegTxt.SetSel(eS,eE)
				; dRegTxt.SetFont({BkColor:'cYellow'}) 	; fix ..: this doesn't work
				; dRegTxt.SetFont(BkColor := "cYELLOW") ; fix ..: this doesn't work either
				;? validation 
				Infos('End Position: ' ePos 
						; '`n'
						; 'dPos.S: ' dPos.S	
						; 'dPos.E: ' dPos.E	
					)
				; dRegTxt.SetSel(0,0)
				; sel := value.GetSel()
				; sel := value
				;save caret position and reset formatting
				; sel := value
				; OnMatch(vM,"_",pos,text)
				; sel := RegExMatch(vM, rstr, &mat)
				; Infos('test: ' sel) ;? for validation
				RegExMatch(vM, rstr, &mat)
			}
			;if we have a match	
			if mat {
				vMat := unset
				for each, vMat in mat {
					RegExMatch(vMat, rstr, &match)
					Infos('value of mat: ' vMat)
					; match.Push(vMat)
				}
			}
			vMatch := unset
			for each, vMatch in match {
				Infos('sel in match: ' vMatch)
				; match := vMatch.RegExFunc(rstr, (param*) => onMatch(text, param*)) 	;highlight matches with onMatch()

			}

			;restore caret position
			dRegTxt.SetSel(es, eE) 
			;prepare matchedText for result output
			for k, v in match {
				m .= (k==1 ? "" : chr(0x2DDF)) . v
			}
			matchedText := Sort(m, "F mySort D" chr(0x2DDF))			;sort lengthwise and alphabetically
			_match := StrSplit(m, chr(0x2DDF))
			;count duplicates
			_mDict := {}			
			for k, v in _match {
				Infos(v)
				_mDict.Has(v) ? _mDict[v] += 1 : _mDict[v] := 1	
			}			
			; Todo: can probably make this better	
			;remove duplicates and keep sort order by re-sorting
			matchedText := Sort(match, "U F mySort D" chr(0x2DDF))
			_match := StrSplit(match, chr(0x2DDF))
			matchedText := ""		;
			for k, v in _match {													;prep output
				_v := "`t" StrReplace(v, "`r", "`n`t")
				m .= format("{:-12}{:}", (k == 1 ? "" : "`n") "[" k "] x " . _mDict[v],  _v) 
			}
			;print results
			result.value .=   "First match at: " 
							. match.pos 
							. "`n" 
							. "Total matches : " 
							. match.Count 
							. "`n"
							. "Unique matches: "
							. _match.Count() . "`n" 
							. match . "`n`n"
							. "Number of captured subpatterns: " 
							. m.Count 
							. "`n"
			Infos(result.value)
			Loop m.count
				result.value .= "[" A_Index "]" 
				. (m.Name(A_Index) ? " (" m.Name(A_Index) ")" : "")
				. " pos: " m.Pos(A_Index) 
				. ", len: " m.Len(A_Index) " => " 
				. m.value(A_Index) "`n" 	;if it has a name show it

			if m.mark { ;untested, included for completeness sake
				result.value .= "Name of last encountered (*m.mark:NAME): " m.mark "`n"
			}
			result.value .= "No ['matches'] found.`n", text.text := text.text 
			;reset format	
			;RegExMatch exceptions : straight from AutoHotkey documentation
		}
	} catch as e
		result.value := e.Message != "PCRE execution error." ? e.Message : 'PCRE execution error. (' e.extra ')`n`nLikely errors: "too many possible empty-string matches"' (-22), "recursion too deep" (-21), 'and "reached match limit"' (-8) '. If these happen, try to redesign the pattern to be more restrictive, such as replacing each * with a ?, +, or a limit like {0,3} wherever feasible.'
	
	;helper functions
	Sort(a, b) => StrLen(a) != StrLen(b) ? (StrLen(a) - StrLen(b)) : (((a > b) + !(a = b) - 1.5) * (a != b) * 2) ;sort by length then by alphabetical order
	qReplace(&str, a, b) => str := StrReplace(str, a, b)	;by reference StrReplace wrapper
}

;helper class for adding gui tooltips
class gcToolTip {
	static gTT := []
	Static __New() {
		Add(guictrl, tt, to := 4000) { ;gui, tooltip, timeout
			this.gTT.Count() == 0 && OnMessage(0x200, (param*) => this.WM_MOUSEMOVE(param*))
			this.gTT[guictrl.Hwnd] := {tooltip:tt, timeout:to}
		}
		
	}
	static WM_MOUSEMOVE(_, __, ___, Hwnd) {
		static PrevHwnd
		if (Hwnd != PrevHwnd)
			PrevHwnd := Hwnd, ToolTip(), this.gTT.Has(Hwnd) && ToolTip(this.gTT[Hwnd].tooltip)
	}
}
