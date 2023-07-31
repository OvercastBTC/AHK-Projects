;=======================================================================================================================
; .............: Begin Section
; Section .....: Auto-Execution
;=======================================================================================================================
; #Warn  ; Enable warnings to assist with detecting common errors.
; SetWinDelay 0 ; (AJB - 06/2023) - comment out for testing
; SetControlDelay 0 ; (AJB - 06/2023) - comment out for testing
; REMOVED: ; SetBatchLines, -1 ; scrip run speed, The value -1 = max speed possible. ; (AJB - 05/2023)comment out for testing
; https://www.autohotkey.com/docs/v1/lib/SetBatchLines.htm
; SetWinDelay, -1 ; (AJB - 05/2023) - comment out for testing
; SetControlDelay, -1 ; (AJB - 05/2023) - comment out for testing
; REMOVED: ;#MaxMem 4095 ; Allows the maximum amount of MB per variable.
;#MaxThreads 255 ; Allows a maximum of 255 instead of default threads.
; REMOVED: #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.; Avoids checking empty variables to see if they are environment variables.
Persistent ; Keeps script permanently running
#SingleInstance Force
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.
SetTitleMatchMode(2) ; sets title matching to search for "containing" instead of "exact"
DetectHiddenText(true)
DetectHiddenWindows(true)
#Requires Autohotkey v2.0
; --------------------------------------------------------------------------------
; #Include, <AHK-libs-and-classes-collection-master\libs\o-z\Toolbar>
Startup_Shortcut := A_Startup "\" A_ScriptName ".lnk"
; --------------------------------------------------------------------------------
; #Include <AHK-libs-and-classes-collection-master\libs\g-n\gdip>
; --------------------------------------------------------------------------------
; Description ..: Horizon Button == A Horizon function library
; Description ..: This library is a collection of functions and buttons that deal with missing interfaces with Horizon.
; AHK Version ..: AutoHotkey 1+
; Author .......: Overcast (Adam Bacon), Terry Keatts, and special assistance from Descolada
; License ......: WTFPL - http://www.wtfpl.net/txt/copying/

;TraySetIcon("HznHorizon.ico")
; //TODO: 2023.07.17 ...: Work on the below but consider if needed due to new FreeLibraryAndExitThread
; //TODO: Library_Load(winuser.dll)
; //TODO: Library_Load(processthreadsapi.dll)
; //TODO: Library_Load(memoryapi.dll)

; --------------------------------------------------------------------------------
; Sub-Section .....: Script Name, Startup Path, and icon
; --------------------------------------------------------------------------------
; --------------------------------------------------------------------------------
; Sub-Section .....: Create Icon File
; Description .....: Base64 icon string
; Author ..........: Hellbent
; Variable ........: icostr
; Function ........: MyIcon_B64()
; Reference .......: https://www.autohotkey.com/boards/viewtopic.php?f=76&t=101960&p=527471#p527471
; --------------------------------------------------------------------------------
; TODO [ ] This is not loading the ICON via the B64
; fix
; bug
; ; Note: ............: Load the GDI+ lib
; Gdip_Startup()
; ; Note: ............: The Base 64 string for the icon image
; ; .................: This was moved to the end of the script via MyIcon_B64()
; icostr := MyIcon_B64()
; ; Note: ............: create a pBitmap from the Base 64 string.
; HznIcon_pBitmap := B64ToPBitmap( icostr )
; ; Note: ............: create a hBitmap from the icon pBitmap
; HznIcon_hIcon := Gdip_CreateHICONFromBitmap( HznIcon_pBitmap )
; ; Note: ............: Dispose of the icon pBitmap to free memory.
; Gdip_DisposeImage( HznIcon_pBitmap )
; ; Note: ............: Set the icon
; ; Menu, Tray, Icon, HICON:%HznIcon_hIcon%
ICON := "HznHorizon.ico"
; //TraySetIcon("C:\Users\bacona\AppData\Local\AutoHotKey\v2\Lib\HznHorizon.ico")
; --------------------------------------------------------------------------------
; Sub-Section .....: Create Tray Menu
; --------------------------------------------------------------------------------
; buildTrayMenu()
; buildTrayMenu()
; {
TraySetIcon(ICON) ; this changes the icon into a little Horizon thing.
; Tray:= A_TrayMenu
; Tray.Delete() ; V1toV2: not 100% replacement of NoStandard, Only if NoStandard is used at the beginning
; addTrayMenuOption("Made with nerd by Adam Bacon and Terry Keatts", "madeBy")
; addTrayMenuOption()
; addTrayMenuOption("Run at startup", "runAtStartup")
; Tray.% fileExist(Startup_Shortcut) ? "Check" : "Uncheck"("Run at startup") ; update the tray menu status on startup
; addTrayMenuOption()
; Tray.AddStandard()
; }

; ********************************************** ... First Return ... **************************************************

; ********************************************** ... First Return ... **************************************************

; ...............: End Sub-Section
;=======================================================================================================================
; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

#HotIf WinActive("ahk_exe hznhorizon.exe", )

; --------------------------------------------------------------------------------
; Function .....: Horizon {Enter} ==> Select Option
; Description ..: Hotkeys (shortcuts) sending {Enter} in leu of "Double Click"
; Author .......: Overcast (Adam Bacon)
; TODO .........: Still doesn't work. Might have to not use the WinActive() function
; --------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe hznhorizonmgr.exe") or WinActive("ahk_exe hznhorizon.exe")
{
	fCtl := ControlGetClassNN(ControlGetFocus("A"))
	hCtl := ControlGethWnd(fCtl, "A")
	Shift & Enter::DllCall("PostMessage", "Ptr", Ctl, "UInt", 0x0203, "Ptr", 0, "Ptr", 0)
}
return
#HotIf

; --------------------------------------------------------------------------------
; Function .....: Horizon Buttons/Hotkeys
; Description ..: Hotkeys (shortcuts) for normal Windows hotkeys: CTRL+I (italics) ; CTRL+B (bold) ; CTRL+A (select all)
; . Continued ..: CTRL+U (underline) - Where Applicable - else same as CTRL+B (I dunno why).
; . Continued ..: In ideal land, this will be a single function call. Right now this works.
; Author .......: Overcast (Adam Bacon)
; fixed .........: Reduce to a single HznButton function call
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
; --------------------------------------------------------------------------------

; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Horizon Button Function <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; --------------------------------------------------------------------------------
; Function .....: Horizon Hotkeys - Italic, Bold, and Underline (***where applicable***)
; ChangeLog ....: 06/05/2023 - CTRL+I and CTRL+B validated for all screens
; . Continued ..: CTRL+U only valid for screens which have it listed as a button, else it reverts to CTRL+B or CTRL+I
; --------------------------------------------------------------------------------
#HotIf WinActive("ahk_exe hznhorizon.exe")

^i::button()
^b::button()
^u::button()
button(){
    SendLevel(50)
    fCtl := ControlGetClassNN(ControlGetFocus("A"))
    bID := SubStr(fCtl, -1, 1)
    hToolbar := ControlGethWnd("msvb_lib_toolbar" bID, "A")
    hIDx := A_ThisHotkey = "^i" ? 2 ; ..............: italic = 2
          : A_ThisHotkey = "^b" ? 1 ; ..............: bold = 1
          : A_ThisHotkey = "^u" ? 3 : 9 ;10 ; .........: underline = 9 and 10 (if available, else italic or bold)
    HznButton(hToolbar,hIDx)
}
; TODO Test stuff for above function
; Global X := NumGet(RECT, 0, "int"),
; Global Y := NumGet(RECT, 4, "int"),
; Global W := NumGet(RECT, 8, "int")-X,
; Global H := NumGet(RECT, 12, "int")-Y ;, prevDelay := A_ControlDelay
; Global x1 := NumGet(rect, 0, "Int") 
; Global x2 := NumGet(rect, 8, "Int") 
; Global y1 := NumGet(rect, 4, "Int") 
; Global y2 := NumGet(rect, 12,"Int")
; Global X, Y, W, H, x1, x2, y1, y2 ;, ctrlh, ctrlw, ctrlx, ctrly
; ctrlh:="", ctrlw:="", ctrlx:="", ctrly:="", x1 :="", x2 :="", y1 :="", y2 :=""
; ControlGetPos, ctrlx, ctrly, ctrlw, ctrlh,, % "ahk_id " hToolbar

; xCtl := ctrlx - (x2+x1//2)
; yCtl := ctrly - (y2+y1//2)

; MouseMove xCtl, yCtl
; ; ControlClick, % "x" x " y" y,% "ahk_id " hToolbar,,,, NA 
; ControlClick, % "x" xCtl " y" yCtl,% "ahk_id " hToolbar,,,, NA 
; ; ControlClick, % "x" (X+W//2) " y" (Y+H//2), % "ahk_id " hToolbar,,,, NA
; MouseMove, % "x" (X+W//2), % "y" (Y+H//2), 
; MouseMove % ctrlx + (x2+x1//2), ctrly + (y2+y1//2)
; MouseMove, % "x" W, % "y" H
; --------------------------------------------------------------------------------
; Function .....: Horizon Hotkeys - Cut, Copy, Paste, Undo, Redo
; ChangeLog ....: 06/05/2023 - Validated for the Human Element Screen only. Commented out due to irratic behavior.
; --------------------------------------------------------------------------------
/*
^x::
^c::
^v::
^z::
^y::
{ ; V1toV2: Added bracket
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
; --------------------------------------------------------------------------------
; Function .....: Horizon Hotkey - Select-All (Ctrl-A)
; --------------------------------------------------------------------------------
} ; V1toV2: Added Bracket before hotkey or Hotstring

^a::HznSelectAll()

HznSelectAll()
{
    Static Msg := EM_SETSEL := 177, wParam := 0, lParam := -1
	fCtl := ControlGetClassNN(ControlGetFocus("A"))
    hCtl := ControlGethWnd(fCtl, "A")
    DllCall("SendMessage", "Ptr", hCtl, "UInt", Msg, "UInt", wParam, "UIntP", &lParam)
}

; --------------------------------------------------------------------------------
; Function .....: HznButton()
; Description ..: Find and Control-Click the Horizon msvb_lib_toolbar buttons
; Definition ...: hWndToolbar = the toolbar window's handle
; Definition ...: n = the index for the specified button
; Author .......: Descolada, Overcast (Adam Bacon)
; --------------------------------------------------------------------------------
SendMessage(hWnd, Msg, wParam, lParam)
{
	return DllCall("SendMessage", "UInt", hWnd, "UInt", Msg, "UInt", wParam, "UInt", lParam)
}
HznButton(hToolbar, n)
{
;   Step: set the Static variables
    Static TB_BUTTONCOUNT  := 1048 ; 0x0418
    Static TB_GETBUTTON    := 1047 ; 0x417,
    Static TB_GETITEMRECT  := 1053 ; 0x41D,
    Static MEM_COMMIT      := 4096 ; 0x1000, ; 0x00001000, ; via MSDN Win32 
    Static MEM_RESERVE     := 8192 ; 0x2000, ; 0x00002000, ; via MSDN Win32
    Static MEM_PHYSICAL    := 4 ; 0x04    ; 0x00400000, ; via MSDN Win32
    Static MEM_PROTECT     := 64 ; 0x40 ;  
    Static MEM_RELEASE     := 32768 ; 0x8000 ;  
;   [in]   SIZE_T dwSize, ; The size of the region of memory to allocate, in bytes.
    Static  dwSize          := 32  
;   Step: count and load all the msvb_lib_toolbar buttons into memory
	; SendMessage, TB_BUTTONCOUNT, 0, 0,,% "ahk_id " hToolbar
	; buttonCount := ErrorLevel
    ; buttonCount := HznButtonCount( hToolbar )
    buttonCount := HznButtonCount( hToolbar )
	if (n >= 1 && n <= buttonCount) {
		; Step: Get the PIDfromHwnd() using DllCall
		DllCall("GetWindowThreadProcessId", "Ptr", hToolbar, "UIntP", &targetProcessID)

		; Step Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
		hProcess := DllCall("OpenProcess", "UInt", 0x0018 | 0x0010 | 0x0020, "Int", 0, "UInt", targetProcessID, "Ptr")

		; ; Allocate memory for the TBBUTTON structure in the target process's address space
		; remoteMemory := DllCall("VirtualAllocEx", "Ptr", hProcess, "Ptr", 0, "UPtr", 16, "UInt", 0x1000, "UInt", 0x04, "Ptr")
        ; Step: Allocate memory for the TBBUTTON structure in the target process's address space
		; Reference: https://learn.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-virtualallocex
		; Description: LPVOID VirtualAllocEx(
        remoteMemory := DllCall("VirtualAllocEx"        , "Ptr",    hProcess        , "Ptr",    0
        , "UPtr",   dwSize        , "UInt",   MEM_COMMIT | MEM_RESERVE        , "UInt",   MEM_PHYSICAL        , "Ptr",    MEM_PROTECT)        ; , "UPtr",      16                     ; [in]           SIZE_T dwSize, ; The size of the region of memory to allocate, in bytes.
        ; , "Ptr") ; original
        ; If the pages are being committed, you can specify any one of the memory protection constants
        ; reference <https://learn.microsoft.com/en-us/windows/win32/Memory/memory-protection-constants>.
		ErrorLevel := SendMessage(TB_GETITEMRECT, n-1, remoteMemory, , "ahk_id " hToolbar)
        ; SendMessage(hToolbar,TB_GETITEMRECT, &(n-1), remoteMemory)
		RECT := Buffer(dwSize, 0) ; V1toV2: if 'RECT' is a UTF-16 string, use 'VarSetStrCapacity(&RECT, dwSize)'
		DllCall("ReadProcessMemory", "Ptr", hProcess, "Ptr", remoteMemory, "Ptr", RECT, "UPtr", dwSize, "UIntP", &bytesRead, "Int")
        DllCall("VirtualFreeEx", "UInt", hProcess, "UInt", remoteMemory, "UInt", 0, "UInt", MEM_RELEASE)
		
        ; get the bounding rectangle for the specified button
        ControlGetPos(&ctrlx, &ctrly, &ctrlw, &ctrlh, , "ahk_id " hToolbar)
		X := NumGet(RECT, 0, "int"),
        Y := NumGet(RECT, 4, "int"),
        W := NumGet(RECT, 8, "int") - X,
        H := NumGet(RECT, 12, "int") - Y,
        ; prevDelay := A_ControlDelay ;,

		ControlClick("x" (X+W//2) " y" (Y+H//2), "ahk_id " hToolbar, , , , "NA")
		;SetControlDelay, %prevDelay%
	} else {
		MsgBox("The specified index " n " is out of range. Please specify a valid index between 1 and " buttonCount ".", "Error", 48)
	}
	DllCall("FreeLibrary", "Ptr", hProcess) ; added 06.23.2023
	DllCall("FreeLibrary", "Ptr", remoteMemory) ; added 06.23.2023
	DllCall("CloseHandle", "Ptr", hToolbar) ; added 06.23.2023
}

HznButtonCount( hToolbar )
{
    Static TB_BUTTONCOUNT  := 1048 ; 0x0418
    ErrorLevel := SendMessage(TB_BUTTONCOUNT, 0, 0, , "ahk_id " hToolbar)
	buttonCount := ErrorLevel
    Return buttonCount
}
#6::
{ ; V1toV2: Added bracket
#Warn All, OutputDebug
SendLevel(1)
fCtl := ControlGetClassNN(ControlGetFocus("A"))
bID:= SubStr(fCtl, -1, 1)
; ControlGet, ctrlhwnd, hWnd,,% "msvb_lib_toolbar" bID, A
; EnumToolbarButtons(ctrlhwnd)
hCtl := ControlGethWnd("msvb_lib_toolbar" bID, "A")


return
} ; Added bracket before function

EnumToolbarButtons(ctrlhwnd) ;, is_apply_scale:=false)
{
    ; Step: set the Static variables
    Static TB_GETBUTTON    := 0x417,
    Static TB_GETITEMRECT  := 0x41D,
    Static MEM_COMMIT      := 0x1000, ; 0x00001000, ; via MSDN Win32 
    Static MEM_RESERVE     := 0x2000, ; 0x00002000, ; via MSDN Win32
    Static MEM_PHYSICAL    := 0x04    ; 0x00400000, ; via MSDN Win32
    ; [in]   SIZE_T dwSize, ; The size of the region of memory to allocate, in bytes.
    Static  dwSize          := 128  
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

    ControlGetPos(&ctrlx, &ctrly, &ctrlw, &ctrlh, , "ahk_id " ctrlhwnd)

; MsgBox % "X: "ctrlx " Y: "ctrly " W: " ctrlw " H: " ctrlh ; 06.25.2023 .. THIS WORKS!!!
; MouseMove, ctrlx, ctrly ; 06.25.2023 .. THIS WORKS!!! It actually moves the mouse to the right location!!!
; pid_target := ""

; pid_target := DllCall( "GetWindowThreadProcessId", "Ptr", ctrlhwnd)
; DllCall( "GetWindowThreadProcessId", "Ptr", ctrlhwnd, "UIntP", pid_target)
; pid_target := DllCall( "GetWindowThreadProcessId", "Ptr", ctrlhwnd, "UIntP", pid_target)
;                  , "UIntP") ;, pid_target)
; OutputDebug, % "pid_target: " . pid_target

    pid_target := WinGetPID("ahk_id " ctrlhwnd) ; ==> replaced with above DllCall()
; Open the target process with PROCESS_VM_OPERATION, PROCESS_VM_READ, and PROCESS_VM_WRITE access
    hpRemote := DllCall( "OpenProcess" 
;                  , "uint", 0x18                    , "UInt", 0x0018 | 0x0010 | 0x0020                    , "Int", false                    , "UInt", pid_target )    ; PROCESS_VM_OPERATION|PROCESS_VM_READ ; ==> original

; hpRemote: Remote process handle
    if(!hpRemote) {
        ToolTip("Autohotkey: Cannot OpenProcess(pid=" . pid_target . ")")
        return
    }
; Allocate memory for the TBBUTTON structure in the target process's address space

    remote_buffer := DllCall( "VirtualAllocEx" 
                        , "Ptr", hpRemote                        ; , "UInt", hpRemote     ; == original
                        , "Ptr", 0                        ; , "Ptr", hProcess      ; ==> from HznButton()
                        ; , "Ptr", 0 ; ==> from HznButton() => same
                        , "UPtr", 16                        , "UInt", 0x1000                        ; , "UInt", 0x1000        ; size to allocate, 4KB
                        ; , "UInt", 0x1000       ; ==> from HznButton() => same
                        , "UInt", 0x04                        , "Ptr")                        ; , "UInt", 0x4)          ; PAGE_READWRITE

    x1 :="", x2 :="", y1 :="", y2 :=""

; WM_USER                 := 0x400,
; , TB_GETSTATE           := WM_USER+18
; , TB_GETBITMAP           := WM_USER+44 ; only for test
; , TB_GETBUTTONSIZE      := WM_USER+58 ; only for test
; , TB_GETBUTTON          := WM_USER+23
; , TB_GETBUTTONTEXTA     := WM_USER+45 ; I always get UTF-16 string from the toolbar // ANSI: WM_USER+45
; , TB_GETBUTTONTEXTW     := WM_USER+75 ; I always get UTF-16 string from the toolbar // ANSI: WM_USER+45
; , TB_GETITEMRECT        := WM_USER+29
; , TB_BUTTONCOUNT        := WM_USER+24 ; or 0x418 (hex)
    Static TB_BUTTONCOUNT           := 0x0418
; , WM_GETDLGCODE         := 135        ;(decimal) or 0x0087 (hex)
; , WM_NEXTDLGCTL         := 40         ;(decimal) or 0x0028 (hex)
; , TB_COMMANDTOINDEX     := 1049       ;(decimal) or 0x0419 (hex)
; , TB_GETBUTTONINFOW     := 1087       ;(decimal) or 0x043f (hex)	


    Msg := TB_BUTTONCOUNT, wParam := 0, lParam := 0, control := ""
    ErrorLevel := SendMessage(Msg, wParam, lParam, control, "ahk_id " ctrlhwnd)
    buttons := ErrorLevel
    OutputDebug("buttons: " . buttons . "`n") ;tooltip, buttons=%buttons%	 ; OK
	
    rect := Buffer(16, 0)  ; V1toV2: if 'rect' is a UTF-16 string, use 'VarSetStrCapacity(&rect, 16)'
    BtnStruct := Buffer(32, 0) ; Winapi TBBUTTON struct(32 bytes on x64, 20 bytes on x86) ; V1toV2: if 'BtnStruct' is a UTF-16 string, use 'VarSetStrCapacity(&BtnStruct, 32)'
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
	
	Loop buttons
	{
		; Try to get button text. Two steps: 
		; 1. get command-id from button-index,
		; 2. get button text from command-id
		ErrorLevel := SendMessage(TB_GETBUTTON, A_Index-1, remote_buffer, , "ahk_id " ctrlhwnd)
		ReadRemoteBuffer(hpRemote, remote_buffer, BtnStruct, 32)
		OutputDebug("BtnStruct: " BtnStruct "`n")
		idButton := NumGet(BtnStruct, 4, "IntP")
        OutputDebug("idButton: " . idButton . "`n")
		
		ErrorLevel := SendMessage(TB_COMMANDTOINDEX, idButton, 0, , "ahk_id " ctrlhwnd) ; hope that 4KB is enough ; just a test
		btnvar1 := ErrorLevel
		OutputDebug("Cmd2Indx: " . btnvar1 . "`n")

		ErrorLevel := SendMessage(TB_GETBUTTONINFOW, btnvar1, remote_buffer, , "ahk_id " ctrlhwnd) ; hope that 4KB is enough ; just a test
		; SendMessage,% TBN_GETBUTTONINFO,% btnvar1,remote_buffer,, % "ahk_id " ctrlhwnd ; hope that 4KB is enough ; just a test
		btnvar2 := % " Info:" . ErrorLevel

		ErrorLevel := SendMessage(TB_GETSTATE, idButton, 0, , "ahk_id " ctrlhwnd) ; hope that 4KB is enough ; just a test
		btnstate := ErrorLevel
        OutputDebug("btnstate: " . btnstate . "`n")

		ErrorLevel := SendMessage(TB_GETBUTTONTEXT, idButton, remote_buffer, , "ahk_id " ctrlhwnd) ; hope that 4KB is enough
		btntextcharsW := ErrorLevel
        OutputDebug("btntextcharsW: " . btntextcharsW . "`n")
    
		; if (btntextcharsW>0){
		if (btntextcharsW){
			btntextbytes := 1 ? btntextcharsW*2 : btntextcharsW
			BtnTextBuf := Buffer(btntextbytes+2, 0) ; +2 is for trailing-NUL ; V1toV2: if 'BtnTextBuf' is a UTF-16 string, use 'VarSetStrCapacity(&BtnTextBuf, btntextbytes+2)'
			ReadRemoteBuffer(hpRemote, remote_buffer, BtnTextBuf, btntextbytes)
			bTxtW := StrGet(BtnTextBuf,,"UTF-16")
            OutputDebug("bTxtW: " . bTxtW . "`n")
		} else {
			bTxtW := ""
		}
        OutputDebug("bTxtW: " . bTxtW . "`n")
    
    /*

    SendMessage, % TB_GETBUTTONTEXTA, % idButton, remote_buffer, , % "ahk_id " ctrlhwnd ; hope that 4KB is enough
		btntextcharsA := ErrorLevel
    OutputDebug, % "btntextcharsA: " . btntextcharsA . "`n"
    
		if(btntextcharsA>0){
    btntextbytes := A_IsUnicode ? btntextcharsA*2 : btntextcharsA
			VarSetCapacity(BtnTextBuf, btntextbytes+2, 0) ; +2 is for trailing-NUL
			ReadRemoteBuffer(hpRemote, remote_buffer, BtnTextBuf, btntextbytes)
			bTxtA := StrGet(&BtnTextBuf,99,0)
		} else {
    bTxtA := ""
		}
    OutputDebug, % "bTxtA: " . bTxtA . "`n"
    */
		
    ;FileAppend, % A_Index . ":" . idButton . "(" . btntextchars . ")" . BtnText . "`n", _emeditor_toolbar_buttons.txt ; debug
		
		ErrorLevel := SendMessage(TB_GETITEMRECT, A_Index-1, remote_buffer, , "ahk_id " ctrlhwnd)
		
		ReadRemoteBuffer(hpRemote, remote_buffer, rect, 32)
		oldx1:=x1
		oldx2:=x2
		oldy1:=y1
		x1 := NumGet(rect, 0, "Int") 
		x2 := NumGet(rect, 8, "Int") 
		y1 := NumGet(rect, 4, "Int") 
		y2 := NumGet(rect, 12, "Int")
		
		FileAppend(A_Index . ":" . idButton . "(" . btntextcharsW . ")" . " bTxtW: " . bTxtW . " State: " btnstate . btnvar1 . btnvar2 . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . " ErrorLevel: " ErrorLevel . "`n", "_emeditor_toolbar_buttons.txt")  ; debug
		OutputDebug(A_Index . ":" . idButton . "(" . btntextcharsW . ")" . " bTxtW: " . bTxtW . " State: " btnstate . " 1:"btnvar1 . " 2:"btnvar2 . " X1: " x1 . " X2: " x2 . " Y1: " y1 . " Y2: " y2 . " ErrorLevel: " ErrorLevel . "`n")                                 ; debug
    
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
		
        arbtn.Insert({"x": x1, "y": 1, "w": x2-x1, "h": y2-y1, "cmd": idButton, "text": bTxtW})
        ;arbtn.Insert( {"x":x1, "y":y1, "w":x2-x1, "h":y2-y1, "cmd":idButton, "text":BtnText} )
        ;line:=100000000+Floor((ctrly+y1)/same)*10000+(ctrlx+x1)
        ;lines=%lines%%line%%A_Tab%%ctrlid%%A_Tab%%class%`n
        arbtn := ({"x":x1, "y":y1, "w":x2-x1, "h":y2-y1, "cmd":idButton, "text":bTxtW})
        For key, value in arbtn
            {
                FileAppend("Key :" . key . " = " . " Value: " . value . "`n", "_arbtn.txt")
            }
	}
	result := DllCall("VirtualFreeEx", "UInt", hpRemote, "UInt", remote_buffer, "UInt", 0, "UInt", 0x8000)
	result := DllCall("CloseHandle", "UInt", hpRemote)
	return arbtn
}

ReadRemoteBuffer(hpRemote, RemoteBuffer, &LocalVar, bytes) {
	result := DllCall("ReadProcessMemory", "Ptr", hpRemote, "Ptr", RemoteBuffer, "Ptr", LocalVar, "UInt", bytes, "UInt", 0) 
}

#HotIf

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
        If (!Buttons.Length)
        {
            Struct := this.BtnSep(TBBUTTON, Options), this.DefaultBtnInfo.Push(Struct)
            if (type(TBBUTTON)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
               ErrorLevel := SendMessage(this.TB_ADDBUTTONS, 1, TBBUTTON, , "ahk_id " this.tbHwnd)
            } else{
               ErrorLevel := SendMessage(this.TB_ADDBUTTONS, 1, StrPtr(TBBUTTON), , "ahk_id " this.tbHwnd)
            }
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
        PostMessage(this.TB_AUTOSIZE, 0, 0, , "ahk_id " this.tbHwnd)
        return ErrorLevel ? false : true
    }
;=======================================================================================
;    Method:             Customize
;    Description:        Displays the Customize Toolbar dialog box.
;    Return:             TRUE if successful, FALSE if there was a problem.
;=======================================================================================
    Customize()
    {
        ErrorLevel := SendMessage(this.TB_CUSTOMIZE, 0, 0, , "ahk_id " this.tbHwnd)
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
            Loop this.GetCount()
                this.Delete(1)
        }
        Else
            ErrorLevel := SendMessage(this.TB_DELETEBUTTON, Button-1, 0, , "ahk_id " this.tbHwnd)
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
        Loop this.GetCount()
        {
            this.GetButton(A_Index, ID, Text, State, Style, Icon)        ,   Label := this.Labels[ID], IncLabels .= Label ":"        ,   cString := (Label ? (Label (Text ? "=" Text : "")                    .    ":" Icon (Style ? "(" Style ")" : "")) : "") ", "        ,   BtnString .= cString
            If (ArrayOut)
                BtnArray.Push({Icon: Icon-1, ID: ID, State: State                                , Style: Style, Text: Text, Label: Label})
        }
        For i, Button in this.DefaultBtnInfo
        {
            If (!InStr(IncLabels, ":" (Label := this.Labels[Button.ID]) ":"))
            {
                If (!Label)
                    continue
                oString := Label (Button.Text ? "=" Button.Text : "")                        .    ":" Button.Icon+1 (Button.Style ? "(" Button.Style ")" : "")
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
    Get(&HotItem := "", &TextRows := "", &Rows := ""    ,   &BtnWidth := "", &BtnHeight := "", &Style := "", &ExStyle := "")
    {
        ErrorLevel := SendMessage(this.TB_GETHOTITEM, 0, 0, , "ahk_id " this.tbHwnd)
            HotItem := (ErrorLevel = 4294967295) ? 0 : ErrorLevel+1
        ErrorLevel := SendMessage(this.TB_GETTEXTROWS, 0, 0, , "ahk_id " this.tbHwnd)
            TextRows := ErrorLevel
        ErrorLevel := SendMessage(this.TB_GETROWS, 0, 0, , "ahk_id " this.tbHwnd)
            Rows := ErrorLevel
        ErrorLevel := SendMessage(this.TB_GETBUTTONSIZE, 0, 0, , "ahk_id " this.tbHwnd)
            this.MakeShort(ErrorLevel, BtnWidth, BtnHeight)
        ErrorLevel := SendMessage(this.TB_GETSTYLE, 0, 0, , "ahk_id " this.tbHwnd)
            Style := ErrorLevel
        ErrorLevel := SendMessage(this.TB_GETEXTENDEDSTYLE, 0, 0, , "ahk_id " this.tbHwnd)
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
    GetButton(Button, &ID := "", &Text := "", &State := "", &Style := ""    ,   &Icon := "", &Label := "", &Index := "")
    {
        BtnVar := Buffer(8 + (A_PtrSize * 3), 0) ; V1toV2: if 'BtnVar' is a UTF-16 string, use 'VarSetStrCapacity(&BtnVar, 8 + (A_PtrSize * 3))'
        if (type(BtnVar)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
           ErrorLevel := SendMessage(this.TB_GETBUTTON, Button-1, BtnVar, , "ahk_id " this.tbHwnd)
        } else{
           ErrorLevel := SendMessage(this.TB_GETBUTTON, Button-1, StrPtr(BtnVar), , "ahk_id " this.tbHwnd)
        }
        ID := NumGet(&BtnVar, 4, "Int"), Icon := NumGet(&BtnVar, 0, "Int")+1    ,   State := NumGet(&BtnVar, 8, "Char"), Style := NumGet(&BtnVar, 9, "Char")    ,   Index := NumGet(&BtnVar, 8 + (A_PtrSize * 2), "Int"), Label := this.Labels[ID]
        ErrorLevel := SendMessage(this.TB_GETBUTTONTEXT, ID, 0, , "ahk_id " this.tbHwnd)
        Buffer := Buffer(ErrorLevel * (1 ? 2 : 1), 0) ; V1toV2: if 'Buffer' is a UTF-16 string, use 'VarSetStrCapacity(&Buffer, ErrorLevel * (A_IsUnicode ? 2 : 1))'
        if (type(Buffer)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
           ErrorLevel := SendMessage(this.TB_GETBUTTONTEXT, ID, Buffer, , "ahk_id " this.tbHwnd)
        } else{
           ErrorLevel := SendMessage(this.TB_GETBUTTONTEXT, ID, StrPtr(Buffer), , "ahk_id " this.tbHwnd)
        }
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
    GetButtonPos(Button, &OutX := "", &OutY := "", &OutW := "", &OutH := "")
    {
        this.GetButton(Button, BtnID), RECT := Buffer(16, 0) ; V1toV2: if 'RECT' is a UTF-16 string, use 'VarSetStrCapacity(&RECT, 16)'
        if (type(RECT)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
           ErrorLevel := SendMessage(this.TB_GETRECT, BtnID, RECT, , "ahk_id " this.tbHwnd)
        } else{
           ErrorLevel := SendMessage(this.TB_GETRECT, BtnID, StrPtr(RECT), , "ahk_id " this.tbHwnd)
        }
        OutX := NumGet(&RECT, 0, "Int"), OutY := NumGet(&RECT, 4, "Int")    ,   OutW := NumGet(&RECT, 8, "Int") - OutX, OutH := NumGet(&RECT, 12, "Int") - OutY
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
        ErrorLevel := SendMessage(Msg, BtnID, 0, , "ahk_id " this.tbHwnd)
        return ErrorLevel ? true : false
    }
;=======================================================================================
;    Method:             GetCount
;    Description:        Retrieves the total number of buttons.
;    Return:             The total number of buttons in the toolbar.
;=======================================================================================
    GetCount()
    {
        ErrorLevel := SendMessage(this.TB_BUTTONCOUNT, 0, 0, , "ahk_id " this.tbHwnd)
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
        ControlGetPos(, , &tbWidth, , , "ahk_id " this.tbHwnd)
        RECT := Buffer(16, 0), HiddenButtons := [] ; V1toV2: if 'RECT' is a UTF-16 string, use 'VarSetStrCapacity(&RECT, 16)'
        Loop this.GetCount()
        {
            if (type(RECT)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
               ErrorLevel := SendMessage(this.TB_GETITEMRECT, A_Index-1, RECT, , "ahk_id " this.tbHwnd)
            } else{
               ErrorLevel := SendMessage(this.TB_GETITEMRECT, A_Index-1, StrPtr(RECT), , "ahk_id " this.tbHwnd)
            }
            If (NumGet(&RECT, 8, "Int") > tbWidth)
                this.GetButton(A_Index, ID, Text, "", "", Icon)            ,   HiddenButtons.Push({ID: ID, Text: Text, Label: this.Labels[ID], Icon: Icon})
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
        If (!Buttons.Length)
        {
            this.BtnSep(TBBUTTON, Options)
            if (type(TBBUTTON)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
               ErrorLevel := SendMessage(this.TB_INSERTBUTTON, Position-1, TBBUTTON, , "ahk_id " this.tbHwnd)
            } else{
               ErrorLevel := SendMessage(this.TB_INSERTBUTTON, Position-1, StrPtr(TBBUTTON), , "ahk_id " this.tbHwnd)
            }
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
                ErrorLevel := SendMessage(this.TB_COMMANDTOINDEX, ID, 0, , "ahk_id " this.tbHwnd)
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
        if !(State ~= "^(?i:CHECK|ENABLE|HIDE|MARK|PRESS)$")
            return false
        Message := this[ "TB_" State "BUTTON"]    ,   this.GetButton(Button, BtnID)
        ErrorLevel := SendMessage(Message, BtnID, Set, , "ahk_id " this.tbHwnd)
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
            if isInteger(Value)
                Value := Value
            Else
            {
                Loop Parse, Value, A_Space "" A_Tab
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
        this.DefineBtnInfoStruct(TBBUTTONINFO, Property, Value)    ,   this.GetButton(Button, BtnID)
        if (type(TBBUTTONINFO)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
           ErrorLevel := SendMessage(this.TB_SETBUTTONINFO, BtnID, TBBUTTONINFO, , "ahk_id " this.tbHwnd)
        } else{
           ErrorLevel := SendMessage(this.TB_SETBUTTONINFO, BtnID, StrPtr(TBBUTTONINFO), , "ahk_id " this.tbHwnd)
        }
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
        ErrorLevel := SendMessage(this.TB_MOVEBUTTON, Button-1, Target-1, , "ahk_id " this.tbHwnd)
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
    OnMessage(CommandID, %FuncParams*%)
    {
        If (IsLabel(this.Labels[CommandID]))
        {
            % this.Labels[CommandID]()
            return true
        }
		Else If (IsFunc(this.Labels[CommandID]))
		{
			BtnFunc := this.Labels[CommandID]		,	%BtnFunc%(FuncParams*)
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
    OnNotify(&Param, &MenuXPos := "", &MenuYPos := "", &BtnLabel := "", &ID := ""    ,   AllowCustom := true, AllowReset := true, HideHelp := true)
    {
        nCode  := NumGet(Param + (A_PtrSize * 2), 0, "Int"), tbHwnd := NumGet(Param + 0, 0, "UPtr")
        If (tbHwnd != this.tbHwnd)
            return ""
        If (nCode = this.TBN_DROPDOWN)
        {
            ID  := NumGet(Param + (A_PtrSize * 3), 0, "Int"), BtnLabel := this.Labels[ID]        ,   RECT := Buffer(16, 0) ; V1toV2: if 'RECT' is a UTF-16 string, use 'VarSetStrCapacity(&RECT, 16)'
            if (type(RECT)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
               ErrorLevel := SendMessage(this.TB_GETRECT, ID, RECT, , "ahk_id " this.tbHwnd)
            } else{
               ErrorLevel := SendMessage(this.TB_GETRECT, ID, StrPtr(RECT), , "ahk_id " this.tbHwnd)
            }
            ControlGetPos(&TBX, &TBY, , , , "ahk_id " this.tbHwnd)
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
            If (iItem = this.DefaultBtnInfo.Length)
                return false
            For each, Member in this.DefaultBtnInfo[iItem+1]
                %each% := Member
            If (Text != "")
            {
                VarSetStrCapacity(&BTNSTR, (StrPut(Text) * (1 ? 2 : 1), 0))            ,   StrPut(Text, &BTNSTR, StrPut(Text) * 2) ; V1toV2: if 'BTNSTR' is NOT a UTF-16 string, use 'BTNSTR := Buffer((StrPut(Text) * (A_IsUnicode ? 2 : 1), 0))'
                if (type(BTNSTR)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
                   ErrorLevel := SendMessage(this.TB_ADDSTRING, 0, BTNSTR, , "ahk_id " this.tbHwnd)
                } else{
                   ErrorLevel := SendMessage(this.TB_ADDSTRING, 0, StrPtr(BTNSTR), , "ahk_id " this.tbHwnd)
                }
                Index := ErrorLevel, this.DefaultBtnInfo[iItem+1]["Index"] := Index            ,   this.DefaultBtnInfo[iItem+1]["Text"] := Text
            }
            NumPut("Int", Icon, Param + (A_PtrSize * 4), 0)        ,   NumPut("Int", ID, Param + (A_PtrSize * 4), 4)        ,   NumPut("Char", State, Param + (A_PtrSize * 4), 8)        ,   NumPut("Char", Style, Param + (A_PtrSize * 4), 9)        ,   NumPut("Int", Index, Param + (A_PtrSize * 4), 8 + (A_PtrSize * 2)) ; iBitmap
            return true
        }
        If (nCode = this.TBN_TOOLBARCHANGE)
        {
            CurrentButtons := this.Export(true)        ,   this.Presets.Load(CurrentButtons)        ,   CurrentButtons := ""
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
        BtnsArray := IsObject(CustomArray) ? CustomArray : this.DefaultBtnInfo    ,   this.Get("", "", Rows)
        Loop this.GetCount()
            this.Delete(1)
        For each, Button in BtnsArray
        {
            For each, Member in Button
                %each% := Member
            If ((Rows > 1) && (Style = this.BTNS_SEP))
                State := 0x24
            If (Text != "")
            {
                VarSetStrCapacity(&BTNSTR, (StrPut(Text) * (1 ? 2 : 1), 0))            ,   StrPut(Text, &BTNSTR, StrPut(Text) * 2) ; V1toV2: if 'BTNSTR' is NOT a UTF-16 string, use 'BTNSTR := Buffer((StrPut(Text) * (A_IsUnicode ? 2 : 1), 0))'
                if (type(BTNSTR)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
                   ErrorLevel := SendMessage(this.TB_ADDSTRING, 0, BTNSTR, , "ahk_id " this.tbHwnd)
                } else{
                   ErrorLevel := SendMessage(this.TB_ADDSTRING, 0, StrPtr(BTNSTR), , "ahk_id " this.tbHwnd)
                }
                Index := ErrorLevel
            }
            TBBUTTON := Buffer(8 + (A_PtrSize * 3), 0)        ,   NumPut("Int", Icon, TBBUTTON, 0)        ,   NumPut("Int", ID, TBBUTTON, 4)        ,   NumPut("Char", State, TBBUTTON, 8)        ,   NumPut("Char", Style, TBBUTTON, 9)        ,   NumPut("Int", Index, TBBUTTON, 8 + (A_PtrSize * 2)) ; V1toV2: if 'TBBUTTON' is a UTF-16 string, use 'VarSetStrCapacity(&TBBUTTON, 8 + (A_PtrSize * 3))'
            if (type(TBBUTTON)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
               ErrorLevel := SendMessage(this.TB_ADDBUTTONS, 1, TBBUTTON, , "ahk_id " this.tbHwnd)
            } else{
               ErrorLevel := SendMessage(this.TB_ADDBUTTONS, 1, StrPtr(TBBUTTON), , "ahk_id " this.tbHwnd)
            }
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
        ErrorLevel := SendMessage(this.TB_SETBUTTONSIZE, 0, Long, , "ahk_id " this.tbHwnd)
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
        If (!Buttons.Length)
            this.DefaultBtnInfo.Push({Icon: -1, ID: "", State: ""                                       , Style: this.BTNS_SEP, Text: "", Label: ""})
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
        if isInteger(Style)
            tbStyle_Ex_ := Style
        Else
        {
            Loop Parse, Style, A_Space "" A_Tab
            {
                If (this[ "TBSTYLE_EX_" A_LoopField ] )
                    tbStyle_Ex_ += this[ "TBSTYLE_EX_" A_LoopField ]
            }
        }
        ErrorLevel := SendMessage(this.TB_SETEXTENDEDSTYLE, 0, tbStyle_Ex_, , "ahk_id " this.tbHwnd)
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
        ErrorLevel := SendMessage(this.TB_SETHOTITEM, Button-1, 0, , "ahk_id " this.tbHwnd)
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
        ErrorLevel := SendMessage(this.TB_SETIMAGELIST, 0, IL_Default, , "ahk_id " this.tbHwnd)
        If (IL_Hot)
            ErrorLevel := SendMessage(this.TB_SETHOTIMAGELIST, 0, IL_Hot, , "ahk_id " this.tbHwnd)
        If (IL_Pressed)
            ErrorLevel := SendMessage(this.TB_SETPRESSEDIMAGELIST, 0, IL_Pressed, , "ahk_id " this.tbHwnd)
        If (IL_Disabled)
            ErrorLevel := SendMessage(this.TB_SETDISABLEDIMAGELIST, 0, IL_Disabled, , "ahk_id " this.tbHwnd)
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
        ErrorLevel := SendMessage(this.TB_SETINDENT, Value, 0, , "ahk_id " this.tbHwnd)
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
        ErrorLevel := SendMessage(this.TB_SETLISTGAP, Value, 0, , "ahk_id " this.tbHwnd)
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
        ErrorLevel := SendMessage(this.TB_SETMAXTEXTROWS, MaxRows, 0, , "ahk_id " this.tbHwnd)
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
        ErrorLevel := SendMessage(this.TB_SETPADDING, 0, Long, , "ahk_id " this.tbHwnd)
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
        ErrorLevel := SendMessage(this.TB_SETROWS, Long, , , "ahk_id " this.tbHwnd)
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
        if isInteger(Style)
            tbStyle := Style
        Else
        {
            Loop Parse, Style, A_Space "" A_Tab
            {
                If (this[ "TBSTYLE_" A_LoopField ] )
                    tbStyle += this[ "TBSTYLE_" A_LoopField ]
            }
        }
        ; TB_SETSTYLE moves the toolbar away from its position for some reason.
        ; SendMessage, this.TB_SETSTYLE, 0, tbStyle,, % "ahk_id " this.tbHwnd
        If (tbStyle != "")
        {
            WinSetStyle("^" tbStyle, "ahk_id " this.tbHwnd)
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
                BtnString .= (Label ? (Label (Text ? "=" Text : "")                        .    ":" Icon+1 (Style ? "(" Style ")" : "")) : "") ", "
                If (ArrayOut)
                    BtnArray.Push({Icon: Icon, ID: ID, State: State                                   , Style: Style, Text: Text, Label: Label})
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
                If (RegExMatch(Button, "^(\W?)(\w+)[=\s]?(.*)?:(\d+)\(?(.*?)?\)?$", &Key))
                {
                    If (Key[1])
                        continue
                    idCommand := this.GenerateRandomID()                ,   iString := Key[3], iBitmap := Key[4]                ,   Struct := this.DefineBtnStruct(TBBUTTON, iBitmap, idCommand, iString, Key[5] ? Key[5] : Options)                ,   Struct.Label := Key[2], BtnArray.Push(Struct)
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
            ErrorLevel := SendMessage(this.TB_GETROWS, 0, 0, , "ahk_id " this.tbHwnd)
                Rows := ErrorLevel
            ErrorLevel := SendMessage(this.TB_BUTTONCOUNT, 0, 0, , "ahk_id " this.tbHwnd)
            Loop ErrorLevel
                ErrorLevel := SendMessage(this.TB_DELETEBUTTON, 0, 0, , "ahk_id " this.tbHwnd)
            For each, Button in Buttons
            {
                For each, Member in Button
                    %each% := Member
                If ((Rows > 1) && (Style = this.BTNS_SEP))
                    State := 0x24
                If (Text != "")
                {
                    VarSetStrCapacity(&BTNSTR, (StrPut(Text) * (1 ? 2 : 1), 0))                ,   StrPut(Text, &BTNSTR, StrPut(Text) * 2) ; V1toV2: if 'BTNSTR' is NOT a UTF-16 string, use 'BTNSTR := Buffer((StrPut(Text) * (A_IsUnicode ? 2 : 1), 0))'
                    if (type(BTNSTR)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
                       ErrorLevel := SendMessage(this.TB_ADDSTRING, 0, BTNSTR, , "ahk_id " this.tbHwnd)
                    } else{
                       ErrorLevel := SendMessage(this.TB_ADDSTRING, 0, StrPtr(BTNSTR), , "ahk_id " this.tbHwnd)
                    }
                    Index := ErrorLevel
                }
                TBBUTTON := Buffer(8 + (A_PtrSize * 3), 0)            ,   NumPut("Int", Icon, TBBUTTON, 0)            ,   NumPut("Int", ID, TBBUTTON, 4)            ,   NumPut("Char", State, TBBUTTON, 8)            ,   NumPut("Char", Style, TBBUTTON, 9)            ,   NumPut("Int", Index, TBBUTTON, 8 + (A_PtrSize * 2)) ; V1toV2: if 'TBBUTTON' is a UTF-16 string, use 'VarSetStrCapacity(&TBBUTTON, 8 + (A_PtrSize * 3))'
                if (type(TBBUTTON)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
                   ErrorLevel := SendMessage(this.TB_ADDBUTTONS, 1, TBBUTTON, , "ahk_id " this.tbHwnd)
                } else{
                   ErrorLevel := SendMessage(this.TB_ADDBUTTONS, 1, StrPtr(TBBUTTON), , "ahk_id " this.tbHwnd)
                }
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
        Static TB_ADDSTRING             := 1 ? 0x044D : 0x041C
        Static TB_AUTOSIZE              := 0x0421
        Static TB_BUTTONCOUNT           := 0x0418
        Static TB_CHECKBUTTON           := 0x0402
        Static TB_COMMANDTOINDEX        := 0x0419
        Static TB_CUSTOMIZE             := 0x041B
        Static TB_DELETEBUTTON          := 0x0416
        Static TB_ENABLEBUTTON          := 0x0401
        Static TB_GETBUTTON             := 0x0417
        Static TB_GETBUTTONSIZE         := 0x043A
        Static TB_GETBUTTONTEXT         := 1 ? 0x044B : 0x042D
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
        Static TB_GETSTRING             := 1 ? "" :0x045B 0x045C
        Static TB_GETTEXTROWS           := 0x043D
        Static TB_HIDEBUTTON            := 0x0404
        Static TB_INDETERMINATE         := 0x0405
        Static TB_INSERTBUTTON          := 1 ? 0x0443 : 0x0415
        Static TB_ISBUTTONCHECKED       := 0x040A
        Static TB_ISBUTTONENABLED       := 0x0409
        Static TB_ISBUTTONHIDDEN        := 0x040C
        Static TB_ISBUTTONHIGHLIGHTED   := 0x040E
        Static TB_ISBUTTONINDETERMINATE := 0x040D
        Static TB_ISBUTTONPRESSED       := 0x040B
        Static TB_MARKBUTTON            := 0x0406
        Static TB_MOVEBUTTON            := 0x0452
        Static TB_PRESSBUTTON           := 0x0403
        Static TB_SETBUTTONINFO         := 1 ? 0x0440 : 0x0442
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
        Static TBN_GETDISPINFO     := 1 ? -717 : -716
        Static TBN_GETINFOTIP      := 1 ? -719 : -718
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
            this.tbHwnd := hToolbar        ,   this.DefaultBtnInfo := []        ,   this.Presets := {tbHwnd: hToolbar, Base: Toolbar.tbPresets}
        }
;=======================================================================================
        __Delete()
        {
            this.RemoveAt(1, this.Length)        ,   this.SetCapacity(0)        ,   this.base := ""
        }
;=======================================================================================
;    Private Methods
;=======================================================================================
;    Method:             SendMessage
;    Description:        Sends a message to create or modify a button.
;=======================================================================================
        SendMessage(Button, Options, Message := "", Param := "")
        {
            If (RegExMatch(Button, "^(\W?)(\w+)[=\s]?(.*)?:(\d+)\(?(.*?)?\)?$", &Key))
            {
                idCommand := this.GenerateRandomID()            ,   iString := Key[3], iBitmap := Key[4]            ,   this.Labels[idCommand] := Key[2]            ,   Struct := this.DefineBtnStruct(TBBUTTON, iBitmap, idCommand, iString, Key[5] ? Key[5] : Options)            ,   this.DefaultBtnInfo.Push(Struct)
                If !(Key[1]) && (Message)
                {
                    if (type(TBBUTTON)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
                       ErrorLevel := SendMessage(Message, Param, TBBUTTON, , "ahk_id " this.tbHwnd)
                    } else{
                       ErrorLevel := SendMessage(Message, Param, StrPtr(TBBUTTON), , "ahk_id " this.tbHwnd)
                    }
                    If (ErrorLevel = "FAIL")
                        return false
                }
            }
            Else
            {
                Struct := this.BtnSep(TBBUTTON, Options), this.DefaultBtnInfo.Push(Struct)
                If (Message)
                {
                    if (type(TBBUTTON)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
                       ErrorLevel := SendMessage(Message, Param, TBBUTTON, , "ahk_id " this.tbHwnd)
                    } else{
                       ErrorLevel := SendMessage(Message, Param, StrPtr(TBBUTTON), , "ahk_id " this.tbHwnd)
                    }
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
        DefineBtnStruct(&BtnVar, iBitmap := 0, idCommand := 0, iString := "", Options := "")
        {
            if isInteger(Options)
                tbStyle := Options, tbState := this.TBSTATE_ENABLED
            Else
            {
                Loop Parse, Options, A_Space "" A_Tab
                {
                    If (this[ "TBSTATE_" A_LoopField ])
                        tbState += this[ "TBSTATE_" A_LoopField ]
                    Else If (this[ "BTNS_" A_LoopField ] )
                        tbStyle += this[ "BTNS_" A_LoopField ]
                    Else If (RegExMatch(A_LoopField, "i)W(\d+)-(\d+)", &MW))
                    {
                        Long := this.MakeLong(MW[1], MW[2])
                        ErrorLevel := SendMessage(this.TB_SETBUTTONWIDTH, 0, Long, , "ahk_id " this.tbHwnd)
                    }
                }
            }
            If (iString != "")
            {
                VarSetStrCapacity(&BTNSTR, (StrPut(iString) * (1 ? 2 : 1), 0))            ,   StrPut(iString, &BTNSTR, StrPut(iString) * 2) ; V1toV2: if 'BTNSTR' is NOT a UTF-16 string, use 'BTNSTR := Buffer((StrPut(iString) * (A_IsUnicode ? 2 : 1), 0))'
                if (type(BTNSTR)="Buffer"){ ;V1toV2 If statement may be removed depending on type parameter
                   ErrorLevel := SendMessage(this.TB_ADDSTRING, 0, BTNSTR, , "ahk_id " this.tbHwnd)
                } else{
                   ErrorLevel := SendMessage(this.TB_ADDSTRING, 0, StrPtr(BTNSTR), , "ahk_id " this.tbHwnd)
                }
                StrIdx := ErrorLevel
            }
            Else
                StrIdx := -1
            BtnVar := Buffer(8 + (A_PtrSize * 3), 0)        ,   NumPut("Int", iBitmap-1, BtnVar, 0)        ,   NumPut("Int", idCommand, BtnVar, 4)        ,   NumPut("Char", tbState, BtnVar, 8)        ,   NumPut("Char", tbStyle, BtnVar, 9)        ,   NumPut("Ptr", StrIdx, BtnVar, 8 + (A_PtrSize * 2)) ; V1toV2: if 'BtnVar' is a UTF-16 string, use 'VarSetStrCapacity(&BtnVar, 8 + (A_PtrSize * 3))'
            return {Icon: iBitmap-1, ID: idCommand, State: tbState                   , Style: tbStyle, Text: iString, Label: this.Labels[idCommand]}
        }
;=======================================================================================
;    Method:             DefineBtnInfoStruct
;    Description:        Creates a TBBUTTONINFO structure for a specific member.
;=======================================================================================
        DefineBtnInfoStruct(&BtnVar, Member, &Value)
        {
            Static cbSize := 16 + (A_PtrSize * 4)
            
            BtnVar := Buffer(cbSize, 0)        ,   NumPut("UInt", cbSize, BtnVar, 0) ; V1toV2: if 'BtnVar' is a UTF-16 string, use 'VarSetStrCapacity(&BtnVar, cbSize)'
            If (this[ "TBIF_" Member] )
                dwMask := this[ "TBIF_" Member ]            ,   NumPut("UInt", dwMask, BtnVar, 4)
            If (dwMask = this.TBIF_COMMAND)
                NumPut("Int", Value, BtnVar, 8) ; idCommand
            Else If (dwMask = this.TBIF_IMAGE)
                Value := Value-1            ,   NumPut("Int", Value, BtnVar, 12)
            Else If (dwMask = this.TBIF_STATE)
                Value := (this[ "TBSTATE_" Value ]) ? this[ "TBSTATE_" Value ] : Value            ,   NumPut("Char", Value, BtnVar, 16)
            Else If (dwMask = this.TBIF_STYLE)
                Value := (this[ "BTNS_" Value ]) ? this[ "BTNS_" Value ] : Value            ,   NumPut("Char", Value, BtnVar, 17)
            Else If (dwMask = this.TBIF_SIZE)
                NumPut("Short", Value, BtnVar, 18) ; cx
            Else If (dwMask = this.TBIF_TEXT)
                NumPut("UPtr", &Value, BtnVar, 16 + (A_PtrSize * 2)) ; pszText
        }
;=======================================================================================
;    Method:             BtnSep
;    Description:        Creates a TBBUTTON structure for a separator.
;    Return:             An array with the button structure values.
;=======================================================================================
        BtnSep(&BtnVar, Options := "")
        {
            tbStyle := this.BTNS_SEP
            Loop Parse, Options, A_Space "" A_Tab
            {
                If (this[ "TBSTATE_" A_LoopField ])
                    tbState += this[ "TBSTATE_" A_LoopField ]
            }
            BtnVar := Buffer(8 + (A_PtrSize * 3), 0)        ,   NumPut("Char", tbState, BtnVar, 8)        ,   NumPut("Char", tbStyle, BtnVar, 9) ; V1toV2: if 'BtnVar' is a UTF-16 string, use 'VarSetStrCapacity(&BtnVar, 8 + (A_PtrSize * 3))'
            return {Icon: -1, ID: "", State: tbState, Style: tbStyle, Text: "", Label: ""}
        }
;=======================================================================================
;    Method:             GenerateRandomID
;    Description:        Returns a random number to be used as Command ID.
;=======================================================================================
        GenerateRandomID()
        {
            While (!Number || this.Labels.Has(Number))
                Number := Random(1, 9999)
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
        MakeShort(Long, &LoWord, &HiWord)
        {
            LoWord := Long & 0xffff        ,   HiWord := Long >> 16
        }
    }
}
; --------------------------------------------------------------------------------
; Function .....: Horizon Hotkeys - Save
; ChangeLog ....: 06/08/2023 - v1 - With #IfWinActive ahk_exe hznhorizon.exe, added CTRL+S
; . Continued ..: Added FindText() function to bottom of script using the-automator.com script
; . Continued ..: Added the "specific text", which is really a picture convereted to base64 (to text) of the Save icon
; --------------------------------------------------------------------------------
/*
^s::

{ ; V1toV2: Added bracket
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
} ; Added bracket before function


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
  Static MyFunc
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
  Static Lib:=[]
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
B64ToPBitmap( Input ){
	; local Ptr , UPtr , pBitmap , pStream , hData , pData , Dec , DecLen , B64
	;Static UPtr , pBitmap , pStream , hData , pData , Dec , DecLen , B64
	;B64 := Buffer(strlen( Input ) << !!A_IsUnicode)
	; VarSetStrCapacity(&B64, 5120000) ; V1toV2: if 'B64' is NOT a UTF-16 string, use 'B64 := Buffer(strlen( Input ) << !!A_IsUnicode)'
	VarSetStrCapacity(&&B64, 5120000) ; V1toV2: if 'B64' is NOT a UTF-16 string, use 'B64 := Buffer(strlen( Input ) << !!A_IsUnicode)' ; V1toV2: if '&B64' is NOT a UTF-16 string, use '&B64 := Buffer(5120000)'
	; VarSetStrCapacity(&DecLen, 5120000) ; V1toV2: if 'B64' is NOT a UTF-16 string, use 'B64 := Buffer(strlen( Input ) << !!A_IsUnicode)'
	VarSetStrCapacity(&&DecLen, 5120000) ; V1toV2: if 'B64' is NOT a UTF-16 string, use 'B64 := Buffer(strlen( Input ) << !!A_IsUnicode)' ; V1toV2: if '&DecLen' is NOT a UTF-16 string, use '&DecLen := Buffer(5120000)'
	B64 := Input
	If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", B64, "UInt", 0, "UInt", 0x01, "Ptr", 0, "UIntP", &DecLen, "Ptr", 0, "Ptr", 0)
		Return False
	; Dec := Buffer(DecLen, 0) ; V1toV2: if 'Dec' is a UTF-16 string, use 'VarSetStrCapacity(&Dec, DecLen)'
	; VarSetStrCapacity(&Dec, DecLen) ; V1toV2: if 'Dec' is a UTF-16 string, use 'VarSetStrCapacity(&Dec, DecLen)'
	VarSetStrCapacity(&&Dec, DecLen) ; V1toV2: if 'Dec' is a UTF-16 string, use 'VarSetStrCapacity(&Dec, DecLen)' ; V1toV2: if '&Dec' is NOT a UTF-16 string, use '&Dec := Buffer(DecLen)'
	If !DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", B64, "UInt", 0, "UInt", 0x01, "Ptr", Dec, "UIntP", &DecLen, "Ptr", 0, "Ptr", 0)
		Return False
	DllCall("Kernel32.dll\RtlMoveMemory", "Ptr", pData := DllCall("Kernel32.dll\StaticLock", "Ptr", hData := DllCall("Kernel32.dll\StaticAlloc", "UInt", 2, UPtr := A_PtrSize ? "UPtr" : "UInt", DecLen, "UPtr"), "UPtr"), "Ptr", Dec, "UPtr", DecLen)
	DllCall("Kernel32.dll\StaticUnlock", "Ptr", hData)
	DllCall("Ole32.dll\CreateStreamOnHStatic", "Ptr", hData, "Int", True, "Ptr", pStream)
	DllCall("Gdiplus.dll\GdipCreateBitmapFromStream", "Ptr", pStream, "Ptr", pBitmap)
	return pBitmap
}
; --------------------------------------------------------------------------------
MyIcon_B64()
{
		
		icostr := "
		(LTrim Join
		AAABAAEAICAAAAEAIACoEAAAFgAAACgAAAAgAAAAQAAAAAEAIAAAAAAAgBAAAGAbAABgGwAAAAAAAAAAAAD7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////////////////////////////////////f/////RERE//tcQv/7XEL////////////////////////////////////////////////3/////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL///////////////////////////f/////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC////////////////////////////////90RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC////////////////////////////////////////////////////////////////////////////////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL///////////////////////////////////////////f////3////9/////f///////////////////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC/////////////////0RERP/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/////////////////////////////////RERE//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//////////////////////////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC////////////////////////////////////////////RERE//tcQv/7XEL/+1xC//tcQv////////////////////////////////////////////////9ERET/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/+1xC//tcQv/7XEL/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
		)"
		return icostr
} 
; --------------------------------------------------------------------------------
; Sub-Section .....: Create Tray Menu Functions
; Description .....: addTrayMenuOption() ; madeBy() ; runAtStartup() ; trayNotify()
; --------------------------------------------------------------------------------

addTrayMenuOption(label := "", command := "") {
	if (label = "" && command = "") {
		Tray.Add()
	} else {
		Tray.Add(label, % command)
	}
}

madeBy(){
	; visit authors website
	;Run, https://bibeka.com.np/
	MsgBox("This was made by nerds, for nerds. Regular people are ok too, lol.`nModified by Adam Bacon`nCredit:Made with â¤ï¸ by Bibek Aryal")
}

runAtStartup() {
	if (FileExist(startup_shortcut)) {
		FileDelete(startup_shortcut)
		Tray.% "unCheck"("Run at startup") ; update the tray menu status on change
		trayNotify("Startup shortcut removed", "This script will not run when you turn on your computer.")
	} else {
		FileCreateShortcut(a_scriptFullPath, startup_shortcut)
		Tray.% "check"("Run at startup") ; update the tray menu status on change
		trayNotify("Startup shortcut added", "This script will now automatically run when your turn on your computer.")
	}

}
trayNotify(title, message, seconds := "", options := 0) {
	TrayTip(title, message, options)
}
; --------------------------------------------------------------------------------
; ; Static TB_ADDBUTTONS            := 0x0414
; Global TB_ADDSTRING             := A_IsUnicode ? 0x044D : 0x041C
; Global TB_AUTOSIZE              := 0x0421
; Global TB_BUTTONCOUNT           := 0x0418
; Global TB_CHECKBUTTON           := 0x0402
; Global TB_COMMANDTOINDEX        := 0x0419
; Global TB_CUSTOMIZE             := 0x041B
; Global TB_DELETEBUTTON          := 0x0416
; Global TB_ENABLEBUTTON          := 0x0401
; ; Global TB_GETBUTTON             := 0x0417
; Global TB_GETBUTTONSIZE         := 0x043A
; Global TB_GETBUTTONTEXT         := A_IsUnicode ? 0x044B : 0x042D
; Global TB_GETEXTENDEDSTYLE      := 0x0455
; Global TB_GETHOTITEM            := 0x0447
; Global TB_GETIMAGELIST          := 0x0431
; Global TB_GETIMAGELISTCOUNT     := 0x0462
; Global TB_GETITEMDROPDOWNRECT   := 0x0467
; Global TB_GETITEMRECT           := 0x041D
; Global TB_GETMAXSIZE            := 0x0453
; Global TB_GETPADDING            := 0x0456
; Global TB_GETRECT               := 0x0433
; Global TB_GETROWS               := 0x0428
; Global TB_GETSTATE              := 0x0412
; Global TB_GETSTYLE              := 0x0439
; Global TB_GETSTRING             := A_IsUnicode ? :0x045B 0x045C
; Global TB_GETTEXTROWS           := 0x043D
; Global TB_HIDEBUTTON            := 0x0404
; Global TB_INDETERMINATE         := 0x0405
; Global TB_INSERTBUTTON          := A_IsUnicode ? 0x0443 : 0x0415
; Global TB_ISBUTTONCHECKED       := 0x040A
; Global TB_ISBUTTONENABLED       := 0x0409
; Global TB_ISBUTTONHIDDEN        := 0x040C
; Global TB_ISBUTTONHIGHLIGHTED   := 0x040E
; Global TB_ISBUTTONINDETERMINATE := 0x040D
; Global TB_ISBUTTONPRESSED       := 0x040B
; Global TB_MARKBUTTON            := 0x0406
; Global TB_MOVEBUTTON            := 0x0452
; Global TB_PRESSBUTTON           := 0x0403
; Global TB_SETBUTTONINFO         := A_IsUnicode ? 0x0440 : 0x0442
; Global TB_SETBUTTONSIZE         := 0x041F
; Global TB_SETBUTTONWIDTH        := 0x043B
; Global TB_SETDISABLEDIMAGELIST  := 0x0436
; Global TB_SETEXTENDEDSTYLE      := 0x0454
; Global TB_SETHOTIMAGELIST       := 0x0434
; Global TB_SETHOTITEM            := 0x0448
; Global TB_SETHOTITEM2           := 0x045E
; Global TB_SETIMAGELIST          := 0x0430
; Global TB_SETINDENT             := 0x042F
; Global TB_SETLISTGAP            := 0x0460
; Global TB_SETMAXTEXTROWS        := 0x043C
; Global TB_SETPADDING            := 0x0457
; Global TB_SETPRESSEDIMAGELIST   := 0x0468
; Global TB_SETROWS               := 0x0427
; Global TB_SETSTATE              := 0x0411
; Global TB_SETSTYLE              := 0x0438
; ; Styles
; Global TBSTYLE_ALTDRAG      := 0x0400
; Global TBSTYLE_CUSTOMERASE  := 0x2000
; Global TBSTYLE_FLAT         := 0x0800
; Global TBSTYLE_LIST         := 0x1000
; Global TBSTYLE_REGISTERDROP := 0x4000
; Global TBSTYLE_TOOLTIPS     := 0x0100
; Global TBSTYLE_TRANSPARENT  := 0x8000
; Global TBSTYLE_WRAPABLE     := 0x0200
; Global TBSTYLE_ADJUSTABLE   := 0x20
; Global TBSTYLE_BORDER       := 0x800000
; Global TBSTYLE_THICKFRAME   := 0x40000
; Global TBSTYLE_TABSTOP      := 0x10000
; ; ExStyles
; Global TBSTYLE_EX_DOUBLEBUFFER       := 0x80 ; // Double Buffer the toolbar
; Global TBSTYLE_EX_DRAWDDARROWS       := 0x01
; Global TBSTYLE_EX_HIDECLIPPEDBUTTONS := 0x10 ; // don't show partially obscured buttons
; Global TBSTYLE_EX_MIXEDBUTTONS       := 0x08
; Global TBSTYLE_EX_MULTICOLUMN        := 0x02 ; // Intended for internal use; not recommended for use in applications.
; Global TBSTYLE_EX_VERTICAL           := 0x04 ; // Intended for internal use; not recommended for use in applications.
; ; Button states
; Global TBSTATE_CHECKED       := 0x01
; Global TBSTATE_ELLIPSES      := 0x40
; Global TBSTATE_ENABLED       := 0x04
; Global TBSTATE_HIDDEN        := 0x08
; Global TBSTATE_INDETERMINATE := 0x10
; Global TBSTATE_MARKED        := 0x80
; Global TBSTATE_PRESSED       := 0x02
; Global TBSTATE_WRAP          := 0x20
; ; Button styles
; Global BTNS_BUTTON        := 0x00 ; TBSTYLE_BUTTON
; Global BTNS_SEP           := 0x01 ; TBSTYLE_SEP
; Global BTNS_CHECK         := 0x02 ; TBSTYLE_CHECK
; Global BTNS_GROUP         := 0x04 ; TBSTYLE_GROUP
; Global BTNS_CHECKGROUP    := 0x06 ; TBSTYLE_CHECKGROUP  // (TBSTYLE_GROUP | TBSTYLE_CHECK)
; Global BTNS_DROPDOWN      := 0x08 ; TBSTYLE_DROPDOWN
; Global BTNS_AUTOSIZE      := 0x10 ; TBSTYLE_AUTOSIZE    // automatically calculate the cx of the button
; Global BTNS_NOPREFIX      := 0x20 ; TBSTYLE_NOPREFIX    // this button should not have accel prefix
; Global BTNS_SHOWTEXT      := 0x40 ; // ignored unless TBSTYLE_EX_MIXEDBUTTONS is set
; Global BTNS_WHOLEDROPDOWN := 0x80 ; // draw drop-down arrow, but without split arrow section
; ; TB_GETBITMAPFLAGS
; Global TBBF_LARGE   := 0x00000001
; Global TBIF_BYINDEX := 0x80000000 ; // this specifies that the wparam in Get/SetButtonInfo is an index, not id
; Global TBIF_COMMAND := 0x00000020
; Global TBIF_IMAGE   := 0x00000001
; Global TBIF_LPARAM  := 0x00000010
; Global TBIF_SIZE    := 0x00000040
; Global TBIF_STATE   := 0x00000004
; Global TBIF_STYLE   := 0x00000008
; Global TBIF_TEXT    := 0x00000002
; ; Notifications
; Global TBN_BEGINADJUST     := -703
; Global TBN_BEGINDRAG       := -701
; Global TBN_CUSTHELP        := -709
; Global TBN_DELETINGBUTTON  := -715
; Global TBN_DRAGOUT         := -714
; Global TBN_DRAGOVER        := -727
; Global TBN_DROPDOWN        := -710
; Global TBN_DUPACCELERATOR  := -725
; Global TBN_ENDADJUST       := -704
; Global TBN_ENDDRAG         := -702
; Global TBN_GETBUTTONINFO   := -720 ; A_IsUnicode ? -720 : -700
; Global TBN_GETDISPINFO     := A_IsUnicode ? -717 : -716
; Global TBN_GETINFOTIP      := A_IsUnicode ? -719 : -718
; Global TBN_GETOBJECT       := -712
; Global TBN_HOTITEMCHANGE   := -713
; Global TBN_INITCUSTOMIZE   := -723
; Global TBN_MAPACCELERATOR  := -728
; Global TBN_QUERYDELETE     := -707
; Global TBN_QUERYINSERT     := -706
; Global TBN_RESET           := -705
; Global TBN_RESTORE         := -721
; Global TBN_SAVE            := -722
; Global TBN_TOOLBARCHANGE   := -708
; Global TBN_WRAPACCELERATOR := -726
; Global TBN_WRAPHOTITEM     := -724
; Global TB_GETBUTTONINFOW   := 1087       ;(decimal) or 0x043f (hex)
; ; Step: set the Global variables
; ; Global TB_GETBUTTON    := 0x417,
; ; Global TB_GETITEMRECT  := 0x41D,
; Global MEM_COMMIT      := 0x1000, ; 0x00001000, ; via MSDN Win32 
; Global MEM_RESERVE     := 0x2000, ; 0x00002000, ; via MSDN Win32
; Global MEM_PHYSICAL    := 0x04    ; 0x00400000, ; via MSDN Win32
; ; [in]   SIZE_T dwSize, ; The size of the region of memory to allocate, in bytes.
; Global  dwSize          := 128  
