	; @resource: https://github.com/Pulover/CbAutoComplete
	; @changes Updated to AutoHotkey v2 (2.0.10)
	; @author (origional): Pulover
	; @resource: https://github.com/Pulover/CbAutoComplete
	; @author (v2-beta): Ark565 (& others)
	; @resource: https://www.reddit.com/r/AutoHotkey/s/4InT1j8Mro
	; @author (v2): OvercastBTC (updates to v2 [2.0.10])

	AutoComplete(ComboBox, entriesList) {
	; CB_GETEDITSEL = 0x0140, CB_SETEDITSEL = 0x0142
		currContent := ComboBox.Text
		QSGui['qEdit'].Value := currContent
		; QSGui['your name'].Value := currContent
		; QSGui.Add('Text','Section','Text')
		QSGui.Show("AutoSize")
		; QSGui.Show()
		if ((GetKeyState("Delete", "P")) || (GetKeyState("Backspace", "P"))){
			return
		}

		valueFound := false
		for index, value in entriesList {
		; for index, value in entries
			; Check if the current value matches the target value
			if (value = currContent)
			{
				valueFound := true
				break ; Exit the loop if the value is found
			}
		}
		if (valueFound){
			return ; Exit Nested request
		}
		Start :=0, End :=0
		MakeShort(0, &Start, &End)
		try {
			if (ControlChooseString(ComboBox.Text, ComboBox) > 0) {
				Start := StrLen(currContent)
				End := StrLen(ComboBox.Text)
				PostMessage( 0x0142, 0, MakeLong(Start, End), , "ahk_id" ComboBox.Hwnd)
			}
		} Catch as e {
			ControlSetText( currContent, ComboBox)
			PostMessage( 0x0142, 0, MakeLong(StrLen(currContent), StrLen(currContent)), , "ahk_id " ComboBox.Hwnd)
		}

		MakeShort(Long, &LoWord, &HiWord) {
			LoWord := Long & 0xffff
			, HiWord := Long >> 16
		}

		MakeLong(LoWord, HiWord) {
			return (HiWord << 16) | (LoWord & 0xffff)
		}
	}
}

; ^+#l::HznAutoComplete()

HznAutoComplete() {
	; SetCapsLockState("Off")
	acInfos := Infos('AutoComplete enabled'
					'Press "Shift+{Enter}",to activate'
				)
	; acInfos := Infos('Press "ctrl + a" to activate, or press "Shift+Enter"')
	; Hotkey(" ", (*) => createGUI())
	; Hotkey("^a", (*) => createGUI())
	Hotkey('+Enter', (*) => createGUI() )
	; createGUI()
	createGUI() {
		initQuery := "Recommendation Library"
		initQuery := ""
		; global entriesList := ["Red", "Green", "Blue"]
		mList := []
		mlist := RecLibs.understanding_the_risk
		; mlist := [RecLibs.understanding_the_risk, RecLibs.HumanElement.electrical]
		; Infos(mlist)
		; entriesList := [mlist]
		; entries := []
		entries := ''
		entriesList := []
		m:=''
		for each, m in mList {
			entriesList.Push(m)
		}
		e:=''
		for each, e in entriesList {
			; entriesList := ''
			; entries := ''
			; entriesList .= value '`n'
			entries .= e '`n'
		}
		
		global QSGui, initQuery, entriesList
		global width := Round(A_ScreenWidth / 4)
		QSGui := Gui("AlwaysOnTop +Resize +ToolWindow Caption", "Recommendation Picker")
		QSGui.SetColor := 0x161821
		QSGui.BackColor := 0x161821
		QSGui.SetFont( "s10 q5", "Fira Code")
		; QSCB := QSGui.AddComboBox("vQSEdit w200", entriesList)
		QSCB := QSGui.AddComboBox("vQSEdit w" width ' h200' ' Wrap', entriesList)
		qEdit := QSGui.AddEdit('vqEdit w' width ' h200')
		; qEdit.OnEvent('Change', (*) => updateEdit(QSCB, entriesList))
		; QSGui_Change(QSCB) => qEdit.OnEvent('Change',qEdit)
		QSGui.Add('Text','Section')
		QSGui.Opt('+Owner ' QSGui.Hwnd)
		; QSCB := QSGui.AddComboBox("vQSEdit w" width ' h200', entriesList)
		QSCB.Text := initQuery
		QSCB.OnEvent("Change", (*) => AutoComplete(QSCB, entriesList))
		; QSCB.OnEvent('Change', (*) => updateEdit(QSCB, entriesList))
		QSBtn := QSGui.AddButton("default hidden yp hp w0", "OK")
		QSBtn.OnEvent("Click", (*) => processInput())
		QSGui.OnEvent("Close", (*) => QSGui.Destroy())
		QSGui.OnEvent("Escape", (*) => QSGui.Destroy())
		; QSGui.Show( "w222")
		; QSGui.Show("w" width ' h200')
		QSGui.Show( "AutoSize")
	}

	processInput() {
		QSSubmit := QSGui.Submit()    ; Save the contents of named controls into an object.
		if QSSubmit.QSEdit {
			; MsgBox(QSSubmit.QSEdit, "Debug GUI")
			initQuery := QSSubmit.QSEdit
			Infos.foDestroyAll()
			Sleep(100)
			updated_Infos := Infos(QSSubmit.QSEdit)
			
		}
		QSGui.Destroy()
		WinWaitClose(updated_Infos.hwnd)
		Run(A_ScriptName)
	}