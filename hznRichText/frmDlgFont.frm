VERSION 5.00
Begin VB.Form frmDlgFont 
   Caption         =   "Font Attributes"
   ClientHeight    =   1380
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   3780
   LinkTopic       =   "Form1"
   ScaleHeight     =   1380
   ScaleWidth      =   3780
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdCancel 
      BackColor       =   &H00C0C0C0&
      Cancel          =   -1  'True
      Caption         =   "&Cancel"
      Height          =   375
      Left            =   2520
      TabIndex        =   3
      Top             =   720
      Width           =   1095
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "&OK"
      Height          =   375
      Left            =   2520
      TabIndex        =   2
      Top             =   120
      Width           =   1095
   End
   Begin VB.CheckBox chkFont 
      Caption         =   "Subscript"
      Height          =   375
      Index           =   1
      Left            =   240
      TabIndex        =   1
      Top             =   480
      Width           =   1935
   End
   Begin VB.CheckBox chkFont 
      Caption         =   "SuperScript"
      Height          =   255
      Index           =   0
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   1815
   End
End
Attribute VB_Name = "frmDlgFont"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim m_ctlText As TXTextControl

Friend Sub showFontProp(ByRef ar_ctlControl As TXTextControl)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_showFontProp
    blnSuccess = False

    Set m_ctlText = ar_ctlControl
    Select Case m_ctlText.BaseLine
              
        Case Is < 0
            chkFont(1).Value = vbChecked 'subscript
            
        Case Is > 0
            chkFont(0).Value = vbChecked 'superscript
            
        Case Else
            chkFont(0).Value = vbUnchecked 'normal
            chkFont(1).Value = vbUnchecked
    End Select
    
    'Me.Show 1
    Me.Show 0   'PR Needed to this as when copeinfo is opened clicking on any richtext icon was moving focus away from the screen

    blnSuccess = True

Exit_showFontProp:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_showFontProp:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFont::showFontProp"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFont", "showFontProp", strErrSource, False
    
    Resume Exit_showFontProp

End Sub

'*************************************************************************
' chkFont_Click (private sub)
'
' Author: Irene Bellettiere
' Created: 15-Feb-05
'
' UPDATE HISTORY:
'
'*************************************************************************
Private Sub chkFont_Click(Index As Integer)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_chkFont_Click
    blnSuccess = False

    Select Case Index
        Case 0
            If chkFont(0).Value = vbChecked Then
                chkFont(1).Value = vbUnchecked
            End If
        Case 1
            If chkFont(1).Value = vbChecked Then
                chkFont(0).Value = vbUnchecked
            End If
    End Select
    

    blnSuccess = True

Exit_chkFont_Click:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_chkFont_Click:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFont::chkFont_Click"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFont", "chkFont_Click", strErrSource, False
    
    Resume Exit_chkFont_Click

End Sub

Private Sub cmdCancel_Click()

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_cmdCancel_Click
    blnSuccess = False

    Unload Me

    blnSuccess = True

Exit_cmdCancel_Click:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_cmdCancel_Click:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFont::cmdCancel_Click"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFont", "cmdCancel_Click", strErrSource, False
    
    Resume Exit_cmdCancel_Click

End Sub

Private Sub cmdOk_Click()
    Dim intfontsize As Integer
    Dim intbaseline As Integer
    
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_cmdOk_Click
    blnSuccess = False

    With m_ctlText
        
        If chkFont.Item(0).Value = vbChecked Then
            .BaseLine = 75 'superscript
            .FontSize = 6
           
        ElseIf chkFont.Item(1).Value = vbChecked Then
            .BaseLine = -75 'subscript
            .FontSize = 6
        Else
            .BaseLine = 0 'normal
            .FontSize = 11
        End If
        
    End With
    
    Unload Me

    blnSuccess = True

Exit_cmdOk_Click:

    On Error Resume Next

    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_cmdOk_Click:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgFont::cmdOK_Click"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgFont", "cmdOK_Click", strErrSource, False
    
    Resume Exit_cmdOk_Click

End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    Set m_ctlText = Nothing
End Sub
