Attribute VB_Name = "modDesproteger"
'-------------------------------------------------------------
'Código para Desproteger Planilhas
'-------------------------------------------------------------
'A princípio, não é utilizado por "Construção Grade Horária",
'mas foi colocado aqui para referência.
'-------------------------------------------------------------
'Fonte:
'   https://www.youtube.com/watch?v=ddkjlApgzd8
'Código em:
'   https://sites.google.com/site/tudonamollezza/home/Desproteger%20Planilha.txt?attredirects=0&d=1
''-------------------------------------------------------------

Public Sub DesprotegerPlanilha()

    Dim i As Integer, j As Integer, k As Integer
    Dim l As Integer, m As Integer, n As Integer
    
    On Error Resume Next
    
    For i = 65 To 66
    For j = 65 To 66
    For k = 65 To 66
    For l = 65 To 66
    For m = 65 To 66
    For i1 = 65 To 66
    For i2 = 65 To 66
    For i3 = 65 To 66
    For i4 = 65 To 66
    For i5 = 65 To 66
    For i6 = 65 To 66
    For n = 32 To 126
        ActiveSheet.Unprotect Chr(i) & Chr(j) & Chr(k) & _
            Chr(l) & Chr(m) & Chr(i1) & Chr(i2) & Chr(i3) & _
            Chr(i4) & Chr(i5) & Chr(i6) & Chr(n)
        If ActiveSheet.ProtectContents = False Then
            MsgBox "SUA PLANILHA FOI DESBLOQUEADA COM SUCESSO "
            Exit Sub
        End If
    Next
    Next
    Next
    Next
    Next
    Next
    Next
    Next
    Next
    Next
    Next
    Next

End Sub
