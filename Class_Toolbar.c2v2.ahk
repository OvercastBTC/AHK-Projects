#Include <Lib.v2\Class_IronToolbar>
#Include <Lib.v2\Toolbar>
#Include <LIb.v2\OpenProcess>

; IronToolbarArray := IronToolbar()
    ; Line 39: "Styles"
    ; Line 57: "bStyles"
    ; Line 66: "exStyles"
    ; Line 73: "states"
    ; Line 82: "flags"
    ; Line 92: "wm_n"
    ; TODO // Line 115: "messages" <======== currently in this.Toolbar on Line 43 => Merge or keep Separate???
    ; Line 155: "hotItemFlags"
    ; Line 163: "metrics"
    ; Line 165: TbList := []
    ; Line 166: padding := 7
    ; Line 176: Start of Methods()



Class Horizon {
    
    __New() {
        SendLevel(5)
        THIS.fCtl := ControlGetClassNN(ControlGetFocus("A"))
        THIS.tbID := SubStr(this.fCtl, -1, 1)
        THIS.tbCtl := Horizon.Terms["hznTb"] this.tbID
    }

    hWndTb() {
        Return THIS.hWnd := ControlGetHwnd(this.tbCtl, "A")
    }

    BtnCount() {
        Msg := Horizon.Msg["TB_BUTTONCOUNT"], wParam := 0, lParam := 0
        Control := ; this CANNOT be Control := "" => "Control not found"
        WinTitle := this.hWndTb()
        btnCount := SendMessage(Msg, wParam, lParam,, Integer(WinTitle))
        return btnCount
    }

; Class GetWindowThreadProcessId extends Horizon {
    GetWindowThreadProcessId(hWnd) {
        hWnd := this.hWndTb()
        ; Local ProcessID
        ; false := 0
        ; , ThreadID  := DllCall('User32.dll\GetWindowThreadProcessId', 'Ptr'  , hWnd           ; hWnd
                                                                    ; , 'UIntP', ProcessID     ;lpdwProcessId
                                                                    ; , 'UInt')                 ;ReturnType    --> dwThreadId
        ; Return (ThreadID ? {ThreadID: ThreadID, ProcessID: ProcessID} : FALSE)
        return this.ProcessID := DllCall('User32.dll\GetWindowThreadProcessId', 'Ptr', hWnd, 'Ptr', 0, 'UInt')
    } ;https://msdn.microsoft.com/en-us/library/windows/desktop/ms633522(v=vs.85).aspx
; }

    
; Class OpenProcess extends Horizon {
    OpenProcess(ProcessId, DesiredAccess, InheritHandle := FALSE){
        DesiredAccess := Horizon.Access["PROCESS_ALL_ACCESS"]
        ProcessID := this.ProcessID
        hProcess := DllCall('Kernel32.dll\OpenProcess', 'UInt', DesiredAccess, 'Int', InheritHandle, 'UInt', ProcessId, 'Ptr')
        Return hProcess
    } ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms684320(v=vs.85).aspx
; }

    Static Access := Map(
        ; https://www.magnumdb.com/search?q=PROCESS_ALL_ACCESS (review and add)
        "PROCESS_ALL_ACCESS"                    , 0x1F0FFF,
        "PROCESS_DUP_HANDLE"                    , 0x0040,
        "PROCESS_QUERY_INFORMATION"             , 0x0400,
        "PROCESS_QUERY_LIMITED_INFORMATION"     , 0x1000,
        "PROCESS_SET_INFORMATION"               , 0x0200,
        "PROCESS_SET_QUOTA"                     , 0x0100,
        "PROCESS_SUSPEND_RESUME"                , 0x0800,
        "PROCESS_TERMINATE"                     , 0x0001,
        "PROCESS_VM_OPERATION"                  , 0x0008,
        "PROCESS_VM_READ"                       , 0x0010,
        "PROCESS_VM_WRITE"                      , 0x0020,
        "SYNCHRONIZE"                           , 0x100000,
        "MEM_PHYSICAL"              			, 4,
        "MEM_PROTECT"               			, 64, ; 0x40,                     
        "MEM_RELEASE"               			, 32768, ; 0x8000
        "MEM_COMMIT"                			, 4096,
        "MEM_RESERVE"               			, 8192,
    )
    ;? Windows Messages with values (decimal or hex)
    ;? Toolbar Messages https://docs.microsoft.com/en-us/windows/win32/controls/bumper-toolbar-control-reference-messages
    
    Static Msg := Map(

        "AddButtons"                ,0x414,
        "AddString"                 ,(StrLen(Chr(0xFFFF))?0x044D:0x041C),
        "AutoSize"                  ,0x421,
        "ButtonCount"               ,0x418,
        "ChangeBitmap"              ,0x42B,
        "CheckButton"               ,0x402,
        "CommandToIndex"            ,0x419,
        "Customize"                 ,0x41B,
        "DeleteButton"              ,0x416,
        "EnableButton"              ,0x401,             
        "GetAnchorHighlight"        ,0x44A,
        "GetBitmap"                 ,0x42C, 
        "GetButton"                 ,0x417,
        "GetButtonInfo"             ,(StrLen(Chr(0xFFFF))?0x43F:0x441), 
        "GetButtonSize"             ,0x43A,
        "GetButtonText"             ,(StrLen(Chr(0xFFFF))?0x044B:0x042D),
        "GetExtendedStyle"          ,0x455,
        "GetHotItem"                ,0x447,             
        "GetIdealSize"              ,0x463,
        "GetImageList"              ,0x431,             
        "GetImageListCount"         ,0x462,
        "GetItemDropDownRect"       ,0x467,
        "GetItemRect"               ,0x41D,
        "GetMaxSize"                ,0x453,             
        "GetMetrics"                ,0x465,
        "GetPadding"                ,0x456,
        "GetRect"                   ,0x433,
        "GetRows"                   ,0x428,             
        "GetState"                  ,0x412,
        "GetString"                 ,(StrLen(Chr(0xFFFF))?0x045B:0x045C),
        "GetStyle"                  ,0x439,
        "GetTextRows"               ,0x43D,             
        "HideButton"                ,0x404,
        "HitTest"                   ,0x445,
        "Indeterminate"             ,0x405,
        "InsertButton"              ,(StrLen(Chr(0xFFFF))?0x0443:0x0415),
        "IsButtonChecked"           ,0x40A,
        "IsButtonEnabled"           ,0x40A,             
        "IsButtonHidden"            ,0x40C,
        "IsButtonHighlighted"       ,0x40E,
        "IsButtonIndeterminate"     ,0x40D,
        "IsButtonPressed"           ,0x40B,
        "MakeButton"                ,0x406,
        "MoveButton"                ,0x452,
        "PressButton"               ,0x403,
        "SetAnchorHighlight"        ,0x449,             
        "SetBitmapSize"             ,0x420,
        "SetButtonInfo"             ,(StrLen(Chr(0xFFFF))?0x0440:0x0442),
        "SetButtonSize"             ,0x41F,
        "SetButtonWidth"            ,0x43B,             
        "SetDisabledImageList"      ,0x436,
        "SetExtendedStyle"          ,0x454,
        "SetHotImageList"           ,0x434,
        "SetHotItem"                ,0x448,
        "SetHotItem2"               ,0x45E,
        "SetImageList"              ,0x430,
        "SetIndent"                 ,0x42F,
        "SetListGap"                ,0x460,             
        "SetMaxTextRows"            ,0x43C,
        "SetMetrics"                ,0x466,             
        "SetPadding"                ,0x457,
        "SetPressedImageList"       ,0x468,             
        "SetRows"                   ,0x427,
        "SetState"                  ,0x411,             
        "SetStyle"                  ,0x438,
    )
    static Message := Map(
        "TB_GETBUTTON"              , 1047,
        "TB_BUTTONCOUNT"            , 1048,
        "TB_GETITEMRECT"            , 1053,                     
        "MEM_PHYSICAL"              , 4,
        "MEM_PROTECT"               , 0x40,                     
        "MEM_RELEASE"               , 0x8000,        
        "MEM_COMMIT"                , 4096,
        "MEM_RESERVE"               , 8192,
    )
    ;?  Constant Definitions    
    static Con := Map(
        "dwSize"                    ,32,
        "0"                         ,"DISABLED",
        "1"                         ,"CHECKED",
        "2"                         ,"CHECK",
        "6"                         ,"CHECKGROUP",
        "8"                         ,"HIDDEN",
        "PAGE_READWRITE"            , 4,
        "FILE_MAP_WRITE"            , 2,
    )
    ;?  Options ?
    static Options := Map(
        "TOOLTIPS"                  ,0x100, 
        "WRAPABLE"                  ,0x200,
        "FLAT"                      ,0x800,
        "LIST"                      ,0x1000,
        "TABSTOP"                   ,0x10000,
        "BORDER"                    ,0x800000,
        "BOTTOM"                    ,0x3,
        "ADJUSTABLE"                ,0x20,
        "NODIVIDER"                 ,0x40,
        "VERTICAL"                  ,0x80,
        "TEXTONLY"                  ,0,
        "SHOWTEXT"                  ,64,
        "WRAP"                      ,32,
        "AUTOSIZE"                  ,16,
        "NOPREFIX"                  ,32,
        "WHOLEDROPDOWN"             ,128,
        "DROPDOWN"                  ,8,
    )
    ;?  State ?
    static state := Map(    
        "DISABLED"                  ,0,
        "CHECKED"                   ,1,
        "CHECK"                     ,2,
        "CHECKGROUP"                ,6,
        "HIDDEN"                    ,8,
    )
    ;?  Terms and variable names
    Static Terms := Map(
        "hznTb"                     , "msvb_lib_toolbar",
        "hzn"                       , "Horizon",
        "btc"                       , "BUTTONCOUNT",
    )  
}