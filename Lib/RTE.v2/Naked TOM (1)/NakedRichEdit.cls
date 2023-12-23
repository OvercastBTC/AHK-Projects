VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "NakedRichEdit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'Create an invisible "naked" (not wrapped by an ActiveX control) RichEdit window
'and expose its Text Object Model.

'Private Const RICHEDIT_LIBRARY As String = "riched20.dll"
'Private Const RICHEDIT_CLASS As String = "RichEdit20W"
Private Const RICHEDIT_LIBRARY As String = "msftedit.dll"
Private Const RICHEDIT_CLASS As String = "RichEdit50W"

Private Const WIN32_NULL As Long = 0&

Private Const WM_USER As Long = &H400&
Private Const EM_GETOLEINTERFACE As Long = WM_USER + 60

Private Const WS_EX_NOPARENTNOTIFY As Long = &H4&
Private Const WS_EX_CLIENTEDGE As Long = &H200&

Private Const ES_MULTILINE As Long = &H4

Private Const CW_USEDEFAULT As Long = &H80000000

Private Declare Function CreateWindowEx Lib "user32" _
    Alias "CreateWindowExW" ( _
    ByVal dwExStyle As Long, _
    ByVal lpClassName As Long, _
    ByVal lpWindowName As Long, _
    ByVal dwStyle As Long, _
    ByVal x As Long, _
    ByVal y As Long, _
    ByVal nWidth As Long, _
    ByVal nHeight As Long, _
    ByVal hWndParent As Long, _
    ByVal hMenu As Long, _
    ByVal hInstance As Long, _
    ByVal lpParam As Long) As Long
Private Declare Function DestroyWindow Lib "user32" (ByVal hWnd As Long) As Long
Private Declare Function LoadLibrary Lib "kernel32" _
    Alias "LoadLibraryW" ( _
    ByVal lpLibFileName As Long) As Long
Private Declare Function FreeLibrary Lib "kernel32" (ByVal hModule As Long) As Long
Private Declare Function SendMessage Lib "user32" _
    Alias "SendMessageW" ( _
    ByVal hWnd As Long, _
    ByVal wMsg As Long, _
    ByVal wParam As Long, _
    ByVal lParam As Long) As Long

Private hRichEdLib As Long
Private hWndRichEd As Long

Private mTextDocument  As tom.ITextDocument

Public Property Get TextDocument() As tom.ITextDocument
    Set TextDocument = mTextDocument
End Property

Private Sub Class_Initialize()
    Dim Unknown As IUnknown
    
    hRichEdLib = LoadLibrary(StrPtr(RICHEDIT_LIBRARY))
    hWndRichEd = CreateWindowEx(WS_EX_CLIENTEDGE Or WS_EX_NOPARENTNOTIFY, _
                                StrPtr(RICHEDIT_CLASS), _
                                WIN32_NULL, _
                                ES_MULTILINE, _
                                0, _
                                0, _
                                CW_USEDEFAULT, _
                                CW_USEDEFAULT, _
                                WIN32_NULL, _
                                WIN32_NULL, _
                                App.hInstance, _
                                WIN32_NULL)
    SendMessage hWndRichEd, EM_GETOLEINTERFACE, 0, VarPtr(Unknown)
    Set mTextDocument = Unknown
End Sub

Private Sub Class_Terminate()
    Set mTextDocument = Nothing
    DestroyWindow hWndRichEd
    FreeLibrary hRichEdLib
End Sub
