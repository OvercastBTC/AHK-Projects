#SingleInstance, Force
#NoEnv
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Requires AutoHotkey v1

#Include <MDMF>

return

^!s::
DPI_AWARENESS_CONTEXT := DllCall("User32.dll\GetThreadDpiAwarenessContext", "ptr")
DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
All_Monitors := MDMF_Enum()

for k, v in All_Monitors
	All_Monitors[k].DPI := GetDpiForMonitor(k)

array_to_console(3, All_Monitors)
DllCall("SetThreadDpiAwarenessContext", "ptr", DPI_AWARENESS_CONTEXT, "ptr")
return

^!d::
DPI_AWARENESS_CONTEXT := DllCall("User32.dll\GetThreadDpiAwarenessContext", "ptr")
DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
Found_Monitor := MDMF_FromHWND(Winexist("A"))
array_to_console(3, GetDpiForMonitor(Found_Monitor))
DllCall("SetThreadDpiAwarenessContext", "ptr", DPI_AWARENESS_CONTEXT, "ptr")
return


GetDpiForMonitor(hMonitor, Type := 0) 
{
	/*	DESCRIPCIÓN / DESCRIPTION
    Recupera los puntos por pulgada (ppp) del monitor especificado.
    Parámetros:
        Type:
            El tipo de DPI que se consulta. Los valores posibles son los siguientes. Este parámetro se ignora en WIN_8 o anterior.
            0 (MDT_EFFECTIVE_DPI)	= El DPI efectivo. Este valor se debe usar al determinar el factor de escala correcto para escalar elementos UI. Esto incorpora el factor de escala establecido por el usuario para esta pantalla específica.
            1 (MDT_ANGULAR_DPI)	= El DPI angular. Este DPI garantiza la reproducción con una resolución angular compatible en la pantalla. Esto no incluye el factor de escala establecido por el usuario para esta pantalla específica.
            2 (MDT_RAW_DPI)       	= El DPI sin procesar. Este valor es el DPI lineal de la pantalla medido en la pantalla. Use este valor cuando quiera leer la densidad de píxeles y no la configuración de escalamiento recomendada.
		                                         		Esto no incluye el factor de escala establecido por el usuario para esta pantalla específica y no se garantiza que sea un valor PPP admitido.
    Return:
        Si tuvo éxito devuelve un objeto con las claves X e Y, o cero en caso contrario.
    Observaciones:
        Esta función no es DPI Aware y no debe utilizarse si el thread de llamada es compatible con DPI por monitor. Para la versión de esta función que tiene en cuenta el DPI, consulte GetDpiForWindow.
    Ejemplo:
        MsgBox(GetDpiForMonitor(MonitorFromWindow()).X)
	Retrieve the dots per inch (dpi) of the specified monitor.
    Parameters:
        Type:
            The type of DPI that is consulted. Possible values ??are as follows. This parameter is ignored in WIN_8 or earlier.
            0 (MDT_EFFECTIVE_DPI)	= The effective DPI. This value should be used when determining the correct scale factor to scale UI elements. This incorporates the scale factor set by the user for this specific screen.
            1 (MDT_ANGULAR_DPI)	= The angular DPI. This DPI guarantees playback with a compatible angular resolution on the screen. This does not include the scale factor set by the user for this specific screen.
            2 (MDT_RAW_DPI) 			= The raw DPI. This value is the linear DPI of the screen measured on the screen. Use this value when you want to read the pixel density and not the recommended scaling settings.
														This does not include the scale factor set by the user for this specific screen and is not guaranteed to be a supported PPP value.
    Return:
        If successful it returns an object with the keys X and Y, or zero otherwise.
    Observations:
        This function is not DPI Aware and should not be used if the call thread is compatible with DPI per monitor. For the version of this function that takes into account the DPI, see GetDpiForWindow.
    Example:
        MsgBox(GetDpiForMonitor(MonitorFromWindow()).X)
	*/

    local osv := StrSplit(A_OSVersion, ".")    ; https://docs.microsoft.com/en-us/windows-hardware/drivers/ddi/content/wdm/ns-wdm-_osversioninfoexw
    if (osv[1] < 6 || (osv[1] == 6 && osv[2] < 3))    ; WIN_8-
    {
        local hDC := 0, info := GetMonitorInfo(hMonitor)
        if (!info || !(hDC := DllCall("Gdi32.dll\CreateDC", "Str", info.name, "Ptr", 0, "Ptr", 0, "Ptr", 0, "Ptr")))
            return FALSE    ; LOGPIXELSX = 88 | LOGPIXELSY = 90
        return {X:DllCall("Gdi32.dll\GetDeviceCaps", "Ptr", hDC, "Int", 88), Y:DllCall("Gdi32.dll\GetDeviceCaps", "Ptr", hDC, "Int", 90)+0*DllCall("Gdi32.dll\DeleteDC", "Ptr", hDC)}
    }
    ; GetDpiForMonitor function
    ; https://docs.microsoft.com/en-us/windows/desktop/api/shellscalingapi/nf-shellscalingapi-getdpiformonitor
    local dpiX := 0, dpiY := 0
    return DllCall("Shcore.dll\GetDpiForMonitor", "Ptr", hMonitor, "Int", Type, "UIntP", dpiX, "UIntP", dpiY, "UInt") ? 0 : {X:dpiX,Y:dpiY}
}

GetMonitorInfo(hMonitor) {

	/*	DESCRIPCIÓN / DESCRIPTION
    Recupera información del monitor especificado.
    Return:
        Devuelve un objeto con las siguientes claves.
        L / T / R / B       = Rectángulo del monitor, expresado en coordenadas de pantalla virtual. Tenga en cuenta que si el monitor no es el principal, algunas de las coordenadas pueden ser negativas.
        WL / W T / W R / WB = Rectángulo del área de trabajo del monitor.  //
        Flags               = Un conjunto de valores que representan atributos del monitor de visualización.
            1 (MONITORINFOF_PRIMARY) = Este es el monitor de visualización principal.
        Name                = Una cadena que especifica el nombre del dispositivo del monitor que se está utilizando.
    Ejemplo:
        MsgBox(GetMonitorInfo(MonitorFromWindow()).Name)
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Retrieve information from the specified monitor.
     Return:
         Returns an object with the following keys.
         L / T / R / B = Monitor rectangle, expressed in virtual screen coordinates. Note that if the monitor is not the main one, some of the coordinates may be negative.
         WL / W T / W R / WB = Rectangle of the work area of the monitor. //
         Flags = A set of values that represent attributes of the display monitor.
             1 (MONITORINFOF_PRIMARY) = This is the main display monitor.
         Name = A string that specifies the name of the monitor device being used.
	*/

    ; GetMonitorInfo function
    ; https://docs.microsoft.com/es-es/windows/desktop/api/winuser/nf-winuser-getmonitorinfoa
    local MONITORINFOEX := ""
    VarSetCapacity(MONITORINFOEX, 104)
    NumPut(104, &MONITORINFOEX, "UInt")
    if (!DllCall("User32.dll\GetMonitorInfoW", "Ptr", hMonitor, "UPtr", &MONITORINFOEX))
        return FALSE
    return {      L:        NumGet(&MONITORINFOEX+ 4	, "Int")
		    	, T:        NumGet(&MONITORINFOEX+ 8	, "Int")
		    	, R:        NumGet(&MONITORINFOEX+12	, "Int")
		    	, B:        NumGet(&MONITORINFOEX+16	, "Int")
		    	, WL:       NumGet(&MONITORINFOEX+20	, "Int")
		    	, WT:       NumGet(&MONITORINFOEX+24	, "Int")
		    	, WR:       NumGet(&MONITORINFOEX+28	, "Int")
				, WB:       NumGet(&MONITORINFOEX+32	, "Int")
		    	, Flags:    NumGet(&MONITORINFOEX+36	, "UInt")
		    	, Name:     StrGet(&MONITORINFOEX+40,64	, "UTF-16")}
}

Array_to_Console(Mode,x*)
{ ; sends an array of depth at least 5 to the console
	for a, b in x
		text .= (IsObject(b)?Build_Array(b):b) "`n"

	if Mode = 1												; write to console
		fileappend, % text, *
	if Mode = 2												; show in tooltip
		tooltip, % text
	if Mode = 3												; show in msgbox
		msgbox, % text
	
	if Mode = 4												; allow us to writelog it
		return "`n" text
}

Build_Array(array, depth=5, indentLevel:="   ") 
{ ; builds the array to send to console
	try {
		for k,v in Array {
			lst.= indentLevel "[" k "]"
			if (IsObject(v) && depth>1)
				lst.="`n" Build_Array(v, depth-1, indentLevel . "    ")
			else
				lst.=" -> " v
			lst.="`n"
		} return rtrim(lst, "`r`n `t")	
	} return
}
