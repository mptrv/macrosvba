' Parte do Instalador de M�todos Autom�ticos
' ===== == ========== == ======= ===========
' Cria��o dos atalhos na �rea de trabalho
'
' M�todos Autom�ticos s�o m�dulos que fazem parte do Sistema Hor�rios.

Set oWS = WScript.CreateObject("WScript.Shell")

dir_origem = oWS.Environment("PROCESS").Item("DIR_ORIGEM")
dir_dest = oWS.Environment("PROCESS").Item("DIR_DEST")
area_trab = oWS.SpecialFolders("Desktop")

sLinkFile = area_trab & "\Constru��o Grade Hor�ria.lnk"

Set oLink = oWS.CreateShortcut(sLinkFile)
	oLink.TargetPath = dir_dest & "\macros\construcao-grade_horaria.xlsm"
	oLink.Arguments = ""
	oLink.Description = "Constru��o Grade Hor�ria - Sistema de Hor�rios"
	oLink.HotKey = "ALT+CTRL+G"
	oLink.IconLocation = dir_dest & "\imagens\cgh.ico"
	oLink.WindowStyle = "1"
	oLink.WorkingDirectory = dir_dest & "\macros"
oLink.Save
Set oLink = nothing

sLinkFile = area_trab & "\Consulta Sistema Hor�rios.lnk"

Set oLink = oWS.CreateShortcut(sLinkFile)
	oLink.TargetPath = dir_dest & "\macros\consulta-sistema-horarios-oficial.accdr"
	oLink.Arguments = ""
	oLink.Description = "Consulta Sistema Hor�rios - Sistema de Hor�rios"
	oLink.HotKey = "ALT+CTRL+C"
	oLink.IconLocation = dir_dest & "\imagens\csh.ico"
	oLink.WindowStyle = "1"
	oLink.WorkingDirectory = dir_dest & "\macros"
oLink.Save
Set oLink = nothing

MsgBox _
	"Instala��o Conclu�da!" & vblf & vblf & _
	"Os atalhos foram criados na �rea de trabalho.", _
	vbOKOnly + vbInformation, _
	"M�todos Autom�ticos - Sistema Hor�rios"

Set oWS = nothing
