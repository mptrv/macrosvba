' Parte do Instalador de Métodos Automáticos
' ===== == ========== == ======= ===========
' Criação dos atalhos na área de trabalho.
'
' Métodos Automáticos são módulos que fazem parte do Sistema Horários.

Set oWS = WScript.CreateObject("WScript.Shell")

dir_origem = oWS.Environment("PROCESS").Item("DIR_ORIGEM")
dir_dest = oWS.Environment("PROCESS").Item("DIR_DEST")
WScript.Echo dir_dest
area_trab = oWS.Environment("PROCESS").Item("HOMEDRIVE") & "\" & _
	oWS.Environment("PROCESS").Item("HOMEPATH") & "\Desktop"
WScript.Echo area_trab

sLinkFile = area_trab & "\Construção Grade Horária.lnk"
WScript.Echo sLinkFile
Set oLink = oWS.CreateShortcut(sLinkFile)

oLink.TargetPath = dir_dest & "\Cronograma.txt"
	oLink.Arguments = ""
	oLink.Description = "Este é um teste de ligação."
	oLink.HotKey = "ALT+CTRL+C"
	oLink.IconLocation = "E:\Projetos\macrosvba\metodos-automaticos\imagens\atualizar.ico"
	oLink.WindowStyle = "1"
	oLink.WorkingDirectory = dir_dest
oLink.Save
