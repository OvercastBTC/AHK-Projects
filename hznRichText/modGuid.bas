Attribute VB_Name = "modGuid"
Private Type GUID
    lngData1 As Long
    intData2 As Integer
    intData3 As Integer
    bytData4(7) As Byte
End Type

Private Declare Function CoCreateGuid Lib "ole32.dll" (pGUID As GUID) As Long

'**********************************************************************************'
' Description: Creates and Formats a Guid to be used as a unique identifier in the
' Attachment Manager project.
' Comments:
' Author: Joe Napoli
' Date: 02/22/2001
'**********************************************************************************'

Public Function CreateGUID() As String

    Dim udtGUID As GUID
    Dim strErrDesc As String
    Dim strErrSource As String
    Dim lngErrNum As Long
    Dim blnSuccess As Boolean

    On Error GoTo Err_CreateGUID

    blnSuccess = False

    'Generating guid via api CoCreateGuid
    
    If (CoCreateGuid(udtGUID) = 0) Then
    
        CreateGUID = "{" & _
        String(8 - Len(Hex$(udtGUID.lngData1)), "0") & _
            Hex$(udtGUID.lngData1) & "-" & _
        String(4 - Len(Hex$(udtGUID.intData2)), "0") & _
            Hex$(udtGUID.intData2) & "-" & _
        String(4 - Len(Hex$(udtGUID.intData3)), "0") & _
            Hex$(udtGUID.intData3) & "-" & _
        IIf((udtGUID.bytData4(0) < &H10), "0", "") & _
            Hex$(udtGUID.bytData4(0)) & _
        IIf((udtGUID.bytData4(1) < &H10), "0", "") & _
            Hex$(udtGUID.bytData4(1)) & "-" & _
        IIf((udtGUID.bytData4(2) < &H10), "0", "") & _
            Hex$(udtGUID.bytData4(2)) & _
        IIf((udtGUID.bytData4(3) < &H10), "0", "") & _
            Hex$(udtGUID.bytData4(3)) & _
        IIf((udtGUID.bytData4(4) < &H10), "0", "") & _
            Hex$(udtGUID.bytData4(4)) & _
        IIf((udtGUID.bytData4(5) < &H10), "0", "") & _
            Hex$(udtGUID.bytData4(5)) & _
        IIf((udtGUID.bytData4(6) < &H10), "0", "") & _
            Hex$(udtGUID.bytData4(6)) & _
        IIf((udtGUID.bytData4(7) < &H10), "0", "") & _
            Hex$(udtGUID.bytData4(7)) & "}"
    End If


    blnSuccess = True

Exit_CreateGUID:

    On Error Resume Next

    ' Place All Set Object = Nothing Here...
    
    If Not blnSuccess Then
        On Error GoTo 0
        Err.Raise lngErrNum, strErrSource, strErrDesc
    End If
    
    Exit Function

Err_CreateGUID:

    lngErrNum = Err.Number
    strErrDesc = Err.Description
    strErrSource = Err.Source & vbCrLf & "modGuid::CreateGUID"
    
    hznErrHandler lngErrNum, strErrDesc, "modGuid", "CreateGUID", strErrSource, False
    
    Resume Exit_CreateGUID

End Function

