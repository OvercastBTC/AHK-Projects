#Requires AutoHotkey v2.0

#Include <Includes\Includes_Runner>

; static visitplanner(search := '') {
visitplanner(search := '') {
	vpLink := 'https://app.fmglobal.com/polaris/assignments/'

	login()
	login(){
		Run(vpLink)
		WaitElement_timeDelay := 30000
		; hWe := WinExist(pIDvp)
		; WinWaitActive(hWe)
		; Sleep(100)
		; WinWaitActive('Sign In - Google Chrome') || WinWaitActive('Polaris - Assignments - Google Chrome')
		WinWaitActive('Sign In - Google Chrome')
		vp := UIA.ElementFromChromium('A',false,WaitElement_timeDelay)
		vp.WaitElement({AutomationId: 'signInName'},WaitElement_timeDelay).Value := 'adam.bacon@fmglobal.com'
		vpC := UIA.ElementFromChromium('A',false,WaitElement_timeDelay)
		; vpC.WaitElement({Name:'Continue', AutomationId:'next'},WaitElement_timeDelay).Invoke()
		vpC.WaitElement({Name:'Continue', AutomationId:'next'},WaitElement_timeDelay).Click(,,,,true)
		; ---------------------------------------------------------------------------
		; WinWaitActive('Polaris - Assignments - Google Chrome')
		; vpN := UIA.ElementFromChromium('A',false,WaitElement_timeDelay)
		; vpN.WaitElement({Type:'button', Name:'Load More'},WaitElement_timeDelay).Invoke()
		; ---------------------------------------------------------------------------
		WinWaitActive('Polaris - Assignments - Google Chrome')
		try {
			fvL := vL.FindElement({Type: '50000 (Button)', Name: "All Loaded", LocalizedType: "button", AutomationId: "rds-button-8"})
		}
		if !fvL {
			Loop {
				vL := UIA.ElementFromChromium('A',false,WaitElement_timeDelay)
				try fvL := vL.FindElement({Type: '50000 (Button)', Name: "All Loaded", LocalizedType: "button", AutomationId: "rds-button-8"})
				vpN := UIA.ElementFromChromium('A',false,WaitElement_timeDelay)
				; vpN.WaitElement({Type:'button', Name:'Load More'},WaitElement_timeDelay).Invoke()
				vpN.WaitElement({Type:'button', Name:'Load More'},WaitElement_timeDelay).Click(,,,,true)
				; counter++
				Sleep(200)
			} until fvL := vL.FindElement({Type: '50000 (Button)', Name: "All Loaded", LocalizedType: "button", AutomationId: "rds-button-8"})
		} else {
			return
		}
		; vpN.Invoke()
		; HotIf()
	}
}

exitvp(){
	ehW := WinExist('Polaris ')
	WaitElement_timeDelay := 30000
	WinActivate(ehW)
	exitV := UIA.ElementFromChromium('A',false,WaitElement_timeDelay).WaitElement({Type:'MenuItem', Name: 'Profile'}, WaitElement_timeDelay).Invoke()
	
	UIA.ElementFromChromium('A',false,WaitElement_timeDelay).WaitElement({Type:'MenuItem', Name: 'Log Out'}, WaitElement_timeDelay).Invoke()
	wE := WinExist('FM Global - Google Chrome')
	WinActivate(wE)
	wWwE := WinWaitActive(wE)
	wA := WinActive()
	Infos(wWwE '`n' WinGetTitle(Wa))
	Sleep(1000)
	ControlSend('{Ctrl down}{F4}{Ctrl up}',,WinGetTitle(winactive('A')))
	ControlSend('F4',,WinGetTitle(winactive('A')))
	ControlSend('{Ctrl up}',,WinGetTitle(winactive('A')))
	ControlSend('{Ctrl down}{F4}{Ctrl up}',,wA)
	ControlSend('F4',,wA)
	ControlSend('{Ctrl up}',,wA)
}