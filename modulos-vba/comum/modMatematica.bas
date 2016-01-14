Attribute VB_Name = "modMatematica"
Option Explicit

'===============================================================================
'ROTINAS DE CÁLCULOS MATEMÁTICOS
'===============================================================================

'Calcula o máximo divisor comum entre dois valores inteiros fornecidos.
'   Ref.: https://pt.wikipedia.org/wiki/Algoritmo_de_Euclides
Public Function MDC(ByVal a As Long, ByVal b As Long) As Long

    Dim r As Long
    Dim q As Long
    
    Do While b <> 0
        q = a \ b
        r = a Mod b
        a = b
        b = r
    Loop
    
    MDC = a
    
End Function

'Calcula o máximo divisor comum entre os valores (inteiros) fornecidos.
Public Function MDCn(ParamArray Valores() As Variant) As Integer

    Dim i As Integer
    Dim iMax As Integer
    Dim MDCParc As Long
    
    iMax = UBound(Valores)
    
    Select Case iMax
        Case Is < 0
            MDCn = 0
        Case 0
            MDCn = MDC(Valores(0), 0)
        Case Else
            MDCParc = MDC(Valores(0), Valores(1))
            For i = 2 To iMax
                MDCParc = MDC(MDCParc, Valores(i))
            Next i
            MDCn = MDCParc
    End Select

End Function

'Calcula o mínimo múltiplo comum entre dois valores inteiros fornecidos.
'   Ref.: https://pt.wikipedia.org/wiki/M%C3%ADnimo_m%C3%BAltiplo_comum
Public Function MMC(ByVal a As Long, ByVal b As Long) As Integer
    If a = 0 And b = 0 Then
        MMC = 0
    Else
        MMC = a * b / MDC(a, b)
    End If
End Function

'Calcula o mínimo múltiplo comum entre os valores (inteiros) fornecidos.
Public Function MMCn(ParamArray Valores() As Variant) As Integer

    Dim i As Integer
    Dim iMax As Integer
    Dim MMCParc As Long
    
    iMax = UBound(Valores)
    
    If iMax < 1 Then
        MMCn = 0
    Else
        MMCParc = MMC(Valores(0), Valores(1))
        For i = 2 To iMax
            MMCParc = MMC(MMCParc, Valores(i))
        Next i
        MMCn = MMCParc
    End If

End Function
