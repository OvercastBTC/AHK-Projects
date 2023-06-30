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
bID := SubStr(fCtl, 0, 1)
ControlGet, hToolbar, hWnd,,% "msvb_lib_toolbar" bID, A
hIDx := A_ThisHotkey = "^i" ? 2 ; ..............: italic = 2
      : A_ThisHotkey = "^b" ? 1 ; ..............: bold = 1
      : A_ThisHotkey = "^u" ? 9 : 10 ; .........: underline = 9 and 10 (if available, else italic or bold)
HznButton(hToolbar,hIDx)
return


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

HznSelectAll()
{
	Static Msg := EM_SETSEL := 177, wParam := 0, lParam := -1
	ControlGetFocus, fCtl, A
  ControlGet, hCtl, hWnd,,% fCtl, A
  DllCall("SendMessage", "Ptr", hCtl, "UInt", Msg, "UInt", wParam, "UIntP", lParam)
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
		;DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
    result := DllCall( "VirtualFreeEx" 
              , "UInt", hpRemote 
              , "UInt", remote_buffer 
              , "UInt", 0 
              , "UInt", 0x8000 )     ; MEM_RELEASE 
		; get the bounding rectangle for the specified button
		X := NumGet(RECT, 0, "int"), Y := NumGet(RECT, 4, "int"), W := NumGet(RECT, 8, "int")-X, H := NumGet(RECT, 12, "int")-Y ;, prevDelay := A_ControlDelay
		
		ControlClick, % "x" (X+W//2) " y" (Y+H//2), % "ahk_id " hToolbar,,,, NA
		;SetControlDelay, %prevDelay%
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
ControlGet, hToolbar, hWnd,,% "msvb_lib_toolbar" bID, A
hIDx:= A_ThisLabel = "ci" ? 2 ; ..............: italic = 2
	   : A_ThisLabel = "cb" ? 1 ; ..............: bold = 1
	   : A_ThisLabel = "cu" ? 9 : 10 ; .........: underline = 9 and 10 (if available, else italic or bold)
HznButton(hToolbar,hIDx)
return
; ......................................................................................................................


#6::
#Warn All, OutputDebug
SendLevel 1
ControlGetFocus, fCtl, A
bID:= SubStr(fCtl, 0, 1)
ControlGet, ctrlhwnd, hWnd,,% "msvb_lib_toolbar" bID, A
EnumToolbarButtons(ctrlhwnd)

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
  /*
	; DllCall("GetWindowThreadProcessId", "Ptr", hToolbar, "UIntP", targetProcessID)
  ; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
  ; hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")
  ; Allocate memory for the TBBUTTON structure in the target process's address space
  ; remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", 16, "UInt", 0x1000, "UInt", 0x04, "Ptr")

  */
  ; SendMessage, TB_GETITEMRECT, % n-1, remoteMemory, ,% "ahk_id " hToolbar
  ; VarSetCapacity(RECT, 16, 0)
  ; DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", &RECT, "UPtr", 16, "UIntP", bytesRead, "Int")
  ; DllCall("VirtualFreeEx", "Ptr", hProcess, "Ptr", remoteMemory, "UPtr", 0, "UInt", 0x8000)
  ; get the bounding rectangle for the specified button
	arbtn := []
	
	ControlGetPos, ctrlx, ctrly, ctrlw, ctrlh,, % "ahk_id " ctrlhwnd
	
	;MsgBox % "X: "ctrlx " Y: "ctrly " W: " ctrlw " H: " ctrlh ; 06.25.2023 .. THIS WORKS!!!
	;MouseMove, ctrlx, ctrly ; 06.25.2023 .. THIS WORKS!!! It actually moves the mouse to the right location!!!
	;pid_target := ""
  /*
  pid_target := DllCall( "GetWindowThreadProcessId"
                    , "Ptr", ctrlhwnd)
  ;                  , "UIntP") ;, pid_target)
  OutputDebug, % "pid_target: " . pid_target

*/

  WinGet, pid_target, PID, % "ahk_id " ctrlhwnd ; ==> replaced with above DllCall()
  OutputDebug, % "pid_targetW: " . pid_target . "`n"
  ; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
	hpRemote := DllCall( "OpenProcess" 
	;                  , "uint", 0x18    ; PROCESS_VM_OPERATION|PROCESS_VM_READ ; ==> original
                    , "UInt", 0x0018 | 0x0010 | 0x0020
                    , "Int", false
                    , "UInt", pid_target )
	
  ; hpRemote: Remote process handle
	if(!hpRemote) {
		tooltip, % "Autohotkey: Cannot OpenProcess(pid=" . pid_target . ")"
		return
	}
	; Allocate memory for the TBBUTTON structure in the target process's address space
  
  remote_buffer := DllCall( "VirtualAllocEx" 
  ;                  , "UInt", hpRemote     ; == original
                    , "Ptr", hpRemote
  ;                  , "Ptr", hProcess      ; ==> from HznButton()
                    , "Ptr", 0              ; LPVOID lpAddress ("uint" tolerable)
  ;                  , "Ptr", 0 ; ==> from HznButton() => same
  ;                  , "UInt", 0x1000        ; size to allocate, 4KB
                    , "UPtr", 16            ; ==> from HznButton()           
                    , "UInt", 0x1000        ; MEM_COMMIT
  ;                  , "UInt", 0x1000       ; ==> from HznButton() => same
  ;                  , "UInt", 0x4)          ; PAGE_READWRITE
                    , "UInt", 0x04         ; ==> from HznButton() => same?
                    , "Ptr")               ; ==> from HznButton()
	
  x1 :="", x2 :="", y1 :="", y2 :=""
	
  Static WM_USER        := 0x400
	, TB_GETSTATE         := WM_USER+18
	, TB_GETBITMAP        := WM_USER+44 ; only for test
	, TB_GETBUTTONSIZE    := WM_USER+58 ; only for test
	, TB_GETBUTTON        := WM_USER+23
	, TB_GETBUTTONTEXTA   := WM_USER+45 ; I always get UTF-16 string from the toolbar // ANSI: WM_USER+45
	, TB_GETBUTTONTEXTW   := WM_USER+75 ; I always get UTF-16 string from the toolbar // ANSI: WM_USER+45
	, TB_GETITEMRECT      := WM_USER+29
	, TB_BUTTONCOUNT      := WM_USER+24 ; or 0x418 (hex)
  , WM_GETDLGCODE       := 135        ;(decimal) or 0x0087 (hex)
  , WM_NEXTDLGCTL       := 40         ;(decimal) or 0x0028 (hex)
	, TB_COMMANDTOINDEX   := 1049       ;(decimal) or 0x0419 (hex)
  , TB_GETBUTTONINFOW   := 1087       ;(decimal) or 0x043f (hex)	
	
  Static Msg := TB_BUTTONCOUNT, wParam := 0, lParam := 0, control := ""
  SendMessage,% TB_BUTTONCOUNT,% wParam,% lParam,% control, % "ahk_id " ctrlhwnd
	buttons := ErrorLevel
	OutputDebug, % "buttons: " . buttons . "`n" ;tooltip, buttons=%buttons%	 ; OK
	
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
	
	Loop,% buttons
	{
		; Try to get button text. Two steps: 
		; 1. get command-id from button-index,
		; 2. get button text from command-id
		SendMessage, TB_GETBUTTON, % A_Index-1, remote_buffer, , % "ahk_id " ctrlhwnd
		ReadRemoteBuffer(hpRemote, remote_buffer, BtnStruct, 32)
		
		idButton := NumGet(BtnStruct, 4, "IntP")
    OutputDebug, % "idButton: " . idButton . "`n"	
		
		SendMessage, TB_COMMANDTOINDEX,% idButton,0,, % "ahk_id " ctrlhwnd ; hope that 4KB is enough ; just a test
		btnvar1 := % " Cmd2Indx: " . ErrorLevel
		OutputDebug, % "Cmd2Indx: " . btnvar1 . "`n"

		SendMessage, TB_GETBUTTONINFOW,% btnvar1,remote_buffer,, % "ahk_id " ctrlhwnd ; hope that 4KB is enough ; just a test
		btnvar2 := % " Info:" . ErrorLevel

		SendMessage, % TB_GETSTATE, % idButton, 0, , % "ahk_id " ctrlhwnd ; hope that 4KB is enough ; just a test
		btnstate := ErrorLevel
    OutputDebug, % "btnstate: " . btnstate . "`n"

		SendMessage, % TB_GETBUTTONTEXTW, % idButton, remote_buffer, ,% "ahk_id " ctrlhwnd ; hope that 4KB is enough
		btntextcharsW := ErrorLevel
    OutputDebug, % "btntextcharsW: " . btntextcharsW . "`n"
    
		if(btntextcharsW>0){
			btntextbytes := A_IsUnicode ? btntextcharsW*2 : btntextcharsW
      
			VarSetCapacity(BtnTextBuf, btntextbytes+2, 0) ; +2 is for trailing-NUL
			ReadRemoteBuffer(hpRemote, remote_buffer, BtnTextBuf, btntextbytes)
			BtnTextW := StrGet(BtnTextBuf,,"UTF-16")
		} else {
			BtnTextW := ""
		}
    OutputDebug, % "BtnTextW: " . BtnTextW . "`n"
    
    /*

    SendMessage, % TB_GETBUTTONTEXTA, % idButton, remote_buffer, , % "ahk_id " ctrlhwnd ; hope that 4KB is enough
		btntextcharsA := ErrorLevel
    OutputDebug, % "btntextcharsA: " . btntextcharsA . "`n"
    
		if(btntextcharsA>0){
      btntextbytes := A_IsUnicode ? btntextcharsA*2 : btntextcharsA
			VarSetCapacity(BtnTextBuf, btntextbytes+2, 0) ; +2 is for trailing-NUL
			ReadRemoteBuffer(hpRemote, remote_buffer, BtnTextBuf, btntextbytes)
			BtnTextA := StrGet(&BtnTextBuf,99,0)
		} else {
      BtnTextA := ""
		}
    OutputDebug, % "BtnTextA: " . BtnTextA . "`n"
    */
		
    ;FileAppend, % A_Index . ":" . idButton . "(" . btntextchars . ")" . BtnText . "`n", _emeditor_toolbar_buttons.txt ; debug
		
		SendMessage,% TB_GETITEMRECT,% A_Index-1, remote_buffer, ,% "ahk_id " ctrlhwnd
		
		ReadRemoteBuffer(hpRemote, remote_buffer, rect, 32)
		oldx1:=x1
		oldx2:=x2
		oldy1:=y1
		x1 := NumGet(rect, 0, "Int") 
		x2 := NumGet(rect, 8, "Int") 
		y1 := NumGet(rect, 4, "Int") 
		y2 := NumGet(rect, 12,"Int")
		
		FileAppend, % A_Index . ":" . idButton . "(" . btntextcharsW . ")" . " BtnTextW: " . BtnTextW . " State: " btnstate . Btnvar1 . Btnvar2 . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . " ErrorLevel: " ErrorLevel . "`n", _emeditor_toolbar_buttons.txt  ; debug
		OutputDebug % A_Index . ":" . idButton . "(" . btntextcharsW . ")" . " BtnTextW: " . BtnTextW . " State: " btnstate . Btnvar1 . Btnvar2 . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . " ErrorLevel: " ErrorLevel . "`n"                                 ; debug
    
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
		
    arbtn.Insert({"x":x1, "y":y1, "w":x2-x1, "h":y2-y1, "cmd":idButton, "text":BtnTextW})
    ;arbtn.Insert( {"x":x1, "y":y1, "w":x2-x1, "h":y2-y1, "cmd":idButton, "text":BtnText} )
    ;line:=100000000+Floor((ctrly+y1)/same)*10000+(ctrlx+x1)
    ;lines=%lines%%line%%A_Tab%%ctrlid%%A_Tab%%class%`n
		arbtn := ({"x":x1, "y":y1, "w":x2-x1, "h":y2-y1, "cmd":idButton, "text":BtnTextW})
		For key, value in arbtn{
			FileAppend, % "Key:" . key . " = " . value . "`n", _arbtn.txt
    }
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

;=======================================================================================
;
;                    Class Toolbar
;
; Author:            Pulover [Rodolfo U. Batista]
; AHK version:       1.1.23.01
;
;                    Class for AutoHotkey Toolbar custom controls
;=======================================================================================
;
; This class provides intuitive methods to work with Toolbar controls created via
;    Gui, Add, Custom, ClassToolbarWindow32.
;
; Note: It's recommended to call any method only after Gui, Show. Adding or modifying
;     buttons of a toolbar in a Gui that is not yet visible might fail eventually.
;
;=======================================================================================
;
; Toolbar Methods:
;    Add([Options, Label1[=Text]:Icon[(Options)], Label2[=Text]:Icon[(Options)]...])
;    AutoSize()
;    Customize()
;    Delete(Button)
;    Export()
;    Get([HotItem, TextRows, Rows, BtnWidth, BtnHeight, Style, ExStyle])
;    GetButton(Button [, ID, Text, State, Style, Icon, Label, Index])
;    GetButtonPos(Button [, OutX, OutY, OutW, OutH])
;    GetButtonState(Button, StateQuerry)
;    GetCount()
;    GetHiddenButtons()
;    Insert(Position [, Options, Label1[=Text]:Icon[(Options)], Label2[=Text]:Icon[(Options)]...])
;    LabelToIndex(Label)
;    ModifyButton(Button, State [, Set])
;    ModifyButtonInfo(Button, Property, Value)
;    MoveButton(Button, Target)
;    OnMessage(CommandID)
;    OnNotify(Param [, MenuXPos, MenuYPos, Label, ID, AllowCustom])
;    Reset()
;    SetButtonSize(W, H)
;    SetDefault([Options, Label1[=Text]:Icon[(Options)], Label2[=Text]:Icon[(Options)]...])
;    SetExStyle(Style)
;    SetHotItem(Button)
;    SetImageList(IL_Default [, IL_Hot, IL_Pressed, IL_Disabled])
;    SetIndent(Value)
;    SetListGap(Value)
;    SetMaxTextRows([MaxRows])
;    SetPadding(X, Y)
;    SetRows([Rows, AddMore])
;    ToggleStyle(Style)
;
; Presets Methods:
;    Presets.Delete(Slot)
;    Presets.Export(Slot, [ArrayOut])
;    Presets.Import(Slot, [Options, Label1[=Text]:Icon, Label2[=Text]:Icon, Label3[=Text]:Icon...])
;    Presets.Load(Slot)
;    Presets.Save(Slot, Buttons)
;
;=======================================================================================
;
; Useful Toolbar Styles:   Styles can be applied to Gui command options, e.g.:
;                              Gui, Add, Custom, ClassToolbarWindow32 0x0800 0x0100
;
; TBSTYLE_FLAT      := 0x0800 - Shows separators as bars.
; TBSTYLE_LIST      := 0x1000 - Shows buttons text on their side.
; TBSTYLE_TOOLTIPS  := 0x0100 - Shows buttons text as tooltips.
; CCS_ADJUSTABLE    := 0x0020 - Allows customization by double-click and shift-drag.
; CCS_NODIVIDER     := 0x0040 - Removes the separator line above the toolbar.
; CCS_NOPARENTALIGN := 0x0008 - Allows positioning and moving toolbars.
; CCS_NORESIZE      := 0x0004 - Allows resizing toolbars.
; CCS_VERT          := 0x0080 - Creates a vertical toolbar (add WRAP to button options).
;
;=======================================================================================
Class Toolbar extends Toolbar.Private
{
;=======================================================================================
;    Method:             Add
;    Description:        Add button(s) to the end the toolbar. The Buttons parameters
;                            sets target Label, text caption and icon index for each
;                            button. If not a valid label name, a function name can be
;                            used instead.
;                        To add a separator call this method without parameters.
;                        Prepend any non letter or digit symbol, such as "-" or "*"
;                            to the label to add a hidden button. Hidden buttons won't
;                            be visible when Gui is shown but will still be available
;                            in the customize window. E.g.: "-Label=New:1", "*Label:2".
;    Parameters:
;        Options:        Enter zero or more words, separated by space or tab, from the
;                            following list to set buttons' initial states and styles:
;                            Checked, Ellipses, Enabled, Hidden, Indeterminate, Marked,
;                            Pressed, Wrap, Button, Sep, Check, Group, CheckGroup,
;                            Dropdown, AutoSize, NoPrefix, ShowText, WholeDropdown.
;                        You can also set the minimum and maximum button width,
;                            for example W20-100 would set min to 20 and max to 100.
;                        This option affects all buttons in the toolbar when added or
;                            inserted but does not prevent modifying button sizes.
;                        If this parameter is blank it defaults to "Enabled", otherwise
;                            you must set this parameter to enable buttons.
;                        You may pass integer values that correspond to (a combination of)
;                            button styles. You cannot set states this way (it will always
;                            be set to "Enabled").
;        Buttons:        Buttons can be added in the following format: Label=Text:1,
;                            where "Label" is the target label to execute when the
;                            button is pressed, "Text" is caption to be displayed
;                            with the button or as a Tooltip if the toolbar has the
;                            TBSTYLE_TOOLTIPS style (this parameter can be omitted) and
;                            "1" can be any numeric value that represents the icon index
;                            in the ImageList (0 means no icon).
;                        You can include specific states and styles for a button appending
;                            them inside parenthesis after the icon. E.g.:
;                            "Label=Text:3(Enabled Dropdown)". This option can also be
;                            an Integer value, in this case the general options are
;                            ignored for that button.
;                        To add a separator between buttons specify "" or equivalent.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    Add(Options := "Enabled", Buttons*)
    {
        If (!Buttons.Length())
        {
            Struct := this.BtnSep(TBBUTTON, Options), this.DefaultBtnInfo.Push(Struct)
            SendMessage, this.TB_ADDBUTTONS, 1, &TBBUTTON,, % "ahk_id " this.tbHwnd
            If (ErrorLevel = "FAIL")
                return false
        }
        Else If (Options = "")
            Options := "Enabled"
        For each, Button in Buttons
        {
            If !(this.SendMessage(Button, Options, this.TB_ADDBUTTONS, 1))
                return false
        }
        this.AutoSize()
        return true
    }
;=======================================================================================
;    Method:             AutoSize
;    Description:        Auto-sizes toolbar.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    AutoSize()
    {
        PostMessage, this.TB_AUTOSIZE, 0, 0,, % "ahk_id " this.tbHwnd
        return ErrorLevel ? false : true
    }
;=======================================================================================
;    Method:             Customize
;    Description:        Displays the Customize Toolbar dialog box.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    Customize()
    {
        SendMessage, this.TB_CUSTOMIZE, 0, 0,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             Delete
;    Description:        Delete one or all buttons.
;    Parameters:
;        Button:         1-based index of the button. If omitted deletes all buttons.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    Delete(Button := "")
    {
        If (!Button)
        {
            Loop, % this.GetCount()
                this.Delete(1)
        }
        Else
            SendMessage, this.TB_DELETEBUTTON, Button-1, 0,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             Export()
;    Description:        Returns a text string with current buttons and order in Add and
;                            Insert methods compatible format (this includes button's
;                            styles but not states). Duplicate labels are ignored.
;    Parameters:
;        ArrayOut:       Set to TRUE to return an object array. The returned object
;                            format is compatible with Presets.Save and Presets.Load
;                            methods, which can be used to save and load layout presets.
;    HidMark:            Changes the default symbol to prepend to hidden buttons.
;    Return:             A text string with current buttons information to be exported.
;=======================================================================================
    Export(ArrayOut := false, HidMark := "-")
    {
        BtnArray := [], IncLabels := ":"
        Loop, % this.GetCount()
        {
            this.GetButton(A_Index, ID, Text, State, Style, Icon)
        ,   Label := this.Labels[ID], IncLabels .= Label ":"
        ,   cString := (Label ? (Label (Text ? "=" Text : "")
                    .    ":" Icon (Style ? "(" Style ")" : "")) : "") ", "
        ,   BtnString .= cString
            If (ArrayOut)
                BtnArray.Push({Icon: Icon-1, ID: ID, State: State
                                , Style: Style, Text: Text, Label: Label})
        }
        For i, Button in this.DefaultBtnInfo
        {
            If (!InStr(IncLabels, ":" (Label := this.Labels[Button.ID]) ":"))
            {
                If (!Label)
                    continue
                oString := Label (Button.Text ? "=" Button.Text : "")
                        .    ":" Button.Icon+1 (Button.Style ? "(" Button.Style ")" : "")
                BtnString .= HidMark oString ", "
            }
        }
        return ArrayOut ? BtnArray : RTrim(BtnString, ", ")
    }
;=======================================================================================
;    Method:             Get
;    Description:        Retrieves information from the toolbar.
;    Parameters:
;        HotItem:        OutputVar to store the 1-based index of current HotItem.
;        TextRows:       OutputVar to store the number of text rows
;        Rows:           OutputVar to store the number of rows for vertical toolbars.
;        BtnWidth:       OutputVar to store the buttons' width in pixels.
;        BtnHeight:      OutputVar to store the buttons' heigth in pixels.
;        Style:          OutputVar to store the current styles numeric value.
;        ExStyle:        OutputVar to store the current extended styles numeric value.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    Get(ByRef HotItem := "", ByRef TextRows := "", ByRef Rows := ""
    ,   ByRef BtnWidth := "", ByRef BtnHeight := "", ByRef Style := "", ByRef ExStyle := "")
    {
        SendMessage, this.TB_GETHOTITEM, 0, 0,, % "ahk_id " this.tbHwnd
            HotItem := (ErrorLevel = 4294967295) ? 0 : ErrorLevel+1
        SendMessage, this.TB_GETTEXTROWS, 0, 0,, % "ahk_id " this.tbHwnd
            TextRows := ErrorLevel
        SendMessage, this.TB_GETROWS, 0, 0,, % "ahk_id " this.tbHwnd
            Rows := ErrorLevel
        SendMessage, this.TB_GETBUTTONSIZE, 0, 0,, % "ahk_id " this.tbHwnd
            this.MakeShort(ErrorLevel, BtnWidth, BtnHeight)
        SendMessage, this.TB_GETSTYLE, 0, 0,, % "ahk_id " this.tbHwnd
            Style := ErrorLevel
        SendMessage, this.TB_GETEXTENDEDSTYLE, 0, 0,, % "ahk_id " this.tbHwnd
            ExStyle := ErrorLevel
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             GetButton
;    Description:        Retrieves information from the toolbar buttons.
;    Parameters:
;        Button:         1-based index of the button.
;        ID:             OutputVar to store the button's command ID.
;        Text:           OutputVar to store the button's text caption.
;        State:          OutputVar to store the button's state numeric value.
;        Style:          OutputVar to store the button's style numeric value.
;        Icon:           OutputVar to store the button's icon index.
;        Label:          OutputVar to store the button's associated script label or function.
;        Index:          OutputVar to store the button's text string index.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    GetButton(Button, ByRef ID := "", ByRef Text := "", ByRef State := "", ByRef Style := ""
    ,   ByRef Icon := "", ByRef Label := "", ByRef Index := "")
    {
        VarSetCapacity(BtnVar, 8 + (A_PtrSize * 3), 0)
        SendMessage, this.TB_GETBUTTON, Button-1, &BtnVar,, % "ahk_id " this.tbHwnd
        ID := NumGet(&BtnVar, 4, "Int"), Icon := NumGet(&BtnVar, 0, "Int")+1
    ,   State := NumGet(&BtnVar, 8, "Char"), Style := NumGet(&BtnVar, 9, "Char")
    ,   Index := NumGet(&BtnVar, 8 + (A_PtrSize * 2), "Int"), Label := this.Labels[ID]
        SendMessage, this.TB_GETBUTTONTEXT, ID, 0,, % "ahk_id " this.tbHwnd
        VarSetCapacity(Buffer, ErrorLevel * (A_IsUnicode ? 2 : 1), 0)
        SendMessage, this.TB_GETBUTTONTEXT, ID, &Buffer,, % "ahk_id " this.tbHwnd
        Text := StrGet(&Buffer)
        return (ErrorLevel = "FAIL") ? false : true
        ; Alternative way to retrieve the button state.
        ; SendMessage, this.TB_GETSTATE, ID, 0,, % "ahk_id " this.tbHwnd
        ; State := ErrorLevel
    }
;=======================================================================================
;    Method:             GetButtonPos
;    Description:        Retrieves position and size of a specific button, relative to
;                            the toolbar control.
;    Parameters:
;        Button:         1-based index of the button.
;        OutX:           OutputVar to store the button's horizontal position.
;        OutY:           OutputVar to store the button's vertical position.
;        OutW:           OutputVar to store the button's width.
;        OutH:           OutputVar to store the button's height.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    GetButtonPos(Button, ByRef OutX := "", ByRef OutY := "", ByRef OutW := "", ByRef OutH := "")
    {
        this.GetButton(Button, BtnID), VarSetCapacity(RECT, 16, 0)
        SendMessage, this.TB_GETRECT, BtnID, &RECT,, % "ahk_id " this.tbHwnd
        OutX := NumGet(&RECT, 0, "Int"), OutY := NumGet(&RECT, 4, "Int")
    ,   OutW := NumGet(&RECT, 8, "Int") - OutX, OutH := NumGet(&RECT, 12, "Int") - OutY
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             GetButtonState
;    Description:        Retrieves the state of a button based on a querry.
;    Parameters:
;        StateQuerry:    Enter one of the following words to get the state of the button:
;                            Checked, Enabled, Hidden, Highlighted, Indeterminate, Pressed.
;    Return:             The TRUE if the StateQuerry is true, FALSE if it's not.
;=======================================================================================
    GetButtonState(Button, StateQuerry)
    {
        this.GetButton(Button, BtnID)
        If (this[ "TB_ISBUTTON" StateQuerry] )
            Msg := this[ "TB_ISBUTTON" StateQuerry ]
        SendMessage, Msg, BtnID, 0,, % "ahk_id " this.tbHwnd
        return ErrorLevel ? true : false
    }
;=======================================================================================
;    Method:             GetCount
;    Description:        Retrieves the total number of buttons.
;    Return:             The total number of buttons in the toolbar.
;=======================================================================================
    GetCount()
    {
        SendMessage, this.TB_BUTTONCOUNT, 0, 0,, % "ahk_id " this.tbHwnd
        return ErrorLevel
    }
;=======================================================================================
;    Method:             GetHiddenButtons
;    Description:        Retrieves which buttons are hidden when the toolbar size is 
;                            smaller then the total size of the buttons it has.
;                        This method is most useful when the toolbar is a child window of
;                            a Rebar control, in order to show a menu when the chevron is
;                            pushed. It does not retrieve buttons hidden by gui size.
;    Return:             An array with all buttons hidden by the Rebar band. Each key
;                            in the array has 4 properties: ID, Text, Label and Icon.
;=======================================================================================
    GetHiddenButtons()
    {
        ControlGetPos,,, tbWidth,,, % "ahk_id " this.tbHwnd
        VarSetCapacity(RECT, 16, 0), HiddenButtons := []
        Loop, % this.GetCount()
        {
            SendMessage, this.TB_GETITEMRECT, A_Index-1, &RECT,, % "ahk_id " this.tbHwnd
            If (NumGet(&RECT, 8, "Int") > tbWidth)
                this.GetButton(A_Index, ID, Text, "", "", Icon)
            ,   HiddenButtons.Push({ID: ID, Text: Text, Label: this.Labels[ID], Icon: Icon})
        }
        return HiddenButtons
    }
;=======================================================================================
;    Method:             Insert
;    Description:        Insert button(s) in specified postion.
;                        To insert a separator call this method without parameters.
;    Parameters:
;        Position:       1-based index of button position to insert the new buttons.
;        Options:        Same as Add().
;        Buttons:        Same as Add().
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    Insert(Position, Options := "Enabled", Buttons*)
    {
        If (!Buttons.Length())
        {
            this.BtnSep(TBBUTTON, Options)
            SendMessage, this.TB_INSERTBUTTON, Position-1, &TBBUTTON,, % "ahk_id " this.tbHwnd
            If (ErrorLevel = "FAIL")
                return false
        }
        Else If (Options = "")
            Options := "Enabled"
        For i, Button in Buttons
        {
            If !(this.SendMessage(Button, Options, this.TB_INSERTBUTTON, (Position-1)+(i-1)))
                return false
        }
        return true
    }
;=======================================================================================
;    Method:             LabelToIndex
;    Description:        Converts a button label to its index in a toolbar.
;    Parameters:
;        Label:          Button's associated label or function.
;    Return:             The 1-based index for the button or FALSE if Label is invalid.
;=======================================================================================
    LabelToIndex(Label)
    {
        For ID, L in this.Labels
        {
            If (L = Label)
            {
                SendMessage, this.TB_COMMANDTOINDEX, ID, 0,, % "ahk_id " this.tbHwnd
                return ErrorLevel+1
            }
        }
        return false
    }
;=======================================================================================
;    Method:             ModifyButton
;    Description:        Sets button states.
;    Parameters:
;        Button:         1-based index of the button.
;        State:          Enter one word from the follwing list to change a button's
;                            state: Check, Enable, Hide, Mark, Press.
;        Set:            Enter TRUE or FALSE to set the state on/off.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    ModifyButton(Button, State, Set := true)
    {
        If State not in CHECK,ENABLE,HIDE,MARK,PRESS
            return false
        Message := this[ "TB_" State "BUTTON"]
    ,   this.GetButton(Button, BtnID)
        SendMessage, Message, BtnID, Set,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             ModifyButtonInfo
;    Description:        Sets button parameters such as Icon and CommandID.
;    Parameters:
;        Button:         1-based index of the button.
;        Property:       Enter one word from the following list to select the Property
;                            to be set: Command, Image, Size, State, Style, Text, Label.
;        Value:          The value to be set in the selected Property.
;                            If Property is State or Style you can enter named values as
;                            in the Add options.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    ModifyButtonInfo(Button, Property, Value)
    {
        If (Property = "Label")
        {
            this.GetButton(Button, ID), this.Labels[ID] := Value
            return true
        }
        If (Property = "State") || (Property = "Style")
        {
            If Value is Integer
                Value := Value
            Else
            {
                Loop, Parse, Value, %A_Space%%A_Tab%
                {
                    If (this[ "TBSTATE_" A_LoopField ])
                        tbState += this[ "TBSTATE_" A_LoopField ]
                    Else If (this[ "BTNS_" A_LoopField ] )
                        tbStyle += this[ "BTNS_" A_LoopField ]
                }
                Value := tb%Property%
            }
        }
        If (Property = "Command")
            this.GetButton(Button, "", "", "", "", "", Label), this.Labels[Value] := Label
        this.DefineBtnInfoStruct(TBBUTTONINFO, Property, Value)
    ,   this.GetButton(Button, BtnID)
        SendMessage, this.TB_SETBUTTONINFO, BtnID, &TBBUTTONINFO,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             MoveButton
;    Description:        Moves a toolbar button (change order).
;    Parameters:
;        Button:         1-based index of the button to be moved.
;        Target:         1-based index of the new position.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    MoveButton(Button, Target)
    {
        SendMessage, this.TB_MOVEBUTTON, Button-1, Target-1,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             OnMessage
;    Description:        Run label associated with button's Command identifier.
;                        This method should be called from a function monitoring the
;                            WM_COMMAND message. Pass the wParam as the CommandID.
;    Parameters:
;        CommandID:      Command ID associated with the button. This is send via
;                            WM_COMMAND message, you must pass the wParam from
;                            inside a function that monitors this message.
;        FuncParams:     In case the button is associated with a valid function,
;                            you may pass optional parameters for the function call.
;                            You can pass any number of parameters.
;    Return:             TRUE if target label or function exists, or FALSE otherwise.
;=======================================================================================
    OnMessage(CommandID, FuncParams*)
    {
        If (IsLabel(this.Labels[CommandID]))
        {
            GoSub, % this.Labels[CommandID]
            return true
        }
		Else If (IsFunc(this.Labels[CommandID]))
		{
			BtnFunc := this.Labels[CommandID]
		,	%BtnFunc%(FuncParams*)
			return true
		}
        Else
            return false
    }
;=======================================================================================
;    Method:             OnNotify
;    Description:        Handles toolbar notifications.
;                        This method should be called from a function monitoring the
;                            WM_NOTIFY message. Pass the lParam as the Param.
;                            The returned value should be used as return value for
;                            the monitoring function as well.
;    Parameters:
;        Param:          The lParam from WM_NOTIFY message.
;        MenuXPos:       OutputVar to store the horizontal position for a menu.
;        MenuYPos:       OutputVar to store the vertical position for a menu.
;        BtnLabel:       OutputVar to store the label or function name associated with the button.
;        ID:             OutputVar to store the button's Command ID.
;        AllowCustom:    Set to FALSE to prevent customization of toolbars.
;        AllowReset:     Set to FALSE to prevent Reset button from restoring original buttons.
;        HideHelp:       Set to FALSE to show the Help button in the customize dialog.
;    Return:             The required return value for the function monitoring
;                            the the WM_NOTIFY message.
;=======================================================================================
    OnNotify(ByRef Param, ByRef MenuXPos := "", ByRef MenuYPos := "", ByRef BtnLabel := "", ByRef ID := ""
    ,   AllowCustom := true, AllowReset := true, HideHelp := true)
    {
        nCode  := NumGet(Param + (A_PtrSize * 2), 0, "Int"), tbHwnd := NumGet(Param + 0, 0, "UPtr")
        If (tbHwnd != this.tbHwnd)
            return ""
        If (nCode = this.TBN_DROPDOWN)
        {
            ID  := NumGet(Param + (A_PtrSize * 3), 0, "Int"), BtnLabel := this.Labels[ID]
        ,   VarSetCapacity(RECT, 16, 0)
            SendMessage, this.TB_GETRECT, ID, &RECT,, % "ahk_id " this.tbHwnd
            ControlGetPos, TBX, TBY,,,, % "ahk_id " this.tbHwnd
            MenuXPos := TBX + NumGet(&RECT, 0, "Int"), MenuYPos := TBY + NumGet(&RECT, 12, "Int")
            return false
        }
        Else
            BtnLabel := "", ID := ""
        If (nCode = this.TBN_QUERYINSERT)
            return AllowCustom
        If (nCode = this.TBN_QUERYDELETE)
            return AllowCustom
        If (nCode = this.TBN_GETBUTTONINFO)
        {
            iItem := NumGet(Param + (A_PtrSize * 3), 0, "Int")
            If (iItem = this.DefaultBtnInfo.Length())
                return false
            For each, Member in this.DefaultBtnInfo[iItem+1]
                %each% := Member
            If (Text != "")
            {
                VarSetCapacity(BTNSTR, (StrPut(Text) * (A_IsUnicode ? 2 : 1), 0))
            ,   StrPut(Text, &BTNSTR, StrPut(Text) * 2)
                SendMessage, this.TB_ADDSTRING, 0, &BTNSTR,, % "ahk_id " this.tbHwnd
                Index := ErrorLevel, this.DefaultBtnInfo[iItem+1]["Index"] := Index
            ,   this.DefaultBtnInfo[iItem+1]["Text"] := Text
            }
            NumPut(Icon, Param + (A_PtrSize * 4), 0, "Int") ; iBitmap
        ,   NumPut(ID, Param + (A_PtrSize * 4), 4, "Int") ; idCommand
        ,   NumPut(State, Param + (A_PtrSize * 4), 8, "Char") ; tbState
        ,   NumPut(Style, Param + (A_PtrSize * 4), 9, "Char") ; tbStyle
        ,   NumPut(Index, Param + (A_PtrSize * 4), 8 + (A_PtrSize * 2), "Int") ; iString
            return true
        }
        If (nCode = this.TBN_TOOLBARCHANGE)
        {
            CurrentButtons := this.Export(true)
        ,   this.Presets.Load(CurrentButtons)
        ,   CurrentButtons := ""
        }
        If (nCode = this.TBN_RESET)
        {
            If (AllowReset)
            {
                this.Reset()
                return 2
            }
        }
        If (nCode = this.TBN_INITCUSTOMIZE)
            return HideHelp
        return ""
    }
;=======================================================================================
;    Method:             Reset
;    Description:        Restores all toolbar's buttons to default layout.
;                        Default layout is set by the buttons added. This can be changed
;                            calling the SetDefault method.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    Reset()
    {
        BtnsArray := IsObject(CustomArray) ? CustomArray : this.DefaultBtnInfo
    ,   this.Get("", "", Rows)
        Loop, % this.GetCount()
            this.Delete(1)
        For each, Button in BtnsArray
        {
            For each, Member in Button
                %each% := Member
            If ((Rows > 1) && (Style = this.BTNS_SEP))
                State := 0x24
            If (Text != "")
            {
                VarSetCapacity(BTNSTR, (StrPut(Text) * (A_IsUnicode ? 2 : 1), 0))
            ,   StrPut(Text, &BTNSTR, StrPut(Text) * 2)
                SendMessage, this.TB_ADDSTRING, 0, &BTNSTR,, % "ahk_id " this.tbHwnd
                Index := ErrorLevel
            }
            VarSetCapacity(TBBUTTON, 8 + (A_PtrSize * 3), 0)
        ,   NumPut(Icon, TBBUTTON, 0, "Int")
        ,   NumPut(ID, TBBUTTON, 4, "Int")
        ,   NumPut(State, TBBUTTON, 8, "Char")
        ,   NumPut(Style, TBBUTTON, 9, "Char")
        ,   NumPut(Index, TBBUTTON, 8 + (A_PtrSize * 2), "Int")
            SendMessage, this.TB_ADDBUTTONS, 1, &TBBUTTON,, % "ahk_id " this.tbHwnd
        }
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetButtonSize
;    Description:        Sets the size of buttons on a toolbar. Affects current buttons.
;    Parameters:
;        W:              Width of buttons, in pixels
;        H:              Height of buttons, in pixels
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetButtonSize(W, H)
    {
        Long := this.MakeLong(W, H)
        SendMessage, this.TB_SETBUTTONSIZE, 0, Long,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetDefault
;    Description:        Sets the internal default layout to be used when customizing or
;                        when the Reset method is called.
;    Parameters:
;        Options:        Same as Add().
;        Buttons:        Same as Add().
;    Return:             Always TRUE.
;=======================================================================================
    SetDefault(Options := "Enabled", Buttons*)
    {
        this.DefaultBtnInfo := []
        If (!Buttons.Length())
            this.DefaultBtnInfo.Push({Icon: -1, ID: "", State: ""
                                       , Style: this.BTNS_SEP, Text: "", Label: ""})
        If (Options = "")
            Options := "Enabled"
        For each, Button in Buttons
            this.SendMessage(Button, Options)
        return true
    }
;=======================================================================================
;    Method:             SetExStyle
;    Description:        Sets toolbar's extended style.
;    Parameters:
;        Style:          Enter one or more words, separated by space or tab, from the
;                            following list to set toolbar's extended styles:
;                            Doublebuffer, DrawDDArrows, HideClippedButtons,
;                            MixedButtons.
;                        You may also enter an integer value to define the style.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetExStyle(Style)
    {
        If Style is Integer
            tbStyle_Ex_ := Style
        Else
        {
            Loop, Parse, Style, %A_Space%%A_Tab%
            {
                If (this[ "TBSTYLE_EX_" A_LoopField ] )
                    tbStyle_Ex_ += this[ "TBSTYLE_EX_" A_LoopField ]
            }
        }
        SendMessage, this.TB_SETEXTENDEDSTYLE, 0, tbStyle_Ex_,, % "ahk_id " this.tbHwnd
    }
;=======================================================================================
;    Method:             SetHotItem
;    Description:        Sets the hot item on a toolbar.
;    Parameters:
;        Button:         1-based index of the button.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetHotItem(Button)
    {
        SendMessage, this.TB_SETHOTITEM, Button-1, 0,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetImageList
;    Description:        Sets an ImageList to the toolbar control.
;    Parameters:
;        IL_Default:     ImageList ID of default ImageList.
;        IL_Hot:         ImageList ID of Hot ImageList.
;        IL_Pressed:     ImageList ID of Pressed ImageList.
;        IL_Disabled:    ImageList ID of Disabled ImageList.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetImageList(IL_Default, IL_Hot := "", IL_Pressed := "", IL_Disabled := "")
    {
        SendMessage, this.TB_SETIMAGELIST, 0, IL_Default,, % "ahk_id " this.tbHwnd
        If (IL_Hot)
            SendMessage, this.TB_SETHOTIMAGELIST, 0, IL_Hot,, % "ahk_id " this.tbHwnd
        If (IL_Pressed)
            SendMessage, this.TB_SETPRESSEDIMAGELIST, 0, IL_Pressed,, % "ahk_id " this.tbHwnd
        If (IL_Disabled)
            SendMessage, this.TB_SETDISABLEDIMAGELIST, 0, IL_Disabled,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetIndent
;    Description:        Sets the indentation for the first button on a toolbar.
;    Parameters:
;        Value:          Value specifying the indentation, in pixels.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetIndent(Value)
    {
        SendMessage, this.TB_SETINDENT, Value, 0,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetListGap
;    Description:        Sets the distance between icons and text on a toolbar.
;    Parameters:
;        Value:          The gap, in pixels, between buttons on the toolbar.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetListGap(Value)
    {
        SendMessage, this.TB_SETLISTGAP, Value, 0,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetMaxTextRows
;    Description:        Sets maximum number of text rows for button captions.
;    Parameters:
;        MaxRows:        Maximum number of text rows. If omitted defaults to 0.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetMaxTextRows(MaxRows := 0)
    {
        SendMessage, this.TB_SETMAXTEXTROWS, MaxRows, 0,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetPadding
;    Description:        Sets the padding for icons a toolbar. 
;    Parameters:
;        X:              Horizontal padding, in pixels
;        Y:              Vertical padding, in pixels
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetPadding(X, Y)
    {
        Long := this.MakeLong(X, Y)
        SendMessage, this.TB_SETPADDING, 0, Long,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             SetRows
;    Description:        Sets the number of rows for a toolbar.
;    Parameters:
;        Rows:           Number of rows to set. If omitted defaults to 0.
;        AddMore:        Indicates whether to create more rows than requested when the
;                            system cannot create the number of rows specified.
;                            If TRUE, the system creates more rows. If FALSE, the system
;                            creates fewer rows.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    SetRows(Rows := 0, AddMore := false)
    {
        Long := this.MakeLong(Rows, AddMore)
        SendMessage, this.TB_SETROWS, Long,,, % "ahk_id " this.tbHwnd
        return (ErrorLevel = "FAIL") ? false : true
    }
;=======================================================================================
;    Method:             ToggleStyle
;    Description:        Toggles toolbar's style.
;    Parameters:
;        Style:          Enter zero or more words, separated by space or tab, from the
;                            following list to toggle toolbar's styles:
;                            AltDrag, CustomErase, Flat, List, RegisterDrop, Tooltips,
;                            Transparent, Wrapable, Adjustable, Border, ThickFrame,
;                            TabStop.
;                        You may also enter an integer value to define the style.
;    Return:             TRUE if a valid style is passed, or FALSE otherwise.
;=======================================================================================
    ToggleStyle(Style)
    {
        If Style is Integer
            tbStyle := Style
        Else
        {
            Loop, Parse, Style, %A_Space%%A_Tab%
            {
                If (this[ "TBSTYLE_" A_LoopField ] )
                    tbStyle += this[ "TBSTYLE_" A_LoopField ]
            }
        }
        ; TB_SETSTYLE moves the toolbar away from its position for some reason.
        ; SendMessage, this.TB_SETSTYLE, 0, tbStyle,, % "ahk_id " this.tbHwnd
        If (tbStyle != "")
        {
            WinSet, Style, ^%tbStyle%, % "ahk_id " this.tbHwnd
            return true
        }
        Else
            return false
    }
;=======================================================================================
;    Presets Methods     These methods are used exclusively by the Presets Object.
;                        Presets can be used to quickly change buttons of a toolbar
;                            to predetermined or saved layouts.
;=======================================================================================
    Class tbPresets extends Toolbar.Private
    {
;=======================================================================================
;    Method:             Presets.Delete
;    Description:        Deletes the layout of the specified slot. 
;    Parameters:
;        Slot:           Number of the slot containing the layout to be deleted.
;    Return:             TRUE if the slot contains a layout, or FALSE otherwise.
;=======================================================================================
        Delete(Slot)
        {
            If (IsObject(this[Slot]))
            {
                this.Delete(Slot)
                return true
            }
            Else
                return false
        }
;=======================================================================================
;    Method:             Presets.Export
;    Description:        Returns a text string with buttons and order in Add and
;                            Insert methods compatible format from the specified slot.
;    Parameters:
;        Slot:           Number of the slot in which to save the layout.
;        ArrayOut:       Set to TRUE to return an object array. The returned object
;                            format is compatible with Presets.Save and Presets.Load
;                            methods, which can be used to save and load layout presets.
;    Return:             A text string with buttons information to be exported.
;=======================================================================================
        Export(Slot, ArrayOut := false)
        {
            BtnArray := []
            For i, Button in this[Slot]
            {
                For each, Member in Button
                    %each% := Member
                BtnString .= (Label ? (Label (Text ? "=" Text : "")
                        .    ":" Icon+1 (Style ? "(" Style ")" : "")) : "") ", "
                If (ArrayOut)
                    BtnArray.Push({Icon: Icon, ID: ID, State: State
                                   , Style: Style, Text: Text, Label: Label})
            }
            return ArrayOut ? BtnArray : RTrim(BtnString, ", ")
        }
;=======================================================================================
;    Method:             Presets.Import
;    Description:        Imports a buttons layout from a string in Add/Insert methods
;                            format and saves it into the specified slot.
;    Parameters:
;        Slot:           Number of the slot in which to save the layout.
;        Options:        Same as Add().
;        Buttons:        Same as Add().
;    Return:             Always TRUE.
;=======================================================================================
        Import(Slot, Options := "Enabled", Buttons*)
        {
            BtnArray := []
            If (Options = "")
                Options := "Enabled"
            For each, Button in Buttons
            {
                If (RegExMatch(Button, "^(\W?)(\w+)[=\s]?(.*)?:(\d+)\(?(.*?)?\)?$", Key))
                {
                    If (Key1)
                        continue
                    idCommand := this.GenerateRandomID()
                ,   iString := Key3, iBitmap := Key4
                ,   Struct := this.DefineBtnStruct(TBBUTTON, iBitmap, idCommand, iString, Key5 ? Key5 : Options)
                ,   Struct.Label := Key2, BtnArray.Push(Struct)
                }
                Else
                    Struct := this.BtnSep(TBBUTTON, Options), BtnArray.Push(Struct)
            }
            this[Slot] := BtnArray
            return true
        }
;=======================================================================================
;    Method:             Presets.Load
;    Description:        Loads a layout from the specified slot.
;    Parameters:
;        Slot:           Number of the slot containing the layout to be loaded.
;                        For convenience and internal operations this parameter can be an
;                            object in the same format of Presets.Save Buttons parameter.
;    Return:             TRUE if the slot contains a layout, or FALSE otherwise.
;=======================================================================================
        Load(Slot)
        {
            If (IsObject(Slot))
                Buttons := Slot
            Else
                Buttons := this[Slot]
            If (!IsObject(Buttons))
                return false
            SendMessage, this.TB_GETROWS, 0, 0,, % "ahk_id " this.tbHwnd
                Rows := ErrorLevel
            SendMessage, this.TB_BUTTONCOUNT, 0, 0,, % "ahk_id " this.tbHwnd
            Loop, % ErrorLevel
                SendMessage, this.TB_DELETEBUTTON, 0, 0,, % "ahk_id " this.tbHwnd
            For each, Button in Buttons
            {
                For each, Member in Button
                    %each% := Member
                If ((Rows > 1) && (Style = this.BTNS_SEP))
                    State := 0x24
                If (Text != "")
                {
                    VarSetCapacity(BTNSTR, (StrPut(Text) * (A_IsUnicode ? 2 : 1), 0))
                ,   StrPut(Text, &BTNSTR, StrPut(Text) * 2)
                    SendMessage, this.TB_ADDSTRING, 0, &BTNSTR,, % "ahk_id " this.tbHwnd
                    Index := ErrorLevel
                }
                VarSetCapacity(TBBUTTON, 8 + (A_PtrSize * 3), 0)
            ,   NumPut(Icon, TBBUTTON, 0, "Int")
            ,   NumPut(ID, TBBUTTON, 4, "Int")
            ,   NumPut(State, TBBUTTON, 8, "Char")
            ,   NumPut(Style, TBBUTTON, 9, "Char")
            ,   NumPut(Index, TBBUTTON, 8 + (A_PtrSize * 2), "Int")
                SendMessage, this.TB_ADDBUTTONS, 1, &TBBUTTON,, % "ahk_id " this.tbHwnd
            }
            return (ErrorLevel = "FAIL") ? false : true
        }
;=======================================================================================
;    Method:             Presets.Save
;    Description:        Saves a buttons layout as a preset into the specified slot. 
;    Parameters:
;        Slot:           Number of the slot in which to save the layout. There is no
;                            predefined limit of slots.
;        Buttons:        Buttons array must be in a valid format. You can use the Export
;                            Toolbar Method (not the Preset Method of the same name)
;                            passing TRUE to the ArrayOut parameter to return a valid
;                            array to be used with this method.
;    Return:             TRUE if Buttons is an object, or FALSE otherwise.
;=======================================================================================
        Save(Slot, Buttons)
        {
            If (IsObject(Buttons))
            {
                this[Slot] := Buttons
                return true
            }
            Else
                return false
        }
    }
;=======================================================================================
;    Private Class       This class is used internally.
;=======================================================================================
    Class Private
    {
;=======================================================================================
;    Private Properties
;=======================================================================================
        ; Messages
        Static TB_ADDBUTTONS            := 0x0414
        Static TB_ADDSTRING             := A_IsUnicode ? 0x044D : 0x041C
        Static TB_AUTOSIZE              := 0x0421
        Static TB_BUTTONCOUNT           := 0x0418
        Static TB_CHECKBUTTON           := 0x0402
        Static TB_COMMANDTOINDEX        := 0x0419
        Static TB_CUSTOMIZE             := 0x041B
        Static TB_DELETEBUTTON          := 0x0416
        Static TB_ENABLEBUTTON          := 0x0401
        Static TB_GETBUTTON             := 0x0417
        Static TB_GETBUTTONSIZE         := 0x043A
        Static TB_GETBUTTONTEXT         := A_IsUnicode ? 0x044B : 0x042D
        Static TB_GETEXTENDEDSTYLE      := 0x0455
        Static TB_GETHOTITEM            := 0x0447
        Static TB_GETIMAGELIST          := 0x0431
        Static TB_GETIMAGELISTCOUNT     := 0x0462
        Static TB_GETITEMDROPDOWNRECT   := 0x0467
        Static TB_GETITEMRECT           := 0x041D
        Static TB_GETMAXSIZE            := 0x0453
        Static TB_GETPADDING            := 0x0456
        Static TB_GETRECT               := 0x0433
        Static TB_GETROWS               := 0x0428
        Static TB_GETSTATE              := 0x0412
        Static TB_GETSTYLE              := 0x0439
        Static TB_GETSTRING             := A_IsUnicode ? :0x045B 0x045C
        Static TB_GETTEXTROWS           := 0x043D
        Static TB_HIDEBUTTON            := 0x0404
        Static TB_INDETERMINATE         := 0x0405
        Static TB_INSERTBUTTON          := A_IsUnicode ? 0x0443 : 0x0415
        Static TB_ISBUTTONCHECKED       := 0x040A
        Static TB_ISBUTTONENABLED       := 0x0409
        Static TB_ISBUTTONHIDDEN        := 0x040C
        Static TB_ISBUTTONHIGHLIGHTED   := 0x040E
        Static TB_ISBUTTONINDETERMINATE := 0x040D
        Static TB_ISBUTTONPRESSED       := 0x040B
        Static TB_MARKBUTTON            := 0x0406
        Static TB_MOVEBUTTON            := 0x0452
        Static TB_PRESSBUTTON           := 0x0403
        Static TB_SETBUTTONINFO         := A_IsUnicode ? 0x0440 : 0x0442
        Static TB_SETBUTTONSIZE         := 0x041F
        Static TB_SETBUTTONWIDTH        := 0x043B
        Static TB_SETDISABLEDIMAGELIST  := 0x0436
        Static TB_SETEXTENDEDSTYLE      := 0x0454
        Static TB_SETHOTIMAGELIST       := 0x0434
        Static TB_SETHOTITEM            := 0x0448
        Static TB_SETHOTITEM2           := 0x045E
        Static TB_SETIMAGELIST          := 0x0430
        Static TB_SETINDENT             := 0x042F
        Static TB_SETLISTGAP            := 0x0460
        Static TB_SETMAXTEXTROWS        := 0x043C
        Static TB_SETPADDING            := 0x0457
        Static TB_SETPRESSEDIMAGELIST   := 0x0468
        Static TB_SETROWS               := 0x0427
        Static TB_SETSTATE              := 0x0411
        Static TB_SETSTYLE              := 0x0438
        ; Styles
        Static TBSTYLE_ALTDRAG      := 0x0400
        Static TBSTYLE_CUSTOMERASE  := 0x2000
        Static TBSTYLE_FLAT         := 0x0800
        Static TBSTYLE_LIST         := 0x1000
        Static TBSTYLE_REGISTERDROP := 0x4000
        Static TBSTYLE_TOOLTIPS     := 0x0100
        Static TBSTYLE_TRANSPARENT  := 0x8000
        Static TBSTYLE_WRAPABLE     := 0x0200
        Static TBSTYLE_ADJUSTABLE   := 0x20
        Static TBSTYLE_BORDER       := 0x800000
        Static TBSTYLE_THICKFRAME   := 0x40000
        Static TBSTYLE_TABSTOP      := 0x10000
        ; ExStyles
        Static TBSTYLE_EX_DOUBLEBUFFER       := 0x80 ; // Double Buffer the toolbar
        Static TBSTYLE_EX_DRAWDDARROWS       := 0x01
        Static TBSTYLE_EX_HIDECLIPPEDBUTTONS := 0x10 ; // don't show partially obscured buttons
        Static TBSTYLE_EX_MIXEDBUTTONS       := 0x08
        Static TBSTYLE_EX_MULTICOLUMN        := 0x02 ; // Intended for internal use; not recommended for use in applications.
        Static TBSTYLE_EX_VERTICAL           := 0x04 ; // Intended for internal use; not recommended for use in applications.
        ; Button states
        Static TBSTATE_CHECKED       := 0x01
        Static TBSTATE_ELLIPSES      := 0x40
        Static TBSTATE_ENABLED       := 0x04
        Static TBSTATE_HIDDEN        := 0x08
        Static TBSTATE_INDETERMINATE := 0x10
        Static TBSTATE_MARKED        := 0x80
        Static TBSTATE_PRESSED       := 0x02
        Static TBSTATE_WRAP          := 0x20
        ; Button styles
        Static BTNS_BUTTON        := 0x00 ; TBSTYLE_BUTTON
        Static BTNS_SEP           := 0x01 ; TBSTYLE_SEP
        Static BTNS_CHECK         := 0x02 ; TBSTYLE_CHECK
        Static BTNS_GROUP         := 0x04 ; TBSTYLE_GROUP
        Static BTNS_CHECKGROUP    := 0x06 ; TBSTYLE_CHECKGROUP  // (TBSTYLE_GROUP | TBSTYLE_CHECK)
        Static BTNS_DROPDOWN      := 0x08 ; TBSTYLE_DROPDOWN
        Static BTNS_AUTOSIZE      := 0x10 ; TBSTYLE_AUTOSIZE    // automatically calculate the cx of the button
        Static BTNS_NOPREFIX      := 0x20 ; TBSTYLE_NOPREFIX    // this button should not have accel prefix
        Static BTNS_SHOWTEXT      := 0x40 ; // ignored unless TBSTYLE_EX_MIXEDBUTTONS is set
        Static BTNS_WHOLEDROPDOWN := 0x80 ; // draw drop-down arrow, but without split arrow section
        ; TB_GETBITMAPFLAGS
        Static TBBF_LARGE   := 0x00000001
        Static TBIF_BYINDEX := 0x80000000 ; // this specifies that the wparam in Get/SetButtonInfo is an index, not id
        Static TBIF_COMMAND := 0x00000020
        Static TBIF_IMAGE   := 0x00000001
        Static TBIF_LPARAM  := 0x00000010
        Static TBIF_SIZE    := 0x00000040
        Static TBIF_STATE   := 0x00000004
        Static TBIF_STYLE   := 0x00000008
        Static TBIF_TEXT    := 0x00000002
        ; Notifications
        Static TBN_BEGINADJUST     := -703
        Static TBN_BEGINDRAG       := -701
        Static TBN_CUSTHELP        := -709
        Static TBN_DELETINGBUTTON  := -715
        Static TBN_DRAGOUT         := -714
        Static TBN_DRAGOVER        := -727
        Static TBN_DROPDOWN        := -710
        Static TBN_DUPACCELERATOR  := -725
        Static TBN_ENDADJUST       := -704
        Static TBN_ENDDRAG         := -702
        Static TBN_GETBUTTONINFO   := -720 ; A_IsUnicode ? -720 : -700
        Static TBN_GETDISPINFO     := A_IsUnicode ? -717 : -716
        Static TBN_GETINFOTIP      := A_IsUnicode ? -719 : -718
        Static TBN_GETOBJECT       := -712
        Static TBN_HOTITEMCHANGE   := -713
        Static TBN_INITCUSTOMIZE   := -723
        Static TBN_MAPACCELERATOR  := -728
        Static TBN_QUERYDELETE     := -707
        Static TBN_QUERYINSERT     := -706
        Static TBN_RESET           := -705
        Static TBN_RESTORE         := -721
        Static TBN_SAVE            := -722
        Static TBN_TOOLBARCHANGE   := -708
        Static TBN_WRAPACCELERATOR := -726
        Static TBN_WRAPHOTITEM     := -724
;=======================================================================================
;    Meta-Functions
;
;    Properties:
;        tbHwnd:            Toolbar's Hwnd.
;        DefaultBtnInfo:    Stores information about button's original structures.
;        Presets:           This is a special object used to save and load buttons
;                               layouts. It has its own methods.
;=======================================================================================
        __New(hToolbar)
        {
            this.tbHwnd := hToolbar
        ,   this.DefaultBtnInfo := []
        ,   this.Presets := {tbHwnd: hToolbar, Base: Toolbar.tbPresets}
        }
;=======================================================================================
        __Delete()
        {
            this.RemoveAt(1, this.Length())
        ,   this.SetCapacity(0)
        ,   this.base := ""
        }
;=======================================================================================
;    Private Methods
;=======================================================================================
;    Method:             SendMessage
;    Description:        Sends a message to create or modify a button.
;=======================================================================================
        SendMessage(Button, Options, Message := "", Param := "")
        {
            If (RegExMatch(Button, "^(\W?)(\w+)[=\s]?(.*)?:(\d+)\(?(.*?)?\)?$", Key))
            {
                idCommand := this.GenerateRandomID()
            ,   iString := Key3, iBitmap := Key4
            ,   this.Labels[idCommand] := Key2
            ,   Struct := this.DefineBtnStruct(TBBUTTON, iBitmap, idCommand, iString, Key5 ? Key5 : Options)
            ,   this.DefaultBtnInfo.Push(Struct)
                If !(Key1) && (Message)
                {
                    SendMessage, Message, Param, &TBBUTTON,, % "ahk_id " this.tbHwnd
                    If (ErrorLevel = "FAIL")
                        return false
                }
            }
            Else
            {
                Struct := this.BtnSep(TBBUTTON, Options), this.DefaultBtnInfo.Push(Struct)
                If (Message)
                {
                    SendMessage, Message, Param, &TBBUTTON,, % "ahk_id " this.tbHwnd
                    If (ErrorLevel = "FAIL")
                        return false
                }
            }
            return true
        }
;=======================================================================================
;    Method:             DefineBtnStruct
;    Description:        Creates a TBBUTTON structure.
;    Return:             An array with the button structure values.
;=======================================================================================
        DefineBtnStruct(ByRef BtnVar, iBitmap := 0, idCommand := 0, iString := "", Options := "")
        {
            If Options is Integer
                tbStyle := Options, tbState := this.TBSTATE_ENABLED
            Else
            {
                Loop, Parse, Options, %A_Space%%A_Tab%
                {
                    If (this[ "TBSTATE_" A_LoopField ])
                        tbState += this[ "TBSTATE_" A_LoopField ]
                    Else If (this[ "BTNS_" A_LoopField ] )
                        tbStyle += this[ "BTNS_" A_LoopField ]
                    Else If (RegExMatch(A_LoopField, "i)W(\d+)-(\d+)", MW))
                    {
                        Long := this.MakeLong(MW1, MW2)
                        SendMessage, this.TB_SETBUTTONWIDTH, 0, Long,, % "ahk_id " this.tbHwnd
                    }
                }
            }
            If (iString != "")
            {
                VarSetCapacity(BTNSTR, (StrPut(iString) * (A_IsUnicode ? 2 : 1), 0))
            ,   StrPut(iString, &BTNSTR, StrPut(iString) * 2)
                SendMessage, this.TB_ADDSTRING, 0, &BTNSTR,, % "ahk_id " this.tbHwnd
                StrIdx := ErrorLevel
            }
            Else
                StrIdx := -1
            VarSetCapacity(BtnVar, 8 + (A_PtrSize * 3), 0)
        ,   NumPut(iBitmap-1, BtnVar, 0, "Int")
        ,   NumPut(idCommand, BtnVar, 4, "Int")
        ,   NumPut(tbState, BtnVar, 8, "Char")
        ,   NumPut(tbStyle, BtnVar, 9, "Char")
        ,   NumPut(StrIdx, BtnVar, 8 + (A_PtrSize * 2), "Ptr")
            return {Icon: iBitmap-1, ID: idCommand, State: tbState
                   , Style: tbStyle, Text: iString, Label: this.Labels[idCommand]}
        }
;=======================================================================================
;    Method:             DefineBtnInfoStruct
;    Description:        Creates a TBBUTTONINFO structure for a specific member.
;=======================================================================================
        DefineBtnInfoStruct(ByRef BtnVar, Member, ByRef Value)
        {
            Static cbSize := 16 + (A_PtrSize * 4)
            
            VarSetCapacity(BtnVar, cbSize, 0)
        ,   NumPut(cbSize, BtnVar, 0, "UInt")
            If (this[ "TBIF_" Member] )
                dwMask := this[ "TBIF_" Member ]
            ,   NumPut(dwMask, BtnVar, 4, "UInt")
            If (dwMask = this.TBIF_COMMAND)
                NumPut(Value, BtnVar, 8, "Int") ; idCommand
            Else If (dwMask = this.TBIF_IMAGE)
                Value := Value-1
            ,   NumPut(Value, BtnVar, 12, "Int") ; iImage
            Else If (dwMask = this.TBIF_STATE)
                Value := (this[ "TBSTATE_" Value ]) ? this[ "TBSTATE_" Value ] : Value
            ,   NumPut(Value, BtnVar, 16, "Char") ; fsState
            Else If (dwMask = this.TBIF_STYLE)
                Value := (this[ "BTNS_" Value ]) ? this[ "BTNS_" Value ] : Value
            ,   NumPut(Value, BtnVar, 17, "Char") ; fsStyle
            Else If (dwMask = this.TBIF_SIZE)
                NumPut(Value, BtnVar, 18, "Short") ; cx
            Else If (dwMask = this.TBIF_TEXT)
                NumPut(&Value, BtnVar, 16 + (A_PtrSize * 2), "UPtr") ; pszText
        }
;=======================================================================================
;    Method:             BtnSep
;    Description:        Creates a TBBUTTON structure for a separator.
;    Return:             An array with the button structure values.
;=======================================================================================
        BtnSep(ByRef BtnVar, Options := "")
        {
            tbStyle := this.BTNS_SEP
            Loop, Parse, Options, %A_Space%%A_Tab%
            {
                If (this[ "TBSTATE_" A_LoopField ])
                    tbState += this[ "TBSTATE_" A_LoopField ]
            }
            VarSetCapacity(BtnVar, 8 + (A_PtrSize * 3), 0)
        ,   NumPut(tbState, BtnVar, 8, "Char")
        ,   NumPut(tbStyle, BtnVar, 9, "Char")
            return {Icon: -1, ID: "", State: tbState, Style: tbStyle, Text: "", Label: ""}
        }
;=======================================================================================
;    Method:             GenerateRandomID
;    Description:        Returns a random number to be used as Command ID.
;=======================================================================================
        GenerateRandomID()
        {
            While, (!Number || this.Labels.HasKey(Number))
                Random, Number, 1, 9999
            return Number
        }
;=======================================================================================
;    Method:             MakeLong
;    Description:        Creates a LongWord from a LoWord and a HiWord.
;=======================================================================================
        MakeLong(LoWord, HiWord)
        {
            return (HiWord << 16) | (LoWord & 0xffff)
        }
;=======================================================================================
;    Method:             MakeLong
;    Description:        Extracts LoWord and HiWord from a LongWord.
;=======================================================================================
        MakeShort(Long, ByRef LoWord, ByRef HiWord)
        {
            LoWord := Long & 0xffff
        ,   HiWord := Long >> 16
        }
    }
}
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
;===== Copy The Following Functions To Your Own Code Just once =====


; Note: parameters of the X,Y is the center of the coordinates,
; and the W,H is the offset distance to the center,
; So the search range is (X-W, Y-H)-->(X+W, Y+H).
; err1 is the character "0" fault-tolerant in percentage.
; err0 is the character "_" fault-tolerant in percentage.
; Text can be a lot of text to find, separated by "|".
; ruturn is a array, contains the X,Y,W,H,Comment results of Each Find.
/*


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
*/
