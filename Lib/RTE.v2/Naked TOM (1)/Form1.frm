VERSION 5.00
Begin VB.Form Form1 
   AutoRedraw      =   -1  'True
   Caption         =   "Form1"
   ClientHeight    =   4635
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   6150
   BeginProperty Font 
      Name            =   "Segoe UI"
      Size            =   9
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   4635
   ScaleWidth      =   6150
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text1 
      Height          =   1515
      Left            =   120
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Top             =   180
      Width           =   2475
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Function TomProp(ByVal Value As Long) As String
    'Note that tomUndefined often means "mixed" within the range
    'under examination.
    If Value = tomUndefined Then
        TomProp = "Undefined"
    Else
        TomProp = CStr(Value)
    End If
End Function

Private Function TomPropB(ByVal Value As Long) As String
    If Value = tomUndefined Then
        TomPropB = "Undefined"
    Else
        TomPropB = CStr(CBool(Value))
    End If
End Function

Private Function TomPropC(ByVal Value As Long) As String
    If Value = tomUndefined Then
        TomPropC = "Undefined"
    ElseIf Value = tomAutoColor Then
        'The default system foreground color.
        TomPropC = "Autocolor"
    Else
        TomPropC = Right$("0000000" & Hex$(Value), 8)
    End If
End Function

Private Sub ReportPara(ByVal ITextPara As tom.ITextPara)
    Text1.SelText = vbTab & "Para:" & vbNewLine
    With ITextPara
        'From MSDN:
        '
        'ITextPara::GetStyle
        '
        'The Text Object Model (TOM) version 1.0 has no way to specify the meanings
        'of user-defined style handles. They depend on other facilities of the text
        'system implementing TOM. Negative style handles are reserved for built-in
        'character and paragraph styles.
        Text1.SelText = vbTab & vbTab & ".Style = " & CStr(.Style) & vbNewLine
        'We'll just report it even though it is relatively useless to us.
        
        Text1.SelText = vbTab & vbTab & ".LineSpacingRule = " & CStr(.LineSpacingRule) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".LineSpacing = " & CStr(.LineSpacing) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".SpaceAfter = " & CStr(.SpaceAfter) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".SpaceBefore = " & CStr(.SpaceBefore) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".Alignment = " & CStr(.Alignment) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".FirstLineIndent = " & CStr(.FirstLineIndent) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".LeftIndent = " & CStr(.LeftIndent) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".RightIndent = " & CStr(.RightIndent) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".ListLevelIndex = " & CStr(.ListLevelIndex) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".ListType = " & CStr(.ListType) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".ListTab = " & CStr(.ListTab) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".ListStart = " & CStr(.ListStart) & vbNewLine
    End With
End Sub

Private Sub ReportFont(ByVal FontNumber As Long, ByVal ITextFont As tom.ITextFont)
    Text1.SelText = vbTab & "Font" & CStr(FontNumber) & ":" & vbNewLine
    With ITextFont
        'From MSDN:
        '
        'ITextFont::GetStyle
        '
        'The Text Object Model (TOM) version 1.0 does not specify the meanings of the
        'style handles. The meanings depend on other facilities of the text system
        'that implements TOM.
        Text1.SelText = vbTab & vbTab & ".Style = " & CStr(.Style) & vbNewLine
        'We'll just report it even though it is relatively useless to us.
        
        Text1.SelText = vbTab & vbTab & ".Name = " & CStr(.Name) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".Size = " & TomProp(.Size) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".Bold = " & TomPropB(.Bold) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".Italic = " & TomPropB(.Italic) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".Underline = " & TomPropB(.Underline) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".Weight = " & TomProp(.Weight) & vbNewLine
        Text1.SelText = vbTab & vbTab & ".ForeColor = " & TomPropC(.ForeColor) & vbNewLine
    End With
End Sub

Private Sub ReportFonts(ByVal ITextRange As tom.ITextRange)
    Dim EndPara As Long
    Dim FontNumber As Long
    Dim Moves As Long
    
    With ITextRange
        EndPara = .End
        .Collapse tomStart
        Do
            .MoveEnd tomCharFormat, 1
            FontNumber = FontNumber + 1
            ReportFont FontNumber, .Font
            Moves = .MoveStart(tomCharFormat, 1)
        Loop Until .Start > EndPara Or Moves = 0 'End of Para or end of Doc.
    End With
End Sub

Private Sub Form_Load()
    Const USE_DEFAULT_CP As Long = 0
    Dim ParaNumber As Long
    
    With New NakedRichEdit
        With .TextDocument
            .Open "Document.rtf", tomRTF Or tomReadOnly, USE_DEFAULT_CP
            With .Range(0, 0)
                Do
                    .MoveEnd tomParagraph, 1
                    ParaNumber = ParaNumber + 1
                    Text1.SelText = "Paragraph " & CStr(ParaNumber) & ":" & vbNewLine
                    Text1.SelText = "Text = " & Replace$(.Text, vbCr, "¶") & vbNewLine
                    ReportPara .Para
                    ReportFonts .Duplicate
                    Text1.SelText = vbNewLine
                Loop Until .MoveStart(tomParagraph, 1) = 0
            End With
        End With
    End With
End Sub

Private Sub Form_Resize()
    If WindowState <> vbMinimized Then
        Text1.Move 0, 0, ScaleWidth, ScaleHeight
    End If
End Sub
