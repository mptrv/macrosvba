Attribute VB_Name = "modExtras"
Option Explicit

Public Declare Function GetUserName Lib "advapi32.dll" Alias "GetUserNameA" _
(ByVal lpBuffer As String, nSize As Long) As Long

Public Declare Function GetComputerName Lib "kernel32" _
Alias "GetComputerNameA" _
(ByVal lpBuffer As String, nSize As Long) As Long

'******************************************************************************
'Gera uma pausa, permitindo atualiza��es visuais no Access.
'Segundo o autor do c�digo, 'Sleep()' n�o tem o mesmo efeito.
'  C�digo por 'ghudson', publicado em
'     http://www.access-programmers.co.uk/forums/showthread.php?t=188821
Public Function Pause(NumberOfSeconds As Variant)

   On Error GoTo Err_Pause

   Dim PauseTime As Variant, start As Variant

   PauseTime = NumberOfSeconds
   start = Timer
   Do While Timer < start + PauseTime
   DoEvents
   Loop

Exit_Pause:
   Exit Function

Err_Pause:
   MsgBox Err.Number & " - " & Err.Description, vbCritical, "Pause()"
   Resume Exit_Pause

End Function

'********************************************************************************
'Fun��es para retornar o nome do usu�rio e do computador.
'Extra�do de:
'  http://www.microsoftexcel.com.br/index.php/excel-dicas-microsoft-excel-vba/169-excel-vba-sistema/268-vba-sistema-o-nome-do-usuario-e-o-nome-do-computador.html

Function Nome_Usuario_OS() As String
   
   Dim Buffer As String * 256
   Dim BuffLen As Long
   
   BuffLen = 256
   
   If GetUserName(Buffer, BuffLen) Then _
      Nome_Usuario_OS = Left(Buffer, BuffLen - 1)

End Function

Function Nome_Maquina_OS() As String
   
   Dim Buffer As String * 256
   Dim BuffLen As Long
   Dim lngX As Long
   Dim strCompName As String
   
   BuffLen = 255
   
   If GetComputerName(Buffer, BuffLen) Then _
      Nome_Maquina_OS = Left(Buffer, BuffLen)

End Function

Sub Teste_Usuario_host()
   MsgBox "Usu�rio: [" & Nome_Usuario_OS & "];  Nome da M�quina: [" & Nome_Maquina_OS & "].", _
      vbInformation, "Saberexcel - o site das macros"
End Sub

'********************************************************************************
'Fun��o para retornar o endere�o IP, MAC e nome do computador de todos
'os adaptadores com IP habilitado.
'
'Com base na publica��o de:
'   http://stackoverflow.com/questions/828496/how-to-retrieve-this-computers-ip-address
Public Function GetIPMACAddress()

    Const strComputer As String = "."   ' Computer name. Dot means local computer
    Dim objWMIService, IPConfigSet, IPConfig, IPAddress, i
    Dim strIPAddress As String

    ' Connect to the WMI service
    Set objWMIService = GetObject("winmgmts:" _
        & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

    ' Get all TCP/IP-enabled network adapters
    Set IPConfigSet = objWMIService.ExecQuery _
        ("Select * from Win32_NetworkAdapterConfiguration Where IPEnabled=TRUE")

    ' Get all IP addresses associated with these adapters
    For Each IPConfig In IPConfigSet
'                Dim a, v
'                Debug.Print "-------------------------------------------------"
'                For Each a In IPConfig.Properties_
'                    If (VarType(a.Value) And vbArray) = vbArray Then
'                        v = Join(a.Value, ", ")
'                    Else
'                        v = a.Value
'                    End If
'                    Debug.Print a.Name & " ; " & v
'                Next a
        IPAddress = IPConfig.IPAddress
        If Not IsNull(IPAddress) Then
            strIPAddress = strIPAddress & "; " & _
                Join(IPAddress, ", ") & ", " & _
                IPConfig.MACAddress & ", " & _
                IPConfig.DNSHostName
        End If
    Next
    
    GetIPMACAddress = Mid(strIPAddress, 3)
    
End Function

'********************************************************************************
'Rotina para ordenar uma cole��o.
'Restri��o: os elementos n�o poder�o ser do tipo objeto.
'Extra�do de:
'  http://stackoverflow.com/questions/3587662/how-do-i-sort-a-collection
Public Sub SortCollection(c As Collection)

    Dim vItm As Variant
    Dim i As Long, j As Long
    Dim vTemp As Variant

    'Two loops to bubble sort
   For i = 1 To c.Count - 1
        For j = i + 1 To c.Count
            If c(i) > c(j) Then
                'store the lesser item
               vTemp = c(j)
                'remove the lesser item
               c.Remove j
                're-add the lesser item before the
               'greater Item
               c.Add vTemp, vTemp, i
            End If
        Next j
    Next i

End Sub
