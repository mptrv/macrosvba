' Parte do Instalador de M�todos Autom�ticos
' ===== == ========== == ======= ===========
' Cria��o dos atalhos na �rea de trabalho.
'
' M�todos Autom�ticos s�o m�dulos que fazem parte do Sistema Hor�rios.

Set oWS = WScript.CreateObject("WScript.Shell")

dir_origem = oWS.Environment("PROCESS").Item("DIR_ORIGEM")
dir_dest = oWS.Environment("PROCESS").Item("DIR_DEST")
WScript.Echo dir_dest
area_trab = oWS.Environment("PROCESS").Item("HOMEDRIVE") & "\" & _
	oWS.Environment("PROCESS").Item("HOMEPATH") & "\Desktop"
WScript.Echo area_trab

sLinkFile = area_trab & "\Constru��o Grade Hor�ria.lnk"
WScript.Echo sLinkFile
Set oLink = oWS.CreateShortcut(sLinkFile)

oLink.TargetPath = dir_dest & "\Cronograma.txt"
	oLink.Arguments = ""
	oLink.Description = "Este � um teste de liga��o."
	oLink.HotKey = "ALT+CTRL+C"
	oLink.IconLocation = "E:\Projetos\macrosvba\metodos-automaticos\imagens\atualizar.ico"
	oLink.WindowStyle = "1"
	oLink.WorkingDirectory = dir_dest
oLink.Save
