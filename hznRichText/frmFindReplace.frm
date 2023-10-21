VERSION 5.00
Object = "{D8F5B61D-9152-4399-BF30-A1E4F3F072F6}#4.0#0"; "IGTabs40.ocx"
Begin VB.Form frmDlgFindReplace 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Find and Replace"
   ClientHeight    =   3465
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6420
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3465
   ScaleWidth      =   6420
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin ActiveTabs.SSActiveTabs SSActiveTabs1 
      Height          =   3255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   6255
      _ExtentX        =   11033
      _ExtentY        =   5741
      _Version        =   262144
      TabCount        =   2
      ControlCount    =   1
      TagVariant      =   ""
      Tabs            =   "frmFindReplace.frx":0000
      Begin VB.Frame Frame1 
         Caption         =   "Search Options"
         Height          =   975
         Left            =   120
         TabIndex        =   10
         Top             =   2040
         Width           =   6015
         Begin VB.CheckBox chkWholeWords 
            Caption         =   "Find Whole Words Only"
            Enabled         =   0   'False
            Height          =   255
            Left            =   120
            TabIndex        =   12
            Top             =   720
            Visible         =   0   'False
            Width           =   2295
         End
         Begin VB.CheckBox ChkCase 
            Caption         =   "Match Case"
            Height          =   255
            Left            =   120
            TabIndex        =   11
            Top             =   360
            Width           =   1815
         End
      End
      Begin ActiveTabs.SSActiveTabPanel SSActiveTabPanel1 
         Height          =   2865
         Left            =   -99969
         TabIndex        =   5
         Top             =   360
         Width           =   6195
         _ExtentX        =   10927
         _ExtentY        =   5054
         _Version        =   262144
         TabGuid         =   "frmFindReplace.frx":007B
         Begin VB.CommandButton cmdReplace 
            Caption         =   "Replace"
            Height          =   375
            Left            =   1680
            TabIndex        =   9
            Top             =   1320
            Width           =   975
         End
         Begin VB.CommandButton cmdReplaceAll 
            Caption         =   "Replace All"
            Enabled         =   0   'False
            Height          =   375
            Left            =   2760
            TabIndex        =   8
            Top             =   1320
            Width           =   975
         End
         Begin VB.TextBox txtReplace 
            Height          =   375
            Left            =   1200
            TabIndex        =   7
            Top             =   600
            Width           =   4935
         End
         Begin VB.Label lblReplace 
            Caption         =   "Replace with:"
            Height          =   255
            Left            =   120
            TabIndex        =   6
            Top             =   600
            Width           =   1000
         End
      End
      Begin VB.CommandButton cmdCancel 
         Caption         =   "Cancel"
         Height          =   375
         Left            =   5040
         TabIndex        =   4
         Top             =   1680
         Width           =   975
      End
      Begin VB.CommandButton cmdFind 
         Caption         =   "Find Next"
         Enabled         =   0   'False
         Height          =   375
         Left            =   3960
         TabIndex        =   3
         Top             =   1680
         Width           =   975
      End
      Begin VB.TextBox txtFind 
         Height          =   375
         Left            =   1200
         TabIndex        =   2
         Top             =   480
         Width           =   4935
      End
      Begin VB.Label lblFind 
         Caption         =   "Find What:"
         Height          =   255
         Left            =   120
         TabIndex        =   1
         Top             =   600
         Width           =   855
      End
   End
End
Attribute VB_Name = "frmDlgFindReplace"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'************************************************************************
' frmDlgFindReplace (form)
'
' Author: Irene Bellettiere
' Created: 18-Feb-05
'
' UPDATE HISTORY:
'
'************************************************************************
Option Explicit
Dim m_txtText As TXTextControl

Dim m_strCurrent As String 'existing string
Dim m_strNew As String 'replacement string
Dim m_lngStart As Long 'starting position of search
Dim m_blnMatchCase As Boolean
Dim m_blnWholeWord As Boolean

Const C_SEARCHUP = 1
Const C_MATCHCAS = 4
Const C_NOHILITE = 8
Const C_NOMSGBOX = 16
Friend Sub ShowFind(ByRef ar_TXTextControl As TXTextControl)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_ShowFind
    blnSuccess = False

    Set m_txtText = ar_TXTextControl
    
    'Me.Show 1
    Me.Show 0   'PR Needed to this as when copeinfo is opened clicking on any richtext icon was moving focus away from the screen
    
    

    blnSuccess = True

Exit_ShowFind:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_ShowFind:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFindReplace::ShowFind"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFindReplace", "ShowFind", strErrSource, False
    
    Resume Exit_ShowFind

End Sub

'*********************************************************************
' ChkCase_Click (private sub)
'
' Author: Irene Bellettiere
' Created: 22-Feb-05
'
' UPDATE HISTORY:
'
'*********************************************************************
Private Sub ChkCase_Click()

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_ChkCase_Click
    blnSuccess = False

    m_lngStart = 0
    With m_txtText
        .SelLength = 0
    End With
    
    Select Case ChkCase.Value
        Case vbChecked
            m_blnMatchCase = True
        Case Else
            m_blnMatchCase = False
    End Select

    blnSuccess = True

Exit_ChkCase_Click:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_ChkCase_Click:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFindReplace::ChkCase_Click"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFindReplace", "ChkCase_Click", strErrSource, False
    
    Resume Exit_ChkCase_Click

End Sub

Private Sub chkWholeWords_Click()

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_chkWholeWords_Click
    blnSuccess = False

    If chkWholeWords.Value = vbChecked Then
        m_blnWholeWord = True
    Else
        m_blnWholeWord = False
    End If
    

    blnSuccess = True

Exit_chkWholeWords_Click:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_chkWholeWords_Click:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFindReplace::chkWholeWords_Click"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFindReplace", "chkWholeWords_Click", strErrSource, False
    
    Resume Exit_chkWholeWords_Click

End Sub

Private Sub cmdCancel_Click()
    Unload Me
     
End Sub

Private Sub cmdFind_Click()
    
    
    Dim lngLoc As Long
    Dim lngCurStart As Long
    Dim lngCurLen As Long
    
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_cmdFind_Click
    blnSuccess = False

    
    If Len(txtFind.Text) = 0 Then Exit Sub
    
    With m_txtText
        
        .HideSelection = False
        .FormatSelection = True
        
        
        lngCurStart = .SelStart
        lngCurLen = .SelLength
        
        If m_blnMatchCase Then
            lngLoc = m_txtText.Find(m_strCurrent, m_lngStart, C_NOMSGBOX + C_MATCHCAS)
        Else
            lngLoc = m_txtText.Find(m_strCurrent, m_lngStart, C_NOMSGBOX)
        End If
        
        If lngLoc <> -1 Then 'string was found
            m_lngStart = lngLoc + 1
            cmdReplace.Enabled = True
        Else 'string was not found
            If m_lngStart > 0 Then
                'start search again from the beginning
                m_lngStart = 0
                If m_blnMatchCase Then
                    lngLoc = m_txtText.Find(m_strCurrent, m_lngStart, C_NOMSGBOX + C_MATCHCAS)
                Else
                    lngLoc = m_txtText.Find(m_strCurrent, m_lngStart, C_NOMSGBOX)
                End If
                
                If lngLoc <> -1 Then  'string was found
                    m_lngStart = lngLoc + 1
                    cmdReplace.Enabled = True
                Else 'string was not found
                    'reposition to last selection
                    .SelStart = lngCurStart
                    .SelLength = lngCurLen
                    cmdReplace.Enabled = False
                End If
            Else
                'reposition to last selection
                .SelStart = lngCurStart
                .SelLength = lngCurLen
                cmdReplace.Enabled = False
            End If
        End If
    End With
    
    blnSuccess = True

Exit_cmdFind_Click:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_cmdFind_Click:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFindReplace::cmdFind_Click"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFindReplace", "cmdFind_Click", strErrSource, False
    
    Resume Exit_cmdFind_Click

End Sub

Private Sub cmdReplace_Click()

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_cmdReplace_Click
    blnSuccess = False

    If m_txtText.SelLength = 0 Then 'IB check selection before replace.
        Call cmdFind_Click
    End If
    
    'note: word doesn't check for blank in the replacement text, so text
    'gets deleted. This works the same way.
    
    With m_txtText
        .SelText = m_strNew
        cmdReplace.Enabled = False
    End With

    blnSuccess = True

Exit_cmdReplace_Click:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_cmdReplace_Click:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFindReplace::cmdReplace_Click"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFindReplace", "cmdReplace_Click", strErrSource, False
    
    Resume Exit_cmdReplace_Click

End Sub

'********************************************************************
' cmdReplaceAll_Click
'
' Author: Irene Bellettiere
' Created: 18-Feb-05
'
' UPDATE HISTORY:
'
'********************************************************************
Private Sub cmdReplaceAll_Click()
    Const NOMSGBOX = 16
    
    Dim lngLoc As Long
    Dim strCurrent As String
    Dim strNew As String
    
    Dim lngCurLoc As Long
    Dim lngCurLen As Long
    
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_cmdReplaceAll_Click
    blnSuccess = False

    

    With m_txtText
        .FormatSelection = True
        .HideSelection = False
        strCurrent = txtFind.Text
        strNew = txtReplace.Text
        
        'check replacement string is not blank
        If Trim(strNew) = "" Then
            Call cmdFind_Click
            Exit Sub
        End If
        
        'save current selection
        lngCurLoc = .SelStart
        lngCurLen = .SelLength
        
        If m_blnMatchCase Then
            lngLoc = m_txtText.Find(m_strCurrent, m_lngStart, C_NOMSGBOX + C_MATCHCAS)
        Else
            lngLoc = .Find(strCurrent, 0, C_NOMSGBOX)
        End If
        
        While (lngLoc <> -1)
            .SelText = strNew
            
            If m_blnMatchCase Then
                lngLoc = m_txtText.Find(m_strCurrent, m_lngStart, C_NOMSGBOX + C_MATCHCAS)
            Else
                lngLoc = .Find(strCurrent, lngLoc + 1, C_NOMSGBOX)
            End If
        Wend
        
        'restore beginning selection
        .SelStart = lngCurLoc
        .SelLength = lngCurLen
    End With

    blnSuccess = True

Exit_cmdReplaceAll_Click:

    On Error Resume Next

    ' Place All Set Object = Nothing Here...
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_cmdReplaceAll_Click:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFindReplace::cmdReplaceAll_Click"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFindReplace", "cmdReplaceAll_Click", strErrSource, False
    
    Resume Exit_cmdReplaceAll_Click

End Sub

'************************************************************************
' Form_Activate (private sub)
'
' Author: Irene Bellettiere
' Created: 18-Feb-05
'
' UPDATE HISTORY:
'
'************************************************************************
Private Sub Form_Activate()

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_Form_Activate
    blnSuccess = False

    txtFind.SetFocus

    blnSuccess = True

Exit_Form_Activate:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_Form_Activate:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFindReplace::Form_Activate"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFindReplace", "Form_Activate", strErrSource, False
    
    Resume Exit_Form_Activate

End Sub

Private Sub Form_Load()

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_Form_Load
    blnSuccess = False

    m_strCurrent = ""
    m_strNew = ""
    m_lngStart = 0
    m_blnWholeWord = False
    cmdReplace.Enabled = False 'disabled until after find is executed and word to replace is found.
    
    blnSuccess = True

Exit_Form_Load:

    On Error Resume Next

    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_Form_Load:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFindReplace::Form_Load"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFindReplace", "Form_Load", strErrSource, False
    
    Resume Exit_Form_Load

End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    Set m_txtText = Nothing
End Sub









'**************************************************************************
' txtFind_Change (private sub)
'
' Author: Irene Bellettiere
' Created: 23-Mar-05
'
' UPDATE HISTORY:
'
'**************************************************************************
Private Sub txtFind_Change()

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_txtFind_Change
    blnSuccess = False

    If txtFind.Text <> "" Then
        cmdFind.Enabled = True
        cmdReplaceAll.Enabled = True
    Else
        cmdFind.Enabled = False
        cmdReplace.Enabled = False
        cmdReplaceAll.Enabled = False
    End If

    blnSuccess = True

Exit_txtFind_Change:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_txtFind_Change:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFindReplace::txtFind_Change"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFindReplace", "txtFind_Change", strErrSource, False
    
    Resume Exit_txtFind_Change

End Sub

'************************************************************************
' txtFind_Validate (private sub)
'
' Author: Irene Bellettiere
' Created: 18-Feb-05
'
' UPDATE HISTORY:
'
'************************************************************************
Private Sub txtFind_Validate(Cancel As Boolean)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_txtFind_Validate
    blnSuccess = False

    m_strCurrent = txtFind.Text

    blnSuccess = True

Exit_txtFind_Validate:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_txtFind_Validate:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFindReplace::txtFind_Validate"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFindReplace", "txtFind_Validate", strErrSource, False
    
    Resume Exit_txtFind_Validate

End Sub







'************************************************************************
' txtReplace_Validate (private sub)
'
' Author: Irene Bellettiere
' Created: 18-Feb-05
'
' UPDATE HISTORY:
'
'************************************************************************
Private Sub txtReplace_Validate(Cancel As Boolean)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_txtReplace_Validate
    blnSuccess = False

    m_strNew = txtReplace.Text
    
'    m_lngStart = 0
'    With m_txtText
'        .SelLength = 0
'    End With

    blnSuccess = True

Exit_txtReplace_Validate:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_txtReplace_Validate:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFindReplace::txtReplace_Validate"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFindReplace", "txtReplace_Validate", strErrSource, False
    
    Resume Exit_txtReplace_Validate

End Sub
