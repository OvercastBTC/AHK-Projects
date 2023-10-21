Attribute VB_Name = "hznErrModule"
'*******************************************************************************
' Module:   hznErrModule
' FILENAME: hznErrModule.bas
' DESCRIPTION:
'   Generic Horizon Error Handler
'       By default, will log to NT app event log or Win-9x vbevents.log file
'       Calls Bryan's generic error handler, fmgErrorHandler.dll
'         This must by registered on your PC and
'         checked off in project/references
'       Sample code to cause a Horizon specific error:
'           If condition Then
'               err.raise vbObjectError + 5,,"[W]DIVIDE_BY_ZERO"
'           End If
'         This will cause your procedure's error handler to be called
'         DIVIDE_BY_ZERO is key to error code table
'         [W] warning, [I] info, [S] Severe icon
'       See Developer's Reference Appendix A for vb runtime error sample
'
' MODIFICATION HISTORY:
' 1.0   20-Mar-2001 Larry Meister   Initial Version
' 31-Dec-2002 - MAR - added g_GetNumericFix and g_SetNumericFix functions
'*******************************************************************************
Option Explicit
Const C_MODULE_NAME As String = "hznErrModule"

Private m_rsUOMTable As Object
'*******************************************************************************
' FormatFileName (PUBLIC FUNCTION)
'
' DESCRIPTION:
' Replaces special chars with and underscore. This function copied here from hznOMinterface.clsOrderManagement
'
' PARAMETERS:
' (In/Out) - av_strType - String - The string that needs to be converted.
'
' RETURN VALUE:
' String - Converted string with special char replaced by underscore.
' change 10/14/2005  wsf  set and edit against the valid characters A-Z, a-z, 0-9
'*******************************************************************************
Public Function FormatFileName(ByVal av_strFilename As String) As String

    
    Dim strTemp As String
    Dim int_idx As Integer
    Dim strValidCharacters As String

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_FormatFileName
    blnSuccess = False


   
'NOTE : This function exists in HZNEmailUtilities.clsEmailUtilities so make changes
'there if you change this in the future.
    strValidCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" & _
                         "abcdefghijklmnopqrstuvwxyz" & _
                         "0123456789"
                         
    strTemp = Trim(av_strFilename)
    For int_idx = 1 To Len(strTemp)
       If 0 = InStr(strValidCharacters, Mid(strTemp, int_idx, 1)) Then
            Mid(strTemp, int_idx, 1) = "_"
       End If
    Next int_idx
   
    
    FormatFileName = strTemp

    blnSuccess = True

Exit_FormatFileName:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_FormatFileName:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "hznErrModule::FormatFileName"
    
    hznErrHandler lngErrNum, strErrDesc, "hznErrModule", "FormatFileName", strErrSource, False
    
    Resume Exit_FormatFileName

End Function

'*******************************************************************************
' hznErrHandler (SUB)
' DESCRIPTION:
'   Generic Horizon Error Handler
'
' PARAMETERS:
'   (In) - lngErrNumber        - Long    -
'   (In) - strErrDesc   - String  -
'   (In) - strErrModule        - String  -
'   (In) - strErrProcedure     - String  -
'   (In) - strErrPath          - String  - Module/Procedure down to first object
'                                              that caused error
'   (In) - blnDisplayMessage   - Boolean - False(Default) don't display error msg
'   (In) - blnRecordInEventLog - Boolean - True(Default) log to event log
'*******************************************************************************
Sub hznErrHandler( _
        ByVal lngErrNumber As Long, _
        ByVal strErrDesc As String, _
        ByVal strErrModule As String, _
        ByVal strErrProcedure As String, _
        ByVal strErrPath As String, _
        Optional ByVal blnDisplayMessage As Boolean = False, _
        Optional ByVal blnRecordInEventLog As Boolean = True)

    Dim fmgErrObject As fmgErrorHandler.clsErrorHandler
    
    Set fmgErrObject = CreateObject("fmgErrorHandler.clsErrorHandler")
    fmgErrObject.RecordInEventLog = blnRecordInEventLog
    fmgErrObject.DisplayMessage = blnDisplayMessage
    fmgErrObject.HandleError lngErrNumber, strErrDesc, strErrModule, strErrProcedure, strErrPath
    
    Set fmgErrObject = Nothing
    
    If blnDisplayMessage Then
        Set_Hourglass False
    End If

End Sub

'returns true if hourglass on, false if it is off
Public Function Get_Hourglass() As Boolean
    
    If Screen.MousePointer = vbHourglass Then
        Get_Hourglass = True
    Else
        Get_Hourglass = False
    End If
    
End Function

'send True to turn on hourglass, false turns it off
Public Sub Set_Hourglass(ByVal av_blnOn As Boolean)

    If av_blnOn Then
        Screen.MousePointer = vbHourglass
    Else
        Screen.MousePointer = vbDefault
    End If
    
End Sub

Public Function FormatErrorSource(ByVal av_strErrorSource As String, _
                                    ByVal av_strModuleName As String, _
                                    ByVal av_strProcedureName As String) As String

'===================================================================
' Purpose: Format Error Message.
' Arguments: av_strErrorSource      - Source of Error, i.e. Err.Source
'            av_strModuleName       - Name of a Module or Class
'            av_strProcedureName    - Name of Sub or Function where error occurs
' Returns: concatenation of all three strings

' Author: Rich Cheng
' Date: 7/19/2001
'
' Modification Log:
'-------------------------------------------------------------------

    Dim lngErrNum      As Long
    Dim strErrSource      As String
    Dim strErrDesc As String
    
    Const C_PROCEDURE_NAME As String = "FormatErrorSource"
    
    On Error GoTo ERROR_HANDLER
    FormatErrorSource = av_strErrorSource & vbCrLf & av_strModuleName & "::" & av_strProcedureName
    
EXIT_PROCEDURE:
    On Error Resume Next

    If lngErrNum <> 0 Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    Exit Function
ERROR_HANDLER:
    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & C_MODULE_NAME & "::" & C_PROCEDURE_NAME
    Resume EXIT_PROCEDURE
End Function


'*******************************************************************************
' g_SetNumericFix (PUBLIC FUNCTION)
'
' DESCRIPTION:
' Converts a string numeric value from international settings to US format
'
' UPDATE HISTORY:
'   03-March-03     Irene Bellettiere       change error handler to EH1
'*******************************************************************************
Public Function g_SetNumericFix(ByVal av_strValue As String) As String

    Dim strValue As String
    Dim strLeftSide As String
    Dim strRightSide As String
    Dim intPosition As Integer

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_g_SetNumericFix
    blnSuccess = False


    


    strValue = Trim(av_strValue)
    
    'check if value contains a comma
    intPosition = InStr(strValue, ",")
    If intPosition <> 0 Then
    
        'parse sides and check if both are numeric
        strLeftSide = Left(strValue, intPosition - 1)
        strRightSide = Right(strValue, Len(strValue) - intPosition)
        
        If IsNumeric(strLeftSide) And IsNumeric(strRightSide) Then
        
            'replace period as decimal separator
            g_SetNumericFix = strLeftSide & "." & strRightSide
        
        Else
            'not a numeric value, return original
            g_SetNumericFix = strValue
        
        End If
    Else
        'comma character not present, return original
        g_SetNumericFix = strValue

    End If


    blnSuccess = True

Exit_g_SetNumericFix:

    On Error Resume Next

    ' Place All Set Object = Nothing Here...
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_g_SetNumericFix:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "hznErrModule::g_SetNumericFix"
    
    hznErrHandler lngErrNum, strErrDesc, "hznErrModule", "g_SetNumericFix", strErrSource, False
    
    Resume Exit_g_SetNumericFix

End Function

'*******************************************************************************
' g_GetNumericFix (PUBLIC FUNCTION)
'
' DESCRIPTION:
' Converts a string numeric value from US format to proper international settings
'
' UPDATE HISTORY:
'   03-March-03         Irene Bellettiere   change error handler to EH1
'   04-March-04         Irene Bellettiere   truncate number of decimals to 9 when translate
'*******************************************************************************
Public Function g_GetNumericFix(ByVal av_strValue As String) As String
    
    Dim strValue As String
    Dim strLeftSide As String
    Dim strRightSide As String
    Dim strSignChar As String
    Dim intPosition As Integer
    Dim intCounter As Integer
    Dim lngMultiplier As Long

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_g_GetNumericFix
    blnSuccess = False


    


    strValue = Trim(av_strValue)
    
    'check if value contains a period
    intPosition = InStr(strValue, ".")
    
    If intPosition <> 0 Then
    
        'parse sides and check if both are numeric
        strLeftSide = Left(strValue, intPosition - 1)
        strRightSide = Right(strValue, Len(strValue) - intPosition)
        
        If IsNumeric(strLeftSide) And IsNumeric(strRightSide) Then
            
            'IB 04-Mar-03 allow only 9 decimals:
            If Len(strRightSide) > 9 Then
                strRightSide = Left(strRightSide, 9)
            End If
            
            lngMultiplier = 1
            For intCounter = 1 To Len(strRightSide)
                lngMultiplier = lngMultiplier * 10
            Next
        
            'rebuild the number using the system decimal separator
            g_GetNumericFix = CStr(Abs(CDbl(strLeftSide)) + CDbl(strRightSide / lngMultiplier))
        
            'put back the sign character if exists
            strSignChar = Left(strLeftSide, 1)
            If strSignChar = "+" Or strSignChar = "-" Then
                g_GetNumericFix = strSignChar & g_GetNumericFix
            End If
        
        Else
            'not a numeric value, return original
            g_GetNumericFix = strValue
        
        End If
    Else
        'comma character not present, return original
        g_GetNumericFix = strValue

    End If



    blnSuccess = True

Exit_g_GetNumericFix:

    On Error Resume Next

    ' Place All Set Object = Nothing Here...
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_g_GetNumericFix:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "hznErrModule::g_GetNumericFix"
    
    hznErrHandler lngErrNum, strErrDesc, "hznErrModule", "g_GetNumericFix", strErrSource, False
    
    Resume Exit_g_GetNumericFix

End Function

'*******************************************************************************
' Val (PUBLIC FUNCTION)
'
' DESCRIPTION:
' Overrides the VB Val function but supports the international numeric format
'
' UPDATE HISTORY:
'   03-Mar-03       Irene Bellettiere       change error handler to EH1
'*******************************************************************************
Public Function Val(av_strValue As Variant) As Variant

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_Val
    blnSuccess = False

     'convert to double if numeric
    If IsNumeric(Trim(CStr(av_strValue))) Then
        Val = CDbl(av_strValue)
    Else
        Val = 0
    End If


    blnSuccess = True

Exit_Val:

    On Error Resume Next
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_Val:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "hznErrModule::Val"
    
    hznErrHandler lngErrNum, strErrDesc, "hznErrModule", "Val", strErrSource, False
    
    Resume Exit_Val

End Function




'*******************************************************************************
' g_getUnitsOfMeasure (PUBLIC FUNCTION)
'
' DESCRIPTION:
' Reads user preferences for units of measure.
'
' PARAMETERS:
' None
'
' RETURN VALUE:
' String -
'*******************************************************************************
Public Function GetUnitsOfMeasure() As String

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    
    Dim blnSuccess As Boolean
    On Error GoTo Err_GetUnitsOfMeasure
    blnSuccess = False

    GetUnitsOfMeasure = GetSetting("FM Global\Horizon", "User Preferences", _
         "Units of Measure", "English")

    ' Insert Procedure Code Here...

    blnSuccess = True

Exit_GetUnitsOfMeasure:

    On Error Resume Next
    
    ' Place All Set Object = Nothing Here...
    
    Exit Function

Err_GetUnitsOfMeasure:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "hznErrModule::GetUnitsOfMeasure"

    hznErrHandler lngErrNum, strErrDesc, "hznErrModule", "GetUnitsOfMeasure", strErrSource, True
    
    Resume Exit_GetUnitsOfMeasure

End Function


'*******************************************************************************
' ConvertUnitsOfMeasure (PUBLIC SUB)
'
'DESCRIPTION:
' ***Description goes here***
'
'PARAMETERS:
' (In)     - av_dblValue   - Double -
' (In)     - av_strLabel   - String -
' (In/Out) - ar_dblToValue - Double -
' (In/Out) - ar_strToLabel - String -
'
' UPDATE HISTORY:
'   06-May-05           Irene Bellettiere       use g_getNumericFix to get correct decimals per regional settings
'*******************************************************************************
Public Sub g_ConvertUnitsOfMeasure(ByRef ar_strToLabel As String, ByRef ar_dblToValue As Double, Optional av_strMetricOverride As Boolean = False)

    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    

    Dim blnSuccess As Boolean
    On Error GoTo Err_ConvertUnitOfMeasure

    blnSuccess = False

    If Trim(ar_strToLabel) = "" Then
        Exit Sub
    End If

    If av_strMetricOverride = False Then
        If LCase(GetUnitsOfMeasure) = "english" Then
            Exit Sub
        End If
    End If
    
    
    If m_rsUOMTable Is Nothing Then
        Set m_rsUOMTable = GetCodeValues("UNITS_OF_MEASURE", 3)
    End If
    If Not m_rsUOMTable.BOF Then
        m_rsUOMTable.MoveFirst
    End If
    
    
    
    m_rsUOMTable.Find (UCase("CD1") & " ='" & UCase(ar_strToLabel) & "'")
    If m_rsUOMTable.EOF Then
        m_rsUOMTable.MoveFirst
        m_rsUOMTable.Find (UCase("CD2") & " ='" & UCase(ar_strToLabel) & "'")
        If m_rsUOMTable.EOF Then
            'REturn bad values
            ar_strToLabel = "Unknown"
            ar_dblToValue = 0
        Else
            'changed to cd1 because it needs to return opposite of cd2.
            ar_strToLabel = m_rsUOMTable.Fields("CD1").Value & ""
            ar_dblToValue = ar_dblToValue / g_GetNumericFix(m_rsUOMTable.Fields("CD3").Value) 'IB 06-May-05
        End If
    Else
            ar_strToLabel = m_rsUOMTable.Fields("CD2").Value & ""
            ar_dblToValue = ar_dblToValue * g_GetNumericFix(m_rsUOMTable.Fields("CD3").Value) 'IB 06-May-05
    End If


   blnSuccess = True

Exit_ConvertUnitOfMeasure:

    On Error Resume Next
    

  '   Place All Set Object = Nothing Here...
    
    Exit Sub

Err_ConvertUnitOfMeasure:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "hznErrModule::ConvertUnitOfMeasure"

    hznErrHandler lngErrNum, strErrDesc, "hznErrModule", "ConvertUnitOfMeasure", strErrSource, True
    
    Resume Exit_ConvertUnitOfMeasure

End Sub
            


'*******************************************************************************
' g_GetCodeValues (PUBLIC FUNCTION)
'
'DESCRIPTION:
' ***Description goes here***
'
'PARAMETERS:
' (In) - av_strTableName - String        -
' (In) - av_strTableName - av_intColumns -
'
' 09-Dec-2002 - MW: Added av_intColumns 9 - 26
'                   to support new fields on code_table_values
'
' RETURN VALUE:
' ADODB.Recordset -
'*******************************************************************************
Private Function GetCodeValues( _
    ByVal av_strTableName As String, _
    Optional ByVal av_intColumns = 2) As Object

    Dim objCodeRetriever As Object
 
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long

    Dim blnSuccess As Boolean
    On Error GoTo Err_GetCodeValues
    blnSuccess = False

   Set objCodeRetriever = CreateObject("fmgCodeValueRetriever.clsRetriever")
      
    With objCodeRetriever
        .Connect
        .TableName = av_strTableName
        .SelectCodes False, True, True, (av_intColumns > 2), _
                                        (av_intColumns > 3), _
                                        (av_intColumns > 4), _
                                        (av_intColumns > 5), _
                                        (av_intColumns > 6), _
                                        (av_intColumns > 7), _
                                        (av_intColumns > 8), _
                                        (av_intColumns > 9), _
                                        (av_intColumns > 10), _
                                        (av_intColumns > 11), _
                                        (av_intColumns > 12), _
                                        (av_intColumns > 13), _
                                        (av_intColumns > 14), _
                                        (av_intColumns > 15), _
                                        (av_intColumns > 16), _
                                        (av_intColumns > 17), _
                                        (av_intColumns > 18), _
                                        (av_intColumns > 19), _
                                        (av_intColumns > 20), _
                                        (av_intColumns > 21), _
                                        (av_intColumns > 22), _
                                        (av_intColumns > 23), _
                                        (av_intColumns > 24), _
                                        (av_intColumns > 25), _
                                        (av_intColumns > 26)
        Set GetCodeValues = .Execute
    End With

   blnSuccess = True

Exit_GetCodeValues:

   On Error Resume Next

   '  Place All Set Object = Nothing Here...
    Set objCodeRetriever = Nothing
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If

    Exit Function

Err_GetCodeValues:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "hznErrModule::GetCodeValues"
    
    hznErrHandler lngErrNum, strErrDesc, "hznErrModule", "GetCodeValues", strErrSource, False
    
    Resume Exit_GetCodeValues

End Function


