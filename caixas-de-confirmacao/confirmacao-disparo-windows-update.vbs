''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' confirmacao-disparo-windows-update
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'
' Pede confirmação ao usuário antes de disparar o Windows Update.
' A ideia é que este "script" seja chamado pela tarefa agendada
' no agendador do Windows (taskschd.msc).


Set oWS = WScript.CreateObject("WScript.Shell")

if MsgBox("Deseja disparar o Windows Update?", vbYesNo + vbQuestion, "Confirmação para disparo do Windows Update") = vbYes then
		  oWS.CurrentDirectory = "C:\WINDOWS\Temp\"
		  oWS.Run "C:\WINDOWS\system32\sc.exe start wuauserv"
else
		  MsgBox "A atualização NÃO será executada.", vbOkOnly + vbInformation, "Informação"
end if
