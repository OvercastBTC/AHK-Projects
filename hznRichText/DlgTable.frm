VERSION 5.00
Begin VB.Form frmDlgTable 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Table Attributes"
   ClientHeight    =   990
   ClientLeft      =   1650
   ClientTop       =   3585
   ClientWidth     =   3660
   Icon            =   "DlgTable.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   990
   ScaleWidth      =   3660
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.ComboBox cboRows 
      Height          =   315
      Left            =   900
      TabIndex        =   1
      Text            =   "Combo1"
      Top             =   120
      Width           =   975
   End
   Begin VB.ComboBox cboColumns 
      Height          =   315
      Left            =   900
      TabIndex        =   3
      Text            =   "Combo1"
      Top             =   540
      Width           =   975
   End
   Begin VB.CommandButton cmdCancel 
      BackColor       =   &H00C0C0C0&
      Cancel          =   -1  'True
      Caption         =   "&Cancel"
      Height          =   375
      Left            =   2400
      TabIndex        =   5
      Top             =   480
      Width           =   1095
   End
   Begin VB.CommandButton cmdOK 
      BackColor       =   &H00C0C0C0&
      Caption         =   "&OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   2400
      TabIndex        =   4
      Top             =   60
      Width           =   1095
   End
   Begin VB.Label lblCols 
      Caption         =   "Co&lumns:"
      Height          =   255
      Left            =   90
      TabIndex        =   2
      Top             =   570
      Width           =   765
   End
   Begin VB.Label lblRows 
      Caption         =   "&Rows:"
      Height          =   255
      Left            =   90
      TabIndex        =   0
      Top             =   180
      Width           =   765
   End
End
Attribute VB_Name = "frmDlgTable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'*******************************************************************************
' MODULE:       frmTableDlg
' FILENAME:     tabledlg.frm
' AUTHOR:       David Boss
' CREATED:      20-Mar-2001
' COPYRIGHT:    Copyright 2001 FM Global. All Rights Reserved.
'
' DESCRIPTION:
' Dialog form that sets the columns and rows of a table in the ctlTxText control
'
' MODIFICATION HISTORY:
' 1.0       26-Mar-2001
'           David Boss
'           Initial Version
' Modification LMS 9/09/2003 replace Me.show with me.show 1 in ShowTableProp
' Replaced form on 09/04/2003 with old frmDlgTable
' per Clear Quest 1952
'*******************************************************************************
Option Explicit
Private m_ctlText As TXTextControl

'*******************************************************************************
' cmdCancel_Click (SUB)
'
' PARAMETERS:
' None
'
' DESCRIPTION:
' Cancels and unloads form
'*******************************************************************************
Private Sub cmdCancel_Click()

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_cmdCancel_Click
    blnSuccess = False

  Unload Me

    ' Insert Procedure Code Here...

    blnSuccess = True

Exit_cmdCancel_Click:

    On Error Resume Next
    
    ' Place All Set Object = Nothing Here...
    
    Exit Sub

Err_cmdCancel_Click:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgTable::cmdCancel_Click"

    hznErrHandler lngErrNum, strErrDesc, "frmDlgTable", "cmdCancel_Click", strErrSource, True
    
    Resume Exit_cmdCancel_Click

End Sub

'*******************************************************************************
' cmdOk_Click (SUB)
'
' PARAMETERS:
' None
'
' DESCRIPTION:
' Sets the column and row propertie of the table
'*******************************************************************************
Private Sub cmdOk_Click()
  Dim intRows As Integer
  Dim intColumns As Integer
  Dim lngTableId As Long
  Dim a_lngTemp() As Long

  Dim strErrDesc As String
  Dim strErrSource As String
  Dim lngErrNum As Long
    
  Dim blnSuccess As Boolean
  On Error GoTo Err_cmdOk_Click
  blnSuccess = False
  
  'save current position
  a_lngTemp = m_ctlText.CurrentInputPosition
  
  intRows = Val(cboRows.Text)
  intColumns = Val(cboColumns.Text)
  m_ctlText.ScrollBars = 3
  m_ctlText.PageWidth = 7950
  m_ctlText.TableInsert intRows, intColumns, -1
  
  'if current position not first char in line, set to next line
  'new tables always start on new line
  If a_lngTemp(2) > 1 Then
    a_lngTemp(2) = 0
    a_lngTemp(1) = a_lngTemp(1) + 1
  End If
  'reset current position
  m_ctlText.CurrentInputPosition = a_lngTemp
  'lm - Oct 2005 - moved to Text Get
  'at times causes Method TableCellAttribute of Object Failed error
  'set grid lines on
  'lngTableId = m_ctlText.TableAtInputPos
  'If lngTableId <> 0 Then
  '  m_ctlText.TableCellAttribute(lngTableId, 0, 0, txTableCellBorderWidth) = 0.75
  'End If
  
  'put focus back to TxTextcontrol row/col 1
  m_ctlText.SetFocus
  
  Unload Me
  blnSuccess = True

Exit_cmdOk_Click:

    On Error Resume Next
    
    Exit Sub

Err_cmdOk_Click:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgTable::cmdOk_Click"

    hznErrHandler lngErrNum, strErrDesc, "frmDlgTable", "cmdOk_Click", strErrSource, True
    
    Resume Exit_cmdOk_Click

End Sub

'*******************************************************************************
' Form_Load (SUB)
'
' PARAMETERS:
' None
'
' DESCRIPTION:
' Sets the combo boxes on load of form
'*******************************************************************************
Private Sub Form_Load()
  Dim intItem As Integer

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_Form_Load
    blnSuccess = False

  For intItem = 1 To 12
      cboColumns.AddItem intItem
  Next
  For intItem = 1 To 100
      cboRows.AddItem intItem
  Next
  cboColumns.ListIndex = 1
  cboRows.ListIndex = 1

    ' Insert Procedure Code Here...

    blnSuccess = True

Exit_Form_Load:

    On Error Resume Next
    
    ' Place All Set Object = Nothing Here...
    
    Exit Sub

Err_Form_Load:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgTable::Form_Load"

    hznErrHandler lngErrNum, strErrDesc, "frmDlgTable", "Form_Load", strErrSource, True
    
    Resume Exit_Form_Load

End Sub

'*******************************************************************************
' ShowTableProp (SUB)
'
' PARAMETERS:
' (In/Out) - ctlControl - TXTextControl -
'
' DESCRIPTION:
' The procedure that is called from the ctlTxText control
' Modification LMS 9/09/2003 replace Me.show with me.show 1 in ShowTableProp
' Replaced form erplaced on 09/04/2003 with old frmDlgTable
' per Clear Quest 1952
'*******************************************************************************
Friend Sub ShowTableProp(ByRef ar_ctlControl As TXTextControl)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_ShowTableProp
    blnSuccess = False

    Set m_ctlText = ar_ctlControl
    ' Modification LMS 9/09/2003 replace Me.show with frmDlgTable.Show
    ' Replaced form erplaced on 09/04/2003 with old frmDlgTable
  
    
    'Me.Show 1
    Me.Show 0   'PR Needed to this as when copeinfo is opened clicking on any richtext icon was moving focus away from the screen
    ' Insert Procedure Code Here...

    blnSuccess = True

Exit_ShowTableProp:

    On Error Resume Next

    ' Place All Set Object = Nothing Here...
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_ShowTableProp:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "frmDlgTable::ShowTableProp"
    
    hznErrHandler lngErrNum, strErrDesc, "frmDlgTable", "ShowTableProp", strErrSource, False
    
    Resume Exit_ShowTableProp

End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next 'IB 15-Feb-05 added
    Set m_ctlText = Nothing 'IB 15-Feb-05 added
End Sub
