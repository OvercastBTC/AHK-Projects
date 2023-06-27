;=======================================================================================================================
; .............: Begin Section
; Section .....: Auto-Execution
;=======================================================================================================================
; #Warn  ; Enable warnings to assist with detecting common errors.
; SetWinDelay 0 ; (AJB - 06/2023) - comment out for testing
; SetControlDelay 0 ; (AJB - 06/2023) - comment out for testing
; SetBatchLines, -1 ; scrip run speed, The value -1 = max speed possible. ; (AJB - 05/2023)comment out for testing
; https://www.autohotkey.com/docs/v1/lib/SetBatchLines.htm
; SetWinDelay, -1 ; (AJB - 05/2023) - comment out for testing
; SetControlDelay, -1 ; (AJB - 05/2023) - comment out for testing
;#MaxMem 4095 ; Allows the maximum amount of MB per variable.
;#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
#Persistent ; Keeps script permanently running
#SingleInstance,Force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2 ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText,On
DetectHiddenWindows, On
#Requires AutoHotkey 1.1+

; ----------------------------------------------------------------------------------------------------------------------
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; 									... End of Auto-Execution ...
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

; ----------------------------------------------------------------------------------------------------------------------
; Name .........: Horizon Button == A Horizon function library
; Description ..: This library is a collection of functions and buttons that deal with missing interfaces with Horizon.
; AHK Version ..: AHK 1.1+ x32/64 Unicode
; Author .......: Overcast (Adam Bacon), Terry Keatts, and special assistance from Descolada
; License ......: WTFPL - http://www.wtfpl.net/txt/copying/
; Changelog ....: ??? - v0.1 - First version. Added Ctrl-I, Ctrl-B
; ..............: ??? - v0.2 - Broke lots of things, and "fixed" them
; ..............: ??? - v0.3 - Broke lots of things, and "fixed" them... again. Added Ctrl-A
; ..............: ??? - v0.4 - Broke lots of things, and "fixed" them... again
; ..............: 05/23/2023 - v0.5 - Fixed issue where Ctrl-A didn't work in the Equipment Section.
; ..............: 05/31/2023 - v0.6 - Transferred all data sheets to a .ini file (OSTitle.ini).
; ..............: 06/01/2023 - v0.7 - Changed the MakeOSItalic() to read the key: Title= only => see Common_Abbrevations
; . Continued .....................: See Common_Abbrevations.ahk for additional details.
; ..............: 06/04/2023 - v0.8 - Added icon, tray menu, separated MakeOSItalic() function
; . Continued ..: => Tray Menu has the "option" to run an startup ==> this needs to change to always for .exe
; ..............: 06/04/2023 - v0.9 - Added "CloseHandle" and "GlobalFree" dllcalls to attempt correction of weirdness
; . Continued ..: after running the HznButton() function.
; ..............: 06/05/2023 - v1.0 - removed CloseHandle and GlobalFree => made it worse.
; . Continued ..: Simplified the button clicking process using the ?: ternary opeartor
; ----------------------------------------------------------------------------------------------------------------------


; ----------------------------------------------------------------------------------------------------------------------
; Sub-Section .....: Script Name, Startup Path, and icon
; ----------------------------------------------------------------------------------------------------------------------
ICON := "C:\AHK-Studio\AHK-Projects\Horizon\HznHorizon.ico"
splitPath, A_ScriptFullPath, , , A_Script_Ext, A_Script_Name
A_Script_Full_Name := A_Script_Name "." A_Script_Ext
Startup_Shortcut := A_Startup "\" A_Script_Name ".lnk"
; ----------------------------------------------------------------------------------------------------------------------
; Sub-Section .....: Create Tray Menu
; ----------------------------------------------------------------------------------------------------------------------

Menu, Tray, Icon, % Icon ; this changes the icon into a little Horizon thing.
Menu, Tray, NoStandard
addTrayMenuOption("Made with nerd by Adam Bacon and Terry Keatts", "madeBy")
addTrayMenuOption()
addTrayMenuOption("Run at startup", "runAtStartup")
Menu, Tray, % fileExist(Startup_Shortcut) ? "check" : "unCheck", Run at startup ; update the tray menu status on startup
addTrayMenuOption()
Menu, Tray, Standard

; ----------------------------------------------------------------------------------------------------------------------
; Sub-Section .....: Create Tray Menu Functions
; Description .....: addTrayMenuOption() ; madeBy() ; runAtStartup() ; trayNotify()
; ----------------------------------------------------------------------------------------------------------------------

addTrayMenuOption(label = "", command = "") {
	if (label = "" && command = "") {
		Menu, Tray, Add
	} else {
		Menu, Tray, Add, % label, % command
	}
}

madeBy(){
	; visit authors website
	;Run, https://bibeka.com.np/
	MsgBox This was made by nerds, for nerds. Regular people are ok too, lol.`nModified by Adam Bacon`nCredit:Made with ❤️ by Bibek Aryal
}

runAtStartup() {
	if (FileExist(startup_shortcut)) {
		FileDelete, % startup_shortcut
		Menu, Tray, % "unCheck", Run at startup ; update the tray menu status on change
		trayNotify("Startup shortcut removed", "This script will not run when you turn on your computer.")
	} else {
		FileCreateShortcut, % a_scriptFullPath, % startup_shortcut
		Menu, Tray, % "check", Run at startup ; update the tray menu status on change
		trayNotify("Startup shortcut added", "This script will now automatically run when your turn on your computer.")
	}

}

trayNotify(title, message, seconds = "", options = 0) {
	TrayTip, %title%, %message%, %seconds%, %options%
}

; ********************************************** ... First Return ... **************************************************
return
; ********************************************** ... First Return ... **************************************************

; ...............: End Sub-Section
;=======================================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

#IfWinActive ahk_exe hznhorizon.exe

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon {Enter} ==> Select Option
; Description ..: Hotkeys (shortcuts) sending {Enter} in leu of "Double Click"
; Author .......: Overcast (Adam Bacon)
; TODO .........: Still doesn't work. Might have to not use the WinActive() function
; ----------------------------------------------------------------------------------------------------------------------
#If WinActive("ahk_exe hznhorizonmgr.exe") or WinActive("ahk_exe hznhorizon.exe")
{
	ControlGetFocus, fCtl, A
	ControlGet, hCtl, hWnd,,% fCtl, A
	Shift & Enter::DllCall("PostMessage", Ptr, Ctl, UInt,0x0203,Ptr, 0, Ptr, 0)
}
return
#If

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Buttons/Hotkeys
; Description ..: Hotkeys (shortcuts) for normal Windows hotkeys: CTRL+I (italics) ; CTRL+B (bold) ; CTRL+A (select all)
; . Continued ..: CTRL+U (underline) - Where Applicable - else same as CTRL+B (I dunno why).
; . Continued ..: In ideal land, this will be a single function call. Right now this works.
; Author .......: Overcast (Adam Bacon)
; TODO .........: Reduce to a single HznButton function call
; ChangeLog ....: see above
; Special Notes : The below indexes, or n from the HznButton(hWndToolbar, n) function, depend on what screen you are on
; . Continued ..: 1=Bold, 2=Italics, (everything after this changes depending on what screen you are on)
; . Continued ..: =====> where underline is an option is index 9 or 10, else it reverts to CTRL+B or CTRL+I
; ......................................................................................................................
; . Continued ..: >>>>>>>>> THIS NEEDS TO BE FULLY VALIDATED FOR EACH SCREEN <<<<<<<<<<
; . Continued ..: (AJB - 06/2023) as of this timestamp, none of this below is fully validated and changes
; . Continued ..: 10=Cut, 11=Copy, 12=Paste, 14=Undo, 15=Redo, 17=Bulleted List, 18=Spell Check
; . Continued ..: ===== Human Element Section =====
; . Continued ..: 20=Super/Sub Script, 21=Find/Replace
; . Continued ..: Mystery or Spacers: 3-9, 13, 16, 19=?Bold?
; . Continued ..: ===== Equipment Section =====
; . Continued ..: Nothing?=1,2; Same: 21,20,18,17,
; ----------------------------------------------------------------------------------------------------------------------

; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Horizon Button Function <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Hotkeys - Italic, Bold, and Underline (***where applicable***)
; ChangeLog ....: 06/05/2023 - CTRL+I and CTRL+B validated for all screens
; . Continued ..: CTRL+U only valid for screens which have it listed as a button, else it reverts to CTRL+B or CTRL+I
; ----------------------------------------------------------------------------------------------------------------------
#If WinActive("ahk_exe hznhorizon.exe")

^i::
^b::
^u::
SendLevel 1
ControlGetFocus, fCtl, A
bID:= SubStr(fCtl, 0, 1)
hIDx:= A_ThisHotkey = "^i" ? 2 ; ..............: italic = 2
	: A_ThisHotkey = "^b" ? 1 ; ..............: bold = 1
	: A_ThisHotkey = "^u" ? 9 : 10 ; .........: underline = 9 and 10 (if available, else italic or bold)
ControlGet, hToolbar, hWnd,,% "msvb_lib_toolbar" bID, A
HznButton(hToolbar,hIDx)
return

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Hotkeys - Save
; ChangeLog ....: 06/08/2023 - v1 - With #IfWinActive ahk_exe hznhorizon.exe, added CTRL+S
; . Continued ..: Added FindText() function to bottom of script using the-automator.com script
; . Continued ..: Added the "specific text", which is really a picture convereted to base64 (to text) of the Save icon
; ----------------------------------------------------------------------------------------------------------------------
/*
^s::

Text:="|<>*152$47.0000000000000000000000000000000003zzz0000Dzzz0000P00q0000q01w0001g03s0003M06k0006k0BU000BU0P0000P00q0000q01g0001g03M00037zsk0006DzlU000A0030000Mzzq0000lzzg0001XzXM00037z6k0006DyBU000ATwP00007zzy01"

if ok:=FindText(23,92,150000,150000,0,0,Text)
{
	CoordMode, Mouse
	X:=ok.1, Y:=ok.2, W:=ok.3, H:=ok.4, Comment:=ok.5
	ControlClick, X+W//2, Y+H//2
}
return
*/
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Hotkeys - Cut, Copy, Paste, Undo, Redo
; ChangeLog ....: 06/05/2023 - Validated for the Human Element Screen only. Commented out due to irratic behavior.
; ----------------------------------------------------------------------------------------------------------------------
/*
^x::
^c::
^v::
^z::
^y::
ControlGetFocus, focus, A
bID:= SubStr(focus, 0, 1)
hIDx:= A_ThisHotkey = "^x" ? 11 ; ........: cut = 11 and 12
	: A_ThisHotkey = "^c" ? 13 ; ........: copy
	: A_ThisHotkey = "^v" ? 16 ; ........: paste
	: A_ThisHotkey = "^z" ? 17 ; ........: undo = 17 and 18
	: A_ThisHotkey = "^y" ? 20 : 20 ; ...: redo

ControlGet, hToolbar, hWnd,,% "msvb_lib_toolbar" bID, A
HznButton(hToolbar,hIDx)
return
*/
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Hotkey - Select-All (Ctrl-A)
; ----------------------------------------------------------------------------------------------------------------------

^a::HznSelectAll()

HznSelectAll(){
	ControlGetFocus, fCtl, A, 
	ControlGet, hCtl, hWnd,,% fCtl, A
	Static Msg := EM_SETSEL := 177,
				   Param := 0,
				  lParam := -1
	DllCall("SendMessage","Ptr",hCtl,"UInt",Msg, "UInt", wParam, "UIntP", lParam)
}
Return


; ......................................................................................................................
;if (ErrorLevel != 1) {
;ToolTip % "SendMessge Error: " ErrorLevel "`n" hCtl "`n" Ctl
;}
;WinGetClass, vCtl, % "ahk_id " Ctl
;DllCall("SendMessage","Ptr",Ctl,"UInt",EM_SETSEL := 0xB1, "Ptr", 0, "Ptr", -1))
;((vCtl = "TX11") ? DllCall("SendMessage","Ptr",Ctl,"UInt",EM_SETSEL := 177, "PtrP", 0, "PtrP", -1) : DllCall("SendMessage","Ptr",Ctl,"UInt",EM_SETSEL := 0xB1, "Ptr", 0, "Ptr", -1))
;((vCtl = "TX11") ? SendMessage,0xB1,"","",,ahk_id %Ctl% : SendMessage,0xB1,0,-1,,ahk_id %Ctl%) ; doesn't work

;ToolTip % "1: " hCtl "`n2: " vCtl, 0,0,1

;MsgBox % "xCtl: " xCtl  "`nyCtl: " yCtl
;hWndChild := DllCall("RealChildWindowFromPoint","Ptr",Ctl,"UInt",4,"Ptr")
;Ctl := DllCall("RealChildWindowFromPoint","Ptr",hCtl,"UInt",4,"Ptr")
;VarSetCapacity(cClass, 261*2, 0)
;DllCall("GetClassName","Ptr",Ctl,"Str",cClass,"Int",261)
;VarSetCapacity(cClass, 64*2, 0)
;DllCall("GetClassName","Ptr",Ctl,"Str",cClass,"Int",64)
;WinGetClass, vCtl, % "ahk_id " hWndChild

;((cClass = "TX11") ? DllCall("SendMessage","Ptr",Ctl,"UInt",0x00B1) : DllCall("SendMessage","Ptr",Ctl,"UInt",0xB1, "Ptr", 0, "Ptr", -1))
;DllCall("SendMessage","Ptr",Ctl,"UInt",0xB1, "Ptr", 0, "Ptr", -1)

return

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: HznButton()
; Description ..: Find and Control-Click the Horizon msvb_lib_toolbar buttons
; Definition ...: hWndToolbar = the toolbar window's handle
; Definition ...: n = the index for the specified button
; Author .......: Descolada, Overcast (Adam Bacon)
; ----------------------------------------------------------------------------------------------------------------------

HznButton(hToolbar, n)
{
	static TB_BUTTONCOUNT := 0x418, TB_GETBUTTON := 0x417, TB_GETITEMRECT := 0x41D ; set the static variables
	SendMessage, TB_BUTTONCOUNT, 0, 0,,% "ahk_id " hToolbar ; count and load all the msvb_lib_toolbar buttons into memory
	;DllCall("SendMessage", "Ptr", hToolbar, "Ptr", TB_BUTTONCOUNT, "Ptr", 0, "Ptr", 0)
	buttonCount := ErrorLevel
	if (n >= 1 && n <= buttonCount) {
		;Ptr := A_PtrSize ? "UPtr" : "UInt", PtrP := Ptr . "*"
		DllCall("GetWindowThreadProcessId", "Ptr", hToolbar, "UIntP", targetProcessID)
		; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
		hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")
		; Allocate memory for the TBBUTTON structure in the target process's address space
		remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", 16, "UInt", 0x1000, "UInt", 0x04, "Ptr")
		SendMessage, TB_GETITEMRECT, % n-1, remoteMemory, ,% "ahk_id " hToolbar
		VarSetCapacity(RECT, 16, 0)
		DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", &RECT, "UPtr", 16, "UIntP", bytesRead, "Int")
		DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
		; get the bounding rectangle for the specified button
		X := NumGet(RECT, 0, "int"), Y := NumGet(RECT, 4, "int"), W := NumGet(RECT, 8, "int")-X, H := NumGet(RECT, 12, "int")-Y, prevDelay := A_ControlDelay
		
		ControlClick, % "x" (X+W//2) " y" (Y+H//2), % "ahk_id " hToolbar,,,, NA
		SetControlDelay, %prevDelay%
	} else {
		MsgBox, 48, Error, % "The specified index " n " is out of range. Please specify a valid index between 1 and " buttonCount "."
	}
	
	DllCall("FreeLibrary", "Ptr", hProcess) ; added 06.23.2023
}
;reload ; make sure you reload or it... does weird stuff ; commented out 06.23.2023 with the "FreeLibrary" DllCall() 
return

;#IfWinActive
; DllCall("CloseHandle", "Ptr", hProcess) ; this and the below "GlobalFree" may have fixed the need for a reload.
; DllCall("GlobalFree", "Ptr", hWndToolbar) ; this and the above "CloseHandle" may have fixed the need for a reload.
; (AJB - 06/2023) - Nope, both? of those make it worse

/*
If(vCtl = "ThunderRT6TextBox"){
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1) ;,"PTR*",start,"PTR*",end) ;EM_SETSEL:=0xB1
}
If(vCtl = "TX11"){
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1) ;,"PTR*",start,"PTR*",end) ;EM_SETSEL:=0xB1
}else {
	;PostMessage, EM_SETSEL:=0xB1, 0, -1, , % "ahk_id " ctl		; works in eqpt
	;SendMessage, EM_SETSEL:=0xB1, 0, -1, , % "ahk_id " ctl		; works in eqpt
	DllCall("SendMessage","PTR",ctl,"UInt",0xB1, Ptr, 0, Ptr, -1) 	; works in eqpt
}
;reload
*/
return

; ----------------------------------------------------------------------------------------------------------------------
; Function .....: Horizon Button - Italics (Ctrl-I)
; ----------------------------------------------------------------------------------------------------------------------


; ..........: Leave until conversion to AHK v2 ==> backup for conflict with SetBatchLines, SetWinDelay, SetControlDelay
ci:
cb:
cu:
ControlGetFocus, focus, A
bID:= SubStr(focus, 0, 1)
hIDx:= A_ThisLabel = "ci" ? 2 ; ..............: italic = 2
	: A_ThisLabel = "cb" ? 1 ; ..............: bold = 1
	: A_ThisLabel = "cu" ? 9 : 10 ; .........: underline = 9 and 10 (if available, else italic or bold)
ControlGet, hToolbar, hWnd,,% "msvb_lib_toolbar" bID, A
HznButton(hToolbar,hIDx)
return
; ......................................................................................................................


#6::
SendLevel 1
ControlGetFocus, fCtl, A
bID:= SubStr(fCtl, 0, 1)
ControlGet, hTbCtl, hWnd,,% "msvb_lib_toolbar" bID, A
;WinGetClass, TbCtlClass, % "ahk_id " hTbCtl
;MsgBox % hTbCtl " " TbCtlClass

;MsgBox % hTbCtl ? "Toolbar handle: " hTbCtl "`nButton count: " ErrorLevel : "Didn't find toolbar!"
EnumToolbarButtons(hTbCtl)

return

EnumToolbarButtons(ctrlhwnd, is_apply_scale:=false) {
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
	
	arbtn := []
	
	ControlGetPos, ctrlx, ctrly, ctrlw, ctrlh,, % "ahk_id " ctrlhwnd
	
	;MsgBox % "X: "ctrlx " Y: "ctrly " W: " ctrlw " H: " ctrlh ; 06.25.2023 .. THIS WORKS!!!
	;MouseMove, ctrlx, ctrly ; 06.25.2023 .. THIS WORKS!!! It actually moves the mouse to the right location!!!
	
	WinGet, pid_target, PID, % "ahk_id " ctrlhwnd
	hpRemote := DllCall( "OpenProcess" 
	                    , "uint", 0x18    ; PROCESS_VM_OPERATION|PROCESS_VM_READ 
	                    , "int", false 
	                    , "uint", pid_target ) 
	; hpRemote: Remote process handle
	if(!hpRemote) {
		tooltip, % "Autohotkey: Cannot OpenProcess(pid=" . pid_target . ")"
		return
	}
	remote_buffer := DllCall( "VirtualAllocEx" 
                    , "uint", hpRemote 
                    , "Ptr", 0          ; LPVOID lpAddress ("uint" tolerable) 
                    , "uint", 0x1000    ; size to allocate, 4KB
                    , "uint", 0x1000         ; MEM_COMMIT 
                    , "uint", 0x4 )          ; PAGE_READWRITE 
	x1 :=""
	x2 :=""
	y1 :=""
	y2 :=""
	WM_USER             := 0x400
	TB_GETSTATE         := WM_USER+18
	TB_GETBITMAP        := WM_USER+44 ; only for test
	TB_GETBUTTONSIZE    := WM_USER+58 ; only for test
	TB_GETBUTTON        := WM_USER+23
	TB_GETBUTTONTEXTA   := WM_USER+45 ; I always get UTF-16 string from the toolbar // ANSI: WM_USER+45
	TB_GETBUTTONTEXTW   := WM_USER+75 ; I always get UTF-16 string from the toolbar // ANSI: WM_USER+45
	TB_GETITEMRECT      := WM_USER+29
	TB_BUTTONCOUNT      := WM_USER+24
  WM_GETDLGCODE       := 135        ;(decimal) or 0x0087 (hex)
  WM_NEXTDLGCTL       := 40         ;(decimal) or 0x0028 (hex)
	TB_COMMANDTOINDEX   := 1049       ;(decimal) or 0x0419 (hex)
  TB_GETBUTTONINFOW   := 1087       ;(decimal) or 0x043f (hex)	
	
  SendMessage, % TB_BUTTONCOUNT,0,0, , % "ahk_id " ctrlhwnd
	buttons := ErrorLevel
	;tooltip, buttons=%buttons%	 ; OK
	
	VarSetCapacity( rect, 16, 0 ) 
	VarSetCapacity( BtnStruct, 32, 0 ) ; Winapi TBBUTTON struct(32 bytes on x64, 20 bytes on x86)
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
	
	Loop,%buttons%
	{
		; Try to get button text. Two steps: 
		; 1. get command-id from button-index,
		; 2. get button text from command-id
		SendMessage, TB_GETBUTTON, % A_Index-1, remote_buffer, , % "ahk_id " ctrlhwnd
		ReadRemoteBuffer(hpRemote, remote_buffer, BtnStruct, 32)
		
		;idButton := NumGet(BtnStruct, 4, "Int")
    idButton := NumGet(BtnStruct, 4, "UIntP")
	
		
		SendMessage, TB_COMMANDTOINDEX,% idButton,0,, % "ahk_id " ctrlhwnd ; hope that 4KB is enough ; just a test
		btnvar1 := ErrorLevel
		
		SendMessage, TB_GETBUTTONINFOW,% btnvar1,remote_buffer,, % "ahk_id " ctrlhwnd ; hope that 4KB is enough ; just a test
		btnvar2 := ErrorLevel
    
		SendMessage, % TB_GETSTATE, % idButton, 0, , % "ahk_id " ctrlhwnd ; hope that 4KB is enough ; just a test
		btnstate := ErrorLevel

		SendMessage, % TB_GETBUTTONTEXTW, % idButton, remote_buffer, , % "ahk_id " ctrlhwnd ; hope that 4KB is enough
		btntextchars := ErrorLevel
    
		if(btntextchars>0){
			btntextbytes := A_IsUnicode ? btntextchars*2 : btntextchars
			VarSetCapacity(BtnTextBuf, btntextbytes+2, 0) ; +2 is for trailing-NUL
			ReadRemoteBuffer(hpRemote, remote_buffer, BtnTextBuf, btntextbytes)
			BtnText := StrGet(&BtnTextBuf,,"UTF-16")
		} else {
			BtnText := ""
		}

		;FileAppend, % A_Index . ":" . idButton . "(" . btntextchars . ")" . BtnText . "`n", _emeditor_toolbar_buttons.txt ; debug
		
		SendMessage,% TB_GETITEMRECT,% A_Index-1, remote_buffer, , ahk_id %ctrlhwnd%
		
		ReadRemoteBuffer(hpRemote, remote_buffer, rect, 16)
		oldx1:=x1
		oldx2:=x2
		oldy1:=y1
		x1 := NumGet(rect, 0, "Int") 
		x2 := NumGet(rect, 8, "Int") 
		y1 := NumGet(rect, 4, "Int") 
		y2 := NumGet(rect, 12,"Int")
		
		FileAppend, % A_Index . ":" . idButton . "(" . btntextchars . ")" . " Txt: " BtnText . " State: " btnstate . " C2I: " Btnvar1 . " Info: " Btnvar2 . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . " ErrorLevel: " ErrorLevel . "`n", _emeditor_toolbar_buttons.txt ; debug
		ToolTip,    % A_Index . ":" . idButton . "(" . btntextchars . ")" . " Txt: " BtnText . " State: " btnstate . " C2I: " Btnvar1 . " Info: " Btnvar2 . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . " ErrorLevel: " ErrorLevel . "`n" ;, _emeditor_toolbar_buttons.txt ; debug
		;MouseMove % ctrlx + (x2+x1//2), ctrly + (y2+y1//2)
		;if(is_apply_scale) {
		;scale := Get_DPIScale()
		;x1 /= scale
		;y1 /= scale
		;x2 /= scale
		;y2 /= scale
		;}
		
		If (x1=oldx1 And y1=oldy1 And x2=oldx2)
			Continue
		If (x2-x1<10)
			Continue
		If (x1>ctrlw Or y1>ctrlh)
			Continue
		
		arbtn := ( {"x":x1, "y":y1, "w":x2-x1, "h":y2-y1, "cmd":idButton, "text":BtnText} )
		For key, value in arbtn
			FileAppend, % "Key:" . key . " = " . value . "`n", _arbtn.txt
		;arbtn.Insert( {"x":x1, "y":y1, "w":x2-x1, "h":y2-y1, "cmd":idButton, "text":BtnText} )
		;arbtn.InsertAt( {"x":x1, "y":y1, "w":x2-x1, "h":y2-y1, "cmd":idButton, "text":BtnText} )
		;line:=100000000+Floor((ctrly+y1)/same)*10000+(ctrlx+x1)
		;lines=%lines%%line%%A_Tab%%ctrlid%%A_Tab%%class%`n
	}
	result := DllCall( "VirtualFreeEx" 
	             , "UInt", hpRemote 
	             , "UInt", remote_buffer 
	             , "UInt", 0 
	             , "UInt", 0x8000 )     ; MEM_RELEASE 
	result := DllCall( "CloseHandle", "UInt", hpRemote )
	return arbtn
}

ReadRemoteBuffer(hpRemote, RemoteBuffer, ByRef LocalVar, bytes) {
	result := DllCall( "ReadProcessMemory" 
	            , "Ptr", hpRemote 
	            , "Ptr", RemoteBuffer 
	            , "Ptr", &LocalVar 
	            , "UInt", bytes 
	            , "UInt", 0 ) 
}

#IfWinActive
;===== Copy The Following Functions To Your Own Code Just once =====


; Note: parameters of the X,Y is the center of the coordinates,
; and the W,H is the offset distance to the center,
; So the search range is (X-W, Y-H)-->(X+W, Y+H).
; err1 is the character "0" fault-tolerant in percentage.
; err0 is the character "_" fault-tolerant in percentage.
; Text can be a lot of text to find, separated by "|".
; ruturn is a array, contains the X,Y,W,H,Comment results of Each Find.

FindText(x,y,w,h,err1,err0,text)
{
  xywh2xywh(x-w,y-h,2*w+1,2*h+1,x,y,w,h)
  if (w<1 or h<1)
    return, 0
  bch:=A_BatchLines
  SetBatchLines, -1
  ;--------------------------------------
  GetBitsFromScreen(x,y,w,h,Scan0,Stride,bits)
  ;--------------------------------------
  sx:=0, sy:=0, sw:=w, sh:=h, arr:=[]
  Loop, 2 {
  Loop, Parse, text, |
  {
    v:=A_LoopField
    IfNotInString, v, $, Continue
    Comment:="", e1:=err1, e0:=err0
    ; You Can Add Comment Text within The <>
    if RegExMatch(v,"<([^>]*)>",r)
      v:=StrReplace(v,r), Comment:=Trim(r1)
    ; You can Add two fault-tolerant in the [], separated by commas
    if RegExMatch(v,"\[([^\]]*)]",r)
    {
      v:=StrReplace(v,r), r1.=","
      StringSplit, r, r1, `,
      e1:=r1, e0:=r2
    }
    StringSplit, r, v, $
    color:=r1, v:=r2
    StringSplit, r, v, .
    w1:=r1, v:=base64tobit(r2), h1:=StrLen(v)//w1
    if (r0<2 or h1<1 or w1>sw or h1>sh or StrLen(v)!=w1*h1)
      Continue
    ;--------------------------------------------
    if InStr(color,"-")
    {
      r:=e1, e1:=e0, e0:=r, v:=StrReplace(v,"1","_")
      v:=StrReplace(StrReplace(v,"0","1"),"_","0")
    }
    mode:=InStr(color,"*") ? 1:0
    color:=RegExReplace(color,"[*\-]") . "@"
    StringSplit, r, color, @
    color:=Round(r1), n:=Round(r2,2)+(!r2)
    n:=Floor(255*3*(1-n)), k:=StrLen(v)*4
    VarSetCapacity(ss, sw*sh, Asc("0"))
    VarSetCapacity(s1, k, 0), VarSetCapacity(s0, k, 0)
    VarSetCapacity(rx, 8, 0), VarSetCapacity(ry, 8, 0)
    len1:=len0:=0, j:=sw-w1+1, i:=-j
    ListLines, Off
    Loop, Parse, v
    {
      i:=Mod(A_Index,w1)=1 ? i+j : i+1
      if A_LoopField
        NumPut(i, s1, 4*len1++, "int")
      else
        NumPut(i, s0, 4*len0++, "int")
    }
    ListLines, On
    e1:=Round(len1*e1), e0:=Round(len0*e0)
    ;--------------------------------------------
    if PicFind(mode,color,n,Scan0,Stride,sx,sy,sw,sh
      ,ss,s1,s0,len1,len0,e1,e0,w1,h1,rx,ry)
    {
      rx+=x, ry+=y
      arr.Push(rx,ry,w1,h1,Comment)
    }
  }
  if (arr.MaxIndex())
    Break
  if (A_Index=1 and err1=0 and err0=0)
    err1:=0.05, err0:=0.05
  else Break
  }
  SetBatchLines, %bch%
  return, arr.MaxIndex() ? arr:0
}

PicFind(mode, color, n, Scan0, Stride
  , sx, sy, sw, sh, ByRef ss, ByRef s1, ByRef s0
  , len1, len0, err1, err0, w, h, ByRef rx, ByRef ry)
{
  static MyFunc
  if !MyFunc
  {
    x32:="5589E583EC408B45200FAF45188B551CC1E20201D08945F"
    . "48B5524B80000000029D0C1E00289C28B451801D08945D8C74"
    . "5F000000000837D08000F85F00000008B450CC1E81025FF000"
    . "0008945D48B450CC1E80825FF0000008945D08B450C25FF000"
    . "0008945CCC745F800000000E9AC000000C745FC00000000E98"
    . "A0000008B45F483C00289C28B451401D00FB6000FB6C02B45D"
    . "48945EC8B45F483C00189C28B451401D00FB6000FB6C02B45D"
    . "08945E88B55F48B451401D00FB6000FB6C02B45CC8945E4837"
    . "DEC007903F75DEC837DE8007903F75DE8837DE4007903F75DE"
    . "48B55EC8B45E801C28B45E401D03B45107F0B8B55F08B452C0"
    . "1D0C600318345FC018345F4048345F0018B45FC3B45240F8C6"
    . "AFFFFFF8345F8018B45D80145F48B45F83B45280F8C48FFFFF"
    . "FE9A30000008B450C83C00169C0E803000089450CC745F8000"
    . "00000EB7FC745FC00000000EB648B45F483C00289C28B45140"
    . "1D00FB6000FB6C069D02B0100008B45F483C00189C18B45140"
    . "1C80FB6000FB6C069C04B0200008D0C028B55F48B451401D00"
    . "FB6000FB6C06BC07201C83B450C730B8B55F08B452C01D0C60"
    . "0318345FC018345F4048345F0018B45FC3B45247C948345F80"
    . "18B45D80145F48B45F83B45280F8C75FFFFFF8B45242B45488"
    . "3C0018945488B45282B454C83C00189454C8B453839453C0F4"
    . "D453C8945D8C745F800000000E9E3000000C745FC00000000E"
    . "9C70000008B45F80FAF452489C28B45FC01D08945F48B45408"
    . "945E08B45448945DCC745F000000000EB708B45F03B45387D2"
    . "E8B45F08D1485000000008B453001D08B108B45F401D089C28"
    . "B452C01D00FB6003C31740A836DE001837DE00078638B45F03"
    . "B453C7D2E8B45F08D1485000000008B453401D08B108B45F40"
    . "1D089C28B452C01D00FB6003C30740A836DDC01837DDC00783"
    . "08345F0018B45F03B45D87C888B551C8B45FC01C28B4550891"
    . "08B55208B45F801C28B45548910B801000000EB2990EB01908"
    . "345FC018B45FC3B45480F8C2DFFFFFF8345F8018B45F83B454"
    . "C0F8C11FFFFFFB800000000C9C25000"
    x64:="554889E54883EC40894D10895518448945204C894D288B4"
    . "5400FAF45308B5538C1E20201D08945F48B5548B8000000002"
    . "9D0C1E00289C28B453001D08945D8C745F000000000837D100"
    . "00F85000100008B4518C1E81025FF0000008945D48B4518C1E"
    . "80825FF0000008945D08B451825FF0000008945CCC745F8000"
    . "00000E9BC000000C745FC00000000E99A0000008B45F483C00"
    . "24863D0488B45284801D00FB6000FB6C02B45D48945EC8B45F"
    . "483C0014863D0488B45284801D00FB6000FB6C02B45D08945E"
    . "88B45F44863D0488B45284801D00FB6000FB6C02B45CC8945E"
    . "4837DEC007903F75DEC837DE8007903F75DE8837DE4007903F"
    . "75DE48B55EC8B45E801C28B45E401D03B45207F108B45F0486"
    . "3D0488B45584801D0C600318345FC018345F4048345F0018B4"
    . "5FC3B45480F8C5AFFFFFF8345F8018B45D80145F48B45F83B4"
    . "5500F8C38FFFFFFE9B60000008B451883C00169C0E80300008"
    . "94518C745F800000000E98F000000C745FC00000000EB748B4"
    . "5F483C0024863D0488B45284801D00FB6000FB6C069D02B010"
    . "0008B45F483C0014863C8488B45284801C80FB6000FB6C069C"
    . "04B0200008D0C028B45F44863D0488B45284801D00FB6000FB"
    . "6C06BC07201C83B451873108B45F04863D0488B45584801D0C"
    . "600318345FC018345F4048345F0018B45FC3B45487C848345F"
    . "8018B45D80145F48B45F83B45500F8C65FFFFFF8B45482B859"
    . "000000083C0018985900000008B45502B859800000083C0018"
    . "985980000008B45703945780F4D45788945D8C745F80000000"
    . "0E90B010000C745FC00000000E9EC0000008B45F80FAF45488"
    . "9C28B45FC01D08945F48B85800000008945E08B85880000008"
    . "945DCC745F000000000E9800000008B45F03B45707D368B45F"
    . "04898488D148500000000488B45604801D08B108B45F401D04"
    . "863D0488B45584801D00FB6003C31740A836DE001837DE0007"
    . "8778B45F03B45787D368B45F04898488D148500000000488B4"
    . "5684801D08B108B45F401D04863D0488B45584801D00FB6003"
    . "C30740A836DDC01837DDC00783C8345F0018B45F03B45D80F8"
    . "C74FFFFFF8B55388B45FC01C2488B85A000000089108B55408"
    . "B45F801C2488B85A80000008910B801000000EB2F90EB01908"
    . "345FC018B45FC3B85900000000F8C05FFFFFF8345F8018B45F"
    . "83B85980000000F8CE6FEFFFFB8000000004883C4405DC390"
    MCode(MyFunc, A_PtrSize=8 ? x64:x32)
  }
  return, DllCall(&MyFunc, "int",mode
    , "uint",color, "int",n, "ptr",Scan0, "int",Stride
    , "int",sx, "int",sy, "int",sw, "int",sh
    , "ptr",&ss, "ptr",&s1, "ptr",&s0
    , "int",len1, "int",len0, "int",err1, "int",err0
    , "int",w, "int",h, "int*",rx, "int*",ry)
}

xywh2xywh(x1,y1,w1,h1,ByRef x,ByRef y,ByRef w,ByRef h)
{
  SysGet, zx, 76
  SysGet, zy, 77
  SysGet, zw, 78
  SysGet, zh, 79
  left:=x1, right:=x1+w1-1, up:=y1, down:=y1+h1-1
  left:=left<zx ? zx:left, right:=right>zx+zw-1 ? zx+zw-1:right
  up:=up<zy ? zy:up, down:=down>zy+zh-1 ? zy+zh-1:down
  x:=left, y:=up, w:=right-left+1, h:=down-up+1
}

GetBitsFromScreen(x,y,w,h,ByRef Scan0,ByRef Stride,ByRef bits)
{
  VarSetCapacity(bits,w*h*4,0), bpp:=32
  Scan0:=&bits, Stride:=((w*bpp+31)//32)*4
  Ptr:=A_PtrSize ? "UPtr" : "UInt", PtrP:=Ptr . "*"
  win:=DllCall("GetDesktopWindow", Ptr)
  hDC:=DllCall("GetWindowDC", Ptr,win, Ptr)
  mDC:=DllCall("CreateCompatibleDC", Ptr,hDC, Ptr)
  ;-------------------------
  VarSetCapacity(bi, 40, 0), NumPut(40, bi, 0, "int")
  NumPut(w, bi, 4, "int"), NumPut(-h, bi, 8, "int")
  NumPut(1, bi, 12, "short"), NumPut(bpp, bi, 14, "short")
  ;-------------------------
  if hBM:=DllCall("CreateDIBSection", Ptr,mDC, Ptr,&bi
    , "int",0, PtrP,ppvBits, Ptr,0, "int",0, Ptr)
  {
    oBM:=DllCall("SelectObject", Ptr,mDC, Ptr,hBM, Ptr)
    DllCall("BitBlt", Ptr,mDC, "int",0, "int",0, "int",w, "int",h
      , Ptr,hDC, "int",x, "int",y, "uint",0x00CC0020|0x40000000)
    DllCall("RtlMoveMemory","ptr",Scan0,"ptr",ppvBits,"ptr",Stride*h)
    DllCall("SelectObject", Ptr,mDC, Ptr,oBM)
    DllCall("DeleteObject", Ptr,hBM)
  }
  DllCall("DeleteDC", Ptr,mDC)
  DllCall("ReleaseDC", Ptr,win, Ptr,hDC)
}

base64tobit(s)
{
  ListLines, Off
  Chars:="0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    . "abcdefghijklmnopqrstuvwxyz"
  SetFormat, IntegerFast, d
  StringCaseSense, On
  Loop, Parse, Chars
  {
    i:=A_Index-1, v:=(i>>5&1) . (i>>4&1)
      . (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1)
    s:=StrReplace(s,A_LoopField,v)
  }
  StringCaseSense, Off
  s:=SubStr(s,1,InStr(s,"1",0,0)-1)
  s:=RegExReplace(s,"[^01]+")
  ListLines, On
  return, s
}

bit2base64(s)
{
  ListLines, Off
  s:=RegExReplace(s,"[^01]+")
  s.=SubStr("100000",1,6-Mod(StrLen(s),6))
  s:=RegExReplace(s,".{6}","|$0")
  Chars:="0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    . "abcdefghijklmnopqrstuvwxyz"
  SetFormat, IntegerFast, d
  Loop, Parse, Chars
  {
    i:=A_Index-1, v:="|" . (i>>5&1) . (i>>4&1)
      . (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1)
    s:=StrReplace(s,v,A_LoopField)
  }
  ListLines, On
  return, s
}

ASCII(s){
  if RegExMatch(s,"(\d+)\.([\w+/]{3,})",r)
  {
    s:=RegExReplace(base64tobit(r2),".{" r1 "}","$0`n")
    s:=StrReplace(StrReplace(s,"0","_"),"1","0")
  }
  else s=
  return, s
}

MCode(ByRef code, hex){
  ListLines, Off
  bch:=A_BatchLines
  SetBatchLines, -1
  VarSetCapacity(code, StrLen(hex)//2)
  Loop, % StrLen(hex)//2
    NumPut("0x" . SubStr(hex,2*A_Index-1,2), code, A_Index-1, "char")
  Ptr:=A_PtrSize ? "UPtr" : "UInt"
  DllCall("VirtualProtect", Ptr,&code, Ptr
    ,VarSetCapacity(code), "uint",0x40, Ptr . "*",0)
  SetBatchLines, %bch%
  ListLines, On
}

; You can put the text library at the beginning of the script, and Use Pic(Text,1) to add the text library to Pic()'s Lib,
; Use Pic("comment1|comment2|...") to get text images from Lib
Pic(comments, add_to_Lib=0) {
  static Lib:=[]
  if (add_to_Lib)
  {
    re:="<([^>]*)>[^$]+\$\d+\.[\w+/]{3,}"
    Loop, Parse, comments, |
      if RegExMatch(A_LoopField,re,r)
        Lib[Trim(r1)]:=r
  }
  else
  {
    text:=""
    Loop, Parse, comments, |
      text.="|" . Lib[Trim(A_LoopField)]
    return, text
  }
}
return

Specify_Area:
run FindText_get_coordinates.ahk
return