Attribute VB_Name = "modDownload"
Option Compare Database
Option Explicit

'-------------------------------------------------------------------------------
' modDownload
'-------------------------------------------------------------------------------
' Baixa um arquivo da internet.
'-------------------------------------------------------------------------------
' Ref.:
'   https://officeaccelerators.wordpress.com/2013/11/26/vba-code-to-download-files-from-internet/
'-------------------------------------------------------------------------------

'************************
'Using URLDownloadToFile
'************************

Public Declare Function URLDownloadToFile Lib "urlmon" _
    Alias "URLDownloadToFileA" (ByVal pCaller As Long, _
    ByVal szURL As String, ByVal szFileName As String, _
    ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long

Public Function DownloadFile(Url As String, SaveTo As String) As Boolean
    DownloadFile = URLDownloadToFile(0, Url, SaveTo, 0, 0) = 0
End Function

'************************
'Using WinHttpRequest
'************************

Public Function DownloadFileWHttp(Url As String, SaveTo As String) As Boolean

    Dim Whttp As Object
    Dim stm As Object
    
    DownloadFileWHttp = False
    
    On Error GoTo EndAll
    
    Set Whttp = CreateObject("WinHTTP.WinHTTPrequest.5.1")
    Set stm = CreateObject("ADODB.Stream")
    
    Whttp.Open "GET", Url, False
    Whttp.send
    
    With stm
        .Type = 1
        .Open
        .Write Whttp.responsebody
        .SaveToFile SaveTo, 2
        DownloadFileWHttp = True
    End With
    
    Set Whttp = Nothing
    Set stm = Nothing
    Exit Function
    
EndAll:
    Set Whttp = Nothing
    Set stm = Nothing

End Function

'************************
'Via Firefox
'************************
' REf.:
'   https://social.msdn.microsoft.com/Forums/en-US/8099c4f9-4383-4c63-a96f-f5d5aa8c8e19/vba-to-download-a-file-without-a-direct-url?forum=isvvba
'************************

''
' Sets the download folder with Firefox
''
Public Sub Download_File_Firefox()
  Dim driver As New FirefoxDriver, file As String
  
  'Set the preferences specific to Firefox
  driver.SetPreference "browser.download.folderList", 2
  driver.SetPreference "browser.download.dir", ThisWorkbook.Path
  driver.SetPreference "browser.helperApps.neverAsk.saveToDisk", "application/pdf"
  driver.SetPreference "pdfjs.disabled", True
  
  ' Init the file waiter
  WaitNewFile ThisWorkbook.Path & "\*.pdf"
  
  ' Open the file for download
  driver.Get "https://www.mozilla.org/en-US/foundation/documents"
  driver.FindElementByLinkText("IRS Form 872-C").Click
  
  ' Waits for a new file
  file = WaitNewFile()
  
  'Stop the browser
  driver.Quit
End Sub

''
' Waits for a new file to be created in a folder
' @folder {String}  Folder where the file will be created
' Usage:
'   WaitNewFile "C:\download\*.pdf"
'   ' The new file is created here
'   filename = WaitNewFile()
''
Public Function WaitNewFile(Optional target As String) As String
  Static files As Collection, filter$
  Dim file$, file_path$, i&
  If Len(target) Then
    ' Initialize the list of files and return
    filter = target
    Set files = New Collection
    file = Dir(filter, vbNormal)
    Do While Len(file)
      files.Add Empty, file
      file = Dir
    Loop
    Exit Function
  End If
  
  ' Waits for a file that is not in the list
  On Error GoTo WaitReady
  Do
    file = Dir(filter, vbNormal)
    Do While Len(file)
      files.Item file
      file = Dir
    Loop
    For i = 0 To 3000: DoEvents: Next
  Loop
  
WaitReady:
  ' Waits for the size to be superior to 0 and try to rename it
  file_path = Left$(filter, InStrRev(filter, "\")) & file
  Do
    If FileLen(file_path) Then
      On Error Resume Next
      Name file_path As file_path
      If Err = 0 Then Exit Do
    End If
    For i = 0 To 3000: DoEvents: Next
  Loop
  files.Add Empty, file
  WaitNewFile = file_path
End Function
