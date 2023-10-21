VERSION 5.00
Object = "{1B635020-8269-11D8-9E2B-004005A9ABD2}#1.6#0"; "tx4ole11.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Object = "{245338C0-BCA3-4A2C-A7B7-53345999A8E8}#1.0#0"; "wspell.ocx"
Begin VB.UserControl fmgRichText 
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   5052
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   8748
   ScaleHeight     =   5052
   ScaleWidth      =   8748
   ToolboxBitmap   =   "ctlRichText.ctx":0000
   Begin WSPELLLib.WSpell WSpell1 
      Left            =   1440
      Top             =   3480
      _Version        =   65536
      _ExtentX        =   360
      _ExtentY        =   466
      _StockProps     =   16
      IgnoreNonAlphaWords=   -1  'True
      MainDictionaryFiles=   ""
   End
   Begin Tx4oleLib.TXStatusBar TXStatusBar1 
      Align           =   2  'Align Bottom
      Height          =   315
      Left            =   0
      TabIndex        =   2
      Top             =   4740
      Visible         =   0   'False
      Width           =   8745
      _Version        =   65542
      _ExtentX        =   15425
      _ExtentY        =   556
      _StockProps     =   116
      Enabled         =   0   'False
      Language        =   1
      TextPage        =   "Page"
      TextLine        =   "Line"
      TextColumn      =   "Col"
   End
   Begin VB.Timer tmrUnpaste 
      Enabled         =   0   'False
      Interval        =   5
      Left            =   600
      Top             =   2880
   End
   Begin MSComctlLib.ImageList ilsTop 
      Left            =   0
      Top             =   2880
      _ExtentX        =   995
      _ExtentY        =   995
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   19
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":0312
            Key             =   "Bold"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":0424
            Key             =   "Underline"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":0536
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":0648
            Key             =   "Center"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":075A
            Key             =   "Italic"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":086C
            Key             =   "Cut"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":097E
            Key             =   "Justified"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":0A90
            Key             =   "Left"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":0BA2
            Key             =   "Paste"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":0CB4
            Key             =   "Right"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":0DC6
            Key             =   "IMG11"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":10E0
            Key             =   "Undo"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":11F2
            Key             =   "Redo"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":1304
            Key             =   "table"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":161E
            Key             =   "bullets"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":1AA8
            Key             =   "bullets1"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":1DFA
            Key             =   "Spell Check"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":1F0C
            Key             =   "Font"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ctlRichText.ctx":265E
            Key             =   "Find"
         EndProperty
      EndProperty
   End
   Begin Tx4oleLib.TXTextControl TXTextControl1 
      Height          =   2055
      Left            =   0
      TabIndex        =   0
      Top             =   330
      Width           =   8745
      _Version        =   65542
      _ExtentX        =   15425
      _ExtentY        =   3625
      _StockProps     =   73
      ForeColor       =   -2147483640
      BackColor       =   16777215
      Language        =   1
      BorderStyle     =   0
      BackStyle       =   1
      ControlChars    =   0   'False
      EditMode        =   0
      HideSelection   =   -1  'True
      InsertionMode   =   -1  'True
      MousePointer    =   0
      ZoomFactor      =   100
      ViewMode        =   3
      ClipChildren    =   -1  'True
      ClipSiblings    =   -1  'True
      SizeMode        =   0
      TabKey          =   -1  'True
      FormatSelection =   -1  'True
      VTSpellDictionary=   "C:\PROGRA~1\THEIMA~1\TXTEXT~1.0\Bin\AMERICAN.VTD"
      ScrollBars      =   2
      PageWidth       =   12240
      PageHeight      =   17000
      PageMarginL     =   0
      PageMarginT     =   0
      PageMarginR     =   0
      PageMarginB     =   0
      PrintZoom       =   100
      PrintOffset     =   0   'False
      PrintColors     =   0   'False
      FontName        =   "Times New Roman"
      FontSize        =   11
      FontBold        =   0   'False
      FontItalic      =   0   'False
      FontStrikethru  =   0   'False
      FontUnderline   =   0   'False
      Baseline        =   0
      TextBkColor     =   16777215
      Alignment       =   0
      LineSpacing     =   100
      LineSpacingT    =   0
      FrameStyle      =   32
      FrameDistance   =   0
      FrameLineWidth  =   20
      IndentL         =   0
      IndentR         =   0
      IndentFL        =   0
      IndentT         =   0
      IndentB         =   0
      Text            =   ""
      WordWrapMode    =   1
      AllowUndo       =   -1  'True
   End
   Begin MSComctlLib.Toolbar tlbrTop 
      Height          =   264
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   8748
      _ExtentX        =   15431
      _ExtentY        =   466
      ButtonWidth     =   487
      ButtonHeight    =   466
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      ImageList       =   "ilsTop"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   21
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Bold"
            Description     =   "Bold"
            Object.ToolTipText     =   "Bold"
            ImageKey        =   "Bold"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Italic"
            Description     =   "Italic"
            Object.ToolTipText     =   "Italic"
            ImageKey        =   "Italic"
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "Underline"
            Description     =   "Underline"
            Object.ToolTipText     =   "Underline"
            ImageKey        =   "Underline"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "Left"
            Description     =   "Left"
            Object.ToolTipText     =   "Align Left"
            ImageKey        =   "Left"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "Right"
            Description     =   "Right"
            Object.ToolTipText     =   "Align Right"
            ImageKey        =   "Right"
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "Center"
            Description     =   "Center"
            Object.ToolTipText     =   "Align Center"
            ImageKey        =   "Center"
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "Justified"
            Description     =   "Justified"
            Object.ToolTipText     =   "Justified"
            ImageKey        =   "Justified"
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cut"
            Description     =   "Cut"
            Object.ToolTipText     =   "Cut"
            ImageKey        =   "Cut"
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Copy"
            Description     =   "Copy"
            Object.ToolTipText     =   "Copy"
            ImageKey        =   "Copy"
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Paste"
            Description     =   "Paste"
            Object.ToolTipText     =   "Paste"
            ImageKey        =   "Paste"
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Undo"
            Description     =   "Undo"
            Object.ToolTipText     =   "Undo"
            ImageKey        =   "Undo"
         EndProperty
         BeginProperty Button15 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Redo"
            Description     =   "Redo"
            Object.ToolTipText     =   "Redo"
            ImageKey        =   "Redo"
         EndProperty
         BeginProperty Button16 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button17 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Bullets"
            Description     =   "Bullets"
            Object.ToolTipText     =   "Bulleted List"
            ImageKey        =   "bullets1"
         EndProperty
         BeginProperty Button18 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Spell Check"
            Description     =   "Spell Check"
            Object.ToolTipText     =   "Spell Check"
            ImageKey        =   "Spell Check"
         EndProperty
         BeginProperty Button19 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Table"
            Description     =   "Table"
            Object.ToolTipText     =   "Insert Table"
            ImageKey        =   "table"
            Style           =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   10
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "Insert Table"
                  Text            =   "Insert Table"
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "Remove Table"
                  Text            =   "Remove Table"
               EndProperty
               BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "-"
                  Text            =   "-"
               EndProperty
               BeginProperty ButtonMenu4 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "Insert Column"
                  Text            =   "Insert Column"
               EndProperty
               BeginProperty ButtonMenu5 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "Insert Row"
                  Text            =   "Insert Row"
               EndProperty
               BeginProperty ButtonMenu6 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "sep2"
                  Text            =   "-"
               EndProperty
               BeginProperty ButtonMenu7 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "Remove Column"
                  Text            =   "Remove Column"
               EndProperty
               BeginProperty ButtonMenu8 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "Remove Row"
                  Text            =   "Remove Row"
               EndProperty
               BeginProperty ButtonMenu9 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "sep3"
                  Text            =   "-"
               EndProperty
               BeginProperty ButtonMenu10 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "Table Properties"
                  Text            =   "Table Properties"
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button20 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Font"
            Description     =   "Font"
            Object.ToolTipText     =   "Super/Sub Script"
            ImageKey        =   "Font"
         EndProperty
         BeginProperty Button21 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Find"
            Object.ToolTipText     =   "Find/Replace"
            ImageKey        =   "Find"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "fmgRichText"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'*******************************************************************************
' MODULE:       ctlTxText
' FILENAME:     fmgControls\ctlTxText.ctl
' AUTHOR:       David Boss
' CREATED:      16-Mar-2001
' COPYRIGHT:    Copyright 2001 FM Global. All Rights Reserved.
'
' DESCRIPTION:
' This is a wrapper custom control for the TxTextControl using
' the TxRuler and the standard Toolbar controls
' Developer must reference the TxTextControl Component Library:
' Tx4ole.ocx
'
' MODIFICATION HISTORY:
' 1.0       22-Mar-2001
'           David Boss
'           Initial Version
' 1.0.6     31-Jul-2001
'           David Boss
'           Added three properties:
'               HideToolbar
'               HideRuler
'               SpellCheckLostFocus
' 1.0.67    07-May-2002
'           Lynn Shevlin
'           Modified Public Property Get Text:
'           Using Tidy Com object correct incorrect HTML
'           Also stripped out Font references
' 1.068     15-May-2002
'           modified objTidy properties
' 1.069     20-JUN-2002
'           Lynn Shevlin
'           LMS modificiation replace Rich Text HTML to syntaxt that Print Preview
'           is able to interpret in TextGet
' 21-Jun-2002 - SAS - added error handling to SpellCheck
' 25-Jun-2002 - LMS - objTidy.Options.DropEmptyParas = False
' 26-Jun-2002 - SAS - replaced WSpell with VSSpell
' 07-Jul-2002 - LMS - replace MS Word special character set with ascii codes
' 31-Jul-2002 - SAS - commented out translation of '&amp' in Text get
' 31-Jul-2002 - LMS - changed Get Text and Let text replace to use Binary compatility
' 31-Jul-2002 - LMS - modified character translation to start with small letters for
' 09-Aug-2002 - SAS - modified character translation for most values between 128 and 159
' 18-Jun-2003 - MAR - added the IsOutdated property (CQ-1192)
' 23-Jun-2003 - JPK - Added the 'SpellCheckerLanguage' property to select a new main spell
'                     checker dictionary at runtime based on a language code. The language
'                     code is used to generate the filename of the main dictionary used. Spell
'                     checking is disabled by hiding the spell check button in the toolbar if no
'                     dictionary file is found for the language code passed. The default
'                     language is set to English ('EN'). The main dictionary file must
'                     be named 'C:\windows\system32\vssp_XX.dct' where 'XX' is the language
'                     code.
' 15-Sep-2003 - JPK - Set the spellchecker language to standard French when
'                     French Canadian is requested.
' 17-Sep-2003 - LM  - Handle case of no dictionary causing sys error 13 if spellchecknow called
' 23-Sep-2003 - LMS - per Clear Quest 2075 Convert Greater than or equal to, Less than equal to
'                     and not equal to in Text(Property Get).
' 05-Nov-2003 - GBW - Modified .Text property to try .FontSize and .FontItalic settings several
'                       times if one fails.  When one fails, you normally get "The objet invoked has
'                       disconnected from its clients."  Now, they will be tried up to 10 times before
'                       finally throwing the error.
' 08-Nov-2003 - GBW - Modified SetTextFormat as indicated above for Font handling.  Also,
'                       did a search across the application to be sure no more scenarios exists.
' 15-Jan-2004 - JPK - 1) Change the ANSI font size from tahoma 8 pt to tahoma 10 pt for readability.
'                     2) Convert the HTML character &ndash; to &#8211;
'                     3) Revert back to WSpell from VSSpell. Wintertree Software has included
'                        support for the TX Text Control. This should alleviate the automation
'                        errors that had been encountered when using the older version of
'                        WSpell.
' 03-Feb-2003 - JPK - To improve performance the Wspell main dictionary will be set
'                     only when spellchecking is being done and no dictionary has
'                     previously been set or when the language is reset.
' 23-Nov-2004 - SAS - CQ6318 - Replace occurances of #146 with #39 and
'                       occurances of <br> with <br/>
' 28-Sep-2005 - SAS - CQ7956, change numbered list left margin from 1.5 to 2.0
' 13-Dec-2005 - SAS - CQ8234, commented out m_intSelStartForSpelling, not used
'                       rich text field with over 32,768 characters caused overflow error
'*******************************************************************************
Option Explicit

Public Enum enumTextFormat
  ANSI = 1
  HTML = 4
End Enum



Private Enum enumExclude
    exNone = 0
    exObject = 1
    extable = 2
    exTableTooLarge = 3
End Enum

Public Enum enumTableMax
    enumZero = 0 'default value
    enumShort = 1 'used for rec detail
    enumWide = 2 'used for comments
End Enum


Private m_endOfTextFired As Boolean             ' 15-Jan-2004 - JPK

Private m_strPrevious As String
Private m_bytExclude As Byte

Private m_blnJustPasted As Boolean
Private m_blnJustPastedDelete As Boolean
Private m_blnSetFormat As Boolean
Private m_blnEnabled As Boolean
'Private m_blnHideRuler As Boolean
Private m_blnAnsiFontBold As Boolean
Private m_blnHideToolbar As Boolean
Private m_blnSpllChkLstFcs As Boolean
Private m_blnSpllChkDictFound As Boolean
Private m_blnLocked As Boolean
Private m_strTextProp As String
Private m_blnAlwaysItalic As Boolean
Private m_blnEnableUnderline As Boolean 'IB 28-Mar-05
Private m_blnTableEnabled As Boolean
Private m_abytData() As Byte
Private m_intTextFormat As Integer
Private m_intMaxLines As Integer
Private m_intMaxChar As Integer
Private m_blnInitialUse As Boolean
Private m_blnIsRequired As Boolean
Private m_blnVerticalScrollBars As Boolean
Private m_IsOutdated As Boolean                     'MAR 06/11/2003 CQ-1192
Private m_strSpellCheckerLanguage As String         ' 23-Jun-2003 - JPK
Private m_strChangeText As String                   '03-Oct-2003 - LM
Private m_intTableId As Integer 'IB 09-Feb-05
Private m_eTableMaxWidth As enumTableMax 'IB 10-Feb-05
'Dim m_intSelStartForSpelling    As Long 'IB 11-Feb-05, SAS CQ8234
Dim m_strMisspelledWord As String 'IB 11-Feb-05
Dim m_blnSubScriptEnabled As Boolean 'IB 16-Feb-05

'Event Declarations:
Event Change()
Event Click()
Event Error(Number As Integer, _
                Description As String, _
                Scode As Long, _
                Source As String, _
                HelpFile As String, _
                HelpContext As Long, _
                CancelDisplay As Boolean)
                
Event KeyDown(KeyCode As Integer, _
                Shift As Integer)
                
Event KeyPress(KeyAscii As Integer)

Event KeyUp(KeyCode As Integer, _
                Shift As Integer)
                
Event MouseDown(Button As Integer, _
                Shift As Integer, _
                X As Single, _
                Y As Single)
                
Event MouseUp(Button As Integer, _
                Shift As Integer, _
                X As Single, _
                Y As Single)
                
Event MouseMove(Button As Integer, _
                Shift As Integer, _
                X As Single, _
                Y As Single)

Const C_SHORT_MAX = 7600 'IB 10-Feb-05 (corresponds to 5" on report)
Const C_WIDE_MAX = 9500 'IB 10-Feb-05 (corresponds to 6.25" on report)
'************************************************************************
' clearFont (public function)
'
' Author: Irene Bellettiere
' Created: 30-Mar-05
'
' UPDATE HISTORY:
'
'************************************************************************
Public Function clearFont() As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_clearFont
    blnSuccess = False
    
    'reset module level variables (IB - not sure about these)
    'm_blnAnsiFontBold = False
    'm_blnAlwaysItalic = False
    
    'clear font properties
    With TXTextControl1
        .FormatSelection = False
        .FontBold = 0
        .FontItalic = 0
        .FontUnderline = 0
        .FormatSelection = True
    End With
    
    ToggleToolbarButtons
    
    blnSuccess = True

Exit_clearFont:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_clearFont:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::clearFont"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "clearFont", strErrSource, False
    
    Resume Exit_clearFont

End Function


'*******************************************************************************
' SetItalic (SUB)
' DESCRIPTION:
'   sets or releases all text to or from underline
'
' PARAMETERS:
' None
'*******************************************************************************
Private Sub SetUnderline()
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_SetUnderline
    blnSuccess = False

    If m_blnEnableUnderline Then
        tlbrTop.Buttons("Underline").Visible = True
    Else
        tlbrTop.Buttons("Underline").Visible = False
    End If

    blnSuccess = True

Exit_SetUnderline:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_SetUnderline:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::SetUnderline"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "SetUnderline", strErrSource, False
    
    Resume Exit_SetUnderline

End Sub
'*******************************************************************************
' FontUnderline (PROPERTY)
'
' Description: Returns property for Underlined Text
'
' Author: Irene Bellettiere
' Created: 28-Mar-05
'
' UPDATE HISTORY:
'
'*******************************************************************************
Public Property Get EnableUnderline() As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_EnableUnderline
    blnSuccess = False

    EnableUnderline = m_blnEnableUnderline

    blnSuccess = True

Exit_EnableUnderline:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_EnableUnderline:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::EnableUnderline"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "EnableUnderline", strErrSource, False
    
    Resume Exit_EnableUnderline

End Property

'*******************************************************************************
' FontUnderline (PROPERTY LET)
'
' Author: Irene Bellettiere
' Created: 28-Mar-05
'
' UPDATE HISTORY:
'
'
'*******************************************************************************
Public Property Let EnableUnderline(ByVal av_blnData As Boolean)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_EnableUnderline
    blnSuccess = False

    m_blnEnableUnderline = av_blnData
    
    'set button
    With tlbrTop.Buttons("Underline")
        .Visible = m_blnEnableUnderline
        .Enabled = m_blnEnableUnderline
    End With
    
    'change property
    PropertyChanged "EnableUnderline"

    blnSuccess = True

Exit_EnableUnderline:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_EnableUnderline:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::EnableUnderline"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "EnableUnderline", strErrSource, False
    
    Resume Exit_EnableUnderline

End Property

'*******************************************************************************
' subScriptEnabled (PROPERTY GET)
'
' Author: Irene Bellettiere
' Created: 16-Feb-05
'
' UPDATE HISTORY:
'
'*******************************************************************************
Public Property Get subScriptEnabled() As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_subScriptEnabled
    blnSuccess = False

    subScriptEnabled = m_blnSubScriptEnabled

    blnSuccess = True

Exit_subScriptEnabled:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_subScriptEnabled:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::subScriptEnabled"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "subScriptEnabled", strErrSource, False
    
    Resume Exit_subScriptEnabled

End Property


'*******************************************************************************
' subScriptEnabled (PROPERTY LET)
'*******************************************************************************
Public Property Let subScriptEnabled(ByVal av_blnData As Boolean)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_subScriptEnabled
    blnSuccess = False

    m_blnSubScriptEnabled = av_blnData
    
    'hide or show button on toolbar
    With tlbrTop.Buttons("Font")
        .Enabled = m_blnSubScriptEnabled
        .Visible = m_blnSubScriptEnabled
    End With
    
    ToggleControls
    
    'change property
    PropertyChanged "subScriptEnabled"

    blnSuccess = True

Exit_subScriptEnabled:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_subScriptEnabled:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::subScriptEnabled"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "subScriptEnabled", strErrSource, False
    
    Resume Exit_subScriptEnabled

End Property

'*******************************************************************************
' TableEnable (PROPERTY LET)
'*******************************************************************************
Public Property Let TableMaxWidth(ByVal av_eData As enumTableMax)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_TableMaxWidth
    blnSuccess = False

    m_eTableMaxWidth = av_eData
    
    PropertyChanged "TableMaxWidth"

    blnSuccess = True

Exit_TableMaxWidth:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_TableMaxWidth:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::TableMaxWidth"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "TableMaxWidth", strErrSource, False
    
    Resume Exit_TableMaxWidth

End Property



'******************************************************************************
' StripAllSpanTags (private function)
'
' Description: used with version 11 of txtText control
'
' Author: Irene Bellettiere
' Created: 28-Jan-05
'
' UPDATE HISTORY:
'
'******************************************************************************
Private Function StripAllSpanTags(ByVal av_strTextProp As String) As String
    Dim lngInstr1 As Long
    Dim lngInstr2 As Long
    Dim strTemp As String
    Dim strTemp1 As String
    Dim strTemp2 As String

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_StripAllSpanTags
    blnSuccess = False
    
    
    strTemp = Trim(av_strTextProp)
    StripAllSpanTags = strTemp
    If strTemp = "" Then Exit Function


    lngInstr1 = InStr(strTemp, "<span>")
    While lngInstr1 > 0
        strTemp1 = Left(strTemp, lngInstr1 - 1)
        strTemp2 = Right(strTemp, Len(strTemp) - lngInstr1 - 5)
        lngInstr2 = InStr(strTemp2, "</span>")
        strTemp2 = Left(strTemp2, lngInstr2 - 1) & Right(strTemp2, Len(strTemp2) - (lngInstr2 + 6))
        strTemp = strTemp1 & strTemp2
        lngInstr1 = InStr(strTemp, "<span>")
    Wend
    
    StripAllSpanTags = strTemp
    
    blnSuccess = True

Exit_StripAllSpanTags:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_StripAllSpanTags:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::StripAllSpanTags"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "StripAllSpanTags", strErrSource, False
    
    Resume Exit_StripAllSpanTags

End Function

'*******************************************************************************
' AlwaysItalic (PROPERTY)
' Returns and sets the control to produce only Italic Text
'*******************************************************************************
'*******************************************************************************
' AlwaysItalic (PROPERTY GET)
'*******************************************************************************
Public Property Get AlwaysItalic() As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_AlwaysItalic
    blnSuccess = False

    AlwaysItalic = m_blnAlwaysItalic

    blnSuccess = True

Exit_AlwaysItalic:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_AlwaysItalic:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::AlwaysItalic"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "AlwaysItalic", strErrSource, False
    
    Resume Exit_AlwaysItalic

End Property

'*******************************************************************************
' AlwaysItalic (PROPERTY LET)
'*******************************************************************************
Public Property Let AlwaysItalic(ByVal av_blnData As Boolean)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_AlwaysItalic
    blnSuccess = False

    m_blnAlwaysItalic = av_blnData
    'set button
    tlbrTop.Buttons("Italic").Visible = Not (m_blnAlwaysItalic)
    'change property
    PropertyChanged "AlwaysItalic"

    blnSuccess = True

Exit_AlwaysItalic:

    On Error Resume Next
   
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_AlwaysItalic:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::AlwaysItalic"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "AlwaysItalic", strErrSource, False
    
    Resume Exit_AlwaysItalic

End Property

'*******************************************************************************
' IsRequired (PUBLIC PROPERTY GET)
'*******************************************************************************
Public Property Get IsRequired() As Boolean


    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_IsRequired
    blnSuccess = False

    IsRequired = m_blnIsRequired

    blnSuccess = True

Exit_IsRequired:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_IsRequired:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::IsRequired"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "IsRequired", strErrSource, False
    
    Resume Exit_IsRequired

End Property

'*******************************************************************************
' IsRequired (PUBLIC PROPERTY LET)
'*******************************************************************************
Public Property Let IsRequired(ByVal New_IsRequired As Boolean)
' Change the Background Color if field is Required
    

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_IsRequired
    blnSuccess = False

    m_blnIsRequired = New_IsRequired
    PropertyChanged "IsRequired"
    
    ' Set Colors
    Call SetColors

    blnSuccess = True

Exit_IsRequired:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_IsRequired:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::IsRequired"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "IsRequired", strErrSource, False
    
    Resume Exit_IsRequired

End Property

'*******************************************************************************
' DisplayText (PROPERTY)
' Returns the text displayed in the Text Control. Read Only
'*******************************************************************************
'*******************************************************************************
' DisplayText (PROPERTY GET)
'*******************************************************************************
Public Property Get DisplayText() As String

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_DisplayText
    blnSuccess = False

    DisplayText = TXTextControl1.Text

    blnSuccess = True

Exit_DisplayText:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_DisplayText:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::DisplayText"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "DisplayText", strErrSource, False
    
    Resume Exit_DisplayText

End Property
'*******************************************************************************
' DisplayText (PROPERTY LET) Read Only
'*******************************************************************************
Public Property Let DisplayText(ByVal av_strData As String)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_DisplayText
    blnSuccess = False

    TXTextControl1.Text = av_strData

    blnSuccess = True

Exit_DisplayText:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_DisplayText:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::DisplayText"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "DisplayText", strErrSource, False
    
    Resume Exit_DisplayText

End Property

'*******************************************************************************
' Enabled (PROPERTY)
' Returns or sets a value that determines whether the control
' can respond to user-generated events.
'*******************************************************************************
'*******************************************************************************
' Enabled (PROPERTY GET)
'*******************************************************************************
'MappingInfo=TXTextControl1,TXTextControl1,-1,Enabled
Public Property Get Enabled() As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_Enabled
    blnSuccess = False

    Enabled = m_blnEnabled

    blnSuccess = True

Exit_Enabled:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_Enabled:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::Enabled"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "Enabled", strErrSource, False
    
    Resume Exit_Enabled

End Property

'*******************************************************************************
' Enabled (PROPERTY LET)
'*******************************************************************************
Public Property Let Enabled(ByVal av_blnData As Boolean)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_Enabled
    blnSuccess = False

    m_blnEnabled = av_blnData
    PropertyChanged "Enabled"
    'set the defaults
    SetEnabled
    SetColors

    blnSuccess = True

Exit_Enabled:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_Enabled:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::Enabled"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "Enabled", strErrSource, False
    
    Resume Exit_Enabled

End Property

'*******************************************************************************
' Locked (PROPERTY)
' Returns or sets a value that determines whether the control
' can respond to user-generated events.
'*******************************************************************************
'*******************************************************************************
' Locked (PROPERTY GET)
'*******************************************************************************
'MappingInfo=TXTextControl1,TXTextControl1,-1,Enabled
Public Property Get Locked() As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_Locked
    blnSuccess = False

    Locked = m_blnLocked

    blnSuccess = True

Exit_Locked:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_Locked:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::Locked"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "Locked", strErrSource, False
    
    Resume Exit_Locked

End Property

'*******************************************************************************
' Locked (PROPERTY LET)
'*******************************************************************************
Public Property Let Locked(ByVal av_blnData As Boolean)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_Locked
    blnSuccess = False

    m_blnLocked = av_blnData
    PropertyChanged "Locked"
    'set the defaults
    SetLocked
    SetColors

    blnSuccess = True

Exit_Locked:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_Locked:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::Locked"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "Locked", strErrSource, False
    
    Resume Exit_Locked

End Property

'*******************************************************************************
' MaxCharacters (PROPERTY)
' Returns and Sets the maximum number of Charachter that can be entered
'*******************************************************************************
'*******************************************************************************
' MaxCharacters (PROPERTY GET)
'*******************************************************************************
Public Property Get MaxCharacters() As Integer

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_MaxCharacters
    blnSuccess = False

    MaxCharacters = m_intMaxChar

    blnSuccess = True

Exit_MaxCharacters:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_MaxCharacters:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::MaxCharacters"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "MaxCharacters", strErrSource, False
    
    Resume Exit_MaxCharacters

End Property

'*******************************************************************************
' MaxCharacters (PROPERTY GET)
'*******************************************************************************
Public Property Let MaxCharacters(ByVal av_intData As Integer)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_MaxCharacters
    blnSuccess = False

    m_intMaxChar = av_intData
    'set dependant properties
    If m_intMaxChar > 0 Then
        'Me.MaxLineCount = 0
        Me.TableEnabled = False
    End If
    'change property
    PropertyChanged "MaxCharacters"

    blnSuccess = True

Exit_MaxCharacters:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_MaxCharacters:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::MaxCharacters"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "MaxCharacters", strErrSource, False
    
    Resume Exit_MaxCharacters

End Property

'*******************************************************************************
' MaxLineCount (PROPERTY)
' Returns and Sets the maximum number of lines that can be entered
'*******************************************************************************
'*******************************************************************************
' MaxLineCount (PROPERTY GET)
'*******************************************************************************
Public Property Get MaxLineCount() As Integer

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_MaxLineCount
    blnSuccess = False

    MaxLineCount = m_intMaxLines

    blnSuccess = True

Exit_MaxLineCount:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_MaxLineCount:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::MaxLineCount"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "MaxLineCount", strErrSource, False
    
    Resume Exit_MaxLineCount

End Property

'*******************************************************************************
' MaxLineCount (PROPERTY LET)
'*******************************************************************************
Public Property Let MaxLineCount(ByVal av_intData As Integer)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_MaxLineCount
    blnSuccess = False

    m_intMaxLines = av_intData
    'set dependant properties
    If m_intMaxLines > 0 Then
        Me.TableEnabled = False
    End If
    
    If m_intMaxLines = 0 Then
        TXTextControl1.WordWrapMode = 1
    Else
        TXTextControl1.WordWrapMode = 0
    End If
    'change property
    PropertyChanged "MaxLineCount"

    blnSuccess = True

Exit_MaxLineCount:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_MaxLineCount:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::MaxLineCount"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "MaxLineCount", strErrSource, False
    
    Resume Exit_MaxLineCount

End Property

'*******************************************************************************
' SpellCheck (PRIVATE SUB)
'
' DESCRIPTION:
' Initializes Spell Checker
'
' PARAMETERS:
' (In) - av_blnMessage - Boolean -
'
' UPDATE HISTORY:
'   17-Feb-05           Irene Bellettiere       for version 11 passing handle to control does
'                                               not result in the correct misspelled word selected
'                                               comment it out
'*******************************************************************************
Private Sub SpellCheck(ByVal av_blnMessage As Boolean)

    On Error GoTo Err_SpellCheck '21-Jun-2002 - SAS
    
    Dim intSpellCheckerResult       As Integer

' lm - 16-sep-03 - removed msgbox stating how to set up custom dict
' never seemed to hit msgbox code and with multiple dictionaries, just want to exit
    If m_blnSpllChkDictFound = False Then Exit Sub
    
    GetWspellSettings

'   15-Jan-2004 - JPK
    WSpell1.Resume
    WSpell1.ShowDialog = True
    WSpell1.ShowContext = False
    TXTextControl1.HideSelection = False
    'IB 17-Feb-05 WSpell1.TextControlHWnd = TXTextControl1.hWnd
    'add following instead:
    WSpell1.Text = TXTextControl1.Text 'IB 17-Feb-05
    
    
    WSpell1.ShowDialog = True
    
    m_endOfTextFired = False
    intSpellCheckerResult = WSpell1.Start
    While (Not m_endOfTextFired And intSpellCheckerResult >= 0)
        intSpellCheckerResult = WSpell1.Resume
    Wend
    
    If intSpellCheckerResult >= 0 _
    And av_blnMessage Then
        MsgBox "The spelling check is complete.", , "Horizon"
    End If
    
    SaveWspellSettings
    
    
Exit_SpellCheck:

    On Error Resume Next
    
    Exit Sub

Err_SpellCheck:
    '10-3-02 lm
    MsgBox "The Custom Dictionary is currently not installed and is needed for Spell Check. " _
            & "Please perform the following steps." & vbCr & vbLf & _
            "Exit Horizon" & vbCr & vbLf & _
            "Start Word" & vbCr & vbLf & _
            "Type some junk characters that will cause a spelling error." & vbCr & vbLf & _
            "Then run spell check from Tools/Spelling and Grammer", "Horizon"

    Resume Exit_SpellCheck

End Sub

'******************************************************************************
' StripAllStyleInfo (private function)
'
' Description: used with version 11 of txtText control to strip out all style
'   except for indent information for bullets.
'
' Author: Irene Bellettiere
' Created: 28-Jan-05
'
' UPDATE HISTORY:
'
'******************************************************************************
Private Function StripAllStyleInfo(ByVal av_strTextProp As String) As String
    Dim lngInstr1 As Long
    Dim lngInstr2 As Long
    Dim strTemp As String
    Dim strTemp1 As String
    Dim strTemp2 As String
    Dim strStyleInfo As String
    Dim strSavePart As String

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_StripAllStyleInfo
    blnSuccess = False

    
    strTemp = Trim$(av_strTextProp)
    StripAllStyleInfo = strTemp
    If strTemp = "" Then Exit Function
    
    'now get rid of any style
    strSavePart = ""
    lngInstr1 = InStr(strTemp, "style=")
    While lngInstr1 > 0
        strTemp1 = Trim$(Left$(strTemp, lngInstr1 - 1))
        strTemp2 = Right$(strTemp, Len(strTemp) - lngInstr1 - 6)
        'locate end of Style="xxxx...xx" and strip it
        lngInstr2 = InStr(strTemp2, """") 'locate end of Style="xxxx...xx"
        strTemp2 = Right$(strTemp2, Len(strTemp2) - lngInstr2)
        strSavePart = strSavePart & strTemp1
        strTemp = strTemp2
        lngInstr1 = InStr(strTemp, "style=")
    Wend
    
    StripAllStyleInfo = strSavePart & strTemp
    
    blnSuccess = True

Exit_StripAllStyleInfo:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_StripAllStyleInfo:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::StripAllStyleInfo"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "StripAllStyleInfo", strErrSource, False
    
    Resume Exit_StripAllStyleInfo

End Function


'lm - 29-Dec-05
'get rid of any trailing spaces and all except one trailing <br/>
' no matter what combo of spaces, break, spaces...
'Note that tabs are translated to spaces somewhere earlier (maybe tidycom)
'This will also set the field to empty string if it only has spaces and <br/>
'If there are trailing end underline, italic or bold, these are moved in front of
' any white space.  Note that you could end up with <b></b> that does nothing, but
' this does not hurt anything except space, so, oh well.
Private Function StripTrailingBlankBreak(ByVal av_strTextProp As String) As String
    Dim strTemp As String
    Dim blnBreak As Boolean
    Dim strFormats As String
    
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_StripTrailingBlankBreak
    blnSuccess = False
    
    strTemp = av_strTextProp
    strFormats = ""
    blnBreak = False
    
    'loop until all trailing chars are removed, saving bold, italic, underline formats
    Do While Right$(strTemp, 1) = " " Or _
             Right$(strTemp, 6) = "&#160;" Or _
             Right$(strTemp, 5) = "<br/>" Or _
             Right$(strTemp, 4) = "</b>" Or _
             Right$(strTemp, 4) = "</i>" Or _
             Right$(strTemp, 4) = "</u>" Or _
             Right$(strTemp, 3) = "<b>" Or _
             Right$(strTemp, 3) = "<i>" Or _
             Right$(strTemp, 3) = "<u>"
        If Right$(strTemp, 1) = " " Then
            strTemp = Left$(strTemp, Len(strTemp) - 1)
        ElseIf Right$(strTemp, 6) = "&#160;" Then
            strTemp = Left$(strTemp, Len(strTemp) - 6)
        ElseIf Right$(strTemp, 5) = "<br/>" Then
            blnBreak = True
            strTemp = Left$(strTemp, Len(strTemp) - 5)
        ElseIf Right$(strTemp, 4) = "</u>" Then
            strFormats = "</u>" & strFormats
            strTemp = Left$(strTemp, Len(strTemp) - 4)
        ElseIf Right$(strTemp, 4) = "</i>" Then
            strFormats = "</i>" & strFormats
            strTemp = Left$(strTemp, Len(strTemp) - 4)
        ElseIf Right$(strTemp, 4) = "</b>" Then
            strFormats = "</b>" & strFormats
            strTemp = Left$(strTemp, Len(strTemp) - 4)
        ElseIf Right$(strTemp, 3) = "<u>" Then
            strFormats = "<u>" & strFormats
            strTemp = Left$(strTemp, Len(strTemp) - 3)
        ElseIf Right$(strTemp, 3) = "<i>" Then
            strFormats = "<i>" & strFormats
            strTemp = Left$(strTemp, Len(strTemp) - 3)
        ElseIf Right$(strTemp, 3) = "<b>" Then
            strFormats = "<b>" & strFormats
            strTemp = Left$(strTemp, Len(strTemp) - 3)
        End If
    Loop
    
    'if only had blanks and bold, ending string is empty
    ' so keep empty and don't add back formats
    If strTemp = "" Then
        StripTrailingBlankBreak = ""
    Else
        'add back any formats
        If strFormats <> "" Then
            strTemp = strTemp & strFormats
        End If
        
        'need to allow one trailing <br/>
        'need to remove last break, this is usually adding by writing text to temp file,
        'it causes an error when max characters is reached and then </br>
'        If blnBreak Then
'            StripTrailingBlankBreak = strTemp & "<br/>"
'        Else
            StripTrailingBlankBreak = strTemp
'        End If
    End If
     
    blnSuccess = True

Exit_StripTrailingBlankBreak:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_StripTrailingBlankBreak:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::StripTrailingBlankBreak"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "StripTrailingBlankBreak", strErrSource, False
    
    Resume Exit_StripTrailingBlankBreak
   

End Function


'lm - Oct-2005
Private Function StripAllAlign(ByVal av_strTextProp As String) As String
    Dim lngInstr1 As Long
    Dim lngInstr2 As Long
    Dim lngInstr3 As Long
    Dim strTemp As String

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_StripAllAlign
    blnSuccess = False

    strTemp = Trim$(av_strTextProp)
    StripAllAlign = strTemp
    If strTemp = "" Then Exit Function
    
    'now get rid of any align not in a table
    
    'for <p align, add two <br/>
    lngInstr1 = InStr(strTemp, "<p align=")
    Do While lngInstr1 > 0
        lngInstr2 = InStr(lngInstr1, strTemp, ">")
        lngInstr3 = InStr(lngInstr2, strTemp, "</p>")
        If lngInstr2 <> 0 And lngInstr3 <> 0 Then
            strTemp = Left$(strTemp, lngInstr1 - 1) & _
                      Mid$(strTemp, lngInstr2 + 1, lngInstr3 - lngInstr2 - 1) & _
                      "<br/><br/>" & _
                      Right$(strTemp, Len(strTemp) - lngInstr3 - 3)
            lngInstr1 = InStr(strTemp, "<p align=")
        Else
            lngInstr1 = 0
        End If
    Loop
    'remove <div align
    lngInstr1 = InStr(strTemp, "<div align=")
    Do While lngInstr1 > 0
        lngInstr2 = InStr(lngInstr1, strTemp, ">")
        lngInstr3 = InStr(lngInstr2, strTemp, "</div>")
        If lngInstr2 <> 0 And lngInstr3 <> 0 Then
            strTemp = Left$(strTemp, lngInstr1 - 1) & _
                      Mid$(strTemp, lngInstr2 + 1, lngInstr3 - lngInstr2 - 1) & _
                      Right$(strTemp, Len(strTemp) - lngInstr3 - 5)
            lngInstr1 = InStr(strTemp, "<div align=")
        Else
            lngInstr1 = 0
        End If
    Loop
    'remove <br align
    lngInstr1 = InStr(strTemp, "<br align=")
    Do While lngInstr1 > 0
        lngInstr2 = InStr(lngInstr1, strTemp, ">")
        lngInstr3 = InStr(lngInstr2, strTemp, "<br/>")
        If lngInstr2 <> 0 And lngInstr3 <> 0 Then
            strTemp = Left$(strTemp, lngInstr1 - 1) & _
                      Mid$(strTemp, lngInstr2 + 1, lngInstr3 - lngInstr2 - 1) & _
                      Right$(strTemp, Len(strTemp) - lngInstr3 - 4)
            lngInstr1 = InStr(strTemp, "<br align=")
        Else
            lngInstr1 = 0
        End If
    Loop

    StripAllAlign = strTemp
    
    blnSuccess = True

Exit_StripAllAlign:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_StripAllAlign:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::StripAllAlign"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "StripAllAlign", strErrSource, False
    
    Resume Exit_StripAllAlign

End Function


'lm - Oct-2005
Private Function StripExtraLiInfo(ByVal av_strTextProp As String) As String
    Dim lngInstr1 As Long
    Dim lngInstr2 As Long
    Dim lngInstr3 As Long
    Dim strTemp As String

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_StripExtraLiInfo
    blnSuccess = False

    strTemp = Trim$(av_strTextProp)
    StripExtraLiInfo = strTemp
    If strTemp = "" Then Exit Function
    

    lngInstr1 = InStr(strTemp, "<li")
    Do While lngInstr1 > 0
        lngInstr2 = InStr(lngInstr1, strTemp, ">")
        If lngInstr2 <> lngInstr1 + 3 Then
            strTemp = Left$(strTemp, lngInstr1 - 1) & "<li>" & _
                      Right$(strTemp, Len(strTemp) - lngInstr2)
        End If
        lngInstr1 = InStr(lngInstr1 + 1, strTemp, "<li")
    Loop

    StripExtraLiInfo = strTemp
    
    blnSuccess = True

Exit_StripExtraLiInfo:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_StripExtraLiInfo:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::StripExtraLiInfo"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "StripExtraLiInfo", strErrSource, False
    
    Resume Exit_StripExtraLiInfo

End Function


Private Function StripAllDivInfo(ByVal av_strTextProp As String) As String
    Dim lngInstr1 As Long
    Dim lngInstr2 As Long
    Dim strTemp As String
    Dim strTemp1 As String
    Dim strTemp2 As String
    Dim strStyleInfo As String
    Dim strSavePart As String

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_StripAllDivInfo
    blnSuccess = False

    
    strTemp = Trim$(av_strTextProp)
    StripAllDivInfo = strTemp
    If strTemp = "" Then Exit Function
    
    strSavePart = ""
    lngInstr1 = InStr(strTemp, "<div")
    While lngInstr1 > 0
        strTemp1 = Trim$(Left$(strTemp, lngInstr1 - 1))
        strTemp2 = Right$(strTemp, Len(strTemp) - lngInstr1 - 3)
        lngInstr2 = InStr(strTemp2, ">")   'locate end <div
        strTemp2 = Right$(strTemp2, Len(strTemp2) - lngInstr2)
        strSavePart = strSavePart & strTemp1
        strTemp = strTemp2
        lngInstr1 = InStr(strTemp, "<div")
    Wend
    
    strTemp = strSavePart & strTemp
    StripAllDivInfo = Replace(strTemp, "</div>", "")
    
    blnSuccess = True

Exit_StripAllDivInfo:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_StripAllDivInfo:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::StripAllDivInfo"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "StripAllDivInfo", strErrSource, False
    
    Resume Exit_StripAllDivInfo

End Function

'*********************************************************************
' StripHeaderInfoFromText (private function)
'
' Description: used with version 11 of txtText control
'
' Author: Irene Bellettiere
' Created: 27-Jan-05
'
' Description: Old version of text control required this code:
'           lngInstr = InStr(m_strTextProp, "link=" & Chr$(34) & "#0000FF" & Chr$(34) & ">" & vbCr)
'            m_strTextProp = Right$(m_strTextProp, Len(m_strTextProp) - (lngInstr + 16))
'            lngInstr = InStr(m_strTextProp, "</body>")
'            m_strTextProp = Left$(m_strTextProp, lngInstr - 1)
'
' UPDATE HISTORY:
'
'*********************************************************************
Private Function StripHeaderInfoFromText(ByVal av_strTextProp As String) As String
    Dim strTemp As String
    Dim lngInstr  As Long
    
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_StripHeaderInfoFromText
    blnSuccess = False

    strTemp = av_strTextProp
    StripHeaderInfoFromText = strTemp
    
    'look for start of body of text tag and remove up to it
    lngInstr = InStr(strTemp, "<body")
    strTemp = Right$(strTemp, Len(strTemp) - lngInstr)
            
    'look for body cont'd (closing bracket for body tag)
    lngInstr = InStr(strTemp, ">")
    strTemp = Right$(strTemp, Len(strTemp) - lngInstr)
    
    'check for end of body and remove it
    lngInstr = InStr(strTemp, "</body>")
    strTemp = Left$(strTemp, lngInstr - 1)  'remove </body> and anything after it

    StripHeaderInfoFromText = strTemp
    blnSuccess = True

Exit_StripHeaderInfoFromText:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_StripHeaderInfoFromText:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::StripHeaderInfoFromText"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "StripHeaderInfoFromText", strErrSource, False
    
    Resume Exit_StripHeaderInfoFromText

End Function

'****************************************************************************
' StripLeadingParagraphAndSpan (private function)
'
' Description: used with version 11 of txtText control
'
' Author: Irene Bellettiere
' Created: 27-Jan-05
'
' UPDATE HISTORY:
'
'****************************************************************************
Private Function StripLeadingParagraphAndSpan(ByVal av_strTextProp As String) As String
    Dim strTemp As String
    Dim lngInstr  As Long
    Dim strLeft2 As String

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_StripLeadingParagraphAndSpan
    blnSuccess = False
    
    strTemp = Trim(av_strTextProp)
    StripLeadingParagraphAndSpan = strTemp
    
    'check for crlf at beginning and strip it
    strLeft2 = Left$(strTemp, 2)
    While strLeft2 = vbCrLf
        strTemp = Right$(strTemp, Len(strTemp) - 2)
        strLeft2 = Left$(strTemp, 2)
    Wend
    
    ' check for first paragraph and remove it
    'note: version 11 -when first paragraph is removed then each subsequent paragraph is
    'deleted as the control is reloaded therefore this paragraph is reinserted in property let Text.
    strTemp = Trim(strTemp)
    If Left(strTemp, 3) = "<p>" Then
        strTemp = Right(strTemp, Len(strTemp) - 3) 'remove <p>
        lngInstr = InStr(strTemp, "</p>")
        strTemp = Trim(Left(strTemp, lngInstr - 1) & Right(strTemp, Len(strTemp) - (lngInstr + 3))) 'remove </p>
    Else
        If Left(strTemp, 3) = "<p " Then
            lngInstr = InStr(strTemp, ">")  'find end of paragraph tag and remove
            strTemp = Right$(strTemp, Len(strTemp) - lngInstr) 'remove >

            'find end of paragragh </p> and remove
            lngInstr = InStr(strTemp, "</p>")
            strTemp = Trim$(Left(strTemp, lngInstr - 1) & Right$(strTemp, Len(strTemp) - (lngInstr + 3)))
        End If
    End If
    
    'check for leading span tag and remove it
    strTemp = Trim$(strTemp)
    If Left$(strTemp, 5) = "<span" Then '<span is at beginning of string
        lngInstr = InStr(strTemp, ">")  'find closing bracket for <span tag
        strTemp = Right$(strTemp, Len(strTemp) - lngInstr) 'removes any font size information that may be inside span tag
        'look for end of span
        lngInstr = InStr(strTemp, "</span>")
        strTemp = Left$(strTemp, lngInstr - 1) & Right$(strTemp, Len(strTemp) - (lngInstr + 6))
    End If

    StripLeadingParagraphAndSpan = strTemp
    
    blnSuccess = True

Exit_StripLeadingParagraphAndSpan:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_StripLeadingParagraphAndSpan:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::StripLeadingParagraphAndSpan"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "StripLeadingParagraphAndSpan", strErrSource, False
    
    Resume Exit_StripLeadingParagraphAndSpan

End Function

'*****************************************************************************
' WSpell1_DeleteWord (private sub)
' description: this sub used with version 11 of the control
'
' Author: Irene Bellettiere
' Created: 17-Feb-05
'
' UPDATE HISTORY:
'
'*****************************************************************************
Private Sub WSpell1_DeleteWord(ByVal offset As Long)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_WSpell1_DeleteWord
    blnSuccess = False



    With TXTextControl1
        .SelStart = WSpell1.WordOffset
        .SelLength = Len(WSpell1.MisspelledWord)
        .SelText = ""
    End With

    blnSuccess = True

Exit_WSpell1_DeleteWord:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_WSpell1_DeleteWord:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::WSpell1_DeleteWord"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "WSpell1_DeleteWord", strErrSource, False
    
    Resume Exit_WSpell1_DeleteWord

End Sub

Private Sub WSpell1_EndOfText()
    m_endOfTextFired = True
End Sub

'*******************************************************************************
' TableEnabled (PROPERTY)
' Sets and returns the ability to insert and manipulate tables
'*******************************************************************************
'*******************************************************************************
' TableEnabled (PROPERTY GET)
'*******************************************************************************
Public Property Get TableEnabled() As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_TableEnabled
    blnSuccess = False

    TableEnabled = m_blnTableEnabled

    blnSuccess = True

Exit_TableEnabled:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_TableEnabled:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::TableEnabled"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "TableEnabled", strErrSource, False
    
    Resume Exit_TableEnabled

End Property

'*******************************************************************************
' TableEnable (PROPERTY LET)
'*******************************************************************************
Public Property Let TableEnabled(ByVal av_blnData As Boolean)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_TableEnabled
    blnSuccess = False

    m_blnTableEnabled = av_blnData
    'set dependant properties
    If m_blnTableEnabled Then
        Me.MaxCharacters = 0
        Me.MaxLineCount = 0
    End If
    'hide or show button on toolbar
    tlbrTop.Buttons("Table").Visible = m_blnTableEnabled
    ToggleControls
    'change property
    PropertyChanged "TableEnabled"

    blnSuccess = True

Exit_TableEnabled:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_TableEnabled:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::TableEnabled"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "TableEnabled", strErrSource, False
    
    Resume Exit_TableEnabled

End Property

'*******************************************************************************
' Text (PROPERTY)
' Sets and Returns the complete text of the Text Control
' MODIFICATION lms modificiation beginning 06-May-2002
'   Using Tidy Com object, replace poorly formatted HTML
'   delete font statements
'               lms modification 15-May-2002
'   modified objTidy properties
'
' 23-Sep-2003 - LMS - Convert Greater than or equal to, Less than equal to
'                     and not equal to in Text(Property Get).
'*******************************************************************************
'*******************************************************************************
' Text (PROPERTY GET)
'*******************************************************************************
Public Property Get Text() As Variant
    Dim objTidy As TidyCOM.TidyObject
    Dim lngInstr As Long
    Dim lngFirstPosition As Long
    Dim lngSecondPosition As Long
    Dim strReplace As String
    Dim lngLength As Long
    Dim lngIndentLevel As Long
    Dim strIndent As String

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long

    Dim blnSuccess As Boolean
    On Error GoTo Err_Text
    blnSuccess = False


    'don't show gridlines
    TXTextControl1.TableGridLines = False
    Dim lngCount As Long
    Dim aData() As Byte

    m_strTextProp = TXTextControl1.SaveToMemoryBuffer(m_strTextProp, m_intTextFormat)

    '    aData = TXTextControl1.SaveToMemory(m_intTextFormat)
    '
    '    'ReDim aData(0 To Len(m_strTextProp) - 1)
    '    m_strTextProp = ""
    '    For lngCount = LBound(aData) To UBound(aData)
    '        m_strTextProp = m_strTextProp & Chr(aData(lngCount))
    '    Next lngCount

    ' Debug.Print m_strTextProp

    'Removes html header information
    Select Case m_intTextFormat
        Case HTML

            m_strTextProp = StripHeaderInfoFromText(m_strTextProp) 'IB 27-Jan-05 added

            'LMS modificiation beginning  07-May-2002
            'multiple spaces are compressed down to one space in html
            'so change to none breaking space
            'need to do up here, before lower replace of CRLF to space and delete spaces
            m_strTextProp = Replace(m_strTextProp, "  ", "&#160;&#160;", , , vbBinaryCompare)
            'need this to handle odd # of multiple spaces
            m_strTextProp = Replace(m_strTextProp, "&#160; ", "&#160;&#160;", , , vbBinaryCompare)
            m_strTextProp = StripLeadingParagraphAndSpan(m_strTextProp) 'IB 27-Jan-05

            'lm Oct 2005 - if you modify part of a <ol> to <ul>, will give <ul> </ol>
            'tidycom will get rid of bad </ol> and then add a </ul> to end of everything
            'so need to fix here
            m_strTextProp = Replace(m_strTextProp, "<ul></ol>", "<ul>")
            m_strTextProp = Replace(m_strTextProp, "<ul> </ol>", "<ul>")
            m_strTextProp = Replace(m_strTextProp, "<ol></ul>", "<ol>")
            m_strTextProp = Replace(m_strTextProp, "<ol> </ul>", "<ol>")
            
            'lm Oct 2005 - TidyCom sets '<b> ' to '<b>' thus dropping a needed space
            m_strTextProp = Replace(m_strTextProp, "b> ", "b>&#160;") 'both <b> and </b>
            m_strTextProp = Replace(m_strTextProp, " <b>", "&#160;<b>")
            m_strTextProp = Replace(m_strTextProp, " </b>", "&#160;</b>")
            m_strTextProp = Replace(m_strTextProp, "i> ", "i>&#160;") 'both <i> and </i>
            m_strTextProp = Replace(m_strTextProp, " <i>", "&#160;<i>")
            m_strTextProp = Replace(m_strTextProp, " </i>", "&#160;</i>")
            m_strTextProp = Replace(m_strTextProp, "u> ", "u>&#160;") 'both <u> and </u>
            m_strTextProp = Replace(m_strTextProp, " <u>", "&#160;<u>")
            m_strTextProp = Replace(m_strTextProp, " </u>", "&#160;</u>")
            
            Set objTidy = New TidyCOM.TidyObject
            'objTidy.Options.InputXml = True 15-May-2002
            With objTidy.Options
                .TidyMark = False
                .Wrap = 0
                .Doctype = "omit"
                .QuoteMarks = True
                '11-Oct-2005 LM set from false to true to fix problem with TxText 11 upgrade
                .DropEmptyParas = True '  False  ' 25-Jun-2002
                .CharEncoding = ascii
            End With
            m_strTextProp = objTidy.TidyMemToMem(m_strTextProp)
            m_strTextProp = Replace(m_strTextProp, Chr(13) & Chr(10), Chr(32))
            If Len(m_strTextProp) > 1 Then
                m_strTextProp = objTidy.TidyMemToMem(m_strTextProp)
                lngFirstPosition = InStr(1, m_strTextProp, "<html>")
                lngSecondPosition = InStr(1, m_strTextProp, "<body>")
                strReplace = Mid(m_strTextProp, lngFirstPosition, lngSecondPosition + 7)
                m_strTextProp = Replace(m_strTextProp, strReplace, " ", 1, 1)
                m_strTextProp = Replace(m_strTextProp, "</body>", " ")
                m_strTextProp = Replace(m_strTextProp, "</html>", " ")
                m_strTextProp = Replace(m_strTextProp, Chr(13) & Chr(10), Chr(32))
                m_strTextProp = Replace(m_strTextProp, Chr(32) & Chr(32) & Chr(32), Chr(32))
                m_strTextProp = Replace(m_strTextProp, Chr(32) & Chr(32), Chr(32))
                m_strTextProp = Replace(m_strTextProp, ">  <", "> <")
            End If
            lngFirstPosition = 0
            lngSecondPosition = 0
            m_strTextProp = Replace(m_strTextProp, "<FONT", "<font")
            m_strTextProp = Replace(m_strTextProp, "</FONT", "</font")
            If InStr(m_strTextProp, "<font") > 0 Then
                lngFirstPosition = InStr(1, m_strTextProp, "<font")
                lngSecondPosition = InStr(lngFirstPosition + 1, m_strTextProp, ">", vbTextCompare)
                Do Until lngFirstPosition = 0
                    lngSecondPosition = InStr(lngFirstPosition, m_strTextProp, ">", vbTextCompare)
                    lngLength = lngSecondPosition - lngFirstPosition + 1
                    strReplace = Mid(m_strTextProp, lngFirstPosition, lngLength)
                    m_strTextProp = Replace(m_strTextProp, strReplace, Chr(32))
                    lngFirstPosition = InStr(lngFirstPosition + 1, m_strTextProp, "<font")
                Loop
                m_strTextProp = Replace(m_strTextProp, "</font>", Chr(32))
            End If
            'LMS modificiation ending  07-May-2002
            'LMS modificiation beginning  07-JUL-2002 replace MS Word character codes with ascii

            m_strTextProp = Replace(m_strTextProp, "&#146;", "&#39;", , , vbBinaryCompare) 'SAS CQ6318
            m_strTextProp = Replace(m_strTextProp, "&rsquo;", "&#39;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&lsquo;", "&#39;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&rdquo;", "&#34;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&ldquo;", "&#34;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&quot;", "&#34;", , , vbBinaryCompare)
            'LMS modificiation ending  07-JUL-2002
            'LMS modificiation beginning  20-JUN-2002
            m_strTextProp = Replace(m_strTextProp, "&lt;", "&#60;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&gt;", "&#62;", , , vbBinaryCompare)
            '09-Aug-2002 - SAS - Start
            'the following don't take the normal ascii values
            '             m_strTextProp = Replace(m_strTextProp, "&euro;", "&#128;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&euro;", "&#8364;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&sbquo;", "&#130;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&sbquo;", "&#8218;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&fnof;", "&#131;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&fnof;", "&#402;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&bdquo;", "&#132;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&bdquo;", "&#8222;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&hellip;", "&#133;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&hellip;", "&#8230;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&dagger;", "&#134;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&dagger;", "&#8224;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&Dagger;", "&#135;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Dagger;", "&#8225;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&circ;", "&#136;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&circ;", "&#710;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&permil;", "&#137;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&permil;", "&#8240;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&Scaron;", "&#138;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Scaron;", "&#352;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&lsaquo;", "&#139;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&lsaquo;", "&#8249;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&OElig;", "&#140;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&OElig;", "&#338;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&bull;", "&#149;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&bull;", "&#8226;", , , vbBinaryCompare)
            '15-Jan-2004 - JPK Beginning per ClearQuest Log 3128
            m_strTextProp = Replace(m_strTextProp, "&ndash;", "&#8211;", , , vbBinaryCompare)
            '                  End per ClearQuest Log 3128
            '             m_strTextProp = Replace(m_strTextProp, "&mdash;", "&#151;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&mdash;", "&#8212;", , , vbBinaryCompare)

            '             m_strTextProp = Replace(m_strTextProp, "&tilde;", "&#152;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&tilde;", "&#732;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&trade;", "&#153;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&trade;", "&#8482;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&scaron;", "&#154;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&scaron;", "&#353;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&rsaquo;", "&#155;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&rsaquo;", "&#8250;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&oelig;", "&#156;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&oelig;", "&#339;", , , vbBinaryCompare)
            '             m_strTextProp = Replace(m_strTextProp, "&Yuml;", "&#159;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Yuml;", "&#376;", , , vbBinaryCompare)
            '09-Aug-2002 - SAS - End

            '23-Sep-2003 - LMS Beginning per Clear Quest 2075
            m_strTextProp = Replace(m_strTextProp, "&le;", "&#8804;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&ge;", "&#8805;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&ne;", "&#8800;", , , vbBinaryCompare)
            '22-Sep-2003 - LMS End per Clear Quest 2075
            m_strTextProp = Replace(m_strTextProp, "&nbsp;", "&#160;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&iexcl;", "&#161;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&cent;", "&#162;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&pound;", "&#163;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&curren;", "&#164;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&yen;", "&#165;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&brvbar;", "&#166;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&sect;", "&#167;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&uml;", "&#168;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&copy;", "&#169;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&ordf;", "&#170;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&laquo;", "&#171;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&not;", "&#172;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&shy;", "&#173;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&reg;", "&#174;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&macr;", "&#175;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&deg;", "&#176;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&plusmn;", "&#177;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&sup2;", "&#178;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&sup3;", "&#179;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&acute;", "&#180;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&micro;", "&#181;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&para;", "&#182;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&middot;", "&#183;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&cedil;", "&#184;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&sup1;", "&#185;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&ordm;", "&#186;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&raquo;", "&#187;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&frac14;", "&#188;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&frac12;", "&#189;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&frac34;", "&#190;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&iquest;", "&#191;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Agrave;", "&#192;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Aacute;", "&#193;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Acirc;", "&#194;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Atilde;", "&#195;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Auml;", "&#196;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Aring;", "&#197;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&AElig;", "&#198;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Ccedil;", "&#199;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Egrave;", "&#200;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Eacute;", "&#201;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Ecirc;", "&#202;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Euml;", "&#203;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Igrave;", "&#204;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Iacute;", "&#205;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Icirc;", "&#206;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Iuml;", "&#207;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&ETH;", "&#208;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Ntilde;", "&#209;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Ograve;", "&#210;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Oacute;", "&#211;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Ocirc;", "&#212;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Otilde;", "&#213;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Ouml;", "&#214;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&times;", "&#215;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Oslash;", "&#216;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Ugrave;", "&#217;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Uacute;", "&#218;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Ucirc;", "&#219;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Uuml;", "&#220;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&Yacute;", "&#221;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&THORN;", "&#222;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&szlig;", "&#223;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&agrave;", "&#224;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&aacute;", "&#225;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&acirc;", "&#226;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&atilde;", "&#227;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&auml;", "&#228;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&aring;", "&#229;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&aelig;", "&#230;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&ccedil;", "&#231;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&egrave;", "&#232;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&eacute;", "&#233;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&ecirc;", "&#234;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&euml;", "&#235;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&igrave;", "&#236;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&iacute;", "&#237;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&icirc;", "&#238;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&iuml;", "&#239;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&eth;", "&#240;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&ntilde;", "&#241;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&ograve;", "&#242;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&oacute;", "&#243;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&ocirc;", "&#244;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&otilde;", "&#245;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&ouml;", "&#246;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&divide;", "&#247;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&oslash;", "&#248;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&ugrave;", "&#249;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&uacute;", "&#250;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&ucirc;", "&#251;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&uuml;", "&#252;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&yacute;", "&#253;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&thorn;", "&#254;", , , vbBinaryCompare)
            m_strTextProp = Replace(m_strTextProp, "&amp;", "&#38;", , , vbBinaryCompare)
            'LMS modificiation ending  20-JUN-2002
            m_strTextProp = Replace(m_strTextProp, "&frasl;", "/", , , vbBinaryCompare) 'IB 28-Feb-05 added

            'lms 15-Dec-2004 cq 6494 replace ascii characters over 256 with space
            lngFirstPosition = 0
            lngSecondPosition = 0
            lngLength = 0
            lngFirstPosition = InStr(1, m_strTextProp, "&#", vbBinaryCompare)
            lngSecondPosition = InStr(lngFirstPosition + 1, m_strTextProp, ";", vbBinaryCompare)
            lngLength = lngSecondPosition - lngFirstPosition

            Do Until lngFirstPosition = 0
                If lngFirstPosition > 0 And lngLength > 0 Then
                    strReplace = Mid(m_strTextProp, lngFirstPosition + 2, lngLength - 2)
                    If Not strReplace = " " Then
                        If CDbl(strReplace) > 255 Then
                            m_strTextProp = Replace(m_strTextProp, "&#" & strReplace & ";", Chr(32))
                        End If
                        lngFirstPosition = InStr(lngFirstPosition + 1, m_strTextProp, "&#", vbBinaryCompare)
                        lngSecondPosition = InStr(lngFirstPosition + 1, m_strTextProp, ";", vbBinaryCompare)
                        lngLength = lngSecondPosition - lngFirstPosition
                    End If
                End If
            Loop

            'from here to almost the end redone for release 5.1 or 5.2

            m_strTextProp = Replace(m_strTextProp, "  ", " ")
            m_strTextProp = Replace(m_strTextProp, " &#160;", " ")
            m_strTextProp = Replace(m_strTextProp, ">&#160;<", "> <")
            
            'need to stip span before > < replace
            'otherwise might lose space between bold and next word
            m_strTextProp = Replace(m_strTextProp, "<li style=""list-style: none"">", "") 'strip out extra line item when insert sub item from item line.(default is vbBinaryCompare)
            m_strTextProp = StripAllStyleInfo(m_strTextProp)
            m_strTextProp = StripAllSpanTags(m_strTextProp)
            'lm Oct 2005 - can't do this, can get </b> <b> and that space is needed.
            'so need to do every special case below
            'm_strTextProp = Replace(m_strTextProp, "> <", "><")
            m_strTextProp = Replace(m_strTextProp, "</ul> ", "</ul>")
            m_strTextProp = Replace(m_strTextProp, "</ol> ", "</ol>")
            m_strTextProp = Replace(m_strTextProp, "</div> ", "</div>")
            m_strTextProp = Replace(m_strTextProp, "</div> ", "</div>")
            m_strTextProp = Replace(m_strTextProp, " </p>", "</p>")
            
            'in previous pass, put two spaces before a </td>, so need to strip out ALL
            'and if two blanks are needed for the grid line problem with empty cells,
            'they will be replaced down below
            Do While InStr(m_strTextProp, " </td>")
                m_strTextProp = Replace(m_strTextProp, " </td>", "</td>")
            Loop
            m_strTextProp = Replace(m_strTextProp, " </li>", "</li>")
            m_strTextProp = Replace(m_strTextProp, " </tr>", "</tr>")
            m_strTextProp = Replace(m_strTextProp, " </table>", "</table>")
            m_strTextProp = Replace(m_strTextProp, " <table", "<table")

            m_strTextProp = Replace(m_strTextProp, "</ul></li>", "</ul>") 'strip out end of extra line item
            m_strTextProp = Replace(m_strTextProp, "</ul></div></li>", "</ul></div>") '/div happens when pasted in a 'far' indented bullet
            m_strTextProp = Replace(m_strTextProp, "</ol></li>", "</ol>")
            m_strTextProp = Replace(m_strTextProp, "</ol></div></li>", "</ol></div>")
            m_strTextProp = StripAllDivInfo(m_strTextProp)
            m_strTextProp = Replace(m_strTextProp, "<br>", "<br/>") 'SAS CQ6318
            m_strTextProp = StripAllAlign(m_strTextProp)
            
            'need this after above strips and br logic
            m_strTextProp = Replace(m_strTextProp, " <p>", "<p>")
            
            'strip all empty <b> <i> and <u>
            'needed for table logic near end.  Can have an empty cell with say just <b></b>
            'so not adding the two blanks needed to get the grid line
            'need extra commands incase something like <b><i><u></u></i></b>
            m_strTextProp = Replace(m_strTextProp, "<b></b>", "")
            m_strTextProp = Replace(m_strTextProp, "<u></u>", "")
            m_strTextProp = Replace(m_strTextProp, "<i></i>", "")

            'also worry about bolding just a space. always seems to be
            'doing a <b><i><u> in that order, either created thru Word or TxText
            m_strTextProp = Replace(m_strTextProp, "<u> </u>", " ")
            m_strTextProp = Replace(m_strTextProp, "<i> </i>", " ")
            m_strTextProp = Replace(m_strTextProp, "<b> </b>", " ")
                        
            'replace &#160; with " "; this was added before calling tidy com
            m_strTextProp = Replace(m_strTextProp, "b>&#160;", "b> ") 'both <b> and </b>
            m_strTextProp = Replace(m_strTextProp, "&#160;<b>", " <b>")
            m_strTextProp = Replace(m_strTextProp, "&#160;</b>", " </b>")
            m_strTextProp = Replace(m_strTextProp, "i>&#160;", "i> ") 'both <i> and </i>
            m_strTextProp = Replace(m_strTextProp, "&#160;<i>", " <i>")
            m_strTextProp = Replace(m_strTextProp, "&#160;</i>", " </i>")
            m_strTextProp = Replace(m_strTextProp, "u>&#160;", "u> ") 'both <u> and </u>
            m_strTextProp = Replace(m_strTextProp, "&#160;<u>", " <u>")
            m_strTextProp = Replace(m_strTextProp, "&#160;</u>", " </u>")
            'look for blank paragraphs and remove them
            'Nov 2005 - removed this logic, was removing needed paragraphs
            'if had two paragraphs with a blank line between and <i><u> turned on
            'm_strTextProp = Replace(m_strTextProp, "<p> </p>", "")
            m_strTextProp = Replace(m_strTextProp, "<p><br/><br/></p>", "")
            
            'replace <p> with <br/>
            m_strTextProp = Replace(m_strTextProp, "<p>", "<br/>")
            m_strTextProp = Replace(m_strTextProp, "</p>", "")
            'now can finally get rid of any blanks in front of a <br/>
            m_strTextProp = Replace(m_strTextProp, " <br/>", "<br/>")
            
            'strip out any <br/> before </li>, need loop incase more than one preceeding br/
            Do While InStr(m_strTextProp, "<br/></li>") > 0
                m_strTextProp = Replace(m_strTextProp, "<br/></li>", "</li>")
            Loop

            m_strTextProp = Replace(m_strTextProp, "border=""0""", "border=""1""") 'IB 10-Feb-05
            
            'at times, getting an extra </li>
            m_strTextProp = Replace(m_strTextProp, "</li></li>", "</li>")

            'this seems to get rid of the double spacing problem when you re-open the data entry screen
            'gets rid of the indent and starting with hollow circle on the report
            m_strTextProp = Replace(m_strTextProp, "<ul type=""circle"">", "<ul style=""margin-left: 1em"">")
            m_strTextProp = Replace(m_strTextProp, "<ol", "<ol style=""margin-left: 2.0em""") 'SAS CQ7956
            m_strTextProp = StripExtraLiInfo(m_strTextProp)
            m_strTextProp = Replace(m_strTextProp, "<li type=""circle""", "<li")
            m_strTextProp = Replace(m_strTextProp, "<li> ", "<li>")
            'lm OPct 2005 - done up above now
            'm_strTextProp = Replace(m_strTextProp, " </li>", "</li>")
            'should not have any <br/> after a <li>
            'pasting an <ol> into a <ul> can cause extra <br/>, so do twice
            m_strTextProp = Replace(m_strTextProp, "<li><br/>", "<li>")
            m_strTextProp = Replace(m_strTextProp, "<li><br/>", "<li>")
            m_strTextProp = Replace(m_strTextProp, "<li>", "<li style="";"">")

            m_strTextProp = CleanOlBullet(m_strTextProp)
            'now get rid of extra blank after /ol
            m_strTextProp = Replace(m_strTextProp, "</ol><br/>", "</ol>")
            'getting an extra break at the end of </ul> and at least one <br/>
            'so strip off extra <br/>
            m_strTextProp = Replace(m_strTextProp, "</ul><br/>", "</ul>")

            'lm 7/05 - now restore text size for subscripts and superscripts
            'using font size 6 even if in header even though 6 might not be appropriate
            If InStr(m_strTextProp, "<sub>") > 0 Then
                m_strTextProp = Replace(m_strTextProp, "<sub>", "<span style=""font-size:6pt;""><sub>")
                m_strTextProp = Replace(m_strTextProp, "</sub>", "</sub></span>")
            End If
            If InStr(m_strTextProp, "<sup>") > 0 Then
                m_strTextProp = Replace(m_strTextProp, "<sup>", "<span style=""font-size:6pt;""><sup>")
                m_strTextProp = Replace(m_strTextProp, "</sup>", "</sup></span>")
            End If

            'lm - Oct 2005 - setting empty cell to non-breaking space to fix problem
            'that grid lines are not displayed unless cell has some data, one space
            'does not seem to work, but two does.  Also, two spaces will not work,
            'need non-breaking spaces
            'this use to be done in TableCreated
            m_strTextProp = Replace(m_strTextProp, """></td>", """>&#160;&#160;</td>")
            'now insert border here, same problem as above in cmdOk on frmDlgTable
            'border always seems to be first attribute after table followed by cell... or col
            'so put in if missing
            m_strTextProp = Replace(m_strTextProp, "<table c", "<table border=""1"" c")
            'remove extra blank after a table
            m_strTextProp = Replace(m_strTextProp, "</table><br/>", "</table>")
            'need to add extra blank before any table unless two tables together
            'so easier just do it for all and then undo two tables together
            m_strTextProp = Replace(m_strTextProp, "<table", "<br/><table")
            m_strTextProp = Replace(m_strTextProp, "</table><br/><table", "</table><table")
            
            'lm - 12/10/02 - Remove all, except the last, trailing newlines
            'lm - Oct-2005 - Redone to replace all triple <br/> with a double <br/> and
            'moved above replace of blanks.  This means, you can never have more than one
            'blank line between paragraphs.  Will fix problem of users trying to create
            'page breaks by inserting multiple blank lines and the client and server print
            'does not always break the same.
            Do While InStr(m_strTextProp, "<br/><br/><br/>") > 0 'remove one of them
                m_strTextProp = Replace(m_strTextProp, "<br/><br/><br/>", "<br/><br/>")
            Loop
            'allow only one leading blank line
            If Left$(m_strTextProp, 10) = "<br/><br/>" Then
                m_strTextProp = Right$(m_strTextProp, Len(m_strTextProp) - 5)
            End If
            'lm - 23-Dec-05 - this is now handled by stroptrailingblankbreak
            ' '21-Dec-05 LM - allow only one trailing <br/>
            ' 'this means no trailing blank lines
            ' If Right$(m_strTextProp, 10) = "<br/><br/>" Then
            '    m_strTextProp = Left$(m_strTextProp, Len(m_strTextProp) - 5)
            ' End If
            '
            ' 'lm - 12/10/02 - Remove all trailing spaces, tabs are already translated to spaces
            ' m_strTextProp = Trim$(m_strTextProp)
            ' Do While Right$(m_strTextProp, 6) = "&#160;"
            '     m_strTextProp = Left$(m_strTextProp, Len(m_strTextProp) - 6)
            ' Loop
            m_strTextProp = StripTrailingBlankBreak(m_strTextProp)
            
    End Select
    Text = Trim$(m_strTextProp)
    TXTextControl1.TableGridLines = True

    blnSuccess = True

Exit_Text:

    On Error Resume Next

    If Not objTidy Is Nothing Then Set objTidy = Nothing 'IB 01-Mar-05 moved down from above

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If

    Exit Property

Err_Text:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::Text"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "Text", strErrSource, False

    Resume Exit_Text

End Property


'*******************************************************************************
' Text (PROPERTY LET)
'*******************************************************************************
Public Property Let Text(ByVal av_vData As Variant)
    Dim strData As String
    Dim lngFirstPosition As Long
    Dim lngSecondPosition As Long
    Dim strReplace As String
    'IB 01-Mar-05 no longer used :Dim aData() As Byte
    Dim lngLength As Long
    Dim lngCount As Long
    Dim objUtils As hznUtilities.clsEnvironment
    Dim lngFilenum As Long
    Dim strfilename As String
    Dim strGuid As String

    Dim intTryMax As Integer
    Dim intTryCount As Integer
    Dim lngInstr As Long
    Dim strLoadedText As String

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_Text
    blnSuccess = False
    
    m_strTextProp = av_vData
    Select Case m_intTextFormat
        Case ANSI
            TXTextControl1.Text = m_strTextProp
        Case HTML
            With TXTextControl1
                m_strPrevious = "Property Let Text"
                .Visible = False
                'load for html formating
                If Not m_strTextProp = vbNullString Then
 
                    If Len(m_strTextProp) > 1 Then
                        'LM Nov 2005 - Paragraph logic redone to help handle backward
                        'compatibility issue.  Release 5 removes all <p>.  If stored
                        'pre-release 5, <p> are still there and are treated like blank
                        'line between paragraph in HTML.  So replace <p> with two <br/>.
                        'After searching hzn01p, only found <p> and only one other, no <p ...>
                        m_strTextProp = Replace(m_strTextProp, "<p>", "<br/><br/>")
                        m_strTextProp = Replace(m_strTextProp, "<p align=""justify"">", "<br/><br/>")
                        m_strTextProp = Replace(m_strTextProp, "</p>", "")
                        'lngInstr = InStr(m_strTextProp, "<p")
                        ''if starts with paragraph, or there are no paragraphs in the data,
                        ''then leave it alone. Otherwise restore starting paragraph.
                        'If lngInstr > 1 Then
                        '     m_strTextProp = _
                        '            "<html><body><p>" & Left(m_strTextProp, lngInstr - 1) & _
                        '            "</p>" & _
                        '            Right(m_strTextProp, Len(m_strTextProp) - (lngInstr - 1)) & _
                        '            "</body></html>" 'IB 01-Feb-05
                        'Else
                        '    m_strTextProp = _
                        '            "<html><body>" & Trim$(m_strTextProp) & _
                        '            "</body></html>" 'IB 27-Jan-05 add ending tags
                        'End If
                        m_strTextProp = "<html><body>" & Trim$(m_strTextProp) & _
                                        "</body></html>"
                        
                        'lm Oct 2005 - not getting this anymore
                        ''lm 8/05 - getting extra break after lists when reloading screen
                        'm_strTextProp = Replace(m_strTextProp, "</ol><br/>", "</ol>")
                        'm_strTextProp = Replace(m_strTextProp, "</ul><br/>", "</ul>")
                        
                        'lm 7/05 - no longer needed
                        ''check for bullets and add back paragraphs for each line item
                        'lngInstr = InStr(m_strTextProp, "<li")
                        'If lngInstr > 0 Then
                        '     m_strTextProp = AddBackPforEachLi(m_strTextProp) 'IB 01-Feb-05
                        'End If
                        
                        'LM Oct 2005 - .FontSize = 11 lower down overrides this, so need to do some other way
                        ''IB 15-Feb-05 add:restore text size for subscripts and superscripts
                        'If InStr(m_strTextProp, "<sub>") > 0 Then
                        '    m_strTextProp = Replace(m_strTextProp, "<sub>", "<span style=""font-size:6pt;""><sub>")
                        '    m_strTextProp = Replace(m_strTextProp, "</sub>", "</sub></span>")
                        'End If
                        'If InStr(m_strTextProp, "<sup>") > 0 Then
                        '    m_strTextProp = Replace(m_strTextProp, "<sup>", "<span style=""font-size:6pt;""><sup>")
                        '    m_strTextProp = Replace(m_strTextProp, "</sup>", "</sup></span>")
                        'End If 'end IB 15-Feb-05
                        
                        'need to remove extra blank added by Get before any table
                        'this needs to be after removal of triple <br/> because need triple <br/> here
                        m_strTextProp = Replace(m_strTextProp, "<br/><table", "<table")
                        
                    End If
                    
                    m_strTextProp = Replace(m_strTextProp, "<FONT", "<font")
                    m_strTextProp = Replace(m_strTextProp, "</FONT", "</font")
                    
                    If InStr(m_strTextProp, "<font") > 0 Then
                        lngFirstPosition = InStr(1, m_strTextProp, "<font")
                        lngSecondPosition = InStr(lngFirstPosition + 1, m_strTextProp, ">", vbTextCompare)
                        Do Until lngFirstPosition = 0
                            lngSecondPosition = InStr(lngFirstPosition, m_strTextProp, ">", vbTextCompare)
                            lngLength = lngSecondPosition - lngFirstPosition + 1
                            strReplace = Mid(m_strTextProp, lngFirstPosition, lngLength)
                            strData = Replace(m_strTextProp, strReplace, Chr(32))
                            lngFirstPosition = InStr(lngFirstPosition + 1, m_strTextProp, "<font")
                        Loop
                        m_strTextProp = Trim$(Replace(m_strTextProp, "</font>", Chr(32)))
                    End If
                    'LMS modificiation ending  17-May-2002
                    
                    'This was put in place to handle memory bug in rich text.
                    'Temporary solution.
                    'Need to get Temp, from hznutilities so
                    'that we can write to disk.

                    Set objUtils = New hznUtilities.clsEnvironment
                    strGuid = CreateGUID
                    strfilename = objUtils.GetFolderTemp & "\" & strGuid & "Text.html"
                    lngFilenum = FreeFile
                    If Dir(strfilename) <> "" Then
                        Kill (strfilename)
                    End If
                    Open strfilename For Output As lngFilenum
                    Print #lngFilenum, , Trim(m_strTextProp) 'IB 27-Jan-05
                    
                    Close #lngFilenum
                    'lm - Oct 2005, uncommented out load to set nothing
                    .Load strfilename, , 4, False 'false = replace all text in HTML format
                    If Dir(strfilename) <> "" Then
                        Kill (strfilename)
                    End If
                    Set objUtils = Nothing
                                       
                    'below code will add junk at end of line, at times
'                    ReDim aData(0 To Len(m_strTextProp))
'                    For lngCount = 1 To Len(m_strTextProp)
'                        aData(lngCount - 1) = Asc(Mid(m_strTextProp, lngCount, 1))
'                    Next lngCount
'                    aData(lngCount - 1) = 0
'                    .LoadFromMemory aData, 4, False
'                    .LoadFromMemory Trim(m_strTextProp), 4
                    
                    'check for tables
                    If InStr(m_strTextProp, "</table>") = 0 _
                       And m_intMaxLines = 0 Then 'No Tables in Text
                        .ScrollBars = 2
                        .PageWidth = UserControl.Width - 300
                    Else  ' Tables in Text or Maximum Line count <> 0
                        .ScrollBars = 3
                        .PageWidth = 8000
                    End If
                Else
                    .Text = m_strTextProp
                End If
                'set default properties of text
                .FormatSelection = False
                .FontName = "Times New Roman"
                
                ' Set FontItalic if needed - GBW 05-Nov-2003
                If m_blnAlwaysItalic Then
                    intTryMax = 10
                    intTryCount = 0
                    Do
                        intTryCount = intTryCount + 1
                        If intTryCount < intTryMax Then
                            If intTryCount <> 1 Then
                                App.LogEvent (Ambient.DisplayName & "::hznRichText::Text:  Internally setting FontItalic (TryCount=" & CStr(intTryCount) & ")")
                            End If
                            On Error Resume Next
                        Else
                            On Error GoTo Err_Text
                        End If
                        .FontItalic = True
                    Loop While intTryCount < intTryMax And Err.Number <> 0
                    On Error GoTo Err_Text
                End If
                
                ' Set FontSize - GBW 05-Nov-2003
                intTryMax = 10
                intTryCount = 0
                Do
                    intTryCount = intTryCount + 1
                    If intTryCount < intTryMax Then
                        If intTryCount <> 1 Then
                            App.LogEvent (Ambient.DisplayName & "::hznRichText::Text:  Internally setting FontSize=11 (TryCount=" & CStr(intTryCount) & ")")
                        End If
                        On Error Resume Next
                    Else
                        On Error GoTo Err_Text
                    End If
                    .FontSize = 11
                Loop While intTryCount < intTryMax And Err.Number <> 0
                On Error GoTo Err_Text
                
                'If m_blnAlwaysItalic Then .FontItalic = True
                '.FontSize = 11
                
                .FormatSelection = True
                .TableGridLines = True
                m_strPrevious = vbNullString
                .Visible = True
                                
                'lm - Oct 2005, moved back up in procedure
                'If Not m_strTextProp = vbNullString Then 'IB 27-Jan-05
                '    .Load strfilename, , 4, False 'false = replace all text in HTML format
                '    If Dir(strfilename) <> "" Then
                '        Kill (strfilename)
                '    End If
                'End If 'end IB 27-Jan-05
            End With
    End Select
    'check maximum lines
    If m_intMaxLines Then CheckMaxLines
    'check maximum characters
    If m_intMaxChar Then CheckMaxChar
    m_strPrevious = vbNullString
    
    'change property
    PropertyChanged "Text"
    
    blnSuccess = True

Exit_Text:

    On Error Resume Next

    If Not objUtils Is Nothing Then Set objUtils = Nothing 'IB 01-Mar-05 added
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_Text:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::Text"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "Text", strErrSource, False
    
    Resume Exit_Text

End Property

'*******************************************************************************
' TextFormat (PROPERTY)
' Returns and sets the format the Text Control will accept and save.  If using
' tables TextFormat must be HTML.  If Set to ANSI the toolbar will not be visible.
'*******************************************************************************
'*******************************************************************************
' TextFormat (PROPERTY GET)
'*******************************************************************************
Public Property Get TextFormat() As enumTextFormat

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_TextFormat
    blnSuccess = False

    TextFormat = m_intTextFormat

    blnSuccess = True

Exit_TextFormat:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_TextFormat:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::TextFormat"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "TextFormat", strErrSource, False
    
    Resume Exit_TextFormat

End Property

'*******************************************************************************
' TextFormat (PROPERTY LET)
'*******************************************************************************
Public Property Let TextFormat(ByVal av_eData As enumTextFormat)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_TextFormat
    blnSuccess = False

    m_intTextFormat = av_eData
    'set dependant properties
    Select Case m_intTextFormat
        Case Is <> HTML
            Me.AlwaysItalic = False
            Me.TableEnabled = False
            'can't get tabs to work with html, so disable
            'Me.HideRuler = True
            Me.HideToolbar = True
        Case HTML
            Me.HideRuler = False
            'Me.HideToolbar = False
            Me.AnsiFontBold = False
            
    End Select
    SetTextFormat
    'change property
    PropertyChanged "TextFormat"

    blnSuccess = True

Exit_TextFormat:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_TextFormat:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::TextFormat"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "TextFormat", strErrSource, False
    
    Resume Exit_TextFormat

End Property

'*******************************************************************************
' Refresh (SUB)
'
' PARAMETERS:
' None
'
' DESCRIPTION:
' This method forces a complete repaint of a Text Control.
'*******************************************************************************
'MappingInfo=TXTextControl1,TXTextControl1,-1,Refresh
Public Sub Refresh()

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_Refresh
    blnSuccess = False

    TXTextControl1.Refresh

    blnSuccess = True

Exit_Refresh:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_Refresh:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::Refresh"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "Refresh", strErrSource, False
    
    Resume Exit_Refresh

End Sub

'*******************************************************************************
' ToggleControls (PRIVATE SUB)
'
' DESCRIPTION:
' sets the appropriate default views of the controls
'
' PARAMETERS:
' None
'*******************************************************************************
Private Sub ToggleControls()

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_ToggleControls
    blnSuccess = False

    Select Case m_intTextFormat
        Case HTML
            tlbrTop.Visible = (m_blnEnabled And Not m_blnLocked) And Not m_blnHideToolbar
            'TXRuler1.Visible = (m_blnEnabled And Not m_blnLocked) And Not m_blnHideRuler
            'TXStatusBar1.Visible = False m_blnEnabled And m_blnTableEnabled And Not m_blnLocked    'MAR 06/16/2003 CQ-1192
        Case ANSI
            tlbrTop.Visible = False
            'TXRuler1.Visible = False
            'TXStatusBar1.Visible = False   'MAR 06/16/2003 CQ-1192
    End Select
    UserControl_Resize

    blnSuccess = True

Exit_ToggleControls:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_ToggleControls:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::ToggleControls"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "ToggleControls", strErrSource, False
    
    Resume Exit_ToggleControls

End Sub

'*******************************************************************************
' TXTextControl1_Change (PRIVATE SUB)
'
' DESCRIPTION:
' Fired when the text in the control changes
'
' PARAMETERS:
' None
'*******************************************************************************
Private Sub TXTextControl1_Change()

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_TXTextControl1_Change
    blnSuccess = False
    If Not m_blnJustPastedDelete Then m_blnJustPasted = False
    
    'only do if not locked, happens when select text and hits delete if locked
    If TXTextControl1.EditMode <> 1 Then
        If m_intMaxLines Then CheckMaxLines
        If m_intMaxChar Then CheckMaxChar
    End If
    If m_blnSetFormat Then
        SetTextFormat
        m_blnSetFormat = False
    End If
    PropertyChanged "Text"
    
    'only raise event if control is not locked
    If TXTextControl1.EditMode <> 1 Then
        'changing .fontname, .fontsize, .fontx causing a change event
        'only want one raised if actual text changes
        'bold, italic and underline taken care of in toolbar click event
        'need to also do these incase these are the only changes
        If m_strChangeText <> TXTextControl1.Text Then
            m_strChangeText = TXTextControl1.Text
            RaiseEvent Change
        End If
    End If

    blnSuccess = True

Exit_TXTextControl1_Change:

    On Error Resume Next
    
    Exit Sub

Err_TXTextControl1_Change:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::TXTextControl1_Change"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "TXTextControl1_Change", strErrSource, True
    
    Resume Exit_TXTextControl1_Change

End Sub

Private Sub TXTextControl1_KeyDown(KeyCode As Integer, Shift As Integer)
    
    'trap ^v and ^V

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_TXTextControl1_KeyDown
    blnSuccess = False

    If KeyCode = 86 And Shift = 2 Then
        m_blnSetFormat = True
    End If
   

    

    ' Insert Procedure Code Here...

    blnSuccess = True

Exit_TXTextControl1_KeyDown:

    On Error Resume Next
    
    Exit Sub

Err_TXTextControl1_KeyDown:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::TXTextControl1_KeyDown"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "TXTextControl1_KeyDown", strErrSource, True
    
    Resume Exit_TXTextControl1_KeyDown

End Sub

Private Sub TXTextControl1_KeyUp(KeyCode As Integer, Shift As Integer)
    

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_TXTextControl1_KeyUp
    blnSuccess = False

    If KeyCode = 46 Then
        TXTextControl1_Change
    End If
    

    ' Insert Procedure Code Here...

    blnSuccess = True

Exit_TXTextControl1_KeyUp:

    On Error Resume Next
    
    Exit Sub

Err_TXTextControl1_KeyUp:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::TXTextControl1_KeyUp"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "TXTextControl1_KeyUp", strErrSource, True
    
    Resume Exit_TXTextControl1_KeyUp

End Sub

Public Function SpellCheckNow(ByVal av_blnDisplayMessage As Boolean)

    '20-Jun-2002 - SAS; auto spell check on ANSI controls only
    '01-Jul-2002 - SAS; auto spell check regardless of format
    '01-Jul-2002 - SAS; put auto spell check back in per Malcolm
    '11-Jul-2002 - SAS; auto spell check regardless of format
'    If m_intTextFormat = 1 Then

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_SpellCheckNow
    blnSuccess = False

'   03-Feb-2003 - JPK
'   reset the main dictionary file for the spell checker to the language being 'Let'
    If WSpell1.MainDictionaryFiles = "" Then
        SetMainDictionary True
    End If

'   03-Feb-2003 - JPK
'   do the spell checking only if the main dictionary has been set
    If WSpell1.MainDictionaryFiles <> "" Then
        SpellCheck av_blnDisplayMessage
    End If
    
    blnSuccess = True

Exit_SpellCheckNow:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_SpellCheckNow:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::SpellCheckNow"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "SpellCheckNow", strErrSource, False
    
    Resume Exit_SpellCheckNow

End Function


'*******************************************************************************
' TXTextControl1_TableCreated (PRIVATE SUB)
'
' DESCRIPTION:
' Fired when a table is created in the control via clipboard
'
' PARAMETERS:
' (In)     - TableId    - Integer -
' (In/Out) - NewTableId - Integer -
'
' UPDATE HISTORY:
'   09-Feb-05  Irene Bellettiere     add check of table width and delete if too wide. CQ 69
'*******************************************************************************
Private Sub TXTextControl1_TableCreated(ByVal TableId As Integer, NewTableId As Integer)
    Dim intRow As Integer
    Dim intCol As Integer
    Dim intRows As Integer
    Dim intCols As Integer
    Dim lngCurWidth As Long
    Dim lngTotalCellLengths As Long
    Dim intTableMaxWidth As Integer
    
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_TXTextControl1_TableCreated
    blnSuccess = False

    If m_strPrevious = vbNullString Then
        'if the property TableEnabled is set to false
        If Not m_blnTableEnabled Then
            m_bytExclude = extable
        Else
            intRows = TXTextControl1.TableRows(TableId)
            intCols = TXTextControl1.TableColumns(TableId)
            
            lngCurWidth = 0 'initialize width
            lngTotalCellLengths = 0
            For intCol = 1 To intCols
                
                'lm - Oct 2005 - moved to Get Text, was blowing up here
                'need to loop thru and put two spaces into any empty cell
                'two spaces will translate to two, non-breaking spaces
                'need char (or non-breaking space) in cell for html to show border
                'For intRow = 1 To intRows
                '    If TXTextControl1.TableCellLength(TableId, intRow, intCol) < 1 Then
                '        TXTextControl1.TableCellText(TableId, intRow, intCol) = "  "
                '    End If
                'Next
                
                'IB 9-Feb-05 total up cell width for each column
                'sum the cell widths
                lngCurWidth = lngCurWidth + TXTextControl1.TableCellAttribute(TableId, 1, intCol, txTableCellLeftBorderWidth) 'cell's left border width
                lngCurWidth = lngCurWidth + TXTextControl1.TableCellAttribute(TableId, 1, intCol, txTableCellHorizontalExt) 'cell width?
                lngCurWidth = lngCurWidth + TXTextControl1.TableCellAttribute(TableId, 1, intCol, txTableCellRightTextGap) 'between border and text (on right side of text)
                lngCurWidth = lngCurWidth + TXTextControl1.TableCellAttribute(TableId, 1, intCol, txTableCellLeftTextGap) 'between border and text (on the left of text)
                    
                If intCol = intCols Then 'if last column then add the right cell border width
                    lngCurWidth = lngCurWidth + TXTextControl1.TableCellAttribute(TableId, 1, intCol, txTableCellRightBorderWidth)
                End If
                
                lngTotalCellLengths = lngTotalCellLengths + TXTextControl1.TableCellLength(TableId, 1, intCol)
                    
            Next
            'check if table too large
            'gives begin position of last col
            '   if >= width, too large
            '   if < but this + col width >, can't trap, can't get col width
            '   if true, try del table here?
            'txtextcontrol1.TableCellAttribute(tableid,0,txtextcontrol1.TableColumns(tableid),txTableCellHorizontalPos)
            
            Select Case m_eTableMaxWidth
                Case enumShort
                    intTableMaxWidth = C_SHORT_MAX
                    
                Case enumWide
                    intTableMaxWidth = C_WIDE_MAX
                    
                Case Else
                    intTableMaxWidth = 0
            End Select
            If intTableMaxWidth <> 0 Then 'default is 0 (do not check width)
                If lngCurWidth > intTableMaxWidth Then 'remove the table
                    'note: tables that are too wide will also trigger a message and get
                    ' deleted when the text is loaded, not just when the user pastes the table.
                    m_bytExclude = exTableTooLarge
                    m_intTableId = TableId
                End If
            End If 'end 09-Feb-05
        End If
        'lm - Oct 2005 - Moved down here from inside previous if
        'start timer for image paste elimination
        tmrUnpaste.Enabled = True
    End If

    blnSuccess = True

Exit_TXTextControl1_TableCreated:

    On Error Resume Next
    
    Exit Sub

Err_TXTextControl1_TableCreated:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::TXTextControl1_TableCreated"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "TXTextControl1_TableCreated", strErrSource, True
    
    Resume Exit_TXTextControl1_TableCreated

End Sub


'*******************************************************************************
' UserControl_Initialize (SUB)
'
' PARAMETERS:
' None
'
' DESCRIPTION:
' Executed at the moment the control is created
' Update History:
' 7/18/10 PR QC1543
' Description
' The property view mode was being set to 3 after checking for the custom dictionary.
'This property is responsible for the word wrap feature. On installation of office 2007 the word dictionary
'is now at a new place : C:\Documents and Settings\raop\Application Data\Microsoft\UProof
'as a result the code was exited and word wrap was not happening.
' Changes: 1.Moved non dictionary code up
'          2.Changed code to llok for the dictionary file at 2 place C:\Documents and Settings\raop\Application Data\Microsoft\UProof
'            and C:\Documents and Settings\raop\Application Data\Microsoft\Proof
' 04-Aug-2010       Irene Bellettiere       fix path for 2003 directory lookup
'*******************************************************************************
Private Sub UserControl_Initialize()
    Dim objUtilities        As Horizon_hznUtilitiesDotNet.environment
    
    Dim strDicPath          As String
    Dim strUserName         As String

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_UserControl_Initialize
    blnSuccess = False
    
    TXTextControl1.ViewMode = 3 'IB 24-Jun-05
    m_bytExclude = exNone
    m_eTableMaxWidth = enumZero 'IB 10-Feb-05
       
    m_blnSpllChkDictFound = False
    
    ' get the default Custom Dictionary Path
    Set objUtilities = New Horizon_hznUtilitiesDotNet.environment 'IB 27-Sep-2010
    strUserName = objUtilities.GetFolderAppData 'IB 27-Sep-2010
    
     

    strDicPath = strUserName _
               & "\FMGlobal\Horizon\horizon.dic"
               
    'PR  11/23/10 Check if dir exists
     Dim oDir As New Scripting.FileSystemObject
     Dim DirectoryExists As Boolean
      DirectoryExists = oDir.FolderExists(strUserName & "\FMGlobal\Horizon")
      If Not (DirectoryExists) Then
      
        oDir.CreateFolder (strUserName & "\FMGlobal")
        oDir.CreateFolder (strUserName & "\FMGlobal\Horizon")
        
      End If
      
    If Dir(strDicPath) <> "" Then
        m_blnSpllChkDictFound = True
    Else
        'custom dictionary does not already exist, so lets create one
        Open strDicPath For Output As #1
        Close #1
        If Dir(strDicPath) <> "" Then
            m_blnSpllChkDictFound = True
        End If
    End If
    
    Set objUtilities = Nothing 'IB 27-Sep-2010
    
    If m_blnSpllChkDictFound = False Then Exit Sub

    'get saved settings
'    With WSpell1
'        MsgBox "GetSetting"
'        .AutoCorrect = GetSetting("FM Global\Horizon", "Spelling", "AutoCorrect", True)
'        .CaseSensitive = GetSetting("FM Global\Horizon", "Spelling", "CaseSensitive", True)
'        .CatchDoubledWords = GetSetting("FM Global\Horizon", "Spelling", "CatchDoubledWords", True)
'        .IgnoreAllCapsWords = GetSetting("FM Global\Horizon", "Spelling", "IgnoreAllCapsWords", True)
'        .IgnoreCapitalizedWords = GetSetting("FM Global\Horizon", "Spelling", "IgnoreCapitalizedWords", False)
'        .IgnoreDomainNames = GetSetting("FM Global\Horizon", "Spelling", "IgnoreDomainNames", True)
'        .IgnoreMixedCaseWords = GetSetting("FM Global\Horizon", "Spelling", "IgnoreMixedCaseWords", False)
'        .IgnoreWordsWithDigits = GetSetting("FM Global\Horizon", "Spelling", "IgnoreWordsWithDigits", True)
'        .PhoneticSuggestions = GetSetting("FM Global\Horizon", "Spelling", "PhoneticSuggestions", False)
'        .TypographicalSuggestions = GetSetting("FM Global\Horizon", "Spelling", "TypographicalSuggestions", True)
'        .SuggestSplitWords = GetSetting("FM Global\Horizon", "Spelling", "SuggestSplitWords", True)
'        .UserDictionaryFiles = CStr(strDicPath)
'    End With

    WSpell1.UserDictionaryFiles = CStr(strDicPath)

    tlbrTop.Buttons("Spell Check").Visible = True
    
 '   TXTextControl1.ViewMode = 3 'IB 24-Jun-05
    
    blnSuccess = True

Exit_UserControl_Initialize:

    On Error Resume Next
    Set objUtilities = Nothing  'IB 27-Sep-2010 added
    Exit Sub

Err_UserControl_Initialize:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::UserControl_Initialize"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "UserControl_Initialize", strErrSource, True
    
    Resume Exit_UserControl_Initialize

End Sub

'*******************************************************************************
' UserControl_InitProperties (SUB)
'
' PARAMETERS:
' None
'
' DESCRIPTION:
' occurs only in the control instance's first incarnation, when an instance of
' the control is placed on a form.
'*******************************************************************************
Private Sub UserControl_InitProperties()
    'set initial properties


    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_UserControl_InitProperties
    blnSuccess = False

    m_blnInitialUse = True
    m_blnEnabled = True
    m_blnLocked = False
    m_blnTableEnabled = False
    m_blnAlwaysItalic = False
    m_blnEnableUnderline = False 'IB 28-Mar-05
    m_intTextFormat = HTML
    m_strTextProp = UserControl.Name
    TXTextControl1.Text = m_strTextProp
    m_blnAnsiFontBold = False
    'm_blnHideRuler = False
    m_blnHideToolbar = False
    m_blnSpllChkLstFcs = True
    m_blnIsRequired = False
    m_blnVerticalScrollBars = True
    m_IsOutdated = False                'MAR 06/12/2003 CQ-1192
    m_blnSubScriptEnabled = False
    blnSuccess = True

Exit_UserControl_InitProperties:

    On Error Resume Next
    
    Exit Sub

Err_UserControl_InitProperties:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::UserControl_InitProperties"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "UserControl_InitProperties", strErrSource, True
    
    Resume Exit_UserControl_InitProperties

End Sub


'*******************************************************************************
' UserControl_ReadProperties (SUB)
'
' PARAMETERS:
' (In/Out) - PropBag - PropertyBag -
'
' DESCRIPTION:
' Activated when the control is instantiated. Reads the properties from the
' UserControl's Property Bag
'*******************************************************************************
Private Sub UserControl_ReadProperties(PropBag As PropertyBag)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_UserControl_ReadProperties
    blnSuccess = False

    With PropBag
        m_strTextProp = .ReadProperty("Text", UserControl.Name)
        TXTextControl1.Text = m_strTextProp
        m_blnEnabled = .ReadProperty("Enabled", True)
        m_blnLocked = .ReadProperty("Locked", False)
        m_blnTableEnabled = .ReadProperty("TableEnabled", False)
        tlbrTop.Buttons("Table").Visible = m_blnTableEnabled
        'TXStatusBar1.Visible = m_blnTableEnabled                               'MAR 06/16/2003 CQ-1192
        m_blnAlwaysItalic = .ReadProperty("AlwaysItalic", False)
        m_intTextFormat = .ReadProperty("TextFormat", 4)
        m_intMaxChar = .ReadProperty("MaxCharacters", 0)
        m_intMaxLines = .ReadProperty("MaxLineCount", 0)
        'm_blnHideRuler = .ReadProperty("HideRuler", False)
        m_blnAnsiFontBold = .ReadProperty("AnsiFontBold", False)
        m_blnEnableUnderline = .ReadProperty("EnableUnderline", False) 'IB 28-Mar-05 added
        m_blnHideToolbar = .ReadProperty("HideToolbar", False)
        m_blnSpllChkLstFcs = .ReadProperty("SpellCheckLostFocus", True)
        m_blnIsRequired = .ReadProperty("IsRequired", False)
        m_blnVerticalScrollBars = .ReadProperty("VerticalScrollBars", True)
        VerticalScrollBars = m_blnVerticalScrollBars
        m_IsOutdated = .ReadProperty("IsOutdated", False) 'MAR 06/12/2003 CQ-1192
        m_eTableMaxWidth = .ReadProperty("TableMaxWidth", 0) 'IB 10-Feb-05
        m_blnSubScriptEnabled = .ReadProperty("subScriptEnabled", False) 'IB 15-Feb-05
    End With
    
'   03-Feb-2004 - JPK
'   Clear out the default dictionaries set by the WSpell control
    WSpell1.MainDictionaryFiles = ""
    
'   23-Jun-2003 - JPK
'   set the default language for the spell checker (English)
    m_strSpellCheckerLanguage = "EN"
    
    'set all default properties based on above settings
    SetItalic
    SetTextFormat
    SetEnabled
    SetLocked
    SetColors
    SetUnderline
    
    MaxLineCount = m_intMaxLines

    blnSuccess = True

Exit_UserControl_ReadProperties:

    On Error Resume Next
    
    Exit Sub

Err_UserControl_ReadProperties:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::UserControl_ReadProperties"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "UserControl_ReadProperties", strErrSource, True
    
    Resume Exit_UserControl_ReadProperties

End Sub

'*******************************************************************************
' UserControl_Resize (SUB)
'
' PARAMETERS:
' None
'
' DESCRIPTION:
' Activated when the user resizes this control on a form. Resizes TXTControl1
' Note:  Design Time only
'*******************************************************************************
Private Sub UserControl_Resize()

    Dim intRulerHeight As Integer
    Dim intToolbarHeight As Integer
    Dim intStatusbarHeight As Integer
    Dim intBorderHeightGap As Integer           'MAR 06/12/2003 CQ-1192
    Dim intBorderWidthGap As Integer            'MAR 06/13/2003 CQ-1192
    
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_UserControl_Resize
    blnSuccess = False

    
    'can't get tabs to work with html, so disable ruler always
    'set Ruler height
    'intRulerHeight = TXRuler1.Height
    'If m_blnHideRuler Then intRulerHeight = 0
    'set toolbar height
    
    intToolbarHeight = tlbrTop.Height
    If m_blnHideToolbar Then intToolbarHeight = 0
    
    intRulerHeight = 0
    intBorderHeightGap = 25                   'MAR 06/12/2003 CQ-1192
    intBorderWidthGap = 33                    'MAR 06/13/2003 CQ-1192
    
    intStatusbarHeight = 0
    'intStatusbarHeight = TXStatusBar1.Height
    'If m_blnLocked Then intStatusbarHeight = 0
    'If m_blnTableEnabled = False Then intStatusbarHeight = 0
    
    With UserControl
    
    
        ' set the minimum width & heigth of text control - MAR 06/12/2003 CQ-1192
        Select Case m_intTextFormat
            Case HTML
                If .Height < 360 + intToolbarHeight + intBorderHeightGap Then
                    .Height = 360 + intToolbarHeight + intBorderHeightGap
                End If
            Case ANSI
                If .Height < 305 + intBorderHeightGap Then
                    .Height = 305 + intBorderHeightGap
                End If
        End Select
        
        If m_blnInitialUse Then
            .Width = 8670
        End If
        If m_blnLocked Then
        
            If .Width < 1000 Then
                .Width = 1000
            End If
            
            TXTextControl1.Top = 0
            TXTextControl1.Height = .Height - 60 - intBorderHeightGap
            TXTextControl1.Width = .Width - 50 - intBorderWidthGap
        Else
            TXTextControl1.Top = 330
            If m_blnHideToolbar = False And m_intTextFormat = HTML Then
            
                 'if a tables are enabled then..
                If m_blnTableEnabled Then
                    If .Width < 4050 Then
                        .Width = 4050
                    End If
                    If m_blnEnabled Then
                        TXTextControl1.Height = .Height - (400 + intBorderHeightGap)
                        TXTextControl1.Width = .Width - 50 - intBorderWidthGap
                    End If
                Else
                    If .Width < 3500 Then
                        .Width = 3500
                    End If
                    
                    If m_blnEnabled Then
                        If m_intTextFormat = ANSI Or m_blnLocked Or Not m_blnEnabled Then
                            TXTextControl1.Height = .Height - 60 - intBorderHeightGap
                        Else
                            TXTextControl1.Height = .Height - (400 + intBorderHeightGap)
                        End If
                        
                        TXTextControl1.Width = .Width - 50 - intBorderWidthGap

                    End If
                End If
            Else
                TXTextControl1.Top = 0
                
                If .Width < 1000 Then
                    .Width = 1000
                End If
                
                TXTextControl1.Height = .Height - 60 - intBorderHeightGap
                TXTextControl1.Width = .Width - 50 - intBorderWidthGap
            End If
        End If
        
        'set the location and width of toolbar - MAR 06/16/2003 CQ-1192
        tlbrTop.Top = 0
        tlbrTop.Width = .Width - 50 - intBorderWidthGap

    End With
    
    m_blnInitialUse = False

    blnSuccess = True

Exit_UserControl_Resize:

    On Error Resume Next
    
    Exit Sub

Err_UserControl_Resize:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::UserControl_Resize"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "UserControl_Resize", strErrSource, True
    
    Resume Exit_UserControl_Resize

End Sub

'*******************************************************************************
' UserControl_WriteProperties (SUB)
'
' PARAMETERS:
' (In/Out) - PropBag - PropertyBag -
'
' DESCRIPTION:
' Activated when the control is destroyed. Writes the properties to the
' UserControl's Property Bag
'
' UPDATE HISTORY:
'   28-Mar-05       Irene Bellettiere       add FontUnderline property
'*******************************************************************************
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
    'save controls property

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_UserControl_WriteProperties
    blnSuccess = False

    With PropBag
        .WriteProperty "Enabled", m_blnEnabled, True
        .WriteProperty "Locked", m_blnLocked, False
        .WriteProperty "Text", TXTextControl1.Text, UserControl.Name
        .WriteProperty "TableEnabled", m_blnTableEnabled, False
        .WriteProperty "AlwaysItalic", m_blnAlwaysItalic, False
        .WriteProperty "EnableUnderline", m_blnEnableUnderline, False 'IB 28-Mar-05
        .WriteProperty "TextFormat", m_intTextFormat, HTML
        .WriteProperty "MaxLineCount", m_intMaxLines, 0
        .WriteProperty "MaxCharacters", m_intMaxChar, 0
        .WriteProperty "HideToolbar", m_blnHideToolbar, False
        .WriteProperty "AnsiFontBold", m_blnAnsiFontBold, False
        '.WriteProperty "HideRuler", m_blnHideRuler, False
        .WriteProperty "SpellCheckLostFocus", m_blnSpllChkLstFcs, True
        .WriteProperty "IsRequired", m_blnIsRequired, False
        .WriteProperty "VerticalScrollBars", m_blnVerticalScrollBars, True
        .WriteProperty "IsOutdated", m_IsOutdated, False                        'MAR 06/12/2003 CQ-1192

    End With

    blnSuccess = True

Exit_UserControl_WriteProperties:

    On Error Resume Next
    
    Exit Sub

Err_UserControl_WriteProperties:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::UserControl_WriteProperties"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "UserControl_WriteProperties", strErrSource, True
    
    Resume Exit_UserControl_WriteProperties

End Sub

'*******************************************************************************
' TXTextControl1_ObjectCreated (PRIVATE SUB)
'
' DESCRIPTION:
' this only fires if an object (or picture) arrives - it ignores text
' to allow paste interception add timer timUnpaste to your form,
' enabled=false, interval=50
'
' PARAMETERS:
' (In) - ObjectId - Integer -
'*******************************************************************************
Private Sub TXTextControl1_ObjectCreated(ByVal ObjectId As Integer)
    'clean up pasted image

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_TXTextControl1_ObjectCreated
    blnSuccess = False

    m_bytExclude = exObject
    tmrUnpaste.Enabled = True

    blnSuccess = True

Exit_TXTextControl1_ObjectCreated:

    On Error Resume Next
    
    Exit Sub

Err_TXTextControl1_ObjectCreated:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::TXTextControl1_ObjectCreated"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "TXTextControl1_ObjectCreated", strErrSource, True
    
    Resume Exit_TXTextControl1_ObjectCreated

End Sub

'*******************************************************************************
' timUnpaste_Timer (PRIVATE SUB)
'
' DESCRIPTION:
' Used to Delete any unwanted objects.
'
' PARAMETERS:
' None
'
' UPDATE HISTORY:
'   09-Feb-05           Irene Bellettiere       add code to delete table when table is too wide. CQ 69
'*******************************************************************************
Private Sub tmrUnpaste_Timer()
    Dim a_lngTemp() As Long
    Dim intMaxRow As Integer
    
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_tmrUnpaste_Timer
    blnSuccess = False

    m_blnJustPastedDelete = True
    tmrUnpaste.Enabled = False
    'kill the wabbit! - TXTextControl1 is my textcontrol
    Select Case m_bytExclude
        Case exNone
        Case exObject
            TXTextControl1.ObjectDelete TXTextControl1.ObjectCurrent
            'You can't just objectdelete in the objectcreated event - it gets mad.
            MsgBox "Please insert attachments with the Horizon Attachment Manager", , "Horizon"
        
        Case extable
            'CurrentInputPosition = (0) Page, (1) Line, (2) Column
            a_lngTemp = TXTextControl1.CurrentInputPosition
            'need loop incase inserting multiple tables
            'so loop until you process the last line
            Do Until a_lngTemp(1) < 1
                TXTextControl1.SelStart = -1
                a_lngTemp = TXTextControl1.CurrentInputPosition
                Do Until TXTextControl1.TableAtInputPos <> 0 Or a_lngTemp(1) < 1
                    a_lngTemp(1) = a_lngTemp(1) - 1
                    'need to set to first column incase shorter line
                    a_lngTemp(2) = 0
                    If a_lngTemp(1) > 0 Then
                        TXTextControl1.CurrentInputPosition = a_lngTemp
                    End If
                Loop
                If a_lngTemp(1) > 0 Then
                    SelectTable
                    TXTextControl1.TableDeleteLines
                End If
            Loop
            MsgBox "Tables are not supported in this Field." & vbCrLf & "Please use Report/Comment.", , "Horizon"
                
        'IB 09-Feb-05 add:
        Case exTableTooLarge
                
            'delete the table
            With TXTextControl1
                .SelStart = .TableCellStart(m_intTableId, 1, 1)
                .SelLength = .TableCellStart(m_intTableId, .TableRows(m_intTableId), _
                .TableColumns(m_intTableId)) + .TableCellLength(m_intTableId, _
                .TableRows(m_intTableId), .TableColumns(m_intTableId)) + -.SelStart
                .TableDeleteLines
            End With
                
            MsgBox "Table is too wide." & vbCrLf & "Please modify and try again.", , "Horizon"
            'IB end 09-Feb-05
    End Select
    
    m_blnJustPastedDelete = False
    m_bytExclude = exNone

    blnSuccess = True

Exit_tmrUnpaste_Timer:

    On Error Resume Next
    
    Exit Sub

Err_tmrUnpaste_Timer:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::tmrUnpaste_Timer"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "tmrUnpaste_Timer", strErrSource, True
    
    Resume Exit_tmrUnpaste_Timer

End Sub
'*******************************************************************************
' CheckMaxLines (PRIVATE FUNCTION)
'
' DESCRIPTION:
' Checks Maximum Lines
'
' PARAMETERS:
' None
'
' RETURN VALUE:
' Boolean -
'*******************************************************************************
Private Function CheckMaxLines() As Boolean



    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_CheckMaxLines
    blnSuccess = False

    CheckMaxLines = False
    'checks to see if the change is from the text property.
    If m_strPrevious = "Property Let Text" Then Exit Function
    
    'commented out because can't handle tabs in html
    'If HideToolbar Then
    '    TXTextControl1.TabKey = False
    'End If
    
    Dim a_lngCurPos() As Long
    Dim a_lngTempPos() As Long
    With TXTextControl1
        'bookmark of current position
        a_lngCurPos = .CurrentInputPosition
        'put cursur at end of text
        .SelStart = -1
        'get end of text position info
        a_lngTempPos = .CurrentInputPosition
        
        If a_lngTempPos(1) > m_intMaxLines And _
            m_intMaxLines <> 0 And _
                TXTextControl1.WordWrapMode = 1 Then
                
            CheckMaxLines = True
            MsgBox "You are limited to " & m_intMaxLines & " lines.", , "Horizon"
            While a_lngTempPos(1) > m_intMaxLines
                .SelStart = .SelStart - 1
                .SelLength = 1
                .SelText = vbNullString
                a_lngTempPos = .CurrentInputPosition
            Wend
        Else
            .CurrentInputPosition = a_lngCurPos
        End If
    End With

    blnSuccess = True

Exit_CheckMaxLines:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_CheckMaxLines:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::CheckMaxLines"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "CheckMaxLines", strErrSource, False
    
    Resume Exit_CheckMaxLines

End Function

'*******************************************************************************
' CheckMaxChar (PRIVATE FUNCTION)
'
' DESCRIPTION:
' Checks Maximum Characters
'
' PARAMETERS:
' None
'
' RETURN VALUE:
' Boolean -
'*******************************************************************************
Private Function CheckMaxChar() As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_CheckMaxChar
    blnSuccess = False

    CheckMaxChar = False
    'checks to see if the change is from the text property.
    If m_strPrevious = "Property Let Text" Then Exit Function
    Dim a_lngCurPos() As Long
    Dim longTextLength As Long
    
    
    With TXTextControl1
        .CurrentInputPosition = a_lngCurPos
        longTextLength = Len(.Text)
        If m_intMaxChar <> 0 And longTextLength > m_intMaxChar Then
            CheckMaxChar = True
            MsgBox "You are limited to " & m_intMaxChar & " characters.", , "Horizon"
            m_strPrevious = "CheckMaxChar"
            Select Case m_intTextFormat
                Case ANSI
                    .Text = Left$(.Text, m_intMaxChar - 1)
                Case HTML
                    .Visible = False
                    .SelStart = 0
                    .SelLength = m_intMaxChar
                    m_abytData = .SaveToMemory(3, True)
                    .LoadFromMemory m_abytData, 3
                    .Visible = True
            End Select
        End If
    End With

    blnSuccess = True

Exit_CheckMaxChar:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_CheckMaxChar:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::CheckMaxChar"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "CheckMaxChar", strErrSource, False
    
    Resume Exit_CheckMaxChar

End Function


'*******************************************************************************
' TXTextControl1_Click (SUB)
'
' PARAMETERS:
' None
'
' DESCRIPTION:
' Occurs when the user presses and then releases a mouse button over the Text Control.
'*******************************************************************************
Private Sub TXTextControl1_Click()

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_TXTextControl1_Click
    blnSuccess = False

    ToggleToolbarButtons

    RaiseEvent Click

    blnSuccess = True

Exit_TXTextControl1_Click:

    On Error Resume Next
    
    Exit Sub

Err_TXTextControl1_Click:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::TXTextControl1_Click"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "TXTextControl1_Click", strErrSource, True
    
    Resume Exit_TXTextControl1_Click

End Sub

'*******************************************************************************
' TXTextControl1_Error (SUB)
'
' PARAMETERS:
' (In/Out) - Number        - Integer -
' (In/Out) - Description   - String  -
' (In/Out) - Scode         - Long    -
' (In/Out) - Source        - String  -
' (In/Out) - HelpFile      - String  -
' (In/Out) - HelpContext   - Long    -
' (In/Out) - CancelDisplay - Boolean -
'
' DESCRIPTION:
' Raises an error if an error occurs
'*******************************************************************************
Private Sub TXTextControl1_Error(Number As Integer, _
                                  Description As String, _
                                  Scode As Long, _
                                  Source As String, _
                                  HelpFile As String, _
                                  HelpContext As Long, _
                                  CancelDisplay As Boolean)
                                  

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_TXTextControl1_Error
    blnSuccess = False

    Select Case Number
    
        Case 321, 57 'wrong type saved
            CancelDisplay = True
            With TXTextControl1
                .Text = m_strTextProp
                m_abytData = .SaveToMemory(m_intTextFormat)
                .LoadFromMemory m_abytData, m_intTextFormat
            End With
            PropertyChanged "Text"
        
        Case 380
            CancelDisplay = True
        
        Case Else
            RaiseEvent Error(Number, _
                              Description, _
                              Scode, _
                              Source, _
                              HelpFile, _
                              HelpContext, _
                              CancelDisplay)
    End Select
  
    blnSuccess = True

Exit_TXTextControl1_Error:

    On Error Resume Next
    
    Exit Sub

Err_TXTextControl1_Error:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::TXTextControl1_Error"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "TXTextControl1_Error", strErrSource, True
    
    Resume Exit_TXTextControl1_Error

End Sub

'*******************************************************************************
' tlbrTop_ButtonClick (SUB)
'
' PARAMETERS:
' (In) - Button - MSComctlLib.Button -
'
' DESCRIPTION:
'   Occurs when the user clicks on a Button object in the Toolbar control.
'   This procedure assigns various formating to the selected text in the
'   Text Control
'*******************************************************************************
Private Sub tlbrTop_ButtonClick(ByVal Button As MSComctlLib.Button)
    Dim strKey As String
    Dim dblSaveBaseline As Double
    
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_tlbrTop_ButtonClick
    blnSuccess = False


    strKey = Button.Key
    With TXTextControl1
        Select Case strKey
            Case "Bold"
                Select Case .FontBold
                    Case 0, 2
                        .FontBold = 1
                    Case 1
                        .FontBold = 0
                End Select
                'need to raise event here incase no actual text change, just format change
                'only raise event in change event if actual code change
                RaiseEvent Change
            Case "Italic"
                Select Case .FontItalic
                    Case 0, 2
                        .FontItalic = 1
                    Case 1
                        .FontItalic = 0
                End Select
                RaiseEvent Change
            'IB 28-Mar-05 add underline
            Case "Underline"
                Select Case .FontUnderline
                    Case 0, 2
                        .FontUnderline = 1
                    Case 1
                        .FontUnderline = 0
                End Select 'end IB 28-Mar-05
                RaiseEvent Change
            Case "Cut"
                .Clip 1
            Case "Copy"
                .Clip 2
            Case "Paste"
                m_blnSetFormat = True
                .Clip 3
            Case "Bullets"
                If .ListAttrDialog Then
                    RaiseEvent Change
                End If
            Case "Undo"
                If Not m_blnJustPasted Then .Undo
            Case "Redo"
                If Not m_blnJustPasted Then .Redo
            Case "Spell Check"
                SpellCheckNow True
            Case "Font" 'IB 17-Feb-05 added:
                dblSaveBaseline = TXTextControl1.BaseLine
                frmDlgFont.showFontProp TXTextControl1
                If TXTextControl1.SelLength > 0 And _
                    dblSaveBaseline <> TXTextControl1.BaseLine Then
                    RaiseEvent Change
                End If 'end IB 17-Feb-05
            Case "Find"
                frmDlgFindReplace.ShowFind TXTextControl1 'IB 18-Feb-05 added
        End Select
    End With
  
    ToggleToolbarButtons

    blnSuccess = True

Exit_tlbrTop_ButtonClick:

    On Error Resume Next
    
    Exit Sub

Err_tlbrTop_ButtonClick:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::tlbrTop_ButtonClick"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "tlbrTop_ButtonClick", strErrSource, True
    
    Resume Exit_tlbrTop_ButtonClick

End Sub

'*******************************************************************************
' tlbrTop_ButtonDropDown (SUB)
' DESCRIPTION:
'   Occurs when the user clicks the dropdown arrow on a Button object.
'
' PARAMETERS:
' (In) - Button - MSComctlLib.Button -
'*******************************************************************************
Private Sub tlbrTop_ButtonDropDown(ByVal Button As MSComctlLib.Button)
    Dim blnAtTable As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_tlbrTop_ButtonDropDown
    blnSuccess = False

  
    blnAtTable = TXTextControl1.TableAtInputPos <> 0
    'set drop down menu defaults
    With tlbrTop.Buttons("Table")
        .ButtonMenus("Insert Table").Enabled = TXTextControl1.TableCanInsert
        .ButtonMenus("Insert Column").Enabled = TXTextControl1.TableCanInsertColumn
        .ButtonMenus("Insert Row").Enabled = TXTextControl1.TableCanInsertLines
        .ButtonMenus("Remove Table").Enabled = blnAtTable
        .ButtonMenus("Remove Row").Enabled = TXTextControl1.TableCanDeleteLines
        .ButtonMenus("Remove Column").Enabled = TXTextControl1.TableCanDeleteColumn
        .ButtonMenus("Table Properties").Enabled = blnAtTable
    End With

    blnSuccess = True

Exit_tlbrTop_ButtonDropDown:

    On Error Resume Next
    
    Exit Sub

Err_tlbrTop_ButtonDropDown:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::tlbrTop_ButtonDropDown"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "tlbrTop_ButtonDropDown", strErrSource, True
    
    Resume Exit_tlbrTop_ButtonDropDown

End Sub

'*******************************************************************************
' tlbrTop_ButtonMenuClick (SUB)
' DESCRIPTION:
'   Occurs when the user clicks a ButtonMenu object.
'
' PARAMETERS:
' (In) - ButtonMenu - MSComctlLib.ButtonMenu -
'*******************************************************************************
Private Sub tlbrTop_ButtonMenuClick(ByVal ButtonMenu As MSComctlLib.ButtonMenu)


    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_tlbrTop_ButtonMenuClick
    blnSuccess = False

    With TXTextControl1
        Select Case ButtonMenu.Key
            Case "Insert Table"
                frmDlgTable.ShowTableProp TXTextControl1
            Case "Remove Table"
                SelectTable
                .TableDeleteLines
            Case "Insert Column"
                .TableInsertColumn txTableInsertAfter
            Case "Insert Row"
                .TableInsertLines txTableInsertAfter, 1
            Case "Remove Column"
                .TableDeleteColumn
            Case "Remove Row"
                .TableDeleteLines
            Case "Table Properties"
                .TableAttrDialog
        End Select
    End With

    blnSuccess = True

Exit_tlbrTop_ButtonMenuClick:

    On Error Resume Next
    
    Exit Sub

Err_tlbrTop_ButtonMenuClick:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::tlbrTop_ButtonMenuClick"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "tlbrTop_ButtonMenuClick", strErrSource, True
    
    Resume Exit_tlbrTop_ButtonMenuClick

End Sub

'*******************************************************************************
' SelectTable (SUB)
' DESCRIPTION:
'   Selects the current table where cursur is
'
' PARAMETERS:
' None
'*******************************************************************************
Private Sub SelectTable()
    'selects table at cursor point

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_SelectTable
    blnSuccess = False

    With TXTextControl1
        .SelStart = .TableCellStart(.TableAtInputPos, 1, 1) - 1
        .SelLength = .TableCellStart(.TableAtInputPos, .TableRows(.TableAtInputPos), _
        .TableColumns(.TableAtInputPos)) + .TableCellLength(.TableAtInputPos, _
        .TableRows(.TableAtInputPos), .TableColumns(.TableAtInputPos)) + -.SelStart
    End With

    blnSuccess = True

Exit_SelectTable:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_SelectTable:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::SelectTable"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "SelectTable", strErrSource, False
    
    Resume Exit_SelectTable

End Sub

'*******************************************************************************
' SetItalic (SUB)
' DESCRIPTION:
'   sets or releases all text to or from italic
'
' PARAMETERS:
' None
'*******************************************************************************
Private Sub SetItalic()


    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_SetItalic
    blnSuccess = False

    If m_blnAlwaysItalic Then
        'set italic
        With TXTextControl1
            .Visible = False
            .FormatSelection = False
            .FontItalic = 1
            .FormatSelection = True
            .Visible = True
        End With
        tlbrTop.Buttons("Italic").Visible = False
    Else
        tlbrTop.Buttons("Italic").Visible = True
    End If

    blnSuccess = True

Exit_SetItalic:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_SetItalic:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::SetItalic"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "SetItalic", strErrSource, False
    
    Resume Exit_SetItalic

End Sub

'*******************************************************************************
' ToggleToolbarButtons (SUB)
'
' PARAMETERS:
' None
'
' DESCRIPTION:
' Presses and Unpresses Toolbar buttons according to formating
'
' UPDATE HISTORY:
'   28-Mar-05           Irene Bellettiere       add underline CQ 6791
'*******************************************************************************
Private Sub ToggleToolbarButtons()
    'toggle appropriate buttons

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_ToggleToolbarButtons
    blnSuccess = False

    With tlbrTop
        Select Case TXTextControl1.FontBold
            Case 0, 2
                .Buttons("Bold").Value = tbrUnpressed
            Case 1
                .Buttons("Bold").Value = tbrPressed
        End Select
        
        Select Case TXTextControl1.FontItalic
            Case 0, 2
                .Buttons("Italic").Value = tbrUnpressed
            Case 1
                .Buttons("Italic").Value = tbrPressed
        End Select
        
        'IB 28-Mar-05 add underline:
        Select Case TXTextControl1.FontUnderline
            Case 0, 2
                .Buttons("Underline").Value = tbrUnpressed
            Case 1
                .Buttons("Underline").Value = tbrPressed
        End Select 'IB end 28-Mar-05
        .Refresh
    End With

    blnSuccess = True

Exit_ToggleToolbarButtons:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_ToggleToolbarButtons:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::ToggleToolbarButtons"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "ToggleToolbarButtons", strErrSource, False
    
    Resume Exit_ToggleToolbarButtons

End Sub

'*******************************************************************************
' SetTextFormat (SUB)
' DESCRIPTION:
'  sets the format of the text
'
' PARAMETERS:
' None
'*******************************************************************************
Private Sub SetTextFormat()

    Dim intTryMax As Integer
    Dim intTryCount As Integer
    
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_SetTextFormat
    blnSuccess = False

    m_blnJustPasted = True
    'set properties based on format
    Select Case m_intTextFormat
        Case HTML
            TXTextControl1.Align = 0
            'TXRuler1.Align = 0
            tlbrTop.Align = 0
            'TXRuler1.Align = 1
            TXTextControl1.FormatSelection = False
            TXTextControl1.FontName = "Times New Roman"
            
            'TXTextControl1.FontSize = 11
            ' Set FontSize - GBW 08-Nov-2003 - Replaces above Action
            intTryMax = 10
            intTryCount = 0
            Do
                intTryCount = intTryCount + 1
                If intTryCount < intTryMax Then
                    If intTryCount <> 1 Then
                        App.LogEvent (Ambient.DisplayName & "::hznRichText::SetTextFormat:  Internally setting FontSize=11 (TryCount=" & CStr(intTryCount) & ")")
                    End If
                    On Error Resume Next
                Else
                    On Error GoTo Err_SetTextFormat
                End If
                TXTextControl1.FontSize = 11
            Loop While intTryCount < intTryMax And Err.Number <> 0
            On Error GoTo Err_SetTextFormat

            TXTextControl1.ForeColor = vbBlack
            'can't replace tabs here, needed to allow pasting of tables
            'can't handle tab char in html, so replace with space
            'TXTextControl1.Text = Replace(TXTextControl1.Text, Chr(9), " ")
            ' 27-Aug-2002 - MW
            'fixes problem with pasting from ms-word when format
            'in word was not single space
            TXTextControl1.LineSpacing = 100
            
            TXTextControl1.FormatSelection = True
            tlbrTop.Enabled = True
        Case ANSI
            tlbrTop.Enabled = False
            tlbrTop.Align = 0
            'TXRuler1.Align = 0
            TXTextControl1.FormatSelection = False
            TXTextControl1.FontName = "tahoma"
            
            'TXTextControl1.FontSize = 8
            ' Set FontSize - GBW 08-Nov-2003 - Replaces above Action
            intTryMax = 10
            intTryCount = 0
            Do
                intTryCount = intTryCount + 1
                If intTryCount < intTryMax Then
                    If intTryCount <> 1 Then
                        App.LogEvent (Ambient.DisplayName & "::hznRichText::SetTextFormat:  Internally setting FontSize=8 (TryCount=" & CStr(intTryCount) & ")")
                    End If
                    On Error Resume Next
                Else
                    On Error GoTo Err_SetTextFormat
                End If
                ' 15-Jan-2004 - JPK per CQ log 3271 & 3036
                ' Fontsize was previouly set to 8
                TXTextControl1.FontSize = 10
            Loop While intTryCount < intTryMax And Err.Number <> 0
            On Error GoTo Err_SetTextFormat
            
            TXTextControl1.Align = 0
            TXTextControl1.ForeColor = vbBlack
            TXTextControl1.FormatSelection = True
            If m_blnAnsiFontBold Then
                TXTextControl1.FontBold = True
            Else
                TXTextControl1.FontBold = False
            End If
    End Select
    ToggleControls

    blnSuccess = True

Exit_SetTextFormat:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_SetTextFormat:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::SetTextFormat"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "SetTextFormat", strErrSource, False
    
    Resume Exit_SetTextFormat

End Sub

'*******************************************************************************
' SpellCheckLostFocus (PUBLIC PROPERTY GET)
'*******************************************************************************
Public Property Get SpellCheckLostFocus() As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_SpellCheckLostFocus
    blnSuccess = False

    SpellCheckLostFocus = m_blnSpllChkLstFcs

    blnSuccess = True

Exit_SpellCheckLostFocus:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_SpellCheckLostFocus:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::SpellCheckLostFocus"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "SpellCheckLostFocus", strErrSource, False
    
    Resume Exit_SpellCheckLostFocus

End Property

'*******************************************************************************
' SpellCheckLostFocus (PUBLIC PROPERTY LET)
'*******************************************************************************
Public Property Let SpellCheckLostFocus(ByVal av_blnNewValue As Boolean)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_SpellCheckLostFocus
    blnSuccess = False

    m_blnSpllChkLstFcs = av_blnNewValue
    PropertyChanged "SpellCheckLostFocus"

    blnSuccess = True

Exit_SpellCheckLostFocus:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_SpellCheckLostFocus:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::SpellCheckLostFocus"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "SpellCheckLostFocus", strErrSource, False
    
    Resume Exit_SpellCheckLostFocus

End Property

'*******************************************************************************
' HideRuler (PUBLIC PROPERTY GET)
'*******************************************************************************
Public Property Get HideRuler() As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_HideRuler
    blnSuccess = False

'    HideRuler = m_blnHideRuler

    blnSuccess = True

Exit_HideRuler:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_HideRuler:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::HideRuler"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "HideRuler", strErrSource, False
    
    Resume Exit_HideRuler

End Property

'*******************************************************************************
' HideRuler (PUBLIC PROPERTY LET)
'*******************************************************************************
Public Property Let HideRuler(ByVal av_blnNewValue As Boolean)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_HideRuler
    blnSuccess = False

'    'used a select case for future expansion
'    Select Case m_intTextFormat
'    Case HTML
'        m_blnHideRuler = av_blnNewValue
'        SetTextFormat
'        PropertyChanged "HideRuler"
'    Case ANSI
'        m_blnHideRuler = True
'        SetTextFormat
'        PropertyChanged "HideRuler"
'    End Select

    blnSuccess = True

Exit_HideRuler:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_HideRuler:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::HideRuler"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "HideRuler", strErrSource, False
    
    Resume Exit_HideRuler

End Property

'*******************************************************************************
' AnsiFontBold (PUBLIC PROPERTY GET)
'*******************************************************************************
Public Property Get AnsiFontBold() As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_AnsiFontBold
    blnSuccess = False

    AnsiFontBold = m_blnAnsiFontBold

    blnSuccess = True

Exit_AnsiFontBold:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_AnsiFontBold:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::AnsiFontBold"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "AnsiFontBold", strErrSource, False
    
    Resume Exit_AnsiFontBold

End Property

'*******************************************************************************
' AnsiFontBold (PUBLIC PROPERTY LET)
'*******************************************************************************
Public Property Let AnsiFontBold(ByVal av_blnNewValue As Boolean)
    'used a select case for future expansion

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_AnsiFontBold
    blnSuccess = False

    Select Case m_intTextFormat
    Case ANSI
        m_blnAnsiFontBold = av_blnNewValue
        SetTextFormat
        PropertyChanged "AnsiFontBold"
    End Select

    blnSuccess = True

Exit_AnsiFontBold:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_AnsiFontBold:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::AnsiFontBold"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "AnsiFontBold", strErrSource, False
    
    Resume Exit_AnsiFontBold

End Property
'*******************************************************************************
' HideToolbar (PUBLIC PROPERTY GET)
'*******************************************************************************
Public Property Get HideToolbar() As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_HideToolbar
    blnSuccess = False

    HideToolbar = m_blnHideToolbar

    blnSuccess = True

Exit_HideToolbar:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_HideToolbar:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::HideToolbar"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "HideToolbar", strErrSource, False
    
    Resume Exit_HideToolbar

End Property

'*******************************************************************************
' HideToolbar (PUBLIC PROPERTY LET)
'*******************************************************************************
Public Property Let HideToolbar(ByVal av_blnNewValue As Boolean)
    'used a select case for future expansion

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_HideToolbar
    blnSuccess = False

    Select Case m_intTextFormat
    Case HTML
        m_blnHideToolbar = av_blnNewValue
        TableEnabled = Not av_blnNewValue
        SetTextFormat
        PropertyChanged "HideToolbar"
    Case ANSI
        m_blnHideToolbar = True
        SetTextFormat
        PropertyChanged "HideToolbar"
    End Select

    blnSuccess = True

Exit_HideToolbar:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_HideToolbar:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::HideToolbar"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "HideToolbar", strErrSource, False
    
    Resume Exit_HideToolbar

End Property


'*******************************************************************************
' WSpell1_DeleteWord (PRIVATE SUB)
'
' DESCRIPTION:
' Fired when a word is deleted with the delete word button in the spell check
'
' PARAMETERS:
' (In) - offset - Long -
'*******************************************************************************
'Private Sub WSpell1_DeleteWord(ByVal offset As Long)
'    'for some reason, getting a chr(13) prefix if repeated words split a line
'    WSpell1.MisspelledWord = Replace(WSpell1.MisspelledWord, Chr(13), "")
'    FindWord
'    'get rid of dup word
'    TXTextControl1.SelText = vbNullString
'    WSpell1.ReplaceAllWord
'End Sub

'*******************************************************************************
' WSpell1_ReplaceWord (PRIVATE SUB)
'
' DESCRIPTION:
' Fired when a word is replaced with the replace word button in the spell check
'
' PARAMETERS:
' None
'*******************************************************************************
'Private Sub WSpell1_ReplaceWord()
'    FindWord
'    'replace selected text with the new word
'    TXTextControl1.SelText = WSpell1.ReplacementWord
'End Sub

'Private Sub FindWord()
'    Dim strTemp As String
'    Dim intInStr As Integer
'    Dim intCRNum As Integer 'Number of Carrage Returns
'
'    With TXTextControl1
'        intInStr = 0
'        intCRNum = 0
'        strTemp = .Text
'        'is line feed in the string?
'        intInStr = InStr(1, strTemp, Chr(10))
'        Do Until intInStr = 0 Or intInStr > WSpell1.WordOffset
'            intCRNum = intCRNum + 1
'            intInStr = InStr(intInStr + 1, strTemp, Chr(10))
'        Loop
'        'start cursur at begining of word taking into account the line number
'        .SelStart = WSpell1.WordOffset - intCRNum
'        .SelLength = Len(WSpell1.MisspelledWord)
'    End With
'
'End Sub

'*******************************************************************************
' SetColors (PRIVATE SUB)
'
' DESCRIPTION:
' Sets the colors for the control.
'
' PARAMETERS:
' None
'*******************************************************************************
Private Sub SetColors()
    

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_SetColors
    blnSuccess = False

     If Enabled = True Then
        If Locked = True Then
            TXTextControl1.BackColor = &H80000016
        Else
            If IsRequired = True Then
                TXTextControl1.BackColor = vbYellow
            Else
                TXTextControl1.BackColor = vbWhite
            End If
        End If
    Else
        TXTextControl1.BackColor = &H80000016
    End If
    
    'change border color based on IsOutdated property - MAR 06/12/2003 CQ-1192
    If IsOutdated Then
        UserControl.BackColor = vbRed
    Else
        UserControl.BackColor = vbButtonFace
    End If

    blnSuccess = True

Exit_SetColors:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_SetColors:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::SetColors"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "SetColors", strErrSource, False
    
    Resume Exit_SetColors

End Sub
Public Property Get IsOutdated() As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_IsOutdated
    blnSuccess = False


    IsOutdated = m_IsOutdated


    blnSuccess = True

Exit_IsOutdated:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_IsOutdated:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::IsOutdated"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "IsOutdated", strErrSource, False
    
    Resume Exit_IsOutdated

End Property

Public Property Let IsOutdated(ByVal New_IsOutdated As Boolean)
   
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_IsOutdated
    blnSuccess = False


    m_IsOutdated = New_IsOutdated
    PropertyChanged "IsOutdated"
   
    ' Set Colors
    Call SetColors


    blnSuccess = True

Exit_IsOutdated:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_IsOutdated:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::IsOutdated"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "IsOutdated", strErrSource, False
    
    Resume Exit_IsOutdated

End Property

'*******************************************************************************
' SetEnabled (SUB)
'
' DESCRIPTION:
' Enables and disables constituent controls
'*******************************************************************************
Private Sub SetEnabled()
    'enable or disable text control

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_SetEnabled
    blnSuccess = False

    With TXTextControl1
        .Enabled = m_blnEnabled
        If m_blnEnabled Then
            UserControl_Resize
            '.BackColor = &H80000005 'white
        Else
            .Height = UserControl.Height
            '.BackColor = &H8000000B 'gray
        End If
    End With
    ToggleControls

    blnSuccess = True

Exit_SetEnabled:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_SetEnabled:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::SetEnabled"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "SetEnabled", strErrSource, False
    
    Resume Exit_SetEnabled

End Sub
 

'*******************************************************************************
' SetLocked (PRIVATE SUB)
'
' DESCRIPTION:
' Locks or unlocks the control
'
' PARAMETERS:
' None
'*******************************************************************************
Private Sub SetLocked()

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_SetLocked
    blnSuccess = False

    If m_blnLocked Then
        TXTextControl1.EditMode = 1 'Read and Select
        TXTextControl1.Height = UserControl.Height
        'TXTextControl1.BackColor = &H8000000B 'gray
    Else
        TXTextControl1.EditMode = 0
        'TXTextControl1.BackColor = &H80000005 'white
    End If
    ToggleControls

    blnSuccess = True

Exit_SetLocked:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_SetLocked:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::SetLocked"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "SetLocked", strErrSource, False
    
    Resume Exit_SetLocked

End Sub


'*******************************************************************************
' VerticalScrollBars (PUBLIC PROPERTY GET)
'*******************************************************************************
Public Property Get VerticalScrollBars() As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_VerticalScrollBars
    blnSuccess = False

    VerticalScrollBars = m_blnVerticalScrollBars

    blnSuccess = True

Exit_VerticalScrollBars:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_VerticalScrollBars:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::VerticalScrollBars"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "VerticalScrollBars", strErrSource, False
    
    Resume Exit_VerticalScrollBars

End Property

'*******************************************************************************
' VerticalScrollBars (PUBLIC PROPERTY LET)
'*******************************************************************************
Public Property Let VerticalScrollBars(ByVal vNewValue As Boolean)


    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_VerticalScrollBars
    blnSuccess = False

    m_blnVerticalScrollBars = vNewValue
    
    If m_blnVerticalScrollBars Then
        TXTextControl1.ScrollBars = 2
    Else
        TXTextControl1.ScrollBars = 0
    End If
    
    PropertyChanged "VerticalScrollBars"

    blnSuccess = True

Exit_VerticalScrollBars:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_VerticalScrollBars:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::VerticalScrollBars"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "VerticalScrollBars", strErrSource, False
    
    Resume Exit_VerticalScrollBars

End Property


Private Function CleanOlBullet(ByVal strText As String)

    Dim strTemp As String
    Dim blnSuccess As Boolean

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    On Error GoTo Err_CleanOlBullet
    blnSuccess = False
    
    strTemp = Replace(strText, "<ol start=""0"">", "<ol start=""1"">", , , vbTextCompare)
    CleanOlBullet = strTemp
    blnSuccess = True

Exit_CleanOlBullet:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_CleanOlBullet:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::CleanOlBullet"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "CleanOlBullet", strErrSource, False
    
    Resume Exit_CleanOlBullet

End Function


'*******************************************************************************
' SpellCheckerLanguage (PUBLIC PROPERTY LET)
'   23-Jun-2003 - JPK
'*******************************************************************************
Public Property Let SpellCheckerLanguage(ByVal vNewValue As String)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    Dim blnFRCA As Boolean
    Dim blnReloadMainDictionaries As Boolean
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_SpellCheckerLanguage
    blnSuccess = False

'   set the new langage symbol for the spell checker

'   15-Sep-2003 - JPK - Set the spellchecker language to standard French when
'                       French Canadian is requested.
    vNewValue = UCase(vNewValue)
    If vNewValue = "FRCA" Then
        vNewValue = "FR"
        blnFRCA = True
    Else
        blnFRCA = False
    End If

'   16-Apr-2004 - LM - if the language is being changed or first time
'                       then force a reload of the main dictionary.
    If vNewValue <> m_strSpellCheckerLanguage Or _
       WSpell1.MainDictionaryFiles = "" Then
        m_strSpellCheckerLanguage = vNewValue
        SetMainDictionary True
    End If
        
'   16-Apr-2004 - lm - special dictionary settings for certain languages
'   settings found in readme.htm file that comes with dictionary
'   07-May-2004 - lm - added Finish with German and added FRCA setting
    Select Case m_strSpellCheckerLanguage
        Case "FR", "IT"                     'French, Italian
            WSpell1.SplitContractedWords = True
            WSpell1.SplitWords = False
            If blnFRCA Then
                WSpell1.AllowAccentedCaps = False
            Else
                WSpell1.AllowAccentedCaps = True
            End If
        Case "GE", "FS"                     'German, Finish
            WSpell1.SplitContractedWords = False
            WSpell1.SplitWords = True
            WSpell1.AllowAccentedCaps = False
        Case Else
            WSpell1.SplitContractedWords = False
            WSpell1.SplitWords = False
            WSpell1.AllowAccentedCaps = False
    End Select
    
    PropertyChanged "SpellCheckerLanguage" 'IB 01-Mar-05 added
    
    blnSuccess = True

Exit_SpellCheckerLanguage:

    On Error Resume Next

    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_SpellCheckerLanguage:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::SpellCheckerLanguage"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "VerticalScrollBars", strErrSource, False
    
    Resume Exit_SpellCheckerLanguage
    
End Property

'*******************************************************************************
' SpellCheckerLanguage (PUBLIC PROPERTY GET)
'   23-Jun-2003 - JPK
'*******************************************************************************
Public Property Get SpellCheckerLanguage() As String

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_SpellCheckerLanguage
    blnSuccess = False

    SpellCheckerLanguage = m_strSpellCheckerLanguage

    blnSuccess = True

Exit_SpellCheckerLanguage:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Property

Err_SpellCheckerLanguage:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::SpellCheckerLanguage"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "SpellCheckerLanguage", strErrSource, False
    
    Resume Exit_SpellCheckerLanguage

End Property

'*******************************************************************************
' SetMainDictionary (SUB)
' DESCRIPTION:
'   sets the main dictionary of the spell checker.
'   1/19/2016 - SAS - moved Wspell dictionary files to App Root\Wspell
' PARAMETERS:
' None
'*******************************************************************************
Private Sub SetMainDictionary(av_blnDisplayMessage As Boolean)

'   23-Jun-2003    - JPK

    Dim blnSuccess      As Boolean
    
    Dim objFSO As Scripting.FileSystemObject
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    blnSuccess = False
    
    On Error GoTo Err_SetMainDictionary
    
'   15-Jan-2004 - JPK
    
    Dim strTextDictionaryFilename                   As String
    Dim strCompressedDictionaryFilename             As String
    Dim strBritishTextDictionaryFilename            As String
    Dim strBritishCompressedDictionaryFilename      As String
    Dim strEnglishAccentDictionaryFilename          As String
    Dim strEnglishAutoCorrectDictionaryFilename     As String
    Dim strEnglishTechnicalDictionaryFilename       As String

    Dim strMainDictionaries                         As String
    Dim strDictionaryPath                           As String
    Dim objRegistry As Registry
        
    Set objRegistry = New Registry
    
    '// See if we can access the subkey
    objRegistry.CreateSubKey RegistryType_LocalMachine, "SOFTWARE\FM Global\Horizon"
    If (objRegistry.HasValue("App Root")) Then
        ' Read the value
        strDictionaryPath = objRegistry.GetValue("App Root") & "\" & "Wspell"
        ' Close the Key
        objRegistry.Dispose
    End If
'   Set the WSpell main dictionary file variables (both text and compressed)
'   Parse dictionary files based on current language code
    strTextDictionaryFilename = strDictionaryPath & "\WspellMainDictionary_" & m_strSpellCheckerLanguage & ".tlx"
    strCompressedDictionaryFilename = strDictionaryPath & "\WspellMainDictionary_" & m_strSpellCheckerLanguage & ".clx"
    
'   Always set the British English dictionary files. They will be needed if the
'   m_strSpellCheckerLanguage language is set to English.
    strBritishTextDictionaryFilename = strDictionaryPath & "\WspellMainDictionary_BR.tlx"
    strBritishCompressedDictionaryFilename = strDictionaryPath & "\WspellMainDictionary_BR.clx"
    
'------------------------------------------------------------------------------------------------
'   English specialty dictionaries
'   ------------------------------

'   English dictionary file containing non-ASCII characters, including contractions using the
'   "curly" apostrophe (character code 0146), and foreign-origin words containing accented
'   characters (e.g., purée, château, Rhône).
    strEnglishAccentDictionaryFilename = strDictionaryPath & "\WspellAccentDictionary_EN.tlx"
    
'   "Auto Correct" dictionary, which contains several hundred common English misspellings
'   and their correct replacements. If your application uses this dictionary, certain
'   common spelling errors will be corrected automatically or conditionally.
    strEnglishAutoCorrectDictionaryFilename = strDictionaryPath & "\WspellAutoCorrectDictionary_EN.tlx"
    
'   English technical and Internet-related terms.
    strEnglishTechnicalDictionaryFilename = strDictionaryPath & "\WspellTechnicalDictionary_EN.tlx"
'------------------------------------------------------------------------------------------------
    
'   Check for the existence of the main dictionary files. If they are found then set the
'   WSpell main dictionary property and set the toolbar spell checker button visible.
'   If not found, hide the toolbar spell checker button and set the WSpell main dictionary
'   property to empty. For English we will look for both American and British dictionary
'   files. The American and British dictionaries are combined because of the reports done
'   prior to Horizon.

'   Note:   The text dictionaries (ending in .tlx) contain commonly used words. Access to these
'           is faster than the compressed files (ending in .clx), but would be much larger
'           than the compressed version if they contained the full language. The compressed
'           files contain the bulk of the words in a given language.
    
'   Any previously set dictionary list needs to be cleaned out before we create a new list below.
    WSpell1.MainDictionaryFiles = ""
    strMainDictionaries = ""
    
    If objFSO.FileExists(strTextDictionaryFilename) _
    And objFSO.FileExists(strCompressedDictionaryFilename) Then
'       Set language dictionary files were found.
        If m_strSpellCheckerLanguage = "EN" Then
'           The set language is English. We need to check for the British English files.
            If objFSO.FileExists(strBritishTextDictionaryFilename) _
            And objFSO.FileExists(strBritishCompressedDictionaryFilename) Then
'               The British English files are found. Use both the American and British
'               dictionaries when spellchecking English.
                strMainDictionaries = strTextDictionaryFilename _
                                    & "," _
                                    & strBritishTextDictionaryFilename _
                                    & "," _
                                    & strCompressedDictionaryFilename _
                                    & "," _
                                    & strBritishCompressedDictionaryFilename
'               Add English specialty dictionaries if they exist
                If objFSO.FileExists(strEnglishAccentDictionaryFilename) Then
                    strMainDictionaries = strMainDictionaries _
                                        & "," _
                                        & strEnglishAccentDictionaryFilename
                End If
                If objFSO.FileExists(strEnglishAutoCorrectDictionaryFilename) Then
                    strMainDictionaries = strMainDictionaries _
                                        & "," _
                                        & strEnglishAutoCorrectDictionaryFilename
                End If
                If objFSO.FileExists(strEnglishTechnicalDictionaryFilename) Then
                    strMainDictionaries = strMainDictionaries _
                                        & "," _
                                        & strEnglishTechnicalDictionaryFilename
                End If
                WSpell1.MainDictionaryFiles = strMainDictionaries
                m_blnSpllChkDictFound = True
            Else
'               British dictionary files not found. Set variable to turn off
'               spell checker button in the rich text control.
                m_blnSpllChkDictFound = False
            End If
        Else
'           Main dictionary files are found. We are doing a language other than English.
'           Set up the main dictionary files.
            WSpell1.MainDictionaryFiles = strTextDictionaryFilename _
                                        & "," _
                                        & strCompressedDictionaryFilename
            m_blnSpllChkDictFound = True
        End If
    Else
'       Set language dictionary files not found. Set variable to turn off spell checker button
'       in the rich text control
        m_blnSpllChkDictFound = False
    End If
        
    tlbrTop.Buttons("Spell Check").Visible = m_blnSpllChkDictFound
            
    If Not m_blnSpllChkDictFound _
    And av_blnDisplayMessage Then
        MsgBox "Spell Checking Cannot Be Done." _
              & vbCrLf & vbCrLf _
              & "The Dictionary Files Used For Spell Checking Could Not Be Found On Your System."
    End If

    blnSuccess = True

Exit_SetMainDictionary:

    On Error Resume Next

    Set objFSO = Nothing
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_SetMainDictionary:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::SetMainDictionary"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "SetMainDictionary", strErrSource, False
    
    Resume Exit_SetMainDictionary
    
End Sub



'********************************************************************
' WSpell1_MisspelledWord (private sub)
'
'
'
' UPDATE HISTORY:
'
'********************************************************************
Private Sub WSpell1_MisspelledWord()

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_WSpell1_MisspelledWord
    blnSuccess = False

    With TXTextControl1
        .SelStart = WSpell1.WordOffset
        'm_intSelStartForSpelling = WSpell1.WordOffset ' SAS CQ8234
        .SelLength = Len(WSpell1.MisspelledWord)
        m_strMisspelledWord = WSpell1.MisspelledWord
    End With

    blnSuccess = True

Exit_WSpell1_MisspelledWord:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_WSpell1_MisspelledWord:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::WSpell1_MisspelledWord"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "WSpell1_MisspelledWord", strErrSource, False
    
    Resume Exit_WSpell1_MisspelledWord

End Sub


'**************************************************************************
' WSpell1_ReplaceWord (private sub)
'
' Description: to be used with version 11 of the control because interface
'   between txt control and wspell no longer works (can no longer simply pass
'   the handle.
'
' Author: Irene Bellettiere
' Created: 17-Feb-05
'
' UPDATE HISTORY;
'
'**************************************************************************
Private Sub WSpell1_ReplaceWord()
    Dim lngStart As Long
    
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_WSpell1_ReplaceWord
    blnSuccess = False
    
    lngStart = WSpell1.WordOffset
    
    'replace misspelled word.Keep first character to preserve formatting
    With TXTextControl1
        .SelStart = WSpell1.WordOffset + 1
        .SelLength = Len(WSpell1.MisspelledWord) - 1
        .SelText = WSpell1.ReplacementWord
        
        'now delete the first character
        .SelStart = lngStart
        .SelLength = 1
        .SelText = ""
    End With

    blnSuccess = True

Exit_WSpell1_ReplaceWord:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Sub

Err_WSpell1_ReplaceWord:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::WSpell1_ReplaceWord"
    
    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "WSpell1_ReplaceWord", strErrSource, False
    
    Resume Exit_WSpell1_ReplaceWord

End Sub


Private Sub SaveWspellSettings()
    'save user settings
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_SaveWspellSettings
    blnSuccess = False


    With WSpell1
        SaveSetting "FM Global\Horizon", "Spelling", "AutoCorrect", .AutoCorrect
        SaveSetting "FM Global\Horizon", "Spelling", "CaseSensitive", .CaseSensitive
        SaveSetting "FM Global\Horizon", "Spelling", "CatchDoubledWords", .CatchDoubledWords
        SaveSetting "FM Global\Horizon", "Spelling", "IgnoreAllCapsWords", .IgnoreAllCapsWords
        SaveSetting "FM Global\Horizon", "Spelling", "IgnoreCapitalizedWords", .IgnoreCapitalizedWords
        SaveSetting "FM Global\Horizon", "Spelling", "IgnoreDomainNames", .IgnoreDomainNames
        SaveSetting "FM Global\Horizon", "Spelling", "IgnoreMixedCaseWords", .IgnoreMixedCaseWords
        SaveSetting "FM Global\Horizon", "Spelling", "IgnoreWordsWithDigits", .IgnoreWordsWithDigits
        SaveSetting "FM Global\Horizon", "Spelling", "PhoneticSuggestions", .PhoneticSuggestions
        SaveSetting "FM Global\Horizon", "Spelling", "TypographicalSuggestions", .TypographicalSuggestions
        SaveSetting "FM Global\Horizon", "Spelling", "SuggestSplitWords", .SuggestSplitWords
    End With

    blnSuccess = True

Exit_SaveWspellSettings:

    On Error Resume Next
    
    Exit Sub

Err_SaveWspellSettings:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::SaveWspellSettings"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "SaveWspellSettings", strErrSource, True
    
    Resume Exit_SaveWspellSettings

End Sub

Private Sub GetWspellSettings()
    'get user settings
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_GetWspellSettings
    blnSuccess = False


    With WSpell1
        .AutoCorrect = GetSetting("FM Global\Horizon", "Spelling", "AutoCorrect", True)
        .CaseSensitive = GetSetting("FM Global\Horizon", "Spelling", "CaseSensitive", True)
        .CatchDoubledWords = GetSetting("FM Global\Horizon", "Spelling", "CatchDoubledWords", True)
        .IgnoreAllCapsWords = GetSetting("FM Global\Horizon", "Spelling", "IgnoreAllCapsWords", True)
        .IgnoreCapitalizedWords = GetSetting("FM Global\Horizon", "Spelling", "IgnoreCapitalizedWords", True) 'QC2138
        .IgnoreDomainNames = GetSetting("FM Global\Horizon", "Spelling", "IgnoreDomainNames", True)
        .IgnoreMixedCaseWords = GetSetting("FM Global\Horizon", "Spelling", "IgnoreMixedCaseWords", False)
        .IgnoreWordsWithDigits = GetSetting("FM Global\Horizon", "Spelling", "IgnoreWordsWithDigits", True)
        .PhoneticSuggestions = GetSetting("FM Global\Horizon", "Spelling", "PhoneticSuggestions", False)
        .TypographicalSuggestions = GetSetting("FM Global\Horizon", "Spelling", "TypographicalSuggestions", True)
        .SuggestSplitWords = GetSetting("FM Global\Horizon", "Spelling", "SuggestSplitWords", True)
    End With


    blnSuccess = True

Exit_GetWspellSettings:

    On Error Resume Next
    
    Exit Sub

Err_GetWspellSettings:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "fmgRichText::GetWspellSettings"

    hznErrHandler lngErrNum, strErrDesc, "fmgRichText", "GetWspellSettings", strErrSource, True
    
    Resume Exit_GetWspellSettings

End Sub

